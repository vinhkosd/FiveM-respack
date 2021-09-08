ESX             = nil
local ShopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM dirtyshops LEFT JOIN items ON dirtyshops.item = items.name', {}, function(shopResult)
		for i=1, #shopResult, 1 do
			if shopResult[i].name then
				if ShopItems[shopResult[i].store] == nil then
					ShopItems[shopResult[i].store] = {}
				end

				if shopResult[i].limit == -1 then
					shopResult[i].limit = 30
				end

				table.insert(ShopItems[shopResult[i].store], {
					label = shopResult[i].label,
					item  = shopResult[i].item,
					price = shopResult[i].price,
					limit = shopResult[i].limit
				})
				local dumped = ESX.DumpTable(ShopItems)
				print(dumped)
			else
				print(('esx_dirtyshops: muc khong hop le "%s" tim thay!'):format(shopResult[i].item))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_dirtyshops:requestDBItems', function(source, cb)
	
	cb(ShopItems)
end)

RegisterServerEvent('esx_dirtyshops:buyItem')
AddEventHandler('esx_dirtyshops:buyItem', function(itemName, amount, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	amount = ESX.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_dirtyshops: ' .. xPlayer.identifier .. ' da co gang khai thac cac cua hang!')
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	price = tonumber(price * amount)
	local dumped = ESX.DumpTable(xPlayer.getAccount('black_money').money)
				print(dumped)
	

	-- can the player afford this item?
	if xPlayer.getAccount('black_money').money >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
		else
			xPlayer.removeAccountMoney('black_money', price)
			xPlayer.addInventoryItem(itemName, amount)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
		end
	else
		local missingMoney = price - xPlayer.getAccount('black_money')
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough', ESX.Math.GroupDigits(missingMoney)))
	end
end)
