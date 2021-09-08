
local ESX	 = nil

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	local data = ESX.GetPlayerData()
	-- Job
	local job = data.job
	local job2 = data.job2
	local jobname
	local jobname2

	if job.label == job.grade_label then
		jobname = job.grade_label
	else
		jobname = job.label .. ': ' .. job.grade_label
	end 
	
	if job2.label == job2.grade_label then
		jobname2 = job2.grade_label
	else
		jobname2 = job2.label .. ': ' .. job2.grade_label
	end 

	SendNUIMessage({ action = 'setText', id = 'job', value = jobname })
	SendNUIMessage({ action = 'setText', id = 'job2', value = jobname2 })

	-- Money
	local acc = data.accounts
	local bankMoney = '0'
	local blackMoney = '0'
	local walletMoney = data.money

	for k,v in pairs(acc) do
		local acc = v
		if acc.name == 'bank' then
			if acc.money then
				bankMoney = acc.money
			end
		elseif acc.name == 'black_money' then
			if acc.money then
				blackMoney = acc.money
			end
		end
	end

	SendNUIMessage({ action = 'setMoney', id = 'bank', value = bankMoney })
	SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = blackMoney })
	SendNUIMessage({ action = 'setMoney', id = 'wallet', value = walletMoney })

	if job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
		end, job.name)				
	end

	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	HideHudComponentThisFrame(3) -- SP Cash
	HideHudComponentThisFrame(4) -- MP Cash
	HideHudComponentThisFrame(13) -- Cash changes

	-- UI Config
	SendNUIMessage({ action = 'ui', config = Config.ui })

	-- Font
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })

	-- Logo
	SendNUIMessage({ action = 'setLogo', value =Config.serverLogo })
end)




local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



-- Hides TREW UI when it's on Pause Menu
Citizen.CreateThread(function()

    local isPauseMenu = false

	while true do
		Citizen.Wait(0)

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = false })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = true })
			end

			HideHudComponentThisFrame(1)  -- Wanted Stars
			HideHudComponentThisFrame(2)  -- Weapon Icon
			HideHudComponentThisFrame(3)  -- Cash
			HideHudComponentThisFrame(4)  -- MP Cash
			HideHudComponentThisFrame(6)  -- Vehicle Name
			HideHudComponentThisFrame(7)  -- Area Name
			HideHudComponentThisFrame(8)  -- Vehicle Class
			HideHudComponentThisFrame(9)  -- Street Name
			HideHudComponentThisFrame(13) -- Cash Change
			HideHudComponentThisFrame(17) -- Save Game
			HideHudComponentThisFrame(20) -- Weapon Stats
		end


	end
end)






-- Date and time update
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if Config.ui.showDate == false then
			SendNUIMessage({ action = 'setText', id = 'date', value = trewDate() })
		end
	end
end)





-- Location update
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(100)

		local player = GetPlayerPed(-1)

		local position = GetEntityCoords(player)

		if Config.ui.showLocation == false then
			local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end

			locationMessage = string.format(
				Locales[Config.Locale]['you_are_on_location'],
				locationMessage
			)

			SendNUIMessage({ action = 'setText', id = 'location', value = locationMessage })
		end
	end
end)





-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = 'off'
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

Citizen.CreateThread(function()
	
	while true do

		Citizen.Wait(100)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local position = GetEntityCoords(player)
		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		local vehicleInfo

		if IsPedInAnyVehicle(player, false) and vehicleIsOn then


			if Config.ui.showMinimap == true then
				DisplayRadar(true)
			end

			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleSpeed
			if Config.vehicle.speedUnit == 'MPH' then
				vehicleSpeed = math.ceil(vehicleSpeedSource * 2.237)
			else
				vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
			end

			-- Vehicle Gradient Speed
			local vehicleNailSpeed

			if vehicleSpeed > Config.vehicle.maxSpeed then
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
			else
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			end


			
			-- Vehicle Fuel and Gear
			local vehicleFuel

			if Config.vehicle.useLegacyFuel == true then
				vehicleFuel = exports['LegacyFuel']:GetFuel(vehicle)
			else
				vehicleFuel = GetVehicleFuelLevel(vehicle)
			end

			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end

			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
			end















			-- Vehicle Seatbelt
			local vehicleClass = GetVehicleClass(vehicle)
			if vehicleClass ~= 13 then

				local prevSpeed = currSpeed
                currSpeed = vehicleSpeedSource

                SetPedConfigFlag(PlayerPedId(), 32, true)

                if not seatbeltIsOn then
                	local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

                        SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end

                else

                	DisableControlAction(0, 75)

                end



			end

			

			vehicleInfo = {
				action = 'updateVehicle',

				status = true,
				speed = vehicleSpeed,
				nail = vehicleNailSpeed,
				gear = vehicleGear,
				fuel = vehicleFuel,
				lights = vehicleIsLightsOn,
				signals = vehicleSignalIndicator,
				cruiser = vehicleCruiser,

				seatbelt = Config.vehicle.seatbelt,

				config = {
					speedUnit = Config.vehicle.speedUnit,
					maxSpeed = Config.vehicle.maxSpeed
				}
			}

			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
		else

			
			vehicleCruiser = false
			vehicleNailSpeed = 0
			vehicleSignalIndicator = 'off'

            seatbeltIsOn = false

			vehicleInfo = {
				action = 'updateVehicle',

				status = false,
				nail = vehicleNailSpeed,
				seatbelt = { status = seatbeltIsOn },
				cruiser = vehicleCruiser,
				signals = vehicleSignalIndicator,
			}

			if Config.ui.showMinimap == true then
				DisplayRadar(true)
			end

		end

		SendNUIMessage(vehicleInfo)





	end
end)




-- Player status
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(1000)

		local playerStatus 
		local showPlayerStatus = 0
		playerStatus = { action = 'setStatus', status = {} }

		if Config.ui.showHealth == true then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['isdead'] = false

			playerStatus['status'][showPlayerStatus] = {
				name = 'health',
				value = GetEntityHealth(GetPlayerPed(-1)) - 100
			}

			if IsEntityDead(GetPlayerPed(-1)) then
				playerStatus.isdead = true
			end
		end

		if Config.ui.showArmor == true then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['status'][showPlayerStatus] = {
				name = 'armor',
				value = GetPedArmour(GetPlayerPed(-1)),
			}
		end

		if Config.ui.showStamina == true then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['status'][showPlayerStatus] = {
				name = 'stamina',
				value = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
			}
		end

		if Config.ui.showHunger == true then
			showPlayerStatus = (showPlayerStatus+1)

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				playerStatus['status'][showPlayerStatus] = {
					name = 'hunger',
					value = status.getPercent()
				}
			end)
		end

		if Config.ui.showThirst == true then
			showPlayerStatus = (showPlayerStatus+1)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				playerStatus['status'][showPlayerStatus] = {
					name = 'thirst',
					value = status.getPercent()
				}
			end)
		end

		if showPlayerStatus > 0 then
			SendNUIMessage(playerStatus)
		end

	end
end)






-- Voice detection and distance


AddEventHandler('onClientMapStart', function()
	if Config.ui.showVoice == true then
		if Config.voice.levels.current == 0 then
			NetworkSetTalkerProximity(Config.voice.levels.default)
		elseif Config.voice.levels.current == 1 then
			NetworkSetTalkerProximity(Config.voice.levels.shout)
		elseif Config.voice.levels.current == 2 then
			NetworkSetTalkerProximity(Config.voice.levels.whisper)
		end
	end
end)

AddEventHandler('playerSpawned', function()
	if Config.ui.showVoice == true then
	    NetworkSetTalkerProximity(5.0)
	end
end)


Citizen.CreateThread(function()

	if Config.ui.showVoice == true then

	    RequestAnimDict('facials@gen_male@variations@normal')
	    RequestAnimDict('mp_facial')

	    while true do
	        Citizen.Wait(300)
	        local playerID = PlayerId()

	        for _,player in ipairs(GetActivePlayers()) do
	            local boolTalking = NetworkIsPlayerTalking(player)

	            if player ~= playerID then
	                if boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
	                elseif not boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
	                end
	            end
	        end
	    end

	end
end)



Citizen.CreateThread(function()
	if Config.ui.showVoice == true then



		local isTalking = false
		local voiceDistance = nil

		while true do
			Citizen.Wait(1)




			if NetworkIsPlayerTalking(PlayerId()) and not isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			elseif not NetworkIsPlayerTalking(PlayerId()) and isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			end



			if IsControlJustPressed(1, Keys[Config.voice.keys.distance]) then

				Config.voice.levels.current = (Config.voice.levels.current + 1) % 3

				if Config.voice.levels.current == 0 then
					NetworkSetTalkerProximity(Config.voice.levels.default)
					voiceDistance = 'normal'
				elseif Config.voice.levels.current == 1 then
					NetworkSetTalkerProximity(Config.voice.levels.shout)
					voiceDistance = 'shout'
				elseif Config.voice.levels.current == 2 then
					NetworkSetTalkerProximity(Config.voice.levels.whisper)
					voiceDistance = 'whisper'
				end

				SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
			end

			if Config.voice.levels.current == 0 then
				voiceDistance = 'normal'
			elseif Config.voice.levels.current == 1 then
				voiceDistance = 'shout'
			elseif Config.voice.levels.current == 2 then
				voiceDistance = 'whisper'
			end


		end





	end
end)






-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function ()

	while true do
		Citizen.Wait(0)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehicleClass = GetVehicleClass(vehicle)

		-- Vehicle Seatbelt
		if IsPedInAnyVehicle(player, false) and GetIsVehicleEngineRunning(vehicle) then
			if IsControlJustReleased(0, Keys[Config.vehicle.keys.seatbelt]) and vehicleClass ~= 8 then
				seatbeltIsOn = not seatbeltIsOn
			end
		end

		-- Vehicle Cruiser
		if IsControlJustPressed(1, Keys[Config.vehicle.keys.cruiser]) and GetPedInVehicleSeat(vehicle, -1) == player then
			
			local vehicleSpeedSource = GetEntitySpeed(vehicle)

			if vehicleCruiser == 'on' then
				vehicleCruiser = 'off'
				SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
				
			else
				vehicleCruiser = 'on'
				SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
			end
		end





		-- Vehicle Signal Lights
		if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalLeft]) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'left'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalRight]) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'right'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalBoth]) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'both'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
		end


	end
end)








function trewDate()
	local timeString = nil

	local day = _U('day_' .. GetClockDayOfMonth())
	local weekDay = _U('weekDay_' .. GetClockDayOfWeek())
	local month = _U('month_' .. GetClockMonth())
	local day = _U('day_' .. GetClockDayOfMonth())
	local year = GetClockYear()


	local hour = GetClockHours()
	local minutes = GetClockMinutes()
	local time = nil
	local AmPm = ''


	if Config.date.AmPm == true then

		if hour >= 13 and hour <= 24 then
			hour = hour - 12
			AmPm = 'PM'
		else
			if hour == 0 or hour == 24 then
				hour = 12
			end
			AmPm = 'AM'
		end

	end

	if hour <= 9 then
		hour = '0' .. hour
	end
	if minutes <= 9 then
		minutes = '0' .. minutes
	end

	time = hour .. ':' .. minutes .. ' ' .. AmPm




	local date_format = Locales[Config.Locale]['date_format'][Config.date.format]

	if Config.date.format == 'default' then
		timeString = string.format(
			date_format,
			day, month, year
		)
	elseif Config.date.format == 'withWeekday' then
		timeString = string.format(
			date_format,
			weekDay, day, month, year
		)
	elseif Config.date.format == 'withHours' then
		timeString = string.format(
			date_format,
			time, day, month, year
		)
	elseif Config.date.format == 'withWeekdayAndHours' then
		timeString = string.format(
			date_format,
			time, weekDay, day, month, year
		)
	end


	

	return timeString
end





RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer

	-- Job
	local job = data.job
	local job2 = data.job2
	local jobname
	local jobname2

	if job.label == job.grade_label then
		jobname = job.grade_label
	else
		jobname = job.label .. ': ' .. job.grade_label
	end 
	
	if job2.label == job2.grade_label then
		jobname2 = job2.grade_label
	else
		jobname2 = job2.label .. ': ' .. job2.grade_label
	end 

	SendNUIMessage({ action = 'setText', id = 'job2', value = jobname2 })

	-- Money
	local acc = data.accounts
	local bankMoney = '0'
	local blackMoney = '0'
	local walletMoney = data.money

	for k,v in pairs(acc) do
		local acc = v
		if acc.name == 'bank' then
			if acc.money then
				bankMoney = acc.money
			end
		elseif acc.name == 'black_money' then
			if acc.money then
				blackMoney = acc.money
			end
		end
	end

	SendNUIMessage({ action = 'setMoney', id = 'bank', value = bankMoney })
	SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = blackMoney })
	SendNUIMessage({ action = 'setMoney', id = 'wallet', value = walletMoney })

	if job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
		end, job.name)				
	end

	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	HideHudComponentThisFrame(3) -- SP Cash
	HideHudComponentThisFrame(4) -- MP Cash
	HideHudComponentThisFrame(13) -- Cash changes

	-- UI Config
	SendNUIMessage({ action = 'ui', config = Config.ui })

	-- Font
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })

	-- Logo
	SendNUIMessage({ action = 'setLogo', value =Config.serverLogo })

end)


RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
		end, ESX.PlayerData.job.name)
	end
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

	local jobname

	ESX.PlayerData.job = job

	if job.label == job.grade_label then
		jobname = job.grade_label
	else
		jobname = job.label .. ': ' .. job.grade_label
	end

	if (ESX.PlayerData.job.grade_name == 'boss') and (Config.ui.showSocietyMoney == true) then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
		end, ESX.PlayerData.job.name)		
		SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
	else
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
	end

	SendNUIMessage({ action = 'setText', id = 'job', value = jobname })
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)

	local jobname2

	ESX.PlayerData.job2 = job2

	if job2.label == job2.grade_label then
		jobname2 = job2.grade_label
	else
		jobname2 = job2.label .. ': ' .. job2.grade_label
	end

	if (ESX.PlayerData.job.grade_name == 'boss') and (Config.ui.showSocietyMoney == true) then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
		end, ESX.PlayerData.job.name)		
		SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
	else
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
	end

	SendNUIMessage({ action = 'setText', id = 'job2', value = jobname2 })
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(acc)
	if acc.name == 'bank' then
		SendNUIMessage({ action = 'setMoney', id = 'bank', value = acc.money })
	elseif acc.name == 'black_money' then
		SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = acc.money })
	end
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	SendNUIMessage({ action = 'setMoney', id = 'wallet', value = money })
end)


RegisterNetEvent('trew_hud_ui:setLogo')
AddEventHandler('trew_hud_ui:setLogo', function(image)
	SendNUIMessage({ action = 'setLogo', value = image })
end)


AddEventHandler('trew_hud_ui:setCarSignalLights', function (status)
	local driver = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver,vehicleTrailer)
	local leftLight
	local rightLight

	if status == 'left' then
		leftLight = false
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'right' then
		leftLight = true
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'both' then
		leftLight = true
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	else
		leftLight = false
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	end

	TriggerServerEvent('trew_hud_ui:syncCarLights', status)

	SetVehicleIndicatorLights(driver, 0, leftLight)
	SetVehicleIndicatorLights(driver, 1, rightLight)
end)



RegisterNetEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function (driver, status)

	if GetPlayerFromServerId(driver) ~= PlayerId() then
		local driver = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(driver)), false)

		if status == 'left' then
			leftLight = false
			rightLight = true

		elseif status == 'right' then
			leftLight = true
			rightLight = false

		elseif status == 'both' then
			leftLight = true
			rightLight = true

		else
			leftLight = false
			rightLight = false
		end

		SetVehicleIndicatorLights(driver, 0, leftLight)
		SetVehicleIndicatorLights(driver, 1, rightLight)

	end
end)

RegisterCommand('adm', function(source, args, rawCommand)
	TriggerServerEvent('trew_hud_ui:admNotifyCheck', args)
end)


local toggleui = false
RegisterCommand('toggleui', function()
	if not toggleui then
		SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
	else

		if (Config.ui.showJob == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'job' })
		end
		if (Config.ui.showSocietyMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
		end
		if (Config.ui.showBankMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'bank' })
		end
		if (Config.ui.showBlackMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
		end
		if (Config.ui.showWalletMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'wallet' })
		end
	end

	toggleui = not toggleui
end)



RegisterNetEvent('trew_hud_ui:admNotifyPrompt')
AddEventHandler('trew_hud_ui:admNotifyPrompt', function (args)

	local type = args[1]
	--local title
	--local msg

	if (type == 'normal') or (type == 'red') or (type == 'rainbow') then
		ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Tiêu đề"
          		},
          	function(data2, menu2)

            	local lorraxsTitle = data2.value

            	if lorraxsTitle == nil then
              		ESX.ShowNotification("Bạn chưa nhập tiêu đề")
            	else
					menu2.close()
              		ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Nội dung"
							},
						function(data3, menu3)
		  
						  	local lorraxsContent = data3.value
		  
						  	if lorraxsContent == nil then
								ESX.ShowNotification("Bạn chưa nhập nội dung")
						  	else
								menu3.close()
								TriggerServerEvent('lorraxs-news:Sync', lorraxsTitle, lorraxsContent)
								TriggerServerEvent('trew_hud_ui:adminNotifyAllPlayers', {lorraxsTitle, lorraxsContent, type})
								
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		-- title = KeyboardInput(_U('notify_title'), '', 30)

		-- if title ~= nil then
			-- msg = KeyboardInput(_U('notify_msg'), '', 300)
		-- else
			-- title = _U('notify_notification')
		-- end

		-- if msg ~= nil then 
			-- TriggerServerEvent('trew_hud_ui:adminNotifyAllPlayers', {title, msg, type})
		-- else
			-- TriggerEvent('chatMessage', '[ERROR]', {255,0,0}, 'Nhap tin nhan' )
		-- end

	else
		TriggerEvent('chatMessage', '[ERROR]', {255,0,0}, '/adm [normal|red|rainbow]' )
	end

end)

RegisterNetEvent('trew_hud_ui:admNotifyShow')
AddEventHandler('trew_hud_ui:admNotifyShow', function (args)
	local title = args[1]
	local message = args[2]
	local type = args[3]

	SendNUIMessage({ action = 'sendNotification', title = title, message = message, type = type })
end)





function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end