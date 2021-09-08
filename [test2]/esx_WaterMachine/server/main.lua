ESX               = nil
local ItemsLabels = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_WaterMachine:buyItem')
AddEventHandler('esx_WaterMachine:buyItem', function(itemName, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	
	if price < 0 then
		print('esx_WaterMachine: ' .. xPlayer.identifier .. ' attempted to cheat money!')
		return
	end

	if xPlayer.getMoney() >= price then
			TriggerClientEvent('esx_WaterMachine:Random', source)
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough', missingMoney))
	end

end)

RegisterServerEvent('esx_WaterMachine:TakeMoney')
AddEventHandler('esx_WaterMachine:TakeMoney', function(price)
	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(price)
end)

RegisterServerEvent('esx_WaterMachine:DrankProduct')
AddEventHandler('esx_WaterMachine:DrankProduct', function()
	local _source = source
	TriggerClientEvent('esx_status:add', _source, 'thirst', 300000)
end)