local holdingUp = false
local store = ""
local blipRobbery = nil
ESX = nil

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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if (holdingUp) then
			TriggerServerEvent('esx_holdup:pingRobberOnline')
		end
		Citizen.Wait(5000)
	end
end)

function drawTxt(x,y, width, height, scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if outline then SetTextOutline() end

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_holdup:currentlyRobbing')
AddEventHandler('esx_holdup:currentlyRobbing', function(currentStore)
	holdingUp, store = true, currentStore
	TriggerServerEvent('global_robbery:setRob', true)
end)

RegisterNetEvent('esx_holdup:killBlip')
AddEventHandler('esx_holdup:killBlip', function()
	RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdup:setBlip')
AddEventHandler('esx_holdup:setBlip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 486)
	SetBlipScale(blipRobbery, 2.0)
	SetBlipColour(blipRobbery, 75)

	PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function()
	holdingUp, store = false, ''
	ESX.ShowNotification(_U('robbery_cancelled'))
	TriggerServerEvent('global_robbery:setRob', false)
	TriggerServerEvent('global_robbery:setLastRob')
end)

RegisterNetEvent('esx_holdup:robberyComplete')
AddEventHandler('esx_holdup:robberyComplete', function(award)
	holdingUp, store = false, ''
	ESX.ShowNotification(_U('robbery_complete', award))
	TriggerServerEvent('global_robbery:setRob', false)
	TriggerServerEvent('global_robbery:setLastRob')
end)

RegisterNetEvent('esx_holdup:startTimer')
AddEventHandler('esx_holdup:startTimer', function()
	local timer = Stores[store].secondsRemaining

	Citizen.CreateThread(function()
		while timer > 0 and holdingUp do
			Citizen.Wait(500)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while holdingUp do
			Citizen.Wait(0)
			drawTxt(0.66, 1.44, 1.0, 1.0, 0.4, _U('robbery_timer', timer), 255, 255, 255, 255)
		end
	end)
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores) do

	    local blip = AddBlipForRadius(v.position.x, v.position.y, v.position.z , 100.0) -- you can use a higher number for a bigger zone 
	    SetBlipHighDetail(blip, true) 
	    SetBlipColour(blip, 1) 
	    SetBlipAlpha (blip, 128)


		local blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
		SetBlipSprite(blip, 354)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

		for k,v in pairs(Stores) do
			local storePos = v.position
			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z)

			if distance < Config.Marker.DrawDistance then
				if not holdingUp then
					DrawMarker(Config.Marker.Type, storePos.x, storePos.y, storePos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)

					if distance < 0.5 then
						ESX.ShowHelpNotification(_U('press_to_rob', v.nameOfStore))

						if IsControlJustReleased(0, Keys['E']) then
							if not IsPedArmed(PlayerPedId(), 4) then
								ESX.ShowNotification(_U('no_threat'))
							else
								ESX.TriggerServerCallback('global_robbery:canRob', function(value)
									if not value.canRob then
										ESX.ShowNotification(_U('robbery_already'))
									elseif value.remaining > 0 then
										ESX.ShowNotification(_U('robbery_remaining', value.remaining))
									else
										TriggerServerEvent('esx_holdup:robberyStarted', k)
									end
								end)
							end
						end
					end
				end
			end
			-- khu Vực Lang Băm Có Thể Cứu Người (Ngoài Khu Vực Cướp) By LiemVi
			if distance < 35.0 then
				TriggerEvent('esx_langbam:disablezone', false)
			else
				TriggerEvent('esx_langbam:disablezone', true)
			end
		end

		if holdingUp then
			local storePos = Stores[store].position
			if Vdist(playerPos.x, playerPos.y, playerPos.z, storePos.x, storePos.y, storePos.z) > Config.MaxDistance then
				TriggerServerEvent('esx_holdup:tooFar', store)
			end
		end
	end
end)
