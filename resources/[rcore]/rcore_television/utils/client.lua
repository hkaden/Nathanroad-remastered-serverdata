------------------------------------------------------------------
-- Need to be changed to your framework, for now default is ESX --
------------------------------------------------------------------
if Config.FrameWork == 1 then
    PlayerData = {}
    ESX = nil

    CreateThread(function()
        local breakme = 0
        while ESX == nil do
            Wait(100)
            breakme = breakme + 1
            TriggerEvent(Config.ESX_Object, function(obj) ESX = obj end)
            if breakme == 10 then
                return
            end
        end

        if ESX.IsPlayerLoaded() then
            PlayerData = ESX.GetPlayerData()
        end
    end)

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)

    function isAtJob(name)
        return PlayerData.job.name == name
    end
end

if Config.FrameWork == 2 then
    local PlayerData = {}
    local QBCore
    function UpdatePlayerDataForQBCore()
        local pData = QBCore.Functions.GetPlayerData()

        local jobName = "none"
        local gradeName = "none"

        if pData.job then
            jobName = pData.job.name or "none"

            if pData.job.grade then
                gradeName = pData.job.grade.name
            end
        end

        PlayerData = {
            job = {
                name = jobName,
                grade_name = gradeName,
            }
        }
    end

    CreateThread(function()
        QBCore = Config.GetQBCoreObject()

        if QBCore and QBCore.Functions.GetPlayerData() then
            UpdatePlayerDataForQBCore()
        end
    end)

    -- Will load player job + update markers
    RegisterNetEvent(Config.OnPlayerLoaded, function()
        UpdatePlayerDataForQBCore()
    end)

    -- Will load player job + update markers
    RegisterNetEvent(Config.OnJobUpdate, function()
        UpdatePlayerDataForQBCore()
    end)

    function isAtJob(name)
        return PlayerData.job.name == name
    end
end

if Config.FrameWork == 0 then
    function isAtJob(name)
        return true
    end
end
------------------------
-- Optional to change --
------------------------
-- This will allow to open any TV if true, other players wont be able to interact but will albe to see
-- what is playing on TVscreen
function CustomPermission()
    return true
end

function showNotification(text)
    ESX.UI.Notify('info', text)
    -- SetNotificationTextEntry('STRING')
    -- AddTextComponentString(text)
    -- DrawNotification(0, 1)
end

RegisterNetEvent('rcore_tv:notification')
AddEventHandler('rcore_tv:notification', showNotification)

---------------------------------
-- Do not change anything here --
---------------------------------
local cameras = {}

function createCamera(name, pos, rot, fov)
    fov = fov or 60.0
    rot = rot or vector3(0, 0, 0)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov, false, 0)
    local try = 0
    while cam == -1 or cam == nil do
        Citizen.Wait(10)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov, false, 0)
        try = try + 1
        if try > 20 then
            return nil
        end
    end
    local self = {}
    self.cam = cam
    self.position = pos
    self.rotation = rot
    self.fov = fov
    self.name = name
    self.lastPointTo = nil
    self.pointTo = function(pos)
        self.lastPointTo = pos
        PointCamAtCoord(self.cam, pos.x, pos.y, pos.z)
    end
    self.render = function()
        SetCamActive(self.cam, true)
        RenderScriptCams(true, true, 1, true, true)
    end
    self.changeCam = function(newCam, duration)
        duration = duration or 3000
        SetCamActiveWithInterp(newCam, self.cam, duration, true, true)
    end
    self.destroy = function()
        SetCamActive(self.cam, false)
        DestroyCam(self.cam)
        cameras[name] = nil
    end
    self.changePosition = function(newPos, newPoint, newRot, duration)
        newRot = newRot or vector3(0, 0, 0)
        duration = duration or 4000
        if IsCamRendering(self.cam) then
            local tempCam = createCamera(string.format('tempCam-%s', self.name), newPos, newRot, self.fov)
            tempCam.render()
            if self.lastPointTo ~= nil then
                tempCam.pointTo(newPoint)
            end
            self.changeCam(tempCam.cam, duration)
            Citizen.Wait(duration)
            self.destroy()
            local newMain = deepCopy(tempCam)
            newMain.name = self.name
            self = newMain
            tempCam.destroy()
        else
            createCamera(self.name, newPos, newRot, self.fov)
        end
    end

    cameras[name] = self
    return self
end

function stopRendering()
    RenderScriptCams(false, false, 1, false, false)
end

function disableControls(toggle)
    blockInput = toggle
end