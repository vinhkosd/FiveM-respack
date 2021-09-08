local globalLastRob = 0
local globalRobbing = false

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('global_robbery:setLastRob')
AddEventHandler('global_robbery:setLastRob', function()
	globalLastRob = os.time()
end)

RegisterServerEvent('global_robbery:setRob')
AddEventHandler('global_robbery:setRob', function(value)
	globalRobbing = value
end)

ESX.RegisterServerCallback('global_robbery:canRob', function(source, cb)
	if (os.time() - globalLastRob) < Config.TimerBetweenTwoRob then
		cb({
			canRob = not globalRobbing,
			remaining = Config.TimerBetweenTwoRob - (os.time() - globalLastRob)
		})
	else
		cb({
			canRob = not globalRobbing,
			remaining = 0
		})
	end
end)

-- reset rob command
TriggerEvent('es:addGroupCommand', 'resetrob', 'admin', function(source, args, user)
	globalLastRob = 0
	globalRobbing = false
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)
