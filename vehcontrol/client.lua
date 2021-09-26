local isInVehControl = false
local windowState1 = true
local windowState2 = true
local windowState3 = true
local windowState4 = true

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
            end)
    end
end)

Citizen.CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local lock = false
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if LeaveRunning then
			local playerPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			if IsPedInAnyVehicle(playerPed, false) and IsControlPressed(2, 75) and not IsEntityDead(playerPed) then
                Citizen.Wait(150)
				if IsPedInAnyVehicle(playerPed, false) and IsControlPressed(2, 75) and not IsEntityDead(playerPed) then
					SetVehicleEngineOn(vehicle, true, true, false)
					TaskLeaveVehicle(playerPed, vehicle, 0)
				end
			end
		end
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if ( IsControlJustReleased( 0, 40 ) or IsDisabledControlJustReleased( 0, 40 ) ) and GetLastInputMethod( 0 ) and not IsPauseMenuActive() then -- Key to open NUI https://docs.fivem.net/docs/game-references/controls/
				openVehControl()
			end
		end
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and DisableSeatShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
    end
end)

-----------------------------------------------------------------------------
-- NUI OPEN EXPORT/EVENT
-----------------------------------------------------------------------------

function openExternal()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		openVehControl()
	end
end

RegisterNetEvent('vehcontrol:openExternal')
AddEventHandler('vehcontrol:openExternal', function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		openVehControl()
	end
end)

-----------------------------------------------------------------------------
-- NUI OPEN/CLOSE FUNCTIONS
-----------------------------------------------------------------------------

function openVehControl()
	isInVehControl = true
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = "openGeneral"
	})
end

function closeVehControl()
	isInVehControl = false
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "closeAll"
	})
end

RegisterNUICallback('NUIFocusOff', function()
	isInVehControl = false
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "closeAll"
	})
end)

-----------------------------------------------------------------------------
-- NUI CALLBACKS
-----------------------------------------------------------------------------

RegisterNUICallback('ignition', function()
    EngineControl()
end)

RegisterNUICallback('interiorLight', function()
	InteriorLightControl()
end)

RegisterNUICallback('doors', function(data, cb)
	DoorControl(data.door)
end)

RegisterNUICallback('seatchange', function(data, cb)
	SeatControl(data.seat)
end)

RegisterNUICallback('windows', function(data, cb)
	WindowControl(data.window, data.door)
end)

-----------------------------------------------------------------------------
-- ACTION FUNCTIONS
-----------------------------------------------------------------------------

function EngineControl()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end

function InteriorLightControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleInteriorLightOn(vehicle) then
			SetVehicleInteriorlight(vehicle, false)
		else
			SetVehicleInteriorlight(vehicle, true)
		end
	end
end

function DoorControl(door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end

function SeatControl(seat)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicle, seat)
		end
	end
end

function WindowControl(window, door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if window == 0 then
			if windowState1 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState1 = false
			else
				RollUpWindow(vehicle, window)
				windowState1 = true
			end
		elseif window == 1 then
			if windowState2 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState2 = false
			else
				RollUpWindow(vehicle, window)
				windowState2 = true
			end
		elseif window == 2 then
			if windowState3 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState3 = false
			else
				RollUpWindow(vehicle, window)
				windowState3 = true
			end
		elseif window == 3 then
			if windowState4 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState4 = false
			else
				RollUpWindow(vehicle, window)
				windowState4 = true
			end
		end
	end
end

function FrontWindowControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if windowState1 == true or windowState2 == true then
			RollDownWindow(vehicle, 0)
			RollDownWindow(vehicle, 1)
			windowState1 = false
			windowState2 = false
		else
			RollUpWindow(vehicle, 0)
			RollUpWindow(vehicle, 1)
			windowState1 = true
			windowState2 = true
		end
	end
end

function BackWindowControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if windowState3 == true or windowState4 == true then
			RollDownWindow(vehicle, 2)
			RollDownWindow(vehicle, 3)
			windowState3 = false
			windowState4 = false
		else
			RollUpWindow(vehicle, 2)
			RollUpWindow(vehicle, 3)
			windowState3 = true
			windowState4 = true
		end
	end
end

function AllWindowControl()
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if windowState1 == true or windowState2 == true or windowState3 == true or windowState4 == true then
			RollDownWindow(vehicle, 0)
			RollDownWindow(vehicle, 1)
			RollDownWindow(vehicle, 2)
			RollDownWindow(vehicle, 3)
			windowState1 = false
			windowState2 = false
			windowState3 = false
			windowState4 = false
		else
			RollUpWindow(vehicle, 0)
			RollUpWindow(vehicle, 1)
			RollUpWindow(vehicle, 2)
			RollUpWindow(vehicle, 3)
			windowState1 = true
			windowState2 = true
			windowState3 = true
			windowState4 = true
		end
	end
end

-----------------------------------------------------------------------------
-- VEHICLE COMMANDS
-----------------------------------------------------------------------------
if UseCommands then
	-- ENGINE
	TriggerEvent('chat:addSuggestion', '/engine', 'Start/Stop Engine')

	RegisterCommand("engine", function(source, args, rawCommand)
		EngineControl()
	end, false)

	-- DOORS
	TriggerEvent('chat:addSuggestion', '/door', 'Open/Close Vehicle Door', {
		{ name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
	})

	RegisterCommand("door", function(source, args, rawCommand)
		local doorID = tonumber(args[1])
		if doorID ~= nil then
			if doorID == 1 then
				DoorControl(0)
			elseif doorID == 2 then
				DoorControl(1)
			elseif doorID == 3 then
				DoorControl(2)
			elseif doorID == 4 then
				DoorControl(3)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/door [door id]")
		end
	end, false)

	-- SEAT
	TriggerEvent('chat:addSuggestion', '/seat', 'Move to a seat', {
		{ name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
	})

	RegisterCommand("seat", function(source, args, rawCommand)
		local seatID = tonumber(args[1])
		if seatID ~= nil then
			if seatID == 1 then
				SeatControl(-1)
			elseif seatID == 2 then
				SeatControl(0)
			elseif seatID == 3 then
				SeatControl(1)
			elseif seatID == 4 then
				SeatControl(2)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/seat [seat id]")
		end
	end, false)

	-- WINDOWS
	TriggerEvent('chat:addSuggestion', '/window', 'Roll Up/Down Window', {
		{ name="ID", help="1) Driver, 2) Passenger, 3) Driver Side Rear, 4) Passenger Side Rear" }
	})

	RegisterCommand("window", function(source, args, rawCommand)
		local windowID = tonumber(args[1])
		
		if windowID ~= nil then
			if windowID == 1 then
				WindowControl(0, 0)
			elseif windowID == 2 then
				WindowControl(1, 1)
			elseif windowID == 3 then
				WindowControl(2, 2)
			elseif windowID == 4 then
				WindowControl(3, 3)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/window [door id]")
		end
	end, false)

	-- HOOD
	TriggerEvent('chat:addSuggestion', '/hood', 'Open/Close Hood')

	RegisterCommand("hood", function(source, args, rawCommand)
		DoorControl(4)
	end, false)

	-- TRUNK
	TriggerEvent('chat:addSuggestion', '/trunk', 'Open/Close Trunk')

	RegisterCommand("trunk", function(source, args, rawCommand)
		DoorControl(5)
	end, false)

	-- FRONT WINDOWS
	TriggerEvent('chat:addSuggestion', '/windowfront', 'Roll Up/Down Front Windows')

	RegisterCommand("windowfront", function(source, args, rawCommand)
		FrontWindowControl()
	end, false)

	-- BACK WINDOWS
	TriggerEvent('chat:addSuggestion', '/windowback', 'Roll Up/Down Back Windows')

	RegisterCommand("windowback", function(source, args, rawCommand)
		BackWindowControl()
	end, false)

	-- ALL WINDOWS
	TriggerEvent('chat:addSuggestion', '/windowall', 'Roll Up/Down All Windows')

	RegisterCommand("windowall", function(source, args, rawCommand)
		AllWindowControl()
	end, false)
end

-- FORCE CLOSE
RegisterCommand("vehcontrolclose", function(source, args, rawCommand)
	closeVehControl()
end, false)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('vehcontrol:lockDoor')
AddEventHandler('vehcontrol:lockDoor', function()
	print("lockDoor")
	local vehicle = VehicleNearBy()
	if DoesEntityExist(vehicle) then
		print("co xe o gan")
		local vehicleProps = GetVehicleProperties(vehicle)
		local KindOfVehicle = "personal"
		ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
				if(valid) then
					local vehicleModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
					local msgType = "success"
					local plateVeh = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
					local message = "Đã mở khóa xe "..vehicleModel..". Biển số : "..plateVeh.." ."
					local islocked = GetVehicleDoorLockStatus(vehicle)
					if (islocked == 1) then -- mo khoa thi khoa xe lai
						msgType = "warning"
						message = "Đã khóa xe "..vehicleModel..". Biển số : "..plateVeh.." ."
						SetVehicleDoorsLocked(vehicle, 2)
						SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
						SetVehicleDoorsLockedForAllPlayers(vehicle, true)
					else -- dang khoa thi mo xe
						SetVehicleDoorsLocked(vehicle,1)
						SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
						SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					end

					TriggerEvent("pNotify:SendNotification",{
						text = "<b style='color:#1E90FF'>"..message.."</b>",
						type = msgType,
						timeout = (3000),
						layout = "centerLeft",
						queue = "global"
					})

					local dict = "anim@mp_player_intmenu@key_fob@" -- hieu ung cam remote
    				RequestAnimDict(dict)
					TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
					-- bat coi` xe & den`
					StartVehicleHorn(vehicle, 100, 1, false) -- còi 100ms
					SetVehicleLights(vehicle, 2) -- đèn sáng
					Wait (200) -- delay 200ms
					SetVehicleLights(vehicle, 0) -- đèn tắt
					StartVehicleHorn(vehicle, 100, 1, false) -- còi 100ms
					Wait (200) -- delay 200ms
					SetVehicleLights(vehicle, 2) -- đèn sáng
					Wait (400) -- delay 400ms
					SetVehicleLights(vehicle, 0) -- đèn tắt
				end
		end,vehicleProps, KindOfVehicle)
	else
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#1E90FF'>Không có phương tiện nào ở gần</b>",
            type = "error",
            timeout = (3000),
            layout = "centerLeft",
            queue = "global"
        })
	end
end)

function VehicleNearBy() -- Xe o gan hoac xe dang lai
	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local playerPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerPed, false)

	if DoesEntityExist(vehicle) then
		return vehicle
	else
		local closecar = GetClosestVehicle(x, y, z, 3.0, 0, 71)
		return closecar
	end
	
  end

  GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}
        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end
        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)
            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
        vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)
        vehicleProps["vehicleType"] = GetVehicleClass(vehicle)

        return vehicleProps
    end
end