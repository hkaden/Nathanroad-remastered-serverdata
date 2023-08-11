Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
	PlayerData.job = job
end)

function IsJobTrue()
    if PlayerData ~= nil then
        local IsJobTrue = false
        if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'admin') then
            IsJobTrue = true
        end
        return IsJobTrue
    end
end

function DrawText3D(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function ToggleNormalAlarm()
	local dialog = exports['qb-input']:ShowInput({
        header = "一般警報",
        submitText = "提交",
        inputs = {
            {
                text = "選擇狀態", -- text you want to be displayed as a input header
                name = "toggle", -- name of the input should be unique otherwise it might override
                type = "select", -- type of the input - Check is useful for "AND" options e.g; taxincle = gst AND business AND othertax
                isRequired = true,
                options = { -- The options (in this case for a check) you want displayed, more than 6 is not recommended
                    { value = "true", text = "啟動警報"}, -- Options MUST include a value and a text option
                    { value = "false", text = "停用警報"}, -- Options MUST include a value and a text option
                }
            }
        },
    })
	if dialog then
		if not dialog.toggle then return end
		if dialog.toggle == 'true' then dialog.toggle = true elseif dialog.toggle == 'false' then dialog.toggle = false end
		local data = {Label = '', NotifyType = ''}
		if dialog.toggle == false then
			data.Label = '解除中...'
		elseif dialog.toggle == true then
			data.Label = '啟動中...'
		end
		exports.progress:Custom({
			Label = data.Label,
			Duration = 1000,
			LabelPosition = "top",
			Radius = 50,
			x = 0.88,
			y = 0.94,
			canCancel = true,
			Animation = {
				animationDictionary = "anim@amb@business@coc@coc_unpack_cut_left@",
				animationName = "coke_cut_v5_coccutter"
			},
			DisableControls = {
				Mouse = true,
				Player = true,
				Vehicle = false
			},
			onStart = function()
				ESX.UI.Notify("info", "按 [X] 取消操作")
			end,
			onComplete = function(cancelled)
				if not cancelled then
					TriggerServerEvent('NR_PoliceAllClear:server:ToggleAlarm', dialog.toggle)
					-- ESX.UI.Notify("info", data.NotifySuccess)
				else
					ESX.UI.Notify("info", "已取消操作")
				end
			end
		})
	end
end

local function ToggleBankingAlarm()
	local BankingAmount = exports["NR_Bankrobbery"]:GetBankingAmount()
	local dialog = exports['qb-input']:ShowInput({
        header = "一般警報",
        submitText = "提交",
        inputs = {
			{
                text = "選擇銀行", -- text you want to be displayed as a input header
                name = "bankId", -- name of the input should be unique otherwise it might override
                type = "select", -- type of the input - Check is useful for "AND" options e.g; taxincle = gst AND business AND othertax
                isRequired = true,
                options = { -- The options (in this case for a check) you want displayed, more than 6 is not recommended
                    { value = 1, text = "太平洋標準銀行"}, -- Options MUST include a value and a text option
                    { value = 2, text = "沙漠銀行"}, -- Options MUST include a value and a text option
                    { value = 3, text = "城市銀行 [大眾廣場分行]"}, -- Options MUST include a value and a text option
                    { value = 4, text = "城市銀行 [頂尖分行]"}, -- Options MUST include a value and a text option
                    { value = 5, text = "城市銀行 [伯頓分行]"}, -- Options MUST include a value and a text option
                    { value = 6, text = "城市銀行 [全福分行]"}, -- Options MUST include a value and a text option
                    { value = 7, text = "城市銀行 [海洋公路分行]"}, -- Options MUST include a value and a text option
                    { value = 8, text = "城市銀行 [沙漠分行]"}, -- Options MUST include a value and a text option
                    { value = 0, text = "所有銀行"}, -- Options MUST include a value and a text option
                }
            },
            {
                text = "選擇狀態", -- text you want to be displayed as a input header
                name = "toggle", -- name of the input should be unique otherwise it might override
                type = "select", -- type of the input - Check is useful for "AND" options e.g; taxincle = gst AND business AND othertax
                isRequired = true,
                options = { -- The options (in this case for a check) you want displayed, more than 6 is not recommended
                    { value = 'true', text = "啟動警報"}, -- Options MUST include a value and a text option
                    { value = 'false', text = "停用警報"}, -- Options MUST include a value and a text option
                }
            }
        },
    })
	if dialog then
		if dialog.toggle ~= nil and not dialog.bankId then return end
		if dialog.toggle == 'true' then dialog.toggle = true elseif dialog.toggle == 'false' then dialog.toggle = false end
		local data = {Label = '', NotifySuccess = '', NotifyType = '', Duration = 1000}
		if dialog.toggle == false then
			data.Label = '解除中...'
			data.NotifySuccess = '已解除'
		elseif dialog.toggle == true then
			data.Label = '啟動中...'
			data.NotifySuccess = '已啟動'
		end
		data.Duration = (dialog.bankId == '0' and 1000 * BankingAmount) or 1000
		exports.progress:Custom({
			Label = data.Label,
			Duration = 1000,
			LabelPosition = "top",
			Radius = 50,
			x = 0.88,
			y = 0.94,
			canCancel = true,
			Animation = {
				animationDictionary = "anim@amb@business@coc@coc_unpack_cut_left@",
				animationName = "coke_cut_v5_coccutter"
			},
			DisableControls = {
				Mouse = true,
				Player = true,
				Vehicle = false
			},
			onStart = function()
				ESX.UI.Notify("info", "按 [X] 取消操作")
			end,
			onComplete = function(cancelled)
				if not cancelled then
					if dialog.bankId ~= '0' then
						TriggerEvent('NR_Bankrobbery:client:ToggleBankingAlarm', tonumber(dialog.bankId), dialog.toggle)
						ESX.UI.Notify("success", data.NotifySuccess)
					else
						for i = 1, BankingAmount do
							TriggerEvent('NR_Bankrobbery:client:ToggleBankingAlarm', i, dialog.toggle)
							Wait(1000)
						end
						ESX.UI.Notify("success", data.NotifySuccess .. "所有警報")
					end
				else
					ESX.UI.Notify("info", "已取消操作")
				end
			end
		})
	end
end

local function openMenu()
	if IsJobTrue() then
		local elements = {
			{header = "關閉", params = {event = 'qb-menu:client:closeMenu'}},
			{header = '一般警報', params = {isAction = true, event = function() ToggleNormalAlarm() end}},
			{header = '銀行警報', params = {isAction = true, event = function() ToggleBankingAlarm() end}},
		}
		exports['qb-menu']:openMenu(elements)
	end
end

CreateThread(function()
    while true do
		sleep = 1000
		if PlayerData then
			if IsJobTrue() then
				local pos = GetEntityCoords(PlayerPedId())
				for k, v in pairs(Config.Locations["resetLoc"]) do
					if #(pos - v.coords) < 7.5 then
						sleep = 3
						DrawMarker(2, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
						if (#(pos - v.coords) < 2.0) then
							DrawText3D(v.coords, "~g~E~w~ - 警報系統")
							if IsControlJustReleased(0, Keys["E"]) then
								openMenu()
							end
						end  
					end
				end
			end
		end
        Wait(sleep)
	end
end)