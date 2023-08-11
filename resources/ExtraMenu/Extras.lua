ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

local AvailableExtras = {['VehicleExtras'] = {}}
local Items = {['Vehicle'] = {}}
local MenuExists, Vehicle
_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Vehicle Extras", "~b~Select Extras")       
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled (false);
_menuPool:MouseEdgeEnabled (false);
_menuPool:ControlDisablingEnabled(false);

function Extras(menu)
    mainMenu:Clear()
    local AvailableExtras = {['VehicleExtras'] = {}}
    local Items = {['Vehicle'] = {}}
    local MenuExists
    local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local GotVehicleExtras = false
    for ExtraID = 0, 20 do
        if DoesExtraExist(Vehicle, ExtraID) then
                AvailableExtras.VehicleExtras[ExtraID] = (IsVehicleExtraTurnedOn(Vehicle, ExtraID) == 1)
                GotVehicleExtras = true
        end
    end
    -- Vehicle Extras
    if GotVehicleExtras then
        for Key, Value in pairs(AvailableExtras.VehicleExtras) do
                local ExtraItem = NativeUI.CreateCheckboxItem('Extra ' .. Key, AvailableExtras.VehicleExtras[Key],"Enable or Disable Extras")
                mainMenu:AddItem(ExtraItem)
                Items.Vehicle[Key] = ExtraItem
        end
        menu.OnCheckboxChange = function(Sender, Item, Checked)
                for Key, Value in pairs(Items.Vehicle) do
                        if Item == Value then
                                AvailableExtras.VehicleExtras[Key] = Checked
                                if AvailableExtras.VehicleExtras[Key] then
                                        SetVehicleExtra(Vehicle, Key, 0)
                                else
                                        SetVehicleExtra(Vehicle, Key, 1)
                                end
                        end
                end
        end
    end
end
-- Extras(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    while true do
        Citizen.Wait(3)
        _menuPool:ProcessMenus()
        if PlayerData.job.name == 'gov' then
            if IsControlJustPressed(1, 56) then
                Extras(mainMenu)
                mainMenu:Visible(not mainMenu:Visible())
            end
        else
            Citizen.Wait(500)
        end
    end
end)