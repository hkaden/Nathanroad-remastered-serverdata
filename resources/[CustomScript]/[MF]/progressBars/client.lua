function startUI(time, text) 
  SendNUIMessage({
    type = "ui",
    display = true,
    time = time,
    text = text
  })
end

function closeUI(...) 
  SendNUIMessage({
    type = "ui",
    display = false,
  })
end

RegisterCommand('startp', function(...) startUI(60 * 1000); TriggerServerEvent('txaLogger:CommandExecuted', "sp"); end)
RegisterCommand('closep', function(...) closeUI(); TriggerServerEvent('txaLogger:CommandExecuted', "cp"); end)