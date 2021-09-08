RegisterNetEvent('showNotification')
AddEventHandler('showNotification', function(text)
	-- SendNUIMessage({
		-- action = 'longnotif',
		-- type = 'error',
		-- text = text,
		-- length = 10000
	-- })
	ShowNotification(text)
end)
function ShowNotification(text)
	--SetTextFont(13)
	SetNotificationTextEntry("STRING")
	SetTextFont(13)
	AddTextComponentString(text)
	DrawNotification(0,1)
end
Citizen.CreateThread(function()
    -- main loop thing
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = PlayerPedId()
		if IsEntityDead(playerPed) and not alreadyDead then
			
			killer = GetPedSourceOfDeath(playerPed)
			killername = false
			_,weapon = GetCurrentPedWeapon(killer,1)
			killerweapon = reverseWeaponHash( tostring(weapon) )
			print(killer.." "..playerPed)
			for id = 0, 254 do
				if killer == GetPlayerPed(id) then
					killername = GetPlayerName(id)
					killServerid = GetPlayerServerId(id)
				end				
			end
		
			if killer == playerPed then
				TriggerServerEvent('playerDied',0,0)
			elseif killername then
				TriggerServerEvent('playerDied',killername,1,killerweapon,killServerid)
            else
                local nguoitong = GetPedInVehicleSeat(killer, -1)
                if nguoitong then
                    for id = 0, 254 do
                        if nguoitong == GetPlayerPed(id) then
                            nguoitongname = GetPlayerName(id)
							nguoitongid = GetPlayerServerId(id)
                        end
                    end
                    
                    TriggerServerEvent('playerDied',nguoitongname,3,nguoitongname,nguoitongid)
                end
			end
		
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
        end
        RemoveAllPickupsOfType(0x5985D162)
	end
end)

--[[ AddEventHandler("DamageEvents:PedKilledByVehicle", function(ped, veh)
    TriggerEvent("showNotification", ped.." bị tông bởi "..veh)
end) ]]

local WEAPON_HASHES_PICKUPS = {
    ["2578778090"] = "pickup_weapon_Dagger",
    ["1737195953"] = "pickup_weapon_Nightstick",
    ["1317494643"] = "pickup_weapon_Hammer",
    ["2508868239"] = "pickup_weapon_Bat",
    ["1141786504"] = "pickup_weapon_GolfClub",
    ["2227010557"] = "pickup_weapon_Crowbar",
    ["4192643659"] = "pickup_weapon_SwitchBlade",
    ["3756226112"] = "pickup_weapon_SwitchBlade",
    ["453432689"] = "pickup_weapon_Pistol",
    ["1593441988"] = "pickup_weapon_CombatPistol",
    ["584646201"] = "pickup_weapon_APPistol",
    ["2578377531"] = "pickup_weapon_Pistol50",
    ["1198879012"] = "pickup_weapon_FlareGun",
    ["3696079510"] = "pickup_weapon_MarksmanPistol",
    ["3249783761"] = "pickup_weapon_Revolver",
    ["324215364"] = "pickup_weapon_MicroSMG",
    ["736523883"] = "pickup_weapon_SMG",
    ["4024951519"] = "pickup_weapon_AssaultSMG",
    ["171789620"] = "pickup_weapon_CombatPDW",
    ["3220176749"] = "pickup_weapon_AssaultRifle",
    ["2210333304"] = "pickup_weapon_CarbineRifle",
    ["2937143193"] = "pickup_weapon_AdvancedRifle",
    ["1649403952"] = "pickup_weapon_CompactRifle",
    ["2634544996"] = "pickup_weapon_MG",
    ["2144741730"] = "pickup_weapon_CombatMG",
    ["487013001"] = "pickup_weapon_PumpShotgun",
    ["2017895192"] = "pickup_weapon_SawnOffShotgun",
    ["3800352039"] = "pickup_weapon_AssaultShotgun",
    ["2640438543"] = "pickup_weapon_BullpupShotgun",
    ["4019527611"] = "pickup_weapon_DoubleBarrelShotgun",
    ["911657153"] = "pickup_weapon_StunGun",
    ["100416529"] = "pickup_weapon_SniperRifle",
    ["205991906"] = "pickup_weapon_HeavySniper",
    ["2726580491"] = "pickup_weapon_GrenadeLauncher",
    ["1305664598"] = "pickup_weapon_GrenadeLauncher",
    ["2982836145"] = "pickup_weapon_RPG",
    ["1119849093"] = "pickup_weapon_Minigun",
    ["2481070269"] = "pickup_weapon_Grenade",
    ["741814745"] = "pickup_weapon_StickyBomb",
    ["4256991824"] = "pickup_weapon_SmokeGrenade",
    ["2694266206"] = "pickup_weapon_SmokeGrenade",
    ["615608432"] = "pickup_weapon_Molotov",
    ["101631238"] = "pickup_weapon_FireExtinguisher",
    ["883325847"] = "pickup_weapon_PetrolCan",
    ["3218215474"] = "pickup_weapon_SNSPistol",
    ["3231910285"] = "pickup_weapon_SpecialCarbine",
    ["3523564046"] = "pickup_weapon_HeavyPistol",
    ["2132975508"] = "pickup_weapon_BullpupRifle",
    ["1672152130"] = "pickup_weapon_HomingLauncher",
    ["2874559379"] = "pickup_weapon_Proxmine",
    ["137902532"] = "pickup_weapon_VintagePistol",
    ["2460120199"] = "pickup_weapon_Dagger",
    ["2828843422"] = "pickup_weapon_Musket",
    ["3342088282"] = "pickup_weapon_MarksmanRifle",
    ["984333226"] = "pickup_weapon_HeavyShotgun",
    ["1627465347"] = "pickup_weapon_Gusenberg",
    ["4191993645"] = "pickup_weapon_Hatchet",
    ["3638508604"] = "pickup_weapon_Knuckle",
    ["3713923289"] = "pickup_weapon_Machete",
    ["3675956304"] = "pickup_weapon_MachinePistol",
    ["317205821"] = "pickup_weapon_SweeperShotgun",
    ["3441901897"] = "pickup_weapon_BattleAxe",
    ["3173288789"] = "pickup_weapon_MiniSMG",
    ["3125143736"] = "pickup_weapon_PipeBomb",
    ["2484171525"] = "pickup_weapon_PoolCue",
    ["419712736"] = "pickup_weapon_Wrench",
	["4208062921"] = "pickup_weapon_CarbineRifle_Mk2",
	["3219281620"] = "pickup_weapon_Pistol_Mk2",
	["3686625920"] = "pickup_weapon_CombatMG_Mk2",
	["961495388"] = "pickup_weapon_AssaultRifle_Mk2",
	["177293209"] = "pickup_weapon_HeavySniper_Mk2",
    ["2024373456"] = "pickup_weapon_SMG_Mk2",
    ["-335430670"] = "pickup_weapon_AKB",
    ["1084920949"] = "pickup_weapon_BF3",
    ["1595201550"] = "pickup_weapon_XR2",
    ["-1171598465"] = "pickup_weapon_XM25",
    ["-303983872"] = "pickup_weapon_BUSTERSWORD",
    ["1495124272"] = "pickup_weapon_GUNBLADE",
    ["-484865036"] = "pickup_weapon_RUNESCAPE1",
    ["-261839222"] = "pickup_weapon_RUNESCAPE2",
    ["1529117720"] = "pickup_weapon_RUNESCAPE3",
    ["693999755"] = "pickup_weapon_RUNESCAPE4",
    ["1034162531"] = "pickup_weapon_XBOW",
    ["1438000445"] = "pickup_weapon_MAGIKSWORD",
    ["1217255841"] = "pickup_weapon_MSR",
    ["1276725267"] = "pickup_weapon_F4MINI",
    ["757043420"] = "pickup_weapon_CHEYTAC",
    ["-851966428"] = "pickup_weapon_AWPH",
    ["1994451307"] = "pickup_weapon_TOMAHAWK"
}

local WEAPON_HASHES_STRINGS = {
    ["-1569615261"] = " Tay không",
    ["-102973651"] = " Rìu",
    ["-1716189206"] = " Knife",
    ["1737195953"] = " Nightstick",
    ["1317494643"] = " Hammer",
    ["2508868239"] = " Bat",
    ["1141786504"] = " Golf Club",
    ["2227010557"] = " Crowbar",
    ["4192643659"] = " Bottle",
    ["3756226112"] = " Switch Blade",
    ["453432689"] = " Pistol",
    ["1593441988"] = " Combat Pistol",
	["-1716589765"] = " Pistol50",
	["-1076751822"] = " SNSPistol",
	["-771403250"] = " HeavyPistol",
    ["584646201"] = " AP Pistol",
    ["2578377531"] = " Pistol 50",
    ["1198879012"] = " Flare Gun",
    ["3696079510"] = " Marksman Pistol",
    ["3249783761"] = " Revolver",
    ["324215364"] = " Micro SMG",
	["-619010992"] = " MachinePistol",
    ["736523883"] = " SMG",
    ["4024951519"] = " Assault SMG",
    ["171789620"] = " Combat PDW",
	["-1660422300"] = " MG",
    ["-1074790547"] = " Assault Rifle",
    ["2210333304"] = " Carbine Rifle",
    ["2937143193"] = " Advanced Rifle",
    ["1649403952"] = " Compact Rifle",
    ["2634544996"] = " MG",
    ["2144741730"] = " Combat MG",
    ["487013001"] = " Pump Shotgun",
	["-1312131151"] = " RPG",
    ["2017895192"] = " Sawn Off Shotgun",
    ["3800352039"] = " Assault Shotgun",
    ["2640438543"] = " Bullpup Shotgun",
    ["4019527611"] = " Double Barrel Shotgun",
    ["911657153"] = " Stun Gun",
    ["100416529"] = " Sniper Rifle",
    ["205991906"] = " Heavy Sniper",
    ["2726580491"] = " Grenade Launcher",
    ["1305664598"] = " Grenade Launcher Smoke",
    ["2982836145"] = " RPG",
    ["1119849093"] = " Minigun",
    ["2481070269"] = " Grenade",
    ["741814745"] = " Sticky Bomb",
    ["4256991824"] = " Smoke Grenade",
    ["2694266206"] = " Gas",
    ["615608432"] = " Molotov",
    ["101631238"] = " Fire Extinguisher",
    ["883325847"] = " Petrol Can",
    ["3218215474"] = " SNS Pistol",
    ["-1063057011"] = " Special Carbine",
    ["3523564046"] = " Heavy Pistol",
    ["2132975508"] = " Bullpup Rifle",
	["2228681469"] = " Bullpup Rifle",
    ["1672152130"] = " Homing Launcher",
    ["2874559379"] = " Proximity Mine",
    ["126349499"] = " Snowball",
    ["137902532"] = " Vintage Pistol",
	["-598887786"] = " MarksmanPistol",
	["-1045183535"] = " Revolver",
    ["2460120199"] = " Dagger",
    ["2138347493"] = "Fireworks",
    ["2828843422"] = " Musket",
    ["3342088282"] = " Marksman Rifle",
    ["984333226"] = " Heavy Shotgun",
    ["1627465347"] = " Gusenberg",
    ["4191993645"] = "aHatchet",
    ["1834241177"] = " Railgun",
    ["2725352035"] = "Fists",
    ["3638508604"] = " Knuckle Duster",
    ["3713923289"] = " Machete",
    ["3675956304"] = " Machine Pistol",
    ["2343591895"] = "Flashlight",
    ["600439132"] = " Ball",
    ["1233104067"] = " Flare",
    ["2803906140"] = "Night Vision",
    ["4222310262"] = " Parachute",
    ["317205821"] = " Sweeper Shotgun",
    ["3441901897"] = " Battle Axe",
    ["125959754"] = " Compact Grenade Launcher",
	["-1813897027"] = " Grenade",
	["-37975472"] = " SmokeGrenade",
    ["-1121678507"] = " Mini SMG",
    ["3125143736"] = " Pipe Bomb",
    ["2484171525"] = " Pool Cue",
    ["419712736"] = " Wrench",
	["4208062921"] = " Carbine Rifle Mk2",
	["-1357824103"] = " AdvancedRifle",
	["3219281620"] = " Mk2 Pistol",
	["3686625920"] = " Mk2 Combat MG",
	["961495388"] = " Mk2 Assault Rifle",
	["-2084633992"] = " CarbineRifle",
	["177293209"] = " Mk2 Heavy Sniper",
	["-952879014"] = " MarksmanRifle",
	["2024373456"] = " Mk2 SMG",
    ["-270015777"] = " AssaultSMG",
    ["-335430670"] = "AK GOLD",
    ["1084920949"] = "AUG BF3",
    ["1595201550"] = "XR2",
    ["-1171598465"] = "SUPER GUN XM25",
    ["-303983872"] = "Do Long Dao",
    ["1495124272"] = "VU KHI CUA TEO NGUUUU",
    ["-484865036"] = "ARMADYL GOD BLADE",
    ["-261839222"] = "BANDOS GOD BLADE",
    ["1529117720"] = "SARADOMIN GOD BLADE",
    ["693999755"] = "ZAMORAK GOD BLADE",
    ["1034162531"] = "No Than",
    ["1438000445"] = "Marvel Magik Sword",
    ["1217255841"] = "Remington MSR SNIPER",
    ["1276725267"] = "FallOut4 MiniGun",
    ["757043420"] = "CheyTac Intervention Sniper Rifle",
    ["-851966428"] = "AWP - Hyper Beast",
    ["1994451307"] = "MGA Tomahawk"
    
}

function reverseWeaponHash(hash,method)
	if not method or method == 1 then
    local name = WEAPON_HASHES_STRINGS[hash]
	local unknown = " một thứ gì đó"
    if name ~= nil then
        return name
    else
				return unknown
		end
	elseif method == 2 then
    local name = WEAPON_HASHES_PICKUPS[hash]
    if name ~= nil then
        return name
    end
	end

    Citizen.Trace("Error reversing weapon hash \"" .. hash .. "\". Maybe it's not been added yet?")
    return "Unknown"
end
