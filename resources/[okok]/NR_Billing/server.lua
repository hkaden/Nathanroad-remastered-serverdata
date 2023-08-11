ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = ''
local limiteTimeHours = Config.LimitDateDays*24
local hoursToPay = limiteTimeHours
local whenToAddFees = {}

for i = 1, Config.LimitDateDays, 1 do
	hoursToPay = hoursToPay - 24
	table.insert(whenToAddFees, hoursToPay)
end

MySQL.ready(function()
	MySQL.query("DELETE FROM okokbilling WHERE (status = 'paid' OR status = 'autopaid' OR status = 'cancelled') AND sent_date < now() - interval 7 DAY", {})
end)

ESX.RegisterCommand('delBilling', 'admin', function()
	MySQL.query("DELETE FROM okokbilling WHERE (status = 'paid' OR status = 'autopaid' OR status = 'cancelled') AND sent_date < now() - interval 7 DAY", {})
end, true)

ESX.RegisterServerCallback("okokBilling:GetInvoices", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM okokBilling WHERE receiver_identifier = ? ORDER BY CASE WHEN status = "unpaid" THEN 1 WHEN status = "autopaid" THEN 2 WHEN status = "paid" THEN 3 WHEN status = "cancelled" THEN 4 END ASC, id DESC', {xPlayer.identifier}, function(result)
		local invoices = {}

		if result ~= nil then
			for i=1, #result, 1 do
				table.insert(invoices, result[i])
			end
		end

		cb(invoices)
	end)
end)

RegisterServerEvent("okokBilling:PayInvoice")
AddEventHandler("okokBilling:PayInvoice", function(invoice_id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM okokBilling WHERE id = ?', {invoice_id}, function(result)
		local invoices = result[1]
		local playerMoney = xPlayer.getAccount('bank').money
		invoices.invoice_value = math.ceil(invoices.invoice_value)

		local senderPlayer = ESX.GetPlayerFromIdentifier(invoices.author_identifier)

		if playerMoney == nil then
			playerMoney = 0
		end

		if playerMoney < invoices.invoice_value then
			TriggerClientEvent('esx:Notify', xPlayer.source, "error", "你銀行沒有足夠的結餘!")
		else
			xPlayer.removeAccountMoney('bank', invoices.invoice_value)
			exports.NR_Banking:AddJobMoney(invoices.society, invoices.invoice_value)

			MySQL.update('UPDATE okokBilling SET status = ?, paid_date = CURRENT_TIMESTAMP WHERE id = ?', {'paid', invoice_id})

			TriggerClientEvent('esx:Notify', xPlayer.source, "success", "已成功支付 #" .. invoice_id .. " 發票, 金額: $" .. invoices.invoice_value)
			if senderPlayer then
				TriggerClientEvent('esx:Notify', senderPlayer.source, "success", xPlayer.name .. " 已成功支付 #" .. invoice_id .. " 發票, 金額: $" .. invoices.invoice_value)
			end

			if Config.Logging then
				local webhookData = {
					_type = 'Billing:PayInvoice',
					_id = invoices.id,
					_receiver_id = invoices.receiver_identifier,
					_receiver_name = invoices.receiver_name,
					_sender_id = invoices.sender_identifier,
					_sender_name = invoices.sender_name,
					_amount = tonumber(invoices.invoice_value),
					_item = invoices.item,
					_society_name = invoices.society_name,
					_society = invoices.society,
					_notes = invoices.notes,
					_latest_money = xPlayer.getAccount('bank').money,
				}
				payInvoiceWebhook(webhookData)
			end
		end
	end)
end)

RegisterServerEvent("okokBilling:CancelInvoice")
AddEventHandler("okokBilling:CancelInvoice", function(invoice_id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM okokBilling WHERE id = ?', {invoice_id}, function(result)
		local invoices = result[1]
		MySQL.update('UPDATE okokBilling SET status = "cancelled", paid_date = CURRENT_TIMESTAMP WHERE id = ?', {invoice_id})
		TriggerClientEvent('esx:Notify', xPlayer.source, "info", "你已取消發票!")
		if Config.Logging then
			local webhookData = {
				_type = 'Billing:CancelInvoice',
				_id = invoices.id,
				_receiver_id = invoices.receiver_identifier,
				_receiver_name = invoices.receiver_name,
				_sender_id = invoices.sender_identifier,
				_sender_name = invoices.sender_name,
				_amount = tonumber(invoices.invoice_value),
				_item = invoices.item,
				_society_name = invoices.society_name,
				_society = invoices.society,
				_trigger = xPlayer.identifier,
				_trigger_name = xPlayer.name,
				_notes = invoices.notes
			}
			cancelInvoiceWebhook(webhookData)
		end
	end)
end)

RegisterServerEvent("okokBilling:CreateInvoice")
AddEventHandler("okokBilling:CreateInvoice", function(data)
	local _source = ESX.GetPlayerFromId(source)
	local target = ESX.GetPlayerFromId(data.target)
	local webhookData = {}

	MySQL.query('SELECT id FROM okokBilling WHERE id = (SELECT MAX(id) FROM okokBilling)', {}, function(result)
		webhookData = {
			_type = 'Billing:CreateInvoice',
			_id = result[1].id + 1,
			_receiver_id = target.identifier,
			_receiver_name = target.name,
			_sender_id = _source.identifier,
			_sender_name = _source.name,
			_amount = tonumber(data.invoice_value),
			_item = data.invoice_item,
			_society_name = data.society_name,
			_society = data.society,
			_notes = data.invoice_notes
		}
	end)

	if Config.LimitDate then
		MySQL.insert('INSERT INTO okokBilling (receiver_identifier, receiver_name, author_identifier, author_name, society, society_name, item, invoice_value, status, notes, sent_date, limit_pay_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP(), DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL ? DAY))', {target.identifier, target.getName(), _source.identifier, _source.getName(), data.society, data.society_name, data.invoice_item, data.invoice_value, "unpaid", data.invoice_notes, Config.LimitDateDays}, function(result)
			TriggerClientEvent('esx:Notify', target.source, "info", "你剛才收到一張新的發票!")
			if Config.Logging then
				createNewInvoiceWebhook(webhookData)
			end
		end)
	else
		MySQL.insert('INSERT INTO okokBilling (receiver_identifier, receiver_name, author_identifier, author_name, society, society_name, item, invoice_value, status, notes, sent_date, limit_pay_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP(), DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL ? DAY))', {target.identifier, target.getName(), _source.identifier, _source.getName(), data.society, data.society_name, data.invoice_item, data.invoice_value, "unpaid", data.invoice_notes, 'N/A'}, function(result)
			TriggerClientEvent('esx:Notify', target.source, "info", "你剛才收到一張新的發票!")
			if Config.Logging then
				createNewInvoiceWebhook(webhookData)
			end
		end)
	end
end)

ESX.RegisterServerCallback("okokBilling:GetSocietyInvoices", function(source, cb, society)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM okokBilling WHERE society_name = ? ORDER BY id DESC', {society}, function(result)
		local invoices = {}
		local totalInvoices = 0
		local totalIncome = 0
		local totalUnpaid = 0
		local awaitedIncome = 0

		if result ~= nil then
			for i=1, #result, 1 do
				invoices[#invoices + 1] = result[i]
				totalInvoices = totalInvoices + 1

				if result[i].status == 'paid' then
					totalIncome = totalIncome + result[i].invoice_value
				elseif result[i].status == 'unpaid' then
					awaitedIncome = awaitedIncome + result[i].invoice_value
					totalUnpaid = totalUnpaid + 1
				end
			end
		end
		cb(invoices, totalInvoices, totalIncome, totalUnpaid, awaitedIncome)
	end)
end)

function checkTimeLeft()
	MySQL.query('SELECT *, TIMESTAMPDIFF(HOUR, CURRENT_TIMESTAMP(), limit_pay_date) AS "timeLeft" FROM okokBilling WHERE status = ?', {'unpaid'}, function(result)
		for k, v in ipairs(result) do
			local invoice_value = math.ceil(v.invoice_value * (Config.FeeAfterEachDayPercentage / 100 + 1))
			if v.timeLeft < 0 and Config.FeeAfterEachDay then
				for k, vl in pairs(whenToAddFees) do
					if v.fees_amount == k - 1 then
						if v.timeLeft >= vl*(-1) then
							MySQL.update('UPDATE okokBilling SET fees_amount = ?, invoice_value = ? WHERE id = ?', {k, invoice_value, v.id})
						end
					end
				end
			elseif v.timeLeft >= 0 and Config.PayAutomaticallyAfterLimit then
				local xPlayer = ESX.GetPlayerFromIdentifier(v.receiver_identifier)

				if xPlayer == nil then
					MySQL.query('SELECT accounts FROM users WHERE identifier = ?', {v.receiver_identifier}, function(account)
						local playerAccount = json.decode(account[1].accounts)
						if playerAccount.bank > 0 then
							playerAccount.bank = playerAccount.bank - invoice_value
						else
							playerAccount.money = playerAccount.money - invoice_value
						end

						playerAccount = json.encode(playerAccount)

						MySQL.update('UPDATE users SET accounts = ? WHERE identifier = ?', {playerAccount, v.receiver_identifier}, function(changed)
							exports.NR_Banking:AddJobMoney(v.society, invoice_value)
							MySQL.update('UPDATE okokBilling SET status = ?, paid_date = CURRENT_TIMESTAMP() WHERE id = ?', {'autopaid', v.id})
						end)
						
						if Config.Logging then
							local webhookData = {
								_type = 'Billing:func:checkTimeLeft:offline',
								_id = v.id,
								_receiver_id = v.receiver_identifier,
								_receiver_name = v.receiver_name,
								_sender_id = v.sender_identifier,
								_sender_name = v.sender_name,
								_amount = tonumber(v.invoice_value),
								_item = v.item,
								_society_name = v.society_name,
								_society = v.society,
								_notes = v.notes
							}
							autopayInvoiceWebhook(webhookData)
						end
					end)
				else
					xPlayer.removeAccountMoney('bank', invoice_value)
					exports.NR_Banking:AddJobMoney(v.society, invoice_value)
					MySQL.update('UPDATE okokBilling SET status = ?, paid_date = CURRENT_TIMESTAMP() WHERE id = ?', {'autopaid', v.id})
					if Config.Logging then
						local webhookData = {
							_type = 'Billing:func:checkTimeLeft',
							_id = v.id,
							_receiver_id = v.receiver_identifier,
							_receiver_name = v.receiver_name,
							_sender_id = v.sender_identifier,
							_sender_name = v.sender_name,
							_amount = tonumber(v.invoice_value),
							_item = v.item,
							_society_name = v.society_name,
							_society = v.society,
							_notes = v.notes
						}
						autopayInvoiceWebhook(webhookData)
					end
				end
			end
		end
	end)
	SetTimeout(30 * 60000, checkTimeLeft)
end

if Config.PayAutomaticallyAfterLimit then
	checkTimeLeft()
end

-------------------------- PAY INVOICE WEBHOOK

function payInvoiceWebhook(data)
	local whData = {
		message = data._receiver_id .. ", " .. data._receiver_name .. ", 已成功支付 #" .. data._id .. " $" .. data._amount .. ' 發票至 ' .. data._society_name,
		sourceIdentifier = data._receiver_id,
		event = 'okokBilling:PayInvoice'
	}

	TriggerEvent('NR_graylog:createLog', whData, data)
end

-------------------------- CANCEL INVOICE WEBHOOK

function cancelInvoiceWebhook(data)
	local whData = {
		message = data._trigger .. ", " .. data._trigger_name .. ", 已取消了 #" .. data._id .. ' 發票 ',
		sourceIdentifier = data._receiver_id,
		event = 'okokBilling:CancelInvoice'
	}

	TriggerEvent('NR_graylog:createLog', whData, data)
end

-------------------------- CREATE NEW INVOICE WEBHOOK

function createNewInvoiceWebhook(data)
	local whData = {
		message = data._sender_id .. ", " .. data._sender_name .. ", 已創建 #" .. data._id .. ' 發票',
		sourceIdentifier = data._sender_id,
		event = 'okokBilling:CreateInvoice'
	}

	TriggerEvent('NR_graylog:createLog', whData, data)
end

-------------------------- AUTOPAY INVOICE WEBHOOK

function autopayInvoiceWebhook(data)
	local whData = {
		message = data._receiver_id .. ", " .. data._receiver_name .. ", 已自動支付 #" .. data._id .. " $" .. data._amount .. ' 發票至 ' .. data._society_name,
		sourceIdentifier = data._receiver_id,
		event = 'okokBilling:PayInvoice'
	}

	TriggerEvent('NR_graylog:createLog', whData, data)
end

-- ESX.RegisterCommand('testbb', 'admin', function(xPlayer, args, showError)
-- 	exports.NR_Banking:AddJobMoney(args.job, args.amount)
-- end, true, {help = "懲罰一名玩家(社會服務令)", validate = true, arguments = {
-- 	{name = 'job', help = "ID", type = 'any'},
-- 	{name = 'amount', help = "次數", type = 'any'}
-- }})