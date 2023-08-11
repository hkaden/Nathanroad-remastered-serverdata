ESX = nil
PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData.job = job
end)

function MyInvoices()
	ESX.TriggerServerCallback("okokBilling:GetInvoices", function(invoices)
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'myinvoices',
			invoices = invoices,
			VAT = Config.VATPercentage
		})			
	end)
end

function SocietyInvoices(society)
	ESX.TriggerServerCallback("okokBilling:GetSocietyInvoices", function(cb, totalInvoices, totalIncome, totalUnpaid, awaitedIncome)
		if json.encode(cb) ~= '[]' then
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'societyinvoices',
				invoices = cb,
				totalInvoices = totalInvoices,
				totalIncome = totalIncome,
				totalUnpaid = totalUnpaid,
				awaitedIncome = awaitedIncome,
				VAT = Config.VATPercentage
			})		
		else
			ESX.UI.Notify("info", "你的公司沒有任何發票.")
			SetNuiFocus(false, false)
		end
	end, society)
end

function CreateInvoice(society)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'createinvoice',
		society = society
	})
end

RegisterCommand(Config.InvoicesCommand, function()
	local isAllowed = false
	local jobName = ""
	for k, v in pairs(Config.AllowedSocieties) do
		if v == PlayerData.job.name then
			jobName = v
			isAllowed = true
		end
	end

	if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name == "boss" and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = true,
			create = true
		})
	elseif Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name ~= "boss" and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = false,
			create = true
		})
	elseif not Config.OnlyBossCanAccessSocietyInvoices and isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = true,
			create = true
		})
	elseif not isAllowed then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'mainmenu',
			society = false,
			create = false
		})
	end
end, false)

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		SetNuiFocus(false, false)
	elseif data.action == "payInvoice" then
		TriggerServerEvent("okokBilling:PayInvoice", data.invoice_id)
		SetNuiFocus(false, false)
	elseif data.action == "cancelInvoice" then
		TriggerServerEvent("okokBilling:CancelInvoice", data.invoice_id)
		SetNuiFocus(false, false)
	elseif data.action == "createInvoice" then
		local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()
		target = GetPlayerServerId(closestPlayer)
		data.target = target
		data.society = "society_"..PlayerData.job.name
		data.society_name = PlayerData.job.label

		if closestPlayer == -1 or playerDistance > 3.0 then
			ESX.UI.Notify("error", "你附近沒有玩家")
		else
			TriggerServerEvent("okokBilling:CreateInvoice", data)
			ESX.UI.Notify("success", "發票已經發送給玩家")
		end
		
		SetNuiFocus(false, false)
	elseif data.action == "missingInfo" then
		ESX.UI.Notify("error", "請填寫所有欄位!")
	elseif data.action == "negativeAmount" then
		ESX.UI.Notify("error", "請輸入正確的銀碼!")
	elseif data.action == "mainMenuOpenMyInvoices" then
		MyInvoices()
	elseif data.action == "mainMenuOpenSocietyInvoices" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				if Config.OnlyBossCanAccessSocietyInvoices and PlayerData.job.grade_name == "boss" then
					SocietyInvoices(PlayerData.job.label)
				elseif not Config.OnlyBossCanAccessSocietyInvoices then
					SocietyInvoices(PlayerData.job.label)
				elseif Config.OnlyBossCanAccessSocietyInvoices then
					ESX.UI.Notify("error", "只有老闆級別才能查看公司賬簿.")
				end
			end
		end
	elseif data.action == "mainMenuOpenCreateInvoice" then
		for k, v in pairs(Config.AllowedSocieties) do
			if v == PlayerData.job.name then
				CreateInvoice(PlayerData.job.label)
			end
		end
	end
end)

function CreateBilling(target)
	local data = {}
	data.targetName = -1
	data.target = target.id
	data.society = "society_"..PlayerData.job.name
	data.society_name = PlayerData.job.label
	data.invoice_item = target.fineLabel
	data.invoice_value = target.amount
	data.invoice_notes = "備註: "
	TriggerServerEvent("okokBilling:CreateInvoice", data)
	ESX.UI.Notify("success", "成功發出罰單!")
end
RegisterNetEvent("NR_Billing:CreateBilling", function(target) CreateBilling(target); end)
exports("CreateBilling", CreateBilling)