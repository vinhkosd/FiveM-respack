local Keys = {
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
--================ begin variables
local VehicleList = {}
Config = {}
--================ end variables
--================ begin config
Config.disableNPC = true
--================ end config

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustReleased(0, Keys['243']) then
			lock()
			Citizen.Wait(1000)
		end
	end
end)

function lock()
	local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player,true)
	local vehicleplate = GetVehicleNumberPlateText(vehicle)
	local lastvehicle= GetVehiclePedIsIn (player, true)
	local islocked = GetVehicleDoorLockStatus(vehicle)
	
	
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
	local clostestvehicle = GetClosestVehicle(x, y, z, 7.000, 0, 127)
	local clostestvehicleplate = GetVehicleNumberPlateText(clostestvehicle)
	local islockedclostestvehicle = GetVehicleDoorLockStatus(clostestvehicle)
	local isvehiclefound = false

	
	local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 20.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 7, player, 0)
    local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)
	local vehicleHandleplate = GetVehicleNumberPlateText(vehicleHandle)
	local islockedHandle = GetVehicleDoorLockStatus(vehicleHandle)
	
	local foundclostestvehicle = false
	
	
	if DoesEntityExist(vehicle) then
		if IsPedInAnyVehicle(player) or IsPedInAnyHeli(player) then
			if vehicleplate ~= nil and clostestvehicleplate ~= nil then
				if not table.empty(VehicleList) then
					for k,v in pairs(VehicleList) do
						if v.plate == vehicleplate then
							isvehiclefound = true
							break
						end
					end
					if isvehiclefound then
						if (islocked == 1)then
							SetVehicleDoorsLocked(vehicle, 2)
							Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ da ~r~khoa xe.~w~")
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)StartVehicleHorn(vehicle, 100, 1, false)
							StartVehicleHorn(vehicle, 100, 1, false)
							Citizen.CreateThread(function()
							local dict = "anim@mp_player_intmenu@key_fob@"
							
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(100)
							end
							local lock = false
							while true do
								Citizen.Wait(0)
								if IsControlJustPressed(1, 243) then ---Klawisz U 
									if not lock then
										TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
										StopAnimTask = true

									end
								end
							end
						end)
						else
							SetVehicleDoorsLocked(vehicle,1)
							Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ mo ~g~khoa xe.~w~")
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)
							Citizen.CreateThread(function()
							local dict = "anim@mp_player_intmenu@key_fob@"
							
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(100)
							end
							local lock = false
							while true do
								Citizen.Wait(0)
								if IsControlJustPressed(1, 243) then ---Klawisz U 
									if not lock then
										TaskPlayAnim(GetPlayerPed(-1), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
										StopAnimTask = true

									end
								end
							end
						end)
						end
					else
						if (islocked == 1)then
							SetVehicleDoorsLocked(vehicle, 2)
							Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ da ~r~khoa xe.~w~")
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)
							table.insert(VehicleList, {plate = vehicleplate})
						else
							SetVehicleDoorsLocked(vehicle,1)
							Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ mo ~g~khoa xe.~w~")
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)
						end
					end
				else
					SetVehicleDoorsLocked(vehicle, 2)
					Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ da ~r~khoa xe.~w~")
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)
					table.insert(VehicleList, {plate = vehicleplate})
				end
			else
				Notify("~r~Khong co xe gan ban!")
			end
		else
			if not table.empty(VehicleList) then
				if vehicleHandleplate ~= nil or clostestvehicleplate ~= nil then
					for k,v in pairs(VehicleList) do
						if v.plate == clostestvehicleplate then
							isvehiclefound = true
							foundclostestvehicle = true
							break
						end
					end
					if not foundclostestvehicle then
						for k,v in pairs(VehicleList) do
							if v.plate == vehicleHandleplate then
								isvehiclefound = true
								break
							end
						end
					end
					if isvehiclefound then
						if not foundclostestvehicle then 
							if (islockedHandle == 1)then
								SetVehicleDoorsLocked(vehicleHandle, 2)
								Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleHandle))) .. "~w~ da ~r~khoa xe.~w~")
								TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)
							else
								SetVehicleDoorsLocked(vehicleHandle,1)
								Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleHandle))) .. "~w~ mo ~g~khoa xe.~w~")
								TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Mo Khoa", 1.0)
							end
						else
							if (islockedclostestvehicle == 1)then
								SetVehicleDoorsLocked(clostestvehicle, 2)
								Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(clostestvehicle))) .. "~w~ da ~r~khoa xe.~w~")
								TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Khoa", 1.0)
								SetVehicleLights(vehicle, 2) Wait (400)
								SetVehicleLights(vehicle, 0) Wait (400)
								SetVehicleLights(vehicle, 2) Wait (400)
								SetVehicleLights(vehicle, 0) Wait (50)
								StartVehicleHorn(vehicle, 100, 1, false)
								foundclostestvehicle = false
							else
								SetVehicleDoorsLocked(clostestvehicle,1)
								Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(clostestvehicle))) .. "~w~ mo ~g~khoa xe.~w~")
								TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "Mo Khoa", 1.0)
								SetVehicleLights(vehicle, 2) Wait (400)
								SetVehicleLights(vehicle, 0) Wait (400)
								SetVehicleLights(vehicle, 2) Wait (400)
								SetVehicleLights(vehicle, 0) Wait (50)
								StartVehicleHorn(vehicle, 100, 1, false)
								foundclostestvehicle = false
							end

						end
					else
						Notify("Chiec xe ban muon mo, khong ~r~ co san cho ban~w~.")
					end
				else
					Notify("~r~Khong co xe gan ban!")
				end
			else
				Notify("~r~Khong co phuong tien de dong hoac phuong tien duoc dong lai.")
			end
		end
	else
		if DoesEntityExist(vehicleHandle) then
			if vehicleHandleplate ~= nil then
				for k,v in pairs(VehicleList) do
					if v.plate == vehicleHandleplate then
						isvehiclefound = true
						break
					end
				end
				if isvehiclefound then
					if (islockedHandle == 1)then
						SetVehicleDoorsLocked(vehicleHandle, 2)
						Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleHandle))) .. "~w~ da ~r~khoa xe.~w~")
					    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 1.0)
					else
						SetVehicleDoorsLocked(vehicleHandle,1)
						Notify("Xe ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicleHandle))) .. "~w~ mo ~g~khoa xe.~w~")
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 1.0)
					end
				else
					Notify("Chiec xe ban muon mo la ~r~dong~w~.")
				end
			end
		end
	end
end

---------- disable pnj Carjacking
if Config.disableNPC then
	Citizen.CreateThread(function()
		while true do
			Wait(700)

			local player = GetPlayerPed(-1)

			if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(player))) then
				local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(player))
				local lock = GetVehicleDoorLockStatus(veh)

				if lock == 7 then
					SetVehicleDoorsLocked(veh, 2)
				end

				local pedd = GetPedInVehicleSeat(veh, -1)

				if pedd then
					SetPedCanBeDraggedOut(pedd, false)
				end
			end
		end
	end)
end

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end
