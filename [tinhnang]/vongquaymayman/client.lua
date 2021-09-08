--[[
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]]

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback(
    "kiemtracoin",
    function()
        TriggerServerEvent("vongquaymayman-kiemtracoin")
    end
)

RegisterNUICallback(
    "quayxong",
    function(data)
		local stt =tonumber(data.thongtin)
		local playerPed = PlayerPedId()
		local rewardType = Config.reward[stt].type
		if rewardType ~= "mayman" and rewardType ~= "themluot" then
			TriggerServerEvent('vongquaymayman-thongbao', GetPlayerName(PlayerId())..' '..Config.rewardName[stt])
		end
		if rewardType == "weapon" then
			local weaponHash = GetHashKey(Config.reward[stt].key)
			TriggerServerEvent('vongquaymayman:addWeapon', Config.reward[stt].key)
			GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
			AddAmmoToPed(playerPed, weaponHash, 400)
		elseif rewardType == "vehicle" then
			local coords = GetEntityCoords(playerPed)
			local heading = GetEntityHeading(playerPed)
			ESX.Game.SpawnVehicle(Config.reward[stt].key, coords, heading, function(vehicle)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				local newPlate     = exports['esx_vehicleshop']:GeneratePlate()
				local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
				vehicleProps.plate = newPlate
				SetVehicleNumberPlateText(vehicle, newPlate)
				TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
				ESX.Game.DeleteVehicle(vehicle)
			end)
		elseif rewardType == "themluot" then
			TriggerEvent("vongquaymayman-dutien")
		elseif rewardType == "money" then
			TriggerServerEvent("vongquaymayman-addtien", Config.reward[stt].key)
		elseif rewardType == "item" then
			TriggerServerEvent("vongquaymayman-additem", Config.reward[stt].key)
		elseif rewardType == "skin" then
			TriggerServerEvent('vipskin_addskin', Config.reward[stt].key)
		end
    end
)

RegisterNetEvent("vongquaymayman-dutien")
AddEventHandler("vongquaymayman-dutien", function()
	SendNUIMessage({
            	   type = 'thanhcong'
				   })
	getCoindata()
end)

RegisterNetEvent("vongquaymayman-dungitem")
AddEventHandler("vongquaymayman-dungitem", function()
	local playerPed = PlayerPedId()
	Citizen.Wait(5000)
	SetPedComponentVariation(playerPed, 9, 27, 9, 2)
	TriggerEvent('Lorraxs:checkArmour', 150)
	SetPlayerMaxArmour(PlayerId(), 150)
	AddArmourToPed(playerPed, 150)
	SetPedArmour(playerPed, 150)
	
end)


--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(1, Config.key) then
			--exports['mythic_notify']:DoLongHudText('error',Config.reward[18])
             -- do something
            -- if isUiOpen == false and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'true'
            	   })
                isUiOpen = true
				SetNuiFocus(true, true)
				getCoindata()
				
				TransitionToBlurred(1000)
            --else
            --   SendNUIMessage({
            --        displayWindow = 'false'
             --  })
             --  isUiOpen = false     
			--	TransitionFromBlurred(1000)
           -- end

            -- SetNuiFocus(true, false);
          	
        end
    end

end)]]

RegisterCommand('vongquay', function()
    SendNUIMessage({
        displayWindow = 'true'
    })
    isUiOpen = true
    SetNuiFocus(true, true)
	getCoindata()
				
	TransitionToBlurred(1000)
end)

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closebaucua()
    end
)

function getCoindata()
	ESX.TriggerServerCallback('vongquaymayman-getcoin',function(result)
		SendNUIMessage({
			type = 'update',
			coin = result
			})
		
		end)
end

function closebaucua()
    isUiOpen = false  
    SendNUIMessage(
        {
            displayWindow = 'false'
        }
    )
    SetNuiFocus(false, false)
	
	TransitionFromBlurred(1000)
end

function autocoin()
	
	TriggerServerEvent("vongquaymayman-autocoin")

SetTimeout(5400000, autocoin)
end
SetTimeout(5400000, autocoin)