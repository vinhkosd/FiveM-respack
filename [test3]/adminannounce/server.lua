ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
msg = ""
RegisterCommand('announce', function(source, args, user)
	if IsPlayerAceAllowed(source, "command") then
			for i,v in pairs(args) do
				msg = msg .. " " .. v
			end
			TriggerClientEvent("announce", -1, msg)
			msg = ""
    end
end)

RegisterCommand("police", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "ADMIN" then
			for i,v in pairs(args) do
				msg = msg .. " " .. v
			end
			TriggerClientEvent("police", -1, msg)
			msg = ""
    end
end)