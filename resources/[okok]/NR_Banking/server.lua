ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local SharedAccounts = {}

CreateThread(function()
	while true do
		local result = MySQL.query.await('SELECT * FROM okokBanking_societies')

		for i=1, #result, 1 do
			local name   = result[i].society
			local label  = result[i].society_name

			local result2 = MySQL.query.await('SELECT * FROM okokBanking_societies WHERE society = @society', {
				['@society'] = name
			})

			if result then
				SharedAccounts[name] = result2[1].value
			end
		end
		Wait(300000)
	end
end)

function UpdateSharedAccounts(name, amount)
	SharedAccounts[name] = SharedAccounts[name] + (amount)
	
	local whData = {
		message = name .. " 最新餘額$ " .. SharedAccounts[name],
		sourceIdentifier = 'Console',
		event = 'okokBanking:server:func:UpdateSharedAccounts'
	}
	local additionalFields = {
		_type = 'Banking:UpdateSharedAccounts',
		_society = name,
		_amount = amount,
		_latest_money = SharedAccounts[name]
	}
	TriggerEvent('NR_graylog:createLog', whData, additionalFields)
	local xPlayers = ESX.GetExtendedPlayers('job', string.gsub(name, "society_", ""))
	for i=1, #xPlayers, 1 do
		local xPlayer = xPlayers[i]
		if xPlayer then
			TriggerClientEvent('NR_HudV2:updateSocietyMoney', xPlayer.source, string.gsub(name, "society_", ""), SharedAccounts[name])
		end
	end
end

function GetSharedAccounts(name)
	return SharedAccounts[name]
end
exports('GetSharedAccounts', GetSharedAccounts)

ESX.RegisterServerCallback("okokBanking:GetPlayerInfo", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.query('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local db = result[1]
		local data = {
			playerName = xPlayer.getName(),
			playerBankMoney = xPlayer.getAccount('bank').money,
			playerIBAN = db.iban,
			walletMoney = xPlayer.getMoney(),
			sex = db.sex,
		}

		cb(data)
	end)
end)

ESX.RegisterServerCallback("okokBanking:IsIBanUsed", function(source, cb, iban)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.query('SELECT * FROM users WHERE iban = @iban', {
		['@iban'] = iban
	}, function(result)
		local db = result[1]
		if db ~= nil then
			
			cb(db, true)
		else
			MySQL.query('SELECT * FROM okokBanking_societies WHERE iban = @iban', {
				['@iban'] = iban
			}, function(result2)
				local db2 = result2[1]
				
				cb(db2, false)
			end)
		end
	end)
end)

ESX.RegisterServerCallback("okokBanking:GetPIN", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.query('SELECT pincode FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result)
		local pin = result[1]

		cb(pin.pincode)
	end)
end)

ESX.RegisterServerCallback("okokBanking:SocietyInfo", function(source, cb, society)
	MySQL.query('SELECT * FROM okokBanking_societies WHERE society = @society', {
		['@society'] = society
	}, function(result)
		local db = result[1]
		cb(db)
	end)
end)

function GetSocietyInfo(society)
	return MySQL.query.await('SELECT * FROM okokBanking_societies WHERE society = ?', {society})
end
exports('GetSocietyInfo', GetSocietyInfo)

RegisterServerEvent("okokBanking:CreateSocietyAccount")
AddEventHandler("okokBanking:CreateSocietyAccount", function(society, society_name, value, iban)
	MySQL.insert('INSERT INTO okokBanking_societies (society, society_name, value, iban) VALUES (?, ?, ?, ?) ', {society, society_name, value, iban:upper()}, function(id) end)
end)

RegisterServerEvent("okokBanking:SetIBAN")
AddEventHandler("okokBanking:SetIBAN", function(iban)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE users SET iban = @iban WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@iban'] = iban,
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:DepositMoney")
AddEventHandler("okokBanking:DepositMoney", function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if amount <= playerMoney then
		xPlayer.removeAccountMoney('money', amount)
		xPlayer.addAccountMoney('bank', amount, 'okokBanking:DepositMoney')
		local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已存入$, " .. amount .. '至銀行戶口',
			sourceIdentifier = xPlayer.identifier,
			event = 'okokBanking:DepositMoney'
		}
		local additionalFields = {
			_type = 'Banking:DepositMoney',
			_PlayerName = xPlayer.name,
			_Amount = amount,
			_LatestBank = xPlayer.getAccount('bank').money,
			_LatestMoney = xPlayer.getAccount('money').money
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)

		TriggerEvent('okokBanking:AddDepositTransaction', amount, source)
		TriggerClientEvent('okokBanking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
		TriggerClientEvent('esx:Notify', source, "success", "你已存入 "..amount.."$")
	else
		TriggerClientEvent('esx:Notify', source, "error", "你身上的現金不足")
	end
end)

RegisterServerEvent("okokBanking:WithdrawMoney")
AddEventHandler("okokBanking:WithdrawMoney", function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getAccount('bank').money

	if amount <= playerMoney then
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addAccountMoney('money', amount, 'okokBanking:WithdrawMoney')
		local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已提取$, " .. amount .. '現金',
			sourceIdentifier = xPlayer.identifier,
			event = 'okokBanking:WithdrawMoney'
		}
		local additionalFields = {
			_type = 'Banking:WithdrawMoney',
			_PlayerName = xPlayer.name,
			_Amount = amount,
			_LatestBank = xPlayer.getAccount('bank').money,
			_LatestMoney = xPlayer.getAccount('money').money
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)

		TriggerEvent('okokBanking:AddWithdrawTransaction', amount, source)
		TriggerClientEvent('okokBanking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
		TriggerClientEvent('esx:Notify', source, "success", "你已提取 "..amount.."$")
	else
		TriggerClientEvent('esx:Notify', source, "error", "你的帳戶餘額不足")
	end
end)

RegisterServerEvent("okokBanking:TransferMoney")
AddEventHandler("okokBanking:TransferMoney", function(amount, ibanNumber, targetIdentifier, acc, targetName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
	local xPlayers = ESX.GetPlayers()
	local playerMoney = xPlayer.getAccount('bank').money
	ibanNumber = ibanNumber:upper()
	if xPlayer.identifier ~= targetIdentifier then
		if amount <= playerMoney then
			
			if xTarget ~= nil then
				xPlayer.removeAccountMoney('bank', amount)
				xTarget.addAccountMoney('bank', amount, 'okokBanking:TransferMoney')

				for i=1, #xPlayers, 1 do
					local xForPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xForPlayer.identifier == targetIdentifier then
						local whData = {
							message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已轉帳$, " .. amount .. '給' .. xTarget.name,
							sourceIdentifier = xPlayer.identifier,
							event = 'okokBanking:TransferMoney'
						}
						local additionalFields = {
							_type = 'Banking:TransferMoney:Online',
							_player_name = xPlayer.name,
							_target_name = xTarget.name,
							_target_identifier = xTarget.identifier,
							_amount = amount,
							_self_latest_bank = xPlayer.getAccount('bank').money,
							_target_latest_bank = xTarget.getAccount('bank').money
						}
						TriggerEvent('NR_graylog:createLog', whData, additionalFields)

						TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.getAccount('bank').money, xTarget.getMoney())
						TriggerClientEvent('esx:Notify', xPlayers[i], "success", "你已收到由 ".. xPlayer.getName() .. "轉帳給你的" .. amount.. "$")
					end
				end
				TriggerEvent('okokBanking:AddTransferTransaction', amount, xTarget, source)
				TriggerClientEvent('okokBanking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
				
				TriggerClientEvent('esx:Notify', source, "success", "你已轉帳 "..amount.."$ 給 "..xTarget.getName())
			elseif xTarget == nil then
				local playerAccount = json.decode(acc)
				playerAccount.bank = playerAccount.bank + amount
				playerAccount = json.encode(playerAccount)

				xPlayer.removeAccountMoney('bank', amount)

				local whData = {
					message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已轉帳$, " .. amount .. '給' .. xTarget.name,
					sourceIdentifier = xPlayer.identifier,
					event = 'okokBanking:TransferMoney'
				}
				local additionalFields = {
					_type = 'Banking:TransferMoney:Offline',
					_player_name = xPlayer.name,
					_target_name = targetName,
					_target_identifier = targetIdentifier,
					_amount = amount,
					_self_latest_bank = xPlayer.getAccount('bank').money
				}

				TriggerEvent('NR_graylog:createLog', whData, additionalFields)
				TriggerEvent('okokBanking:AddTransferTransaction', amount, xTarget, source, targetName, targetIdentifier)
				TriggerClientEvent('okokBanking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
				TriggerClientEvent('esx:Notify', source, "success", "你已轉帳 "..amount.."$ 給 "..targetName)

				MySQL.update('UPDATE users SET accounts = @playerAccount WHERE identifier = @target', {
					['@playerAccount'] = playerAccount,
					['@target'] = targetIdentifier
				}, function(changed)

				end)
			end
		else
			TriggerClientEvent('esx:Notify', source, "error", "你的帳戶餘額不足")
		end
	else
		TriggerClientEvent('esx:Notify', source, "error", "你不能轉帳給自己")
	end
end)

RegisterServerEvent("okokBanking:DepositMoneyToSociety")
AddEventHandler("okokBanking:DepositMoneyToSociety", function(amount, society, societyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if amount <= playerMoney then
		MySQL.update('UPDATE okokBanking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
			UpdateSharedAccounts(society, amount)
		end)
		xPlayer.removeAccountMoney('money', amount)
		local whData = {
			message = xPlayer.identifier .. ", " .. xPlayer.name .. ", 已存入$, " .. amount .. ' 至 ' .. societyName .. " 的帳戶",
			sourceIdentifier = xPlayer.identifier,
			event = 'okokBanking:DepositMoneyToSociety'
		}
		local additionalFields = {
			_type = 'Banking:DepositMoneyToSociety',
			_player_name = xPlayer.name,
			_society = society,
			_society_name = societyName,
			_amount = amount,
			_self_current_money = playerMoney,
			_self_latest_money = xPlayer.getMoney()
		}

		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		TriggerEvent('okokBanking:AddDepositTransactionToSociety', amount, source, society, societyName)
		TriggerClientEvent('okokBanking:updateTransactionsSociety', source, xPlayer.getMoney())
		TriggerClientEvent('esx:Notify', source, "success", "你已將 "..amount.."$ 存入 "..societyName .. " 的帳戶")
	else
		TriggerClientEvent('esx:Notify', source, "error", "你的現金不夠")
	end
end)

function AddJobMoney(jobName, amount)
	if jobName and string.find(jobName, "society_", 1)  then jobName = string.gsub(jobName, "society_", "") end;
	MySQL.update('UPDATE okokBanking_societies SET value = value + @value WHERE society = @jobName', {
		['@value'] = amount,
		['@jobName'] = "society_"..jobName,
	}, function(changed)
		UpdateSharedAccounts("society_"..jobName, amount)
	end)
end
exports('AddJobMoney', AddJobMoney)

function RemoveJobMoney(jobName, amount)
	if jobName and string.find(jobName, "society_", 1)  then jobName = string.gsub(jobName, "society_", "") end;
	MySQL.update('UPDATE okokBanking_societies SET value = value - @value WHERE society = @jobName', {
		['@value'] = amount,
		['@jobName'] = "society_"..jobName,
	}, function(changed)
		UpdateSharedAccounts("society_"..jobName, -amount)
	end)
end
exports('RemoveJobMoney', RemoveJobMoney)


RegisterServerEvent("okokBanking:WithdrawMoneyToSociety")
AddEventHandler("okokBanking:WithdrawMoneyToSociety", function(amount, society, societyName, societyMoney)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local db
	local hasChecked = false

	MySQL.query('SELECT * FROM okokBanking_societies WHERE society = @society', {
		['@society'] = society
	}, function(result)
		db = result[1]
		hasChecked = true
	end)

	MySQL.update('UPDATE okokBanking_societies SET is_withdrawing = 1 WHERE society = @society AND society_name = @society_name', {
		['@value'] = amount,
		['@society'] = society,
		['@society_name'] = societyName,
	}, function(changed)
	end)

	while not hasChecked do 
		Wait(100)
	end
	
	if amount <= db.value then
		if db.is_withdrawing == 1 then
			TriggerClientEvent('esx:Notify', _source, "error", "有人正在提款 請等等")
		else

			MySQL.update('UPDATE okokBanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
				['@value'] = amount,
				['@society'] = society,
				['@society_name'] = societyName,
			}, function(changed)
				UpdateSharedAccounts(society, -amount)
			end)
			
			xPlayer.addAccountMoney('money', amount, 'okokBanking:WithdrawMoneyToSociety')
			--xPlayer.addAccountMoney('bank', amount)
			local whData = {
				message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 已從, " .. societyName .. ' 的帳戶提取 $' .. amount,
				sourceIdentifier = xPlayer.identifier,
				event = 'okokBanking:WithdrawMoneyToSociety'
			}
			local additionalFields = {
				_type = 'Banking:WithdrawMoneyToSociety',
				_self_name = xPlayer.name,
				_society_name = societyName,
				_amount = amount,
				_self_latest_money = xPlayer.getMoney()
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerEvent('okokBanking:AddWithdrawTransactionToSociety', amount, _source, society, societyName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', _source, xPlayer.getMoney())
			TriggerClientEvent('esx:Notify', _source, "success", "你已從 "..societyName.." 的帳戶提取 "..amount .. "$ ")
		end
	else
		TriggerClientEvent('esx:Notify', _source, "error", "這個公款帳號的餘額不足")
	end

	MySQL.update('UPDATE okokBanking_societies SET is_withdrawing = 0 WHERE society = @society AND society_name = @society_name', {
		['@value'] = amount,
		['@society'] = society,
		['@society_name'] = societyName,
	}, function(changed)
	end)
end)

RegisterServerEvent("okokBanking:TransferMoneyToSociety")
AddEventHandler("okokBanking:TransferMoneyToSociety", function(amount, ibanNumber, societyName, society)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

		if amount <= playerMoney then
			MySQL.update('UPDATE okokBanking_societies SET value = value + @value WHERE iban = @iban', {
				['@value'] = amount,
				['@iban'] = ibanNumber
			}, function(changed)
				UpdateSharedAccounts(society, amount)
				local whData = {
					message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 已存入$, " .. amount .. ', 至, ' .. societyName .. ', 的帳戶',
					sourceIdentifier = xPlayer.identifier,
					event = 'okokBanking:TransferMoneyToSociety'
				}
				local additionalFields = {
					_type = 'Banking:TransferMoneyToSociety',
					_self_name = xPlayer.name,
					_society_name = societyName,
					_amount = amount,
					_self_latest_money = xPlayer.getMoney()
				}
				TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			end)
			xPlayer.removeAccountMoney('money', amount)
			TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, source, society, societyName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', source, xPlayer.getMoney())
			TriggerClientEvent('esx:Notify', source, "success", "你已存入 "..amount.."$ 到 "..societyName)
		else
			TriggerClientEvent('esx:Notify', source, "error", "你的帳戶餘額不足")
		end
end)

RegisterServerEvent("okokBanking:TransferMoneyToSocietyFromSociety")
AddEventHandler("okokBanking:TransferMoneyToSocietyFromSociety", function(amount, ibanNumber, societyNameTarget, societyTarget, society, societyName, societyMoney)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if amount <= societyMoney then
		MySQL.update('UPDATE okokBanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
			UpdateSharedAccounts(society, -amount)
		end)
		MySQL.update('UPDATE okokBanking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = societyTarget,
			['@society_name'] = societyNameTarget,
		}, function(changed)
			UpdateSharedAccounts(societyTarget, amount)
		end)
		local whData = {
			message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 以" .. societyName .. "轉帳了$, " .. amount .. ', 至, ' .. societyNameTarget .. ', 的帳戶',
			sourceIdentifier = xPlayer.identifier,
			event = 'okokBanking:TransferMoneyToSocietyFromSociety'
		}
		local additionalFields = {
			_type = 'Banking:TransferMoneyToSocietyFromSociety',
			_self_name = xPlayer.name,
			_self_society = society,
			_self_society_name = societyName,
			_target_society = societyTarget,
			_target_society_name = societyNameTarget,
			_amount = amount
		}
		TriggerEvent('NR_graylog:createLog', whData, additionalFields)
		TriggerEvent('okokBanking:AddTransferTransactionFromSociety', amount, society, societyName, societyTarget, societyNameTarget)
		TriggerClientEvent('okokBanking:updateTransactionsSociety', source, xPlayer.getMoney())
		TriggerClientEvent('esx:Notify', source, "success", "你已轉帳 "..amount.."$ 到 "..societyNameTarget)
	else
		TriggerClientEvent('esx:Notify', source, "error", "這個公款帳號的餘額不足")
	end
end)

RegisterServerEvent("okokBanking:TransferMoneyToPlayerFromSociety")
AddEventHandler("okokBanking:TransferMoneyToPlayerFromSociety", function(amount, ibanNumber, targetIdentifier, acc, targetName, society, societyName, societyMoney, toMyself)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
	local xPlayers = ESX.GetPlayers()

	if amount <= societyMoney then
		MySQL.update('UPDATE okokBanking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
			UpdateSharedAccounts(society, -amount)
		end)
		if xTarget ~= nil then
			xTarget.addAccountMoney('bank', amount, 'okokBanking:TransferMoneyToPlayerFromSociety')
			if not toMyself then
				for i=1, #xPlayers, 1 do
					local xForPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xForPlayer.identifier == targetIdentifier then
						--TriggerClientEvent('okokBanking:updateMoney', xPlayers[i], xTarget.getAccount('bank').money)
						TriggerClientEvent('okokBanking:updateTransactions', xPlayers[i], xTarget.getAccount('bank').money, xTarget.getMoney())
						TriggerClientEvent('esx:Notify', xPlayers[i], "success", "你已收到由 ".. xPlayer.getName() .. "轉帳給你的" .. amount.. "$")
					end
				end
			end
			local whData = {
				message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 以" .. societyName .. "轉帳了$, " .. amount .. ', 至, ' .. targetIdentifier .. ', ' .. targetName .. ', 的帳戶',
				sourceIdentifier = xPlayer.identifier,
				event = 'okokBanking:TransferMoneyToPlayerFromSociety'
			}
			local additionalFields = {
				_type = 'Banking:TransferMoneyToPlayerFromSociety:Online',
				_self_name = xPlayer.name,
				_self_society = society,
				_self_society_name = societyName,
				_target_identifier = targetIdentifier,
				_target_name = targetName,
				_target_latest_money = xTarget.getAccount('bank').money,
				_amount = amount
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', source, xPlayer.getMoney())
			TriggerClientEvent('esx:Notify', source, "success", "你已轉帳 "..amount.."$ 給 "..xTarget.getName())
		elseif xTarget == nil then
			local playerAccount = json.decode(acc)
			playerAccount.bank = playerAccount.bank + amount
			playerAccount = json.encode(playerAccount)

			--xPlayer.removeAccountMoney('bank', amount)

			--TriggerClientEvent('okokBanking:updateMoney', source, xPlayer.getAccount('bank').money)
			local whData = {
				message = xPlayer.identifier .. ', ' .. xPlayer.name .. ", 以" .. societyName .. "轉帳了$, " .. amount .. ', 至, ' .. targetIdentifier .. ', ' .. targetName .. ', 的帳戶',
				sourceIdentifier = xPlayer.identifier,
				event = 'okokBanking:TransferMoneyToPlayerFromSociety'
			}
			local additionalFields = {
				_type = 'Banking:TransferMoneyToPlayerFromSociety:Offline',
				_self_name = xPlayer.name,
				_self_society = society,
				_self_society_name = societyName,
				_target_identifier = targetIdentifier,
				_target_name = targetName,
				_target_latest_money = xTarget.getAccount('bank').money,
				_amount = amount
			}
			TriggerEvent('NR_graylog:createLog', whData, additionalFields)
			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			TriggerClientEvent('okokBanking:updateTransactionsSociety', source, xPlayer.getMoney())
			TriggerClientEvent('esx:Notify', source, "success", "你已轉帳 "..amount.."$ 給 "..targetName)


			MySQL.update('UPDATE users SET accounts = @playerAccount WHERE identifier = @target', {
				['@playerAccount'] = playerAccount,
				['@target'] = targetIdentifier
			}, function(changed)

			end)
		end
	else
		TriggerClientEvent('esx:Notify', source, "error", "帳戶餘額不足")
	end
end)

ESX.RegisterServerCallback("okokBanking:GetOverviewTransactions", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerIdentifier = xPlayer.identifier
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.query('SELECT * FROM okokBanking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = playerIdentifier
	}, function(result)
		MySQL.query('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `okokBanking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY AND receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
			['@identifier'] = playerIdentifier
		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)

ESX.RegisterServerCallback("okokBanking:GetSocietyTransactions", function(source, cb, society)
	local playerIdentifier = society
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.query('SELECT * FROM okokBanking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = society
	}, function(result)
		MySQL.query('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `okokBanking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY AND receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
			['@identifier'] = society
		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)


RegisterServerEvent("okokBanking:AddDepositTransaction")
AddEventHandler("okokBanking:AddDepositTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = 'bank',
		['@receiver_name'] = 'Bank Account',
		['@sender_identifier'] = tostring(xPlayer.identifier),
		['@sender_name'] = tostring(xPlayer.getName()),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddWithdrawTransaction")
AddEventHandler("okokBanking:AddWithdrawTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.identifier),
		['@receiver_name'] = tostring(xPlayer.getName()),
		['@sender_identifier'] = 'bank',
		['@sender_name'] = 'Bank Account',
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransaction")
AddEventHandler("okokBanking:AddTransferTransaction", function(amount, xTarget, source_, targetName, targetIdentifier)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)
	if targetName == nil then
		MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(xTarget.identifier),
			['@receiver_name'] = tostring(xTarget.getName()),
			['@sender_identifier'] = tostring(xPlayer.identifier),
			['@sender_name'] = tostring(xPlayer.getName()),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	elseif targetName ~= nil and targetIdentifier ~= nil then
		MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(targetIdentifier),
			['@receiver_name'] = tostring(targetName),
			['@sender_identifier'] = tostring(xPlayer.identifier),
			['@sender_name'] = tostring(xPlayer.getName()),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	end
end)

RegisterServerEvent("okokBanking:AddTransferTransactionToSociety")
AddEventHandler("okokBanking:AddTransferTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.identifier),
		['@sender_name'] = tostring(xPlayer.getName()),
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransactionFromSocietyToP")
AddEventHandler("okokBanking:AddTransferTransactionFromSocietyToP", function(amount, society, societyName, identifier, name)

	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = identifier,
		['@receiver_name'] = name,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddTransferTransactionFromSociety")
AddEventHandler("okokBanking:AddTransferTransactionFromSociety", function(amount, society, societyName, societyTarget, societyNameTarget)
	
	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = societyTarget,
		['@receiver_name'] = societyNameTarget,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddDepositTransactionToSociety")
AddEventHandler("okokBanking:AddDepositTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.identifier),
		['@sender_name'] = tostring(xPlayer.getName()),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:AddWithdrawTransactionToSociety")
AddEventHandler("okokBanking:AddWithdrawTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.insert('INSERT INTO okokBanking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.identifier),
		['@receiver_name'] = tostring(xPlayer.getName()),
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("okokBanking:UpdateIbanDB")
AddEventHandler("okokBanking:UpdateIbanDB", function(iban, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if amount <= xPlayer.getAccount('bank').money then
		MySQL.update('UPDATE users SET iban = @iban WHERE identifier = @identifier', {
			['@iban'] = iban,
			['@identifier'] = xPlayer.identifier,
		}, function(changed)
		end)

		xPlayer.removeAccountMoney('bank', amount)
		TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, "bank", "Bank (IBAN)")
		TriggerClientEvent('okokBanking:updateIban', _source, iban)
		TriggerClientEvent('okokBanking:updateIbanPinChange', _source)

		TriggerClientEvent('esx:Notify', _source, "success", "帳戶號碼已變更為 "..iban)
	else
		TriggerClientEvent('esx:Notify', _source, "error", "如要變更帳戶號碼 你需要" .. amount .."$ 作手續費")
	end
end)

RegisterServerEvent("okokBanking:UpdatePINDB")
AddEventHandler("okokBanking:UpdatePINDB", function(pin, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if amount <= xPlayer.getAccount('bank').money then
		MySQL.update('UPDATE users SET pincode = @pin WHERE identifier = @identifier', {
			['@pin'] = pin,
			['@identifier'] = xPlayer.identifier,
		}, function(changed)
		end)

		xPlayer.removeAccountMoney('bank', amount)
		TriggerClientEvent('okokBanking:updateMoney', _source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
		TriggerEvent('okokBanking:AddTransferTransactionToSociety', amount, _source, "bank", "Bank (PIN)")
		TriggerClientEvent('okokBanking:updateIbanPinChange', _source)
		TriggerClientEvent('esx:Notify', _source, "success", "帳戶密碼已變更為 "..pin, 5000, 'success')
	else
		TriggerClientEvent('esx:Notify', _source, "error", "如要變更帳戶密碼 你需要" .. amount .."$ 作手續費")
	end
end)