ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("endiezhaha:getownedskin", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('SELECT * FROM vipskin WHERE identifier = @identifier', {['@identifier'] = identifier}, function(result)
		cb(result)
	end)
end)

TriggerEvent('es:addGroupCommand', 'addskin', 'superadmin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			if args[2] ~= nil then
				--print(('add coin '):format(GetPlayerName(source)))
				addskin( tonumber(args[1]), (args[2]))
			end
		end
	end
	end,function(source, args, user)
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end,{help = ''})

function addskin(id, name)
	local xPlayer = ESX.GetPlayerFromId(id)
	local identifier = xPlayer.getIdentifier()
	MySQL.Sync.execute("INSERT INTO vipskin (identifier, name) VALUE (@identifier, @name)", {['@identifier'] = identifier, ['@name'] = name})
	TriggerClientEvent('esx:showNotification', id, 'Bạn đã nhận được một skin')
	TriggerClientEvent("endiezhaha:update", id)
end