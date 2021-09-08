local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local isTalking = false
local inVehicle = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('es:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)


	--Updates the UI on start
	NetworkSetTalkerProximity(10.0)
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({action = "setValue", key = "bankmoney", value = "$"..account.money})
		elseif account.name == "black_money" then
			SendNUIMessage({action = "setValue", key = "dirtymoney", value = "$"..account.money})
		end
	end

	--Job
	local job = data.job
	SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
	local job2 = data.job2
	SendNUIMessage({action = "setValue", key = "job2", value = job2.label.." - "..job2.grade_label, icon = job2.name})

	--Money
	SendNUIMessage({action = "setValue", key = "money", value = "$"..data.money})
end)



-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(0)
		-- TriggerEvent('569b143d-6e4d-4dc5-84bd-101280cf3759', 0.0)
		-- ESX.UI.HUD.SetDisplay(0.0)
		-- if isTalking == false then
			-- if NetworkIsPlayerTalking(PlayerId()) then
				-- isTalking = true
				-- SendNUIMessage({action = "setTalking", value = true})
			-- end
		-- else
			-- if NetworkIsPlayerTalking(PlayerId()) == false then
				-- isTalking = false
				-- SendNUIMessage({action = "setTalking", value = false})
			-- end
		-- end


		-- if inVehicle == false then
			-- if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
				-- inVehicle = true
				-- SendNUIMessage({action = "toggleCar", show = true})
			-- end
		-- else
			-- if IsPedInAnyVehicle(PlayerPedId()) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
				-- local essence = exports.esx_AdvancedFuel:getFuel()
				-- local percent = (essence/0.142)*100
				-- SendNUIMessage({action = "updateCarStatus", status = {{name = "gas", percent = percent}}})
			-- else
				-- inVehicle = false
				-- SendNUIMessage({action = "toggleCar", show = false})
			-- end


		-- end

	-- end
-- end)


---voice

-- local portevoix = 10.0

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(0)
		-- if IsControlJustPressed(1, 243) then
			-- local voip
			-- if portevoix <= 2.0 then
				-- portevoix = 10.0
				-- --event normal
				-- voip = "normal"
			-- elseif portevoix == 10.0 then
				-- portevoix = 26.0
			-- -- event shout
				-- voip = "shout"
			-- elseif portevoix >= 26.0 then
				-- portevoix = 2.0
				-- voip = "whisper"
			-- --event whisper
			-- end
			-- NetworkSetTalkerProximity(portevoix)
			-- SendNUIMessage({action = "setProximity", value = voip})
		-- end
		-- if IsControlPressed(1, 243) then
			-- local posPlayer = GetEntityCoords(PlayerPedId())
			-- DrawMarker(1, posPlayer.x, posPlayer.y, posPlayer.z - 1, 0, 0, 0, 0, 0, 0, portevoix * 2, portevoix * 2, 0.8001, 0, 75, 255, 165, 0,0, 0,0)
		-- end
	-- end
-- end)


RegisterNetEvent('ui:toggle')
AddEventHandler('ui:toggle', function(show)

	SendNUIMessage({action = "toggle", show = show})

end)


RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	--account.name , account.money
	if account.name == "bank" then
		SendNUIMessage({action = "setValue", key = "bankmoney", value = "$"..account.money})
	elseif account.name == "black_money" then
		SendNUIMessage({action = "setValue", key = "dirtymoney", value = "$"..account.money})
	end
	
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  --job
  SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
  --job
  SendNUIMessage({action = "setValue", key = "job2", value = job.label.." - "..job.grade_label, icon = job.name})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	--Sets Money
	SendNUIMessage({action = "setValue", key = "money", value = "$"..e})
end)

RegisterNetEvent('esx_customui:updateStatus')
AddEventHandler('esx_customui:updateStatus', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

RegisterNetEvent('esx_customui:updateWeight')
AddEventHandler('esx_customui:updateWeight', function(weight)
	weightprc = (weight/8000)*100
	SendNUIMessage({action = "updateWeight", weight = weightprc})
end)