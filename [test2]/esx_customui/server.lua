TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'togglehud', function(source, args)
	if not args then 
		TriggerClientEvent('chatMessage', source, "[SYNTAX]", {255, 0, 0}, "/togglehud [on/off]") 
	else
	local a = tostring(args[1])
		if a == "off" then
			TriggerClientEvent('6f0be580-73f8-40ea-8337-18248698e74e', source,false)
		elseif a == "on" then
			TriggerClientEvent('6f0be580-73f8-40ea-8337-18248698e74e', source,true)
		else
			TriggerClientEvent('chatMessage', source, "[SYNTAX]", {255, 0, 0}, "/togglehud [on/off]") 
		end
	end
end, {help = "Toggles the hud on and off"})

