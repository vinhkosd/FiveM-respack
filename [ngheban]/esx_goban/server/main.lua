ESX = nil
local Dangchebienopium = {}
local BatDauBanGo = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(10 * 1000, CountCops)
end

CountCops()



local function BanGo(source)

	if CopsConnected < Config.RequiredCopsopium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsopium))
		return
	end

	SetTimeout(Config.ThoiGianBan, function()

		if BatDauBanGo[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			--local 'opium_pooch' = 'opium_pooch'
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
			else
				if Config.RequiredCopsopium == 0 then
					xPlayer.removeInventoryItem('opium_pooch', 1)
					xPlayer.addAccountMoney('black_money', 1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', 1))			
				elseif CopsConnected == 1 then
					xPlayer.removeInventoryItem('opium_pooch', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 2 then
					xPlayer.removeInventoryItem('opium_pooch', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 3 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 4 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 5 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 6 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan )
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 7 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 8 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 9 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 10 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 11 then
					xPlayer.removeInventoryItem('opium_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				end
				
				BanGo(source)
			end
	
		end
	end)
end


RegisterServerEvent('SellGo')
AddEventHandler('SellGo', function()

	local _source = source

	BatDauBanGo[_source] = true

	TriggerClientEvent('esx:showNotification', _source,_U('start_sell'))

	BanGo(_source)

end)

RegisterServerEvent('DungBanGo')
AddEventHandler('DungBanGo', function()

	local _source = source

	BatDauBanGo[_source] = false	


end)

RegisterServerEvent('chatcaygo')
AddEventHandler('chatcaygo', function()
	
	if CopsConnected < Config.RequiredCopsopium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsopium))
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('opium')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)
RegisterServerEvent('thuevan')
AddEventHandler('thuevan', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.RentBoard)

end)

ESX.RegisterServerCallback('cothechat', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if CopsConnected < Config.RequiredCopsopium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsopium))
		cb(false)

	elseif  xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)

	elseif xItem.count < xItem.limit then
		cb(true)
	end
end)

RegisterServerEvent('chebienopium')
AddEventHandler('chebienopium', function()
	if CopsConnected < Config.RequiredCopsopium then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsopium))

	elseif not Dangchebienopium[source] then
		
		local _source = source
		TriggerClientEvent('esx:showNotification', _source, _U('weed_processingstarted'))
		Dangchebienopium[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xopium, xopium_pooch = xPlayer.getInventoryItem('opium'), xPlayer.getInventoryItem('opium_pooch')

			if xopium_pooch.limit ~= 15 and (xopium_pooch.count + 1) >= xopium_pooch.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xopium.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			
			else
				xPlayer.removeInventoryItem('opium', 3)
				xPlayer.addInventoryItem('opium_pooch', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			Dangchebienopium[_source] = nil
		end)
	else
		print(('esx_opium: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)






