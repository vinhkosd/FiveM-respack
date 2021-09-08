local skinlist = {}
ESX				= nil
Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Citizen.Wait(10000)
	ESX.TriggerServerCallback("endiezhaha:getownedskin", function(skin)
		skinlist = skin
	end)
end)

RegisterNetEvent("endiezhaha:update")
AddEventHandler("endiezhaha:update", function()
	ESX.TriggerServerCallback("endiezhaha:getownedskin", function(skin)
		skinlist = skin
	end)
end)
RegisterCommand("myskin",function()
	local playerped = PlayerPedId()
	local elements = {
		{label = 'Skin mặc định', name = 'citizen_wear'}
	}
	if skinlist ~= {} then
		local dumped = ESX.DumpTable(skinlist)
		print(dumped)
		print(skinlist.name)
		for k,v in ipairs(skinlist) do
			table.insert(elements, {
				name = v.name,
				label = v.name
			})
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_skin',{
			title = 'Vip Skin',
			align = 'center',
			elements = elements
		}, function (data,menu)
			if data.current.name == 'citizen_wear' then
				local curHea = GetEntityHealth(PlayerPedId())
				print(curHea)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
				Citizen.Wait(1000)
				SetEntityHealth(PlayerPedId(), curHea)
				Citizen.Wait(10000)
			else
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vip_skin_confirm',
			{
				title = 'Bạn muốn đổi thành skin này',
				align = 'center',
				elements = {
					{ label = 'Không', value = 'no'},
					{ label = 'Có', value = 'yes'}
				}
			}, function (data2, menu2)
					if data2.current.value == 'yes' then
						local curHea = GetEntityHealth(PlayerPedId())
						characterModel = data.current.name
						RequestModel(characterModel)
						while not HasModelLoaded(characterModel) do
							RequestModel(characterModel)
							Citizen.Wait(0)
						end

						if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
							SetPlayerModel(PlayerId(), characterModel)
							SetPedDefaultComponentVariation(playerPed)
							TriggerEvent('esx:restoreLoadout')
							SetEntityHealth(PlayerPedId(), curHea)
						end

						SetModelAsNoLongerNeeded(characterModel)
					else
						menu2.close()
					end
			end, function (data2, menu2)
				menu2.close()
			end)
		end
		end, function (data,menu)
			menu.close()
		end, function (data, menu)
		end)
	else 
		ESX.ShowNotification('Bạn ~r~ Không ~w~ có skin')
	end
end)
				
			
		
