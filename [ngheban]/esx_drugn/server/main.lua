ESX = nil
local DangCheBienCanSa = {}
local BatDauBanCanSa = {}
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



local function BanCanSa(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.ThoiGianBan, function()

		if BatDauBanCanSa[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			--local 'marijuana' = 'marijuana'
			local poochQuantity = xPlayer.getInventoryItem('marijuana').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
			else
				if Config.RequiredCopsWeed == 0 then
					xPlayer.removeInventoryItem('marijuana', 1)
					xPlayer.addAccountMoney('black_money', 1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', 1))			
				elseif CopsConnected == 1 then
					xPlayer.removeInventoryItem('marijuana', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 2 then
					xPlayer.removeInventoryItem('marijuana', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan2)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 3 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan3)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 4 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan4)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 5 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan5)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 6 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan6)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 7 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan7)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 8 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan8)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 9 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 10 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected >= 11 then
					xPlayer.removeInventoryItem('marijuana', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				end
				
				BanCanSa(source)
			end
	
		end
	end)
end


RegisterServerEvent('SellCanSa')
AddEventHandler('SellCanSa', function()

	local _source = source

	BatDauBanCanSa[_source] = true

	TriggerClientEvent('esx:showNotification', _source,_U('start_sell'))

	BanCanSa(_source)

end)

RegisterServerEvent('DungBanCanSa')
AddEventHandler('DungBanCanSa', function()

	local _source = source

	BatDauBanCanSa[_source] = false	


end)


RegisterServerEvent('haicansa')
AddEventHandler('haicansa', function()
	
	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cannabis')

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

ESX.RegisterServerCallback('Chaicansa', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		cb(false)

	elseif  xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)

	elseif xItem.count < xItem.limit then
		cb(true)
	end
end)

RegisterServerEvent('chebiencansa')
AddEventHandler('chebiencansa', function()
	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))

	elseif not DangCheBienCanSa[source] then
		
		local _source = source
		TriggerClientEvent('esx:showNotification', _source, _U('weed_processingstarted'))
		DangCheBienCanSa[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xcannabis, xmarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('marijuana')

			if xmarijuana.limit ~= 15 and (xmarijuana.count + 1) >= xmarijuana.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xcannabis.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			
			else
				xPlayer.removeInventoryItem('cannabis', 3)
				xPlayer.addInventoryItem('marijuana', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			DangCheBienCanSa[_source] = nil
		end)
	else
		print(('esx_drugn: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)






