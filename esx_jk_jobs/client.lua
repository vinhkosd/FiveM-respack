local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		DrawMarker(Config.Marker.type, Config.Marker.x, Config.Marker.y, Config.Marker.z, 0, 0, 0, 0, 0, 0, 2.0001,2.0001,2.0001, 0, Config.Color.r, Config.Color.g, Config.Color.b, 0, 0, 0, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -265.0,-963.6,31.22313117981, true) < 1 then
			DisplayHelpText("Nhan ~g~E~s~ Mo bang nghe")
		 if (IsControlJustReleased(1, 51)) then
			SetNuiFocus( true, true )
			SendNUIMessage({
				ativa = true
			})
		 end
		end
	end
end)

RegisterNUICallback('1', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobunemployed')
  	cb('ok')
end)

RegisterNUICallback('2', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobt')
  	cb('ok')
end)

RegisterNUICallback('3', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobfisherman')
  	cb('ok')
end)

RegisterNUICallback('4', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobminer')
  	cb('ok')
end)

RegisterNUICallback('5', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobfueler')
  	cb('ok')
end)

RegisterNUICallback('6', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobslaughterer')
  	cb('ok')
end)

RegisterNUICallback('7', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobtailor')
  	cb('ok')
end)

RegisterNUICallback('8', function(data, cb)
	TriggerServerEvent('esx_empregos:setJoblumberjack')
  	cb('ok')
end)

RegisterNUICallback('9', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobreporter')
  	cb('ok')
end)

RegisterNUICallback('10', function(data, cb)
	TriggerServerEvent('esx_empregos:setJoblangbam')
  	cb('ok')
end)

RegisterNUICallback('11', function(data, cb)
	TriggerServerEvent('esx_empregos:setJobgarbage')
  	cb('ok')
end)

RegisterNUICallback('fechar', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({
	ativa = false
	})
  	cb('ok')
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Zones, 1 do
		local blip = AddBlipForCoord(Config.Zones[i])

		SetBlipSprite (blip, 407)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 27)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['E']) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			ShowJobListingMenu()
		end
	end
end)