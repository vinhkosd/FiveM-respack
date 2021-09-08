--local logs = "https://discordapp.com/api/webhooks/649934856435925004/xvS2m4FjuFRVZ6fF_k1yRPmHFQq83t7gVaUX0wDd7yZkaCc4VTBsGT2ndjfzxD2Y1c8w"
--local communityname = "VOZ"
--local communtiylogo = "https://i.imgur.com/hodjj53.png" -- AddEventHandler('playerConnecting', function()
	-- TriggerClientEvent('showNotification', -1,"~g~".. GetPlayerName(source).."~w~ joined.")
-- end)

-- AddEventHandler('playerDropped', function()
	-- TriggerClientEvent('showNotification', -1,"~r~".. GetPlayerName(source).."~w~ left.")
-- end)
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(killer,reason,weapon,killerid)
	local xPlayer = ESX.GetPlayerFromId(killerid)
	if killer == "**Invalid**"  then
		reason = 3
	end
	if reason == 0 then
		
		TriggerClientEvent('showNotification', -1,"~g~"..GetPlayerName(source).." ~w~đã tự tử. ")
		--PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Spidey Bot", embeds = connect}), { ['Content-Type'] = 'application/json' })
	elseif reason == 1 then
		
		--xPlayer.addXp(0)
		TriggerClientEvent('showNotification', -1,"~r~"..killer .. " đã giết~g~ "..GetPlayerName(source).."~w~ với "..weapon..".")
		--PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Spidey Bot", embeds = connect}), { ['Content-Type'] = 'application/json' })
	elseif reason == 3 then
		if killer == "**Invalid**"  then
			
			TriggerClientEvent('showNotification', -1,"~g~"..GetPlayerName(source).."~w~ đã chết không rõ lý do")
			--PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Spidey Bot", embeds = connect}), { ['Content-Type'] = 'application/json' })
		else
			
			--xPlayer.addXp(0)
			TriggerClientEvent('showNotification', -1,"~g~"..GetPlayerName(source).."~w~ đã bị tông bởi  "..killer)
			--PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Spidey Bot", embeds = connect}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
