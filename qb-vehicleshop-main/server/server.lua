-- QBCore = nil
ESX = nil
Vehicles = {}

-- TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('qb-vehicleshop.requestInfo')
AddEventHandler('qb-vehicleshop.requestInfo', function()
    local src = source
    -- local xPlayer = QBCore.Functions.GetPlayer(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local rows    

    TriggerClientEvent('qb-vehicleshop.receiveInfo', src, xPlayer.getMoney(), xPlayer.getName())
    TriggerClientEvent("qb-vehicleshop.notify", src, 'error', 'Use A and D To Rotate')
    TriggerClientEvent('qb-vehicleshop.sendVehicles', src, Vehicles)
end)

ESX.RegisterServerCallback('qb-vehicleshop.isPlateTaken', function (source, cb, plate)
    -- QBCore.Functions.ExecuteSql(true, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
    --     cb(result[1] ~= nil)
    -- end)

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles where plate=@plate",{['@plate'] = plate}, function(result)
        cb(result[1] ~= nil)
    end)
end)

RegisterServerEvent('qb-vehicleshop.CheckMoneyForVeh')
AddEventHandler('qb-vehicleshop.CheckMoneyForVeh', function(veh, price, name, vehicleProps)
    local src = source
    -- local xPlayer = QBCore.Functions.GetPlayer(src)
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getMoney() >= tonumber(price) then
        -- xPlayer.Functions.RemoveMoney('bank', tonumber(price))
        xPlayer.removeMoney(tonumber(price))
        local vehiclePropsjson = json.encode(vehicleProps)
        if Config.SpawnVehicle then
            stateVehicle = 0
        else
            stateVehicle = 1
        end

        -- QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..xPlayer.PlayerData.steam.."', '"..xPlayer.PlayerData.citizenid.."', '"..veh.."', '"..GetHashKey(veh).."', '"..vehiclePropsjson.."', '"..vehicleProps.plate.."', '"..stateVehicle.."')")

        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
        {
            ['@owner']   = xPlayer.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps)
        }, function (rowsChanged) 
        end)
        TriggerClientEvent("qb-vehicleshop.successfulbuy", source, name, vehicleProps.plate, price)
        TriggerClientEvent('qb-vehicleshop.receiveInfo', source, xPlayer.getMoney())    
        TriggerClientEvent('qb-vehicleshop.spawnVehicle', source, veh, vehicleProps.plate)
    else
        TriggerClientEvent("qb-vehicleshop.notify", source, 'error', 'Not Enough Money')
    end
end)

MySQL.ready(function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM vehicle_categories')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	-- send information after db has loaded, making sure everyone gets vehicle information
	-- TriggerClientEvent('esx_vehicleshop:sendCategories', -1, Categories)
    -- print(json.encode(Vehicles))
end)