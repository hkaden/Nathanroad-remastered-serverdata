RegisterCommand("record", function(source , args)
    StartRecording(1)
    ESX.UI.Notify("success", "Started Recording!")
end)

RegisterCommand("clip", function(source , args)
    StartRecording(0)
end)

RegisterCommand("saveclip", function(source , args)
    StopRecordingAndSaveClip()
    ESX.UI.Notify("success", "Saved Recording!")
end)

RegisterCommand("delclip", function(source , args)
    StopRecordingAndDiscardClip()
    ESX.UI.Notify("error", "Deleted Recording!")
end)

RegisterCommand("editor", function(source , args)
    NetworkSessionLeaveSinglePlayer()
    ActivateRockstarEditor()
    ESX.UI.Notify("error", "Later aligator!")
end)