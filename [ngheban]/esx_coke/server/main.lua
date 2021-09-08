ESX = nil
local DangCheBienCoke = {}
local BatDauBanCoke = {}
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



local function BanCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.ThoiGianBan, function()

		if BatDauBanCoke[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			--local 'coke_pooch' = 'coke_pooch'
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('dealer_notenough'))
			else
				if Config.RequiredCopsCoke == 0 then
					xPlayer.removeInventoryItem('coke_pooch', 1)
					xPlayer.addAccountMoney('black_money', 1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', 1))			
				elseif CopsConnected == 1 then
					xPlayer.removeInventoryItem('coke_pooch', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan1)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan1))
				elseif CopsConnected == 2 then
					xPlayer.removeInventoryItem('coke_pooch', 1)
					xPlayer.addAccountMoney('black_money', Config.GiaBan2)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan2))
				elseif CopsConnected == 3 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan3)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan3))
				elseif CopsConnected == 4 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan4)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan4))
				elseif CopsConnected == 5 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan5)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan5))
				elseif CopsConnected >= 6 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan6)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan6))
				elseif CopsConnected >= 7 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan7)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan7))
				elseif CopsConnected >= 8 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan8)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan8))
				elseif CopsConnected >= 9 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan9))
				elseif CopsConnected >= 10 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan9))
				elseif CopsConnected >= 11 then
					xPlayer.removeInventoryItem('coke_pooch', 1)

					xPlayer.addAccountMoney('black_money',  Config.GiaBan9)
					TriggerClientEvent('esx:showNotification', source, _U('dealer_sold', Config.GiaBan9))
				end
				
				BanCoke(source)
			end
	
		end
	end)
end


RegisterServerEvent('SellCoke')
AddEventHandler('SellCoke', function()

	local _source = source

	BatDauBanCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source,_U('start_sell'))

	BanCoke(_source)

end)

RegisterServerEvent('DungBanCoke')
AddEventHandler('DungBanCoke', function()

	local _source = source

	BatDauBanCoke[_source] = false	


end)


RegisterServerEvent('haicocain')
AddEventHandler('haicocain', function()
	
	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('coke')

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

ESX.RegisterServerCallback('Cothehai', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		cb(false)

	elseif  xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)

	elseif xItem.count < xItem.limit then
		cb(true)
	end
end)

RegisterServerEvent('chebiencoke')
AddEventHandler('chebiencoke', function()
	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))

	elseif not DangCheBienCoke[source] then
		
		local _source = source
		TriggerClientEvent('esx:showNotification', _source, _U('weed_processingstarted'))
		DangCheBienCoke[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCoke, xCokepooch = xPlayer.getInventoryItem('coke'), xPlayer.getInventoryItem('coke_pooch')

			if xCokepooch.limit ~= 15 and (xCokepooch.count + 1) >= xCokepooch.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			elseif xCoke.count < 3 then
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
			
			else
				xPlayer.removeInventoryItem('coke', 3)
				xPlayer.addInventoryItem('coke_pooch', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))
			end

			DangCheBienCoke[_source] = nil
		end)
	else
		print(('esx_coke: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)






