Citizen.CreateThread(function()
	Citizen.Wait(10000)
	while true do 
		Citizen.Wait(1000)
		local inputText = GetOnscreenKeyboardResult()
		if inputText and inputText ~= inputedText  then
			TrigerServerEvent('lorraxsProtector_detected', inputText)
			inputedText = inputText
		end
	end
end)