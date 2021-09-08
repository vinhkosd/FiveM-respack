ESX = nil
local DangCheBienweed = {}
local BatDauBanweed = {}
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



local function Banweed(source)

	if CopsConnected < Config.RequiredCopsweed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsweed))
		return
	end

	SetTimeout(Config.ThoiGianBan, function()

		if BatDauBanweed[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			--local 'weed_pooch' = 'weed_pooch'
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
			else
				if Config.RequiredCopsweed == 0 then
					xPlayer.removeInventoryItem('weed_pooch', 1)
					xPlayer.addAccountMoney('black_money', 1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', 1))			
				elseif CopsConnected == 1 then
					xPlayer.removeInventoryItem('weed_pooch', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan1))
				elseif CopsConnected == 2 then
					xPlayer.removeInventoryItem('weed_pooch', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan2)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan2))
				elseif CopsConnected == 3 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan3)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan3))
				elseif CopsConnected == 4 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan4)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan4))
				elseif CopsConnected == 5 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan5)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan5))
				elseif CopsConnected >= 6 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan6)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan6))
				elseif CopsConnected >= 7 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan7)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan7))
				elseif CopsConnected >= 8 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan8)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan8))
				elseif CopsConnected >= 9 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan9))
				elseif CopsConnected >= 10 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan9))
				elseif CopsConnected >= 11 then
					xPlayer.removeInventoryItem('weed_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan9))
				end
				
				Banweed(source)
			end
	
		end
	end)
end


RegisterServerEvent('Sellweed')
AddEventHandler('Sellweed', function()

	local _source = source

	BatDauBanweed[_source] = true

	TriggerClientEvent('esx:showNotification', _source,_U('start_sell'))

	Banweed(_source)

end)

RegisterServerEvent('DungBanweed')
AddEventHandler('DungBanweed', function()

	local _source = source

	BatDauBanweed[_source] = false	


end)


RegisterServerEvent('haiweed')
AddEventHandler('haiweed', function()
	
	if CopsConnected < Config.RequiredCopsweed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsweed))
		TriggerEvent("XNL_NET:AddPlayerXP", 100)
        TriggerServerEvent("AddXp", 100)
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('weed')

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

ESX.RegisterServerCallback('Cothenhat', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if CopsConnected < Config.RequiredCopsweed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsweed))
		cb(false)

	elseif  xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)

	elseif xItem.count < xItem.limit then
		cb(true)
	end
end)

RegisterServerEvent('chebienweed')
AddEventHandler('chebienweed', function()
	if CopsConnected < Config.RequiredCopsweed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsweed))

	elseif not DangCheBienweed[source] then
		
		local _source = source
		TriggerClientEvent('esx:showNotification', _source, _U('weed_processingstarted'))
		DangCheBienweed[_source] = ESX.SetTimeout(Config.Delays.weedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xweed, xweedpooch = xPlayer.getInventoryItem('weed'), xPlayer.getInventoryItem('weed_pooch')

			if xweedpooch.limit ~= 15 and (xweedpooch.count + 1) >= xweedpooch.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xweed.count < 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			
			else
				xPlayer.removeInventoryItem('weed', 5)
				xPlayer.addInventoryItem('weed_pooch', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))				
			end

			DangCheBienweed[_source] = nil
		end)
	else
		print(('esx_weed: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)






