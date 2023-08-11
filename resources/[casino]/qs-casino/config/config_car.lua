local spinningObject = nil
local spinningCar = nil

local carOnShow = Config.CarOnShow

function drawCarForWins()
	if DoesEntityExist(spinningCar) then
	DeleteEntity(spinningCar)
	end
	RequestModel(carOnShow)
	while not HasModelLoaded(carOnShow) do
		Citizen.Wait(0)
	end
	SetModelAsNoLongerNeeded(carOnShow)
	spinningCar = CreateVehicle(carOnShow, 1100.0, 220.0, -51.0 + 0.05, 0.0, 0, 0)
	Wait(0)
	SetVehicleDirtLevel(spinningCar, 0.0)
	SetVehicleOnGroundProperly(spinningCar)
	Wait(0)
	FreezeEntityPosition(spinningCar, 1)
end

function enterCasino(pIsInCasino, pFromElevator, pCoords, pHeading)
	if pIsInCasino == inCasino then return end
	inCasino = pIsInCasino
	if DoesEntityExist(spinningCar) then
		DeleteEntity(spinningCar)
	end
	Wait(500)
	spinMeRightRoundBaby()
	showDiamondsOnScreenBaby()
	playSomeBackgroundAudioBaby()
end

function spinMeRightRoundBaby()
	Citizen.CreateThread(function()
	while inCasino do
		if not spinningObject or spinningObject == 0 or not DoesEntityExist(spinningObject) then
		spinningObject = GetClosestObjectOfType(1100.0, 220.0, -51.0, 10.0, -1561087446, 0, 0, 0)
		drawCarForWins()
		end
		if spinningObject ~= nil and spinningObject ~= 0 then
		local curHeading = GetEntityHeading(spinningObject)
		local curHeadingCar = GetEntityHeading(spinningCar)
		if curHeading >= 360 then
			curHeading = 0.0
			curHeadingCar = 0.0
		elseif curHeading ~= curHeadingCar then
			curHeadingCar = curHeading
		end
		SetEntityHeading(spinningObject, curHeading + 0.075)
		SetEntityHeading(spinningCar, curHeadingCar + 0.075)
		end
		Wait(0)
	end
	spinningObject = nil
	end)
end

-- render tv 
function showDiamondsOnScreenBaby()
	Citizen.CreateThread(function()
	local model = GetHashKey("vw_vwint01_video_overlay")
	local timeout = 21085 -- 5000 / 255

	local handle = CreateNamedRenderTargetForModel("CasinoScreen_01", model)

	RegisterScriptWithAudio(0)
	SetTvChannel(-1)
	SetTvVolume(0)
	SetScriptGfxDrawOrder(4)
	SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
	SetTvChannel(2)
	EnableMovieSubtitles(1)

	function doAlpha()
		Citizen.SetTimeout(timeout, function()
		SetTvChannelPlaylist(2, "CASINO_DIA_PL", 0)
		SetTvChannel(2)
		doAlpha()
		end)
	end
	doAlpha()

	Citizen.CreateThread(function()
	while inCasino do
	SetTextRenderId(handle)
	DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	Citizen.Wait(0)
	end
	SetTvChannel(-1)
	ReleaseNamedRendertarget(GetHashKey("CasinoScreen_01"))
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	end)
 end)
end

function playSomeBackgroundAudioBaby()
	Citizen.CreateThread(function()
	local function audioBanks()
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false, -1) do
		Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false, -1) do
		Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false, -1) do
		Citizen.Wait(0)
		end
		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false, -1) do
		Citizen.Wait(0)
		end
	end
	audioBanks()
	while inCasino do
		if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
		PlayStreamFromPosition(1111, 230, -47)
		end
		if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
		StartAudioScene("DLC_VW_Casino_General")
		end
		Citizen.Wait(1000)
	end
	if IsStreamPlaying() then
		StopStream()
	end
	if IsAudioSceneActive("DLC_VW_Casino_General") then
		StopAudioScene("DLC_VW_Casino_General")
	end
	end)
end

AddEventHandler("onResourceStop", function(resourceName)
	if ("qs-casino" == resourceName) then
		if DoesEntityExist(spinningCar) then
			DeleteEntity(spinningCar)
		end
    end
end)