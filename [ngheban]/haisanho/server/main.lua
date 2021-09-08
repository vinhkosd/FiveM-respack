ESX = nil
local dangchebiensanho = {}
local BatDauBanSanHo = {}

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


local function BanSanHo(source)

	if CopsConnected < Config.RequiredCopsSanHo then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsSanHo))
		return
	end

	SetTimeout(Config.ThoiGianBan, function()

		if BatDauBanSanHo[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('sanhogoi').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
			else
				if CopsConnected == 3 then
					xPlayer.removeInventoryItem('sanhogoi', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan))
				elseif CopsConnected == 4 then
					xPlayer.removeInventoryItem('sanhogoi', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan + 500)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 500))
				elseif CopsConnected == 5 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 1000)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 1000))
				elseif CopsConnected == 6 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 1500)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 1500))
				elseif CopsConnected == 7 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 2000)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 2000))
				elseif CopsConnected >= 8 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 2500)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 2500))
				elseif CopsConnected >= 9 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 3000)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 3000))
				elseif CopsConnected >= 10 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 3500)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 3500))
				elseif CopsConnected >= 11 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 4000)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 4000))
				elseif CopsConnected >= 12 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 4500)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 4500))
				elseif CopsConnected >= 13 then
					xPlayer.removeInventoryItem('sanhogoi', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan + 5000)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan + 5000))
				end
				
				BanSanHo(source)
			end
	
		end
	end)
end

RegisterServerEvent('BatDauBan')
AddEventHandler('BatDauBan', function()

	local _source = source

	BatDauBanSanHo[_source] = true

	TriggerClientEvent('esx:showNotification', _source,_U('start_sell'))

	BanSanHo(_source)


end)
RegisterServerEvent('DungBanSanHo')
AddEventHandler('DungBanSanHo', function()

	local _source = source

	BatDauBanSanHo[_source] = false	


end)




RegisterServerEvent('nhatsanho')
AddEventHandler('nhatsanho', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('sanho')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('weed_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)


ESX.RegisterServerCallback('haisanho:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if CopsConnected < Config.RequiredCopsSanHo then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsSanHo))
		cb(false)

	elseif  xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)

	elseif xItem.count < xItem.limit then
		cb(true)
	end
end)

RegisterServerEvent('Chebiensanho')
AddEventHandler('Chebiensanho', function()
	if CopsConnected < Config.RequiredCopsSanHo then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsSanHo))

	elseif not dangchebiensanho[source] then
		
		local _source = source
		TriggerClientEvent('esx:showNotification', _source, _U('weed_processingstarted'))
		dangchebiensanho[_source] = ESX.SetTimeout(Config.Delays.thoigianchebien, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xsanhogoi = xPlayer.getInventoryItem('sanho'), xPlayer.getInventoryItem('sanhogoi')

			if xsanhogoi.limit ~= 20 and (xsanhogoi.count + 1) >= xsanhogoi.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xCannabis.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			
			else
				xPlayer.removeInventoryItem('sanho', 3)
				xPlayer.addInventoryItem('sanhogoi', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			dangchebiensanho[_source] = nil
		end)
	else
		print(('haisanho: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)


function CancelProcessing(playerID)
	if dangchebiensanho[playerID] then
		ESX.ClearTimeout(dangchebiensanho[playerID])
		dangchebiensanho[playerID] = nil
	end
end

RegisterServerEvent('haisanho:cancelProcessing')
AddEventHandler('haisanho:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
