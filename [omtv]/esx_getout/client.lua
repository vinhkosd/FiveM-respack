-- Kick khoi xe nha nuoc -- Linh --
ESX					= nil
local PlayerData	= {}
local waitTimeInSeconds = 5  -- Thoi gian truoc khi bi kick

local waitTime = waitTimeInSeconds * 1000

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
        	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local vehicleClass = GetVehicleClass(vehicle)
		PlayerData = ESX.GetPlayerData()
		
		if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
			if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' and PlayerData.job.name ~= 'mechanic' then
			ClearPedTasksImmediately(PlayerPedId())
			TaskLeaveVehicle(PlayerPedId(),vehicle,0)
			ESX.ShowNotification("Bạn không có quyền lên xe nhà nước")
			Citizen.Wait(waitTime)
				if IsPedInVehicle(PlayerPedId(), vehicle, false) then
			ClearPedTasksImmediately(PlayerPedId())
				end
			end
		end
	end
end)
