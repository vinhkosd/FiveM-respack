ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer 
end)

RegisterNetEvent('esx_bulletproof:bulletproof')
AddEventHandler('esx_bulletproof:bulletproof', function()
	local playerPed = GetPlayerPed(-1)
	TriggerEvent('Lorraxs:checkArmour', 100)
	SetPedComponentVariation(playerPed, 9, 27, 9, 2)
	AddArmourToPed(playerPed, 100)
	SetPedArmour(playerPed, 100)
	
end)
