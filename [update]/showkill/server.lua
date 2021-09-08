AddEventHandler('playerConnecting', function()
	TriggerClientEvent('showNotification', -1,"~g~".. GetPlayerName(source).."~w~ Vào.")
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('showNotification', -1,"~r~".. GetPlayerName(source).."~w~ Thoát.")
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason)
	if killer == "**Invalid**" then --Can't figure out what's generating invalid, it's late. If you figure it out, let me know. I just handle it as a string for now.
		reason = 2
	end
	if reason == 0 then
		TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ đã tự tử. ")
	elseif reason == 1 then
		TriggerClientEvent('showNotification', -1,"~o~".. killer .. "~w~ đã giết ~o~"..GetPlayerName(source).."~w~.")
	else
		TriggerClientEvent('showNotification', -1,"~o~".. GetPlayerName(source).."~w~ đã chết.")
	end
end)