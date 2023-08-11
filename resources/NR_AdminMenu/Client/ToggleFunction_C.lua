_G.UnlimitedStamina = false

function UnlimitedStaminaToggle()
    if UnlimitedStamina then
        local PlayerId = PlayerId()
        while UnlimitedStamina do
            ResetPlayerStamina(PlayerId)
            Wait(5000)
        end
    end
end