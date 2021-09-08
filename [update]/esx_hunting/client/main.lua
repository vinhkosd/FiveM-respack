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

ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end

local AnimalPositions = {
	{ x = -1505.2, y = 4887.39, z = 78.38 },
	{ x = -1164.68, y = 4806.76, z = 223.11 },
	{ x = -1410.63, y = 4730.94, z = 44.0369 },
	{ x = -1377.29, y = 4864.31, z = 134.162 },
	{ x = -1697.63, y = 4652.71, z = 22.2442 },
	{ x = -1259.99, y = 5002.75, z = 151.36 },
	{ x = -960.91, y = 5001.16, z = 183.0 },
	
}

local AnimalsInSession = {}

local Positions = {
	['StartHunting'] = { ['hint'] = '[E] Bắt đầu săn bắt', ['x'] = -769.23773193359, ['y'] = 5595.6215820313, ['z'] = 33.48571395874 , ['name'] = 'Điểm săn bắn'},
	['Sell'] = { ['hint'] = '[E] Bán thành phẩm', ['x'] = 969.16375732422, ['y'] = -2107.9033203125, ['z'] = 31.475671768188, ['name'] = 'Điểm bán' },
	['SpawnATV'] = { ['x'] = -769.63067626953, ['y'] = 5592.7573242188, ['z'] = 33.48571395874, ['name'] = 'Điểm spawn xe' }
}

local OnGoingHuntSession = false
local HuntCar = nil

function LoadMarkers()

	Citizen.CreateThread(function()
		for index, v in pairs(Positions) do
			if index ~= 'SpawnATV' then
				local StartBlip = AddBlipForCoord(v.x, v.y, v.z)
				SetBlipSprite(StartBlip, 442)
				SetBlipColour(StartBlip, 75)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.name)
				EndTextCommandSetBlipName(StartBlip)
			end
		end
	end)
				local StartBlip = AddBlipForCoord(-1320.733, -394.1741, 36.42225)
				SetBlipSprite(StartBlip, 269)
				SetBlipColour(StartBlip, 59)
				SetBlipScale(StartBlip, 0.9)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Cửa hàng súng tiền bẩn')
				EndTextCommandSetBlipName(StartBlip)
				
				local StartBlip = AddBlipForCoord(131.4623, -1325.67, 29.2031)
				SetBlipSprite(StartBlip, 621)
				SetBlipColour(StartBlip, 8)
				SetBlipScale(StartBlip, 0.7)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Gái bán dâm')
				EndTextCommandSetBlipName(StartBlip)
				
				local StartBlip = AddBlipForCoord(-2962.652, 483.7263, 15.70228)
				SetBlipSprite(StartBlip, 108)
				SetBlipColour(StartBlip, 15)
				SetBlipScale(StartBlip, 0.8)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Ngân hàng bờ biển')
				EndTextCommandSetBlipName(StartBlip)
				
				
				local StartBlip = AddBlipForCoord(247.1203, 223.2926, 106.2868)
				SetBlipSprite(StartBlip, 108)
				SetBlipColour(StartBlip, 15)
				SetBlipScale(StartBlip, 0.8)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Ngân hàng bán vàng')
				EndTextCommandSetBlipName(StartBlip)
				
				local StartBlip = AddBlipForCoord(-112.705, 6469.607, 31.62671)
				SetBlipSprite(StartBlip, 108)
				SetBlipColour(StartBlip, 15)
				SetBlipScale(StartBlip, 0.8)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Ngân hàng ngoại ô')
				EndTextCommandSetBlipName(StartBlip)
				
				local StartBlip = AddBlipForCoord(1849.429, 2586.344, 45.67201)
				SetBlipSprite(StartBlip, 188)
				SetBlipColour(StartBlip, 1)
				SetBlipScale(StartBlip, 1.2)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Nhà tù')
				EndTextCommandSetBlipName(StartBlip)
				
				
				local StartBlip = AddBlipForCoord(-1673.5103759766, -911.05505371094, 8.2279672622681)
				SetBlipSprite(StartBlip, 135)
				SetBlipColour(StartBlip, 74)
				SetBlipScale(StartBlip, 1.2)
				SetBlipAsShortRange(StartBlip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Chiếu phim công cộng')
				EndTextCommandSetBlipName(StartBlip)

	 ('blazer')
	LoadModel('a_c_deer')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')

	Citizen.CreateThread(function()
		while true do
			local sleep = 500
			
			local plyCoords = GetEntityCoords(PlayerPedId())

			for index, value in pairs(Positions) do
				if value.hint ~= nil then

					if OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '[E] Dừng săn bắn'
					elseif not OnGoingHuntSession and index == 'StartHunting' then
						value.hint = '[E] Bắt đầu săn bắn'
					end

					local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)

					if distance < 5.0 then
						sleep = 5
						DrawM(value.hint, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
						if distance < 1.0 then
							if IsControlJustReleased(0, Keys['E']) then
								if index == 'StartHunting' then
									StartHuntingSession()
								else
									SellItems()
								end
							end
						end
					end

				end
				
			end
			Citizen.Wait(sleep)
		end
	end)
end

function StartHuntingSession()

	if OnGoingHuntSession then

		OnGoingHuntSession = false

		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"), true, true)
		RemoveWeaponFromPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"), true, true)

		DeleteEntity(HuntCar)

		for index, value in pairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end

	else
		OnGoingHuntSession = true

		--Car

		HuntCar = CreateVehicle(GetHashKey('blazer'), Positions['SpawnATV'].x, Positions['SpawnATV'].y, Positions['SpawnATV'].z, 169.79, true, false)

		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_PISTOL"),45, true, false)
		GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_KNIFE"),1, true, false)

		--Animals

		Citizen.CreateThread(function()
			local hash = GetHashKey('a_c_deer')
				RequestModel(hash)
				while not HasModelLoaded(hash) do
					Wait(1)
					print('false')
				end
				
			for index, value in pairs(AnimalPositions) do
				local Animal = CreatePed(5, hash, value.x, value.y, value.z, 0.0, true, false)
				TaskWanderStandard(Animal, true, true)
				SetEntityAsMissionEntity(Animal, true, true)
				print(Animal)
				--Blips

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 153)
				SetBlipColour(AnimalBlip, 1)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Hưu - Động vật')
				EndTextCommandSetBlipName(AnimalBlip)


				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			end

			while OnGoingHuntSession do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)

						if AnimalHealth <= 0 then
							SetBlipColour(value.Blipid, 3)
							if PlyToAnimal < 2.0 then
								sleep = 5

								ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, '[E] Slaughter Animal', 0.4)

								if IsControlJustReleased(0, Keys['E']) then
									if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNIFE')  then
										if DoesEntityExist(value.id) then
											table.remove(AnimalsInSession, index)
											SlaughterAnimal(value.id)
										end
									else
										ESX.ShowNotification('Bạn cần phải dùng dao!')
									end
								end

							end
						end
					end
				end

				Citizen.Wait(sleep)

			end
				
		end)
	end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )

	Citizen.Wait(5000)

	ClearPedTasksImmediately(PlayerPedId())

	local AnimalWeight = math.random(10, 160) / 10

	ESX.ShowNotification('Bạn vừa sẻ thịt và nhận được ' ..AnimalWeight.. 'kg')

	TriggerServerEvent('esx-qalle-hunting:reward', AnimalWeight)

	DeleteEntity(AnimalId)
end

function SellItems()
	TriggerServerEvent('esx-qalle-hunting:sell')
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DrawM(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end