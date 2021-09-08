ESX = nil

local spawnedweeds = 0
local weedPlants = {}
local isPickingUp, isProcessing = false, false
local PlayerData	= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.CircleZones.weedField.coords, true) < 50 then
			SpawnweedPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.weedProcessing.coords, true) < 1 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('weed_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then
				local PlayerData = ESX.GetPlayerData()
				if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then
					Processweed()

				else
					ESX.ShowNotification("Cán bộ nhà nước không thể làm việc này")

				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)


function Processweed()
	isProcessing = true

	--ESX.ShowNotification(_U('weed_processingstarted'))
	
	TriggerServerEvent('chebienweed')
					TriggerEvent("XNL_NET:AddPlayerXP", 100)
        		TriggerServerEvent("AddXp", 100)
	

	local timeLeft = Config.Delays.weedProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.weedProcessing.coords, false) > 4 then
			ESX.ShowNotification(_U('weed_processingtoofar'))
			TriggerServerEvent('esx_weed:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

		if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
					isPickingUp = true
					local 		PlayerData = ESX.GetPlayerData()

						ESX.TriggerServerCallback('Cothenhat', function(canPickUp)

									if canPickUp then
										if PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'ambulance' then

												TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

												Citizen.Wait(2000)
												ClearPedTasks(playerPed)
												Citizen.Wait(1500)
								
												ESX.Game.DeleteObject(nearbyObject)
								
												table.remove(weedPlants, nearbyID)
												spawnedweeds = spawnedweeds - 1
								
												TriggerServerEvent('haiweed')
										else
											ESX.ShowNotification("Cán bộ nhà nước không thể làm việc này")
										end
										--ESX.ShowNotification(_U('weed_inventoryfull'))
									end
								

								isPickingUp = false
							

							end, 'weed')
				
			
		end
	end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnweedPlants()
	while spawnedweeds < Config.MaxWeedsSpawn do
		Citizen.Wait(1)
		local weedCoords = GenerateweedCoords()
-- lá cocain: prop_fib_plant_02
-- lá weed gốc: prop_weed_02
		ESX.Game.SpawnLocalObject('bkr_prop_weed_lrg_01a', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants, obj)
			spawnedweeds = spawnedweeds + 1
		end)
	end
end

function ValidateweedCoord(plantCoord)
	if spawnedweeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.weedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateweedCoords()
	while true do
		Citizen.Wait(15)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)

		weedCoordX = Config.CircleZones.weedField.coords.x + modX
		weedCoordY = Config.CircleZones.weedField.coords.y + modY

		local coordZ = GetCoordZ(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateweedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end