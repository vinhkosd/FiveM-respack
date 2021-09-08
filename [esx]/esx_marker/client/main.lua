local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

-- Copyright © 2019 by Guy Shefer
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
-- Tweaked by Campinchris (Added ESX only Diff animation for Police and Non Police)
----------------------------------------------------------------
whitelisted = false
whiteCheck = true
Config 				  = {}
Config.CooldownPolice = 700
Config.cooldown		  = 1700

-- Add/remove weapon hashes here to be added for holster checks.
Config.Weapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_FLAREGUN",
	"WEAPON_STUNGUN",
	"WEAPON_REVOLVER",
}

RegisterCommand("tpm", function(source)
    TeleportToWaypoint()
end)

TeleportToWaypoint = function()
    ESX.TriggerServerCallback("esx_marker:fetchUserRank", function(playerRank)
        if playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            local WaypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(WaypointHandle) then
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

                for height = 1, 1000 do
                    SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

                    if foundGround then
                        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                        break
                    end

                    Citizen.Wait(5)
                end

                exports['mythic_notify']:DoLongHudText('success', "Đã dịch chuyển")
            else
                exports['mythic_notify']:DoLongHudText('inform', "Hãy chọn vị trí cần tới trên bản đồ")
            end
        else
            exports['mythic_notify']:DoLongHudText('inform', "Bạn không có quyền hạn để dùng lệnh này")
        end
    end)
end

--coords--
local coordsVisible = false

function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.5)
end

function DrawHealth(health, maxh, giap, maxgiap)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentString('mau'..health..', max :'..maxh..', giáp:'..giap..', max giáp:'..maxgiap)
	EndTextCommandDisplayText(0.3, 0.3)
end

Citizen.CreateThread(function()
    while true do
		local sleepThread = 250
		
		if coordsVisible then
			sleepThread = 5

			local playerPed = PlayerPedId()
			local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
			local playerH = GetEntityHeading(playerPed)
			local playerHe = GetEntityHealth(playerPed)
			local PlayerM = GetEntityMaxHealth(playerPed)
			local playerAr = GetPedArmour(playerPed)
			local playerMar = GetPlayerMaxArmour(PlayerId())
			DrawHealth(playerHe, PlayerM, playerAr, playerMar)

			DrawGenericText(("~g~X~w~: %s ~g~Y~w~: %s ~g~Z~w~: %s ~g~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
		end

		Citizen.Wait(sleepThread)
	end
end)

-- Citizen.CreateThread(function()
	-- Citizen.Wait(1000)
	-- while true do
		-- Citizen.Wait(0)
		-- local ped = PlayerPedId()
		-- local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
		-- local still = IsPedStill(ped)
		-- Wait(3000)
		-- local newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
		-- local newPed = PlayerPedId()
		-- --if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 300 and not IsPedInAnyVehicle(ped, false) and not IsPedFalling(ped) and IsPedOnFoot(ped)  then
			-- --exports['mythic_notify']:DoLongHudText('inform', GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
		-- --end
	-- end
-- end)

FormatCoord = function(coord)
	if coord == nil then
		return "unknown"
	end

	return tonumber(string.format("%.2f", coord))
end

ToggleCoords = function()
	coordsVisible = not coordsVisible
end

RegisterCommand("coords", function()
    ToggleCoords()
end)

---holserweapon---
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		loadAnimDict("rcmjosh4")
		loadAnimDict("reaction@intimidation@cop@unarmed")
		loadAnimDict("reaction@intimidation@1h")
		local ped = PlayerPedId()

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			if not IsPedInAnyVehicle(ped, false) then
				if GetVehiclePedIsTryingToEnter (ped) == 0 and not IsPedInParachuteFreeFall (ped) then
					if CheckWeapon(ped) then
						--if IsPedArmed(ped, 4) then
						if holstered then
							blocked   = true
								TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when removing weapon
								--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
									Citizen.Wait(Config.CooldownPolice)
								TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
									Citizen.Wait(400)
								ClearPedTasks(ped)
							holstered = false
						else
							blocked = false
						end
					else
					--elseif not IsPedArmed(ped, 4) then
						if not holstered then
					
								TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
									Citizen.Wait(500)
								TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
								--TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 30, 2.0, 0, 0, 0 ) Use this line if you want to stand still when holstering weapon
									Citizen.Wait(60)
								ClearPedTasks(ped)
							holstered = true
						end
					end
				else
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				end
			else
				holstered = true
			end
		else
			if not IsPedInAnyVehicle(ped, false) then
				if GetVehiclePedIsTryingToEnter (ped) == 0 and not IsPedInParachuteFreeFall (ped) then
					if CheckWeapon(ped) then
						--if IsPedArmed(ped, 4) then
						if holstered then
							blocked   = true
								TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
								--TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 30, 0, 0, 0, 0 ) Use this line if you want to stand still when removing weapon
									Citizen.Wait(Config.cooldown)
								ClearPedTasks(ped)
							holstered = false
						else
							blocked = false
						end
					else
					--elseif not IsPedArmed(ped, 4) then
						if not holstered then
								TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
								--TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 30, 0, 0, 0.125, 0 ) Use this line if you want to stand still when holstering weapon
									Citizen.Wait(1700)
								ClearPedTasks(ped)
							holstered = true
						end
					end
				else
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				end
			else
				holstered = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if blocked then
			DisableControlAction(1, 25, true )
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
		end
	end
end)


function CheckWeapon(ped)
	--[[if IsPedArmed(ped, 4) then
		return true
	end]]
	if IsEntityDead(ped) then
		blocked = false
			return false
		else
			for i = 1, #Config.Weapons do
				if GetHashKey(Config.Weapons[i]) == GetSelectedPedWeapon(ped) then
					return true
				end
			end
		return false
	end
end


function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

--car wash ---
Key = 201 -- ENTER

vehicleWashStation = {
	{26.5906,  -1392.0261,  27.3634},
	{167.1034,  -1719.4704,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325,  -932.7043,  17.0139}
}



Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleWashStation do
		garageCoords = vehicleWashStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) -- 100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(PlayerPedId()) then 
			for i = 1, #vehicleWashStation do
				garageCoords2 = vehicleWashStation[i]
				DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then
					DrawSpecialText("Nhan [~g~ENTER~s~] de rua xe!")
					if(IsControlJustPressed(1, Key)) then
						TriggerServerEvent('2445d980-b482-4c45-b6ab-5852f8b4a660', GetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(),false)))
					end
				end
			end
		end
	end
end)

RegisterNetEvent('e4c6ba59-f3c9-4d1a-9f09-f9fe1bb28928')
AddEventHandler('e4c6ba59-f3c9-4d1a-9f09-f9fe1bb28928', function()
	SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId(),false), 0.0)
	SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(),false), false)
	exports['mythic_notify']:DoLongHudText('success','Đã thanh toán 20$ cho dịch vụ rửa xe')
end)
RegisterNetEvent('4ed021f1-4361-4b4c-911c-3cffc0be99e0')
AddEventHandler('4ed021f1-4361-4b4c-911c-3cffc0be99e0', function()
	exports['mythic_notify']:DoLongHudText('error','Không đủ tiền')
end)
RegisterNetEvent('cafcae6a-440e-444f-9c44-3a43da01ffe6')
AddEventHandler('cafcae6a-440e-444f-9c44-3a43da01ffe6', function()
	exports['mythic_notify']:DoLongHudText('inform',"Xe đã sạch, không cần rửa")
end)

--giat sung---
local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if whitelisted == false then
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		--print(weapon) -- To get the weapon hash by pressing F8 in game

		---Retical Removed by TheDevJeremy
		
		-- Disable melee while aiming (may be not working)
		
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
		
		-- Disable ammo HUD
		
		DisplayAmmoThisFrame(false)
		
		-- Shakycam
		
		-- Pistol
		if weapon == GetHashKey("WEAPON_STUNGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.001)
			end
		end
		
		if weapon == GetHashKey("WEAPON_FLAREGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.001)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.002)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.003)
			end
		end
		
		if weapon == GetHashKey("WEAPON_APPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.005)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.003)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL50") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.005)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.003)
			end
		end
		
		if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.003)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER_MK2") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0055)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DOUBLEACTION") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0025)
			end
		end
		-- SMG
		
		if weapon == GetHashKey("WEAPON_MICROSMG") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPDW") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG_MK2") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0055)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTSMG") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINISMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.007)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATMG") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.008)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATMG_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0085)
			end
		end
		
		-- Rifles
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.007)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0075)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.006)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0065)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.006)
			end
		end
		
		if weapon == GetHashKey("WEAPON_GUSENBERG") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.005)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.006)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0075)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.005)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0065)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.005)
			end
		end
		
		-- Shotgun
		
		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.007)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.0085)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.006)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.012)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.008)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DBSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.005)
			end
		end
		
		if weapon == GetHashKey("WEAPON_AUTOSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.008)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MUSKET") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.004)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.013)
			end
		end
		
		-- Sniper
		
		if weapon == GetHashKey("WEAPON_SNIPERRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSNIPER") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		-- Launcher
		
		if weapon == GetHashKey("WEAPON_GRENADELAUNCHER") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.008)
			end
		end
		
		if weapon == GetHashKey("WEAPON_RPG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.09)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HOMINGLAUNCHER") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.09)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINIGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.020)
			end
		end
		
		if weapon == GetHashKey("WEAPON_RAILGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
				
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMPACTLAUNCHER") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.008)
			end
		end
		
		if weapon == GetHashKey("WEAPON_FIREWORK") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		-- Infinite FireExtinguisher
		
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then		
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
	end
end)

-- recoil script by bluethefurry / Blumlaut https://forum.fivem.net/t/betterrecoil-better-3rd-person-recoil-for-fivem/82894
-- I just added some missing weapons because of the doomsday update adding some MK2.
-- I can't manage to make negative hashes works, if someone make it works, please let me know =)

local recoils = {
	[453432689] = 0.03, -- PISTOL
	[3219281620] = 0.03, -- PISTOL MK2
	[1593441988] = 0.02, -- COMBAT PISTOL
	[584646201] = 0.01, -- AP PISTOL
	[2578377531] = 0.06, -- PISTOL .50
	[324215364] = 0.02, -- MICRO SMG
	[736523883] = 0.01, -- SMG
	[2024373456] = 0.01, -- SMG MK2
	[4024951519] = 0.01, -- ASSAULT SMG
	[3220176749] = 0.02, -- ASSAULT RIFLE
	[961495388] = 0.02, -- ASSAULT RIFLE MK2
	[2210333304] = 0.01, -- CARBINE RIFLE
	[4208062921] = 0.01, -- CARBINE RIFLE MK2
	[2937143193] = 0.01, -- ADVANCED RIFLE
	[2634544996] = 0.01, -- MG
	[2144741730] = 0.01, -- COMBAT MG
	[3686625920] = 0.01, -- COMBAT MG MK2
	[487013001] = 0.04, -- PUMP SHOTGUN
	[1432025498] = 0.04, -- PUMP SHOTGUN MK2
	[2017895192] = 0.07, -- SAWNOFF SHOTGUN
	[3800352039] = 0.04, -- ASSAULT SHOTGUN
	[2640438543] = 0.02, -- BULLPUP SHOTGUN
	[911657153] = 0.01, -- STUN GUN
	[100416529] = 0.05, -- SNIPER RIFLE
	[205991906] = 0.07, -- HEAVY SNIPER
	[177293209] = 0.07, -- HEAVY SNIPER MK2
	[856002082] = 0.12, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.01, -- MINIGUN
	[3218215474] = 0.02, -- SNS PISTOL
	[2009644972] = 0.025, -- SNS PISTOL MK2
	[1627465347] = 0.01, -- GUSENBERG
	[3231910285] = 0.02, -- SPECIAL CARBINE
	[-1768145561] = 0.025, -- SPECIAL CARBINE MK2
	[3523564046] = 0.05, -- HEAVY PISTOL
	[2132975508] = 0.02, -- BULLPUP RIFLE
	[-2066285827] = 0.025, -- BULLPUP RIFLE MK2
	[137902532] = 0.04, -- VINTAGE PISTOL
	[-1746263880] = 0.04, -- DOUBLE ACTION REVOLVER
	[2828843422] = 0.07, -- MUSKET
	[984333226] = 0.02, -- HEAVY SHOTGUN
	[3342088282] = 0.03, -- MARKSMAN RIFLE
	[1785463520] = 0.035, -- MARKSMAN RIFLE MK2
	[1672152130] = 0, -- HOMING LAUNCHER
	[1198879012] = 0.09, -- FLARE GUN
	[171789620] = 0.02, -- COMBAT PDW
	[3696079510] = 0.09, -- MARKSMAN PISTOL
  	[1834241177] = 0.24, -- RAILGUN
	[3675956304] = 0.03, -- MACHINE PISTOL
	[3249783761] = 0.06, -- REVOLVER
	[-879347409] = 0.065, -- REVOLVER MK2
	[4019527611] = 0.07, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.03, -- COMPACT RIFLE
	[317205821] = 0.02, -- AUTO SHOTGUN
	[125959754] = 0.05, -- COMPACT LAUNCHER
	[3173288789] = 0.01, -- MINI SMG		
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	if whitelisted == false then

		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= recoils[wep]
			end
			
		end
	end
	end
end)