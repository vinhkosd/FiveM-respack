ESX = nil 
local toaDoDrop = nil
local spawnedObj = nil
local sleepTime = 500
local looting = false
spawned = false
local pressed = false
Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
	end
	
	--Citizen.Wait(20000)
	--print('Lorraxs_drop: Synced')
	--TriggerServerEvent('lorraxs_drop:syncDrop')
end)

RegisterNetEvent('lorraxs_drop:toaDo')
AddEventHandler('lorraxs_drop:toaDo', function(posX, posY)
	--local ped =  PlayerPedId()
	--local pedCoords = GetEntityCoords(ped)
	--local dumpedTable = ESX.DumpTable(pedCoords)
	local coords = vector3(posX, posY, 30.00)

	--print(dumpedTable)
	--exports['mythic_notify']:DoLongHudText('error', 'message'..toaDo.x)
	
	CreateBlip(coords)
	toaDoDrop = {
		x = posX,
		y = posY
	}
end)

-- RegisterNetEvent('lorraxs_drop:addWeapon')
-- AddEventHandler('lorraxs_drop:addWeapon', function(weaponName)
	-- local playerPed = PlayerPedId()
	-- local weaponHash = GetHashKey(weaponName)
	-- GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
	-- AddAmmoToPed(playerPed, weaponHash, 400)
	-- TriggerServerEvent('Lorraxs:drop', GetPlayerName(PlayerId()).." đã nhận được "..weaponName.." từ kho báu")
-- end)

RegisterNetEvent('lorraxs_drop:deleteDrop')
AddEventHandler('lorraxs_drop:deleteDrop', function()
	ESX.Game.DeleteObject(spawnedObj)
	spawnedObj = nil
	toaDoDrop = nil
	RemoveBlip(blip)
	spawned = false
end)
	
	

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(sleepTime)
		if toaDoDrop ~= nil then
			
			sleepTime = 1
			local ped =  PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local Distance = GetDistanceBetweenCoords(pedCoords, toaDoDrop.x, toaDoDrop.y, toaDoDrop.z, false)
			if Distance < 20 then
				if spawned == false then
					local hash = `xm_prop_rsply_crate04a`
					for height = 1, 1000, 1 do
						local foundGround, zPos = GetGroundZFor_3dCoord(toaDoDrop.x, toaDoDrop.y, height + 0.0)
						if foundGround then
							coords = vector3(toaDoDrop.x, toaDoDrop.y, zPos)
								
								ESX.Game.SpawnLocalObject(hash, coords, function(obj)
									PlaceObjectOnGroundProperly(obj)
									FreezeEntityPosition(obj, true)
									spawnedObj = obj
									spawned = true
								end)
							
							break
						end
						Citizen.Wait(5)
					end
				end
				ESX.Game.Utils.DrawText3D(coords, '~r~Nhấn [E] để mở rương', 1, ESX.FontId)
				if Distance < 2 and pressed == false then
					if IsControlJustReleased(0, 38) then
						pressed = true
						SetTimeout(10000, delaypress)
						ESX.TriggerServerCallback('lorraxs_drop:isLooting', function(cb)
							if cb == false then
								looting = true
								TriggerEvent("mythic_progbar:client:progress", {
									name = "khobau",
									duration = 120000,
									label = "Đang loot",
									useWhileDead = false,
									canCancel = true,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									},
									animation = {
										animDict = "",
										anim = "",
									},
									prop = {
										model = "",
									}
								}, function(status)
									if not status then
										TriggerServerEvent('lorraxs_drop:daLoot')
										--ESX.Game.DeleteObject(spawnedObj)
										sleepTime = 500
										looting = false
										--spawned = false
									else 
										looting = false
										TriggerServerEvent('lorraxs_drop:stopLoot')
									end
								end)
							end
						end)
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		if looting == true then
			Citizen.Wait(1000)
			local ped =  PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local Distance = GetDistanceBetweenCoords(pedCoords, toaDoDrop.x, toaDoDrop.y, toaDoDrop.z, false)
			if Distance > 10 then
				TriggerEvent("mythic_progbar:client:cancel")
				looting = false
			end
		end
	end
end)

function delaypress()
	if pressed == true then
		pressed = false
	end
end
