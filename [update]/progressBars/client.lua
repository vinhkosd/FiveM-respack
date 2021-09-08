RegisterNetEvent("progbar:startUi")
AddEventHandler("progbar:startUi", function(time, text)
	startUI(time, text)
end)
function startUI(time, text) 
	SendNUIMessage({
		type = "ui",
		display = true,
		time = time,
		text = text
	})
end