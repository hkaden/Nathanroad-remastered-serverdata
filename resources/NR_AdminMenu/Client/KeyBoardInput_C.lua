----------------------- [ JP_AdminMenu ] -----------------------
-- GitHub: https://github.com/juanp15
-- License:
-- url
-- Author: Juanp
-- Name: JP_AdminMenu
-- Version: 1.0.0
-- Description: JP Admin Menu
----------------------- [ JP_AdminMenu ] -----------------------

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        if IsDisabledControlPressed(0, 322) then return "" end
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end