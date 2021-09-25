  -- Local
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

local GUI = {}
GUI.Time = 0
local carInstance = {}

-- Fin Local

-- Init ESX
ESX = nil
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
            SetNuiFocus(false, false)
    end
end)
Citizen.CreateThread(function()
    while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
            end)
    end
end)

RegisterNUICallback('escape', function(data, cb)

    SetNuiFocus(false, false)

    SendNUIMessage({
            type = "close",
    })
end)
--Fonction Menu

function OpenMenuGarage(garage, KindOfVehicle)
    ESX.UI.Menu.CloseAll()

    local elements = {
            {label = "Chuộc phương tiện ("..Config.Price.."$)", value = 'return_vehicle'},
    }


    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'garage_menu',
            {
                    title    = 'Garage',
                    align    = 'top-left',
                    elements = elements,
            },
            function(data, menu)

                    menu.close()
                    if(data.current.value == 'return_vehicle') then
                            ESX.TriggerServerCallback('eden_garage:checkMoney', function(result)
                                    if result == true then
                                            ReturnVehicleMenu(garage, KindOfVehicle)
                                    else
                                            ESX.ShowNotification('Bạn không đủ tiền')
                                    end
                            end)
                    end
            end,
            function(data, menu)
                    menu.close()
            end
    )
end

RegisterNUICallback('spawnVehicle', function(data)
	local plate = data.plate
	ESX.TriggerServerCallback('lorraxs-garage:getVehicle', function(vehicle)
		if vehicle ~= nil then
			if vehicle.state == false or vehicle.state == 0 then -- xe nam ngoai garage
				local vehicleOnMap = false
				local vehicles = ESX.Game.GetVehicles()

				for i=1, #vehicles, 1 do
					local plateVeh = ESX.Math.Trim(GetVehicleNumberPlateText(vehicles[i]))
					if plateVeh == plate then
						vehicleOnMap = true
					end
				end

				if vehicleOnMap == true then
					ESX.ShowNotification('Xe của bạn đang ở trên map, không thể chuộc xe!')
					return
				end
				ESX.TriggerServerCallback('eden_garage:checkMoney', function(result)
					if result ~= true then
						ESX.ShowNotification('Bạn không đủ tiền chuộc xe')
						return
					else
						local vehicleProps = json.decode(vehicle.vehicle)
						local KindOfVehicle = data.KindOfVehicle
						local arrayGarage = {
							SpawnPoint = {Pos = {x = data.x, y = data.y, z = data.z},Heading = data.Heading}
						}
						SpawnVehicle(vehicleProps, arrayGarage, KindOfVehicle, vehicleProps.engineHealth, vehicleProps.bodyHealth)
					end
				end)
			else	-- xe nam trong garage
				local vehicleProps = json.decode(vehicle.vehicle)
				local KindOfVehicle = data.KindOfVehicle
				local arrayGarage = {
					SpawnPoint = {Pos = {x = data.x, y = data.y, z = data.z},Heading = data.Heading}
				}
				SpawnVehicle(vehicleProps, arrayGarage, KindOfVehicle, vehicleProps.engineHealth, vehicleProps.bodyHealth)
			end
		else
			ESX.ShowNotification('Không tìm thấy phương tiện này')
		end
	end, plate)
    -- local KindOfVehicle = data.KindOfVehicle
    -- local arrayGarage = {
    --         SpawnPoint = {Pos = {x = data.x, y = data.y, z = data.z},Heading = data.Heading}
    -- }
    -- vehicle = json.decode(data.vehicle)
    -- SpawnVehicle(vehicle, arrayGarage, KindOfVehicle, data.engineHealth, data.bodyHealth)
end)

RegisterNUICallback('notify', function(data)
    ESX.ShowNotification(data.msg)
end)
-- Afficher les listes des vehicules
function ListVehiclesMenu(garage, KindOfVehicle)

    local curGarage = garage
    --local encodeGarage = json.encode(curGarage)
    local curKindOfVehicle = KindOfVehicle
    local elements = {}
    local vehicleName = ""
    local engineHealth, bodyHealth, fuelLevel, vehicleType

    ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
            if not table.empty(vehicles) then
                    for _,v in pairs(vehicles) do
                            v.vehicle2 = json.decode(v.vehicle)

                            local hashVehicule = v.vehicle2.model
                            if v.vehiclename == 'voiture' then
                                    vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
                            else
                                    vehicleName = v.vehiclename
                            end
                            if v.vehicle2.engineHealth ~= nil then
                                    engineHealth = v.vehicle2.engineHealth
                            else
                                    engineHealth = 1000
                            end
                            if v.vehicle2.bodyHealth ~= nil then
                                    bodyHealth = v.vehicle2.bodyHealth
                            else
                                    bodyHealth = 1000
                            end
                            if v.vehicle2.fuelLevel ~= nil then
                                    fuelLevel = v.vehicle2.fuelLevel
                            else
                                    fuelLevel = 100
                            end
                            if v.vehicle2.vehicleType ~= nil then
                                    vehicleType = v.vehicle2.vehicleType
                            else
                                    vehicleType = 1
                            end
                            local labelvehicle
                            if(v.fourrieremecano)then
                                    labelvehicle = vehicleName..': Hư Hỏng'
                            elseif (v.state)  then
                                    labelvehicle = vehicleName..': Lấy xe'
                            else
                                    labelvehicle = vehicleName..': Cất xe'
                            end
                            table.insert(elements, {label =labelvehicle , value = v, name = vehicleName, plate = v.plate , state = v.state, vehicle = v.vehicle, garage = curGaragea, KindOfVehicle = curKindOfVehicle, x = garage.SpawnPoint.Pos.x, y = garage.SpawnPoint.Pos.y, z = garage.SpawnPoint.Pos.z, Heading = garage.SpawnPoint.Heading, engineHealth = engineHealth, bodyHealth = bodyHealth, fuelLevel = fuelLevel, vehicleType = vehicleType})

                    end
                    SetNuiFocus(true, true)
                            SendNUIMessage({
                                    type = "shop",
                                    result = elements,
                                    pos = "getVehicle",
                                    price = Config.Price,
                            })
            else
                    ESX.ShowNotification('Không có phương tiện nào trong gara')
            end
            --[[ ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'spawn_vehicle',
            {
                    title    = 'Garage',
                    align    = 'top-left',
                    elements = elements,
            },
            function(data, menu)
                    local elem = {}
                    table.insert(elem, {label ="Lß║Ñy ph╞░╞íng tiß╗çn ra" , value = 'get_vehicle_out'})
                    table.insert(elem, {label ="─Éß╗òi t├¬n ph╞░╞íng tiß╗çn" , value = 'rename_vehicle'})
                    if data.current.value.vehiclename == 'voiture' then
                            vehicleName = GetDisplayNameFromVehicleModel(data.current.value.vehicle.model)
                    else
                            vehicleName = data.current.value.vehiclename
                    end
                    ESX.UI.Menu.Open(
                            'default', GetCurrentResourceName(), 'vehicle_menu',
                            {
                                    title    =  vehicleName,
                                    align    = 'top-left',
                                    elements = elem,
                            },
                            function(data2, menu2)
                                    if data2.current.value == "get_vehicle_out" then
                    if (data.current.value.fourrieremecano) then
                        TriggerEvent('esx:showNotification', 'Xe cß╗ºa bß║ín ─æang ß╗ƒ chß╗ù sß╗¡a xe')
                    elseif (data.current.value.state) then
                        menu.close()
                        menu.cancel()
                        SpawnVehicle(data.current.value.vehicle, garage, KindOfVehicle)
                    else
                        TriggerEvent('esx:showNotification', 'Kh├┤ng c├│ ph╞░╞íng tiß╗çn n├áo ß╗ƒ ─æ├óy')
                    end
                                    elseif data2.current.value == "rename_vehicle" then
                                            AddTextEntry('FMMC_KEY_TIP8', "Nhap ten chiec xe")
                                            DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
                                            while (UpdateOnscreenKeyboard() == 0) do
                                                            DisableAllControlActions(0);
                                                            Wait(0);
                                            end
                                            if (GetOnscreenKeyboardResult()) then
                                                    local name = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('eden_garage:renamevehicle', ESX.Math.Trim(data.current.value.plate), name)
                                            end
                                    end
                            end,
                            function(data2, menu2)
                                    menu.cancel()
                            end
                    )
            end,
            function(data, menu)
                    menu.close()
            end
    ) ]]
    end, KindOfVehicle)
end

function houseGarage(coords, KindOfVehicle)

    local curGarage = garage
    --local encodeGarage = json.encode(curGarage)
    local curKindOfVehicle = KindOfVehicle
    local elements = {}
    local vehicleName = ""
    local engineHealth, bodyHealth, fuelLevel, vehicleType

    ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
            if not table.empty(vehicles) then
                    for _,v in pairs(vehicles) do
                            v.vehicle2 = json.decode(v.vehicle)

                            local hashVehicule = v.vehicle2.model
                            if v.vehiclename == 'voiture' then
                                    vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
                            else
                                    vehicleName = v.vehiclename
                            end
                            if v.vehicle2.engineHealth ~= nil then
                                    engineHealth = v.vehicle2.engineHealth
                            else
                                    engineHealth = 1000
                            end
                            if v.vehicle2.bodyHealth ~= nil then
                                    bodyHealth = v.vehicle2.bodyHealth
                            else
                                    bodyHealth = 1000
                            end
                            if v.vehicle2.fuelLevel ~= nil then
                                    fuelLevel = v.vehicle2.fuelLevel
                            else
                                    fuelLevel = 100
                            end
                            if v.vehicle2.vehicleType ~= nil then
                                    vehicleType = v.vehicle2.vehicleType
                            else
                                    vehicleType = 1
                            end
                            local labelvehicle
                            if(v.fourrieremecano)then
                                    labelvehicle = vehicleName..': Hư Hỏng'
                            elseif (v.state)  then
                                    labelvehicle = vehicleName..': Lấy xe'
                            else
                                    labelvehicle = vehicleName..': Cất xe'
                            end
                            table.insert(elements, {label =labelvehicle , value = v, name = vehicleName, plate = v.plate , state = v.state, vehicle = v.vehicle, KindOfVehicle = curKindOfVehicle, x = coords.x, y = coords.y, z = coords.z, Heading = coords.w, engineHealth = engineHealth, bodyHealth = bodyHealth, fuelLevel = fuelLevel, vehicleType = vehicleType})

                    end
                    SetNuiFocus(true, true)
                            SendNUIMessage({
                                    type = "shop",
                                    result = elements,
                                    pos = "getVehicle",
                                    price = Config.Price,
                            })
            else
                    ESX.ShowNotification('Không có phương tiện nào ')
            end
            --[[ ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'spawn_vehicle',
            {
                    title    = 'Garage',
                    align    = 'top-left',
                    elements = elements,
            },
            function(data, menu)
                    local elem = {}
                    table.insert(elem, {label ="Lß║Ñy ph╞░╞íng tiß╗çn ra" , value = 'get_vehicle_out'})
                    table.insert(elem, {label ="─Éß╗òi t├¬n ph╞░╞íng tiß╗çn" , value = 'rename_vehicle'})
                    if data.current.value.vehiclename == 'voiture' then
                            vehicleName = GetDisplayNameFromVehicleModel(data.current.value.vehicle.model)
                    else
                            vehicleName = data.current.value.vehiclename
                    end
                    ESX.UI.Menu.Open(
                            'default', GetCurrentResourceName(), 'vehicle_menu',
                            {
                                    title    =  vehicleName,
                                    align    = 'top-left',
                                    elements = elem,
                            },
                            function(data2, menu2)
                                    if data2.current.value == "get_vehicle_out" then
                    if (data.current.value.fourrieremecano) then
                        TriggerEvent('esx:showNotification', 'Xe cß╗ºa bß║ín ─æang ß╗ƒ chß╗ù sß╗¡a xe')
                    elseif (data.current.value.state) then
                        menu.close()
                        menu.cancel()
                        SpawnVehicle(data.current.value.vehicle, garage, KindOfVehicle)
                    else
                        TriggerEvent('esx:showNotification', 'Kh├┤ng c├│ ph╞░╞íng tiß╗çn n├áo ß╗ƒ ─æ├óy')
                    end
                                    elseif data2.current.value == "rename_vehicle" then
                                            AddTextEntry('FMMC_KEY_TIP8', "Nhap ten chiec xe")
                                            DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 64)
                                            while (UpdateOnscreenKeyboard() == 0) do
                                                            DisableAllControlActions(0);
                                                            Wait(0);
                                            end
                                            if (GetOnscreenKeyboardResult()) then
                                                    local name = GetOnscreenKeyboardResult()
                                                    TriggerServerEvent('eden_garage:renamevehicle', ESX.Math.Trim(data.current.value.plate), name)
                                            end
                                    end
                            end,
                            function(data2, menu2)
                                    menu.cancel()
                            end
                    )
            end,
            function(data, menu)
                    menu.close()
            end
    ) ]]
    end, KindOfVehicle)
end

RegisterNUICallback('changeName', function(data)
    local plate = data.plate
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name',
            {title = "Nhập tên phương tiện"}, function(data2, menu2)
                    local name = data2.value
                    if name == nil then
                            ESX.ShowNotification('bạn phải nhập tên cho phương tiện')
                    else
                            menu2.close()
                            TriggerServerEvent('eden_garage:renamevehicle', ESX.Math.Trim(plate), name)
                            ESX.ShowNotification('Đổi tên thành công')
                            SetNuiFocus(false)
                    end
            end, function(data2, menu2)
                    menu2.close()
            end)
end)
-- Fin Afficher les listes des vehicules

-- Afficher les listes des vehicules de fourriere
function ListVehiclesFourriereMenu(garage)
    local elements = {}

    ESX.TriggerServerCallback('eden_garage:getVehiclesMecano', function(vehicles)

            for _,v in pairs(vehicles) do
                    v.vehicle = json.decode(v.vehicle)
                    local hashVehicule = v.vehicle.model
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)

                    table.insert(elements, {label =vehicleName.." | "..v.firstname.." "..v.lastname , value = v})

            end

            ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'spawn_vehicle_mecano',
            {
                    title    = 'Garage',
                    align    = 'top-left',
                    elements = elements,
            },
            function(data, menu)
                    menu.close()
                    SpawnVehicleMecano(data.current.value.vehicle, garage)
                    TriggerServerEvent('eden_garage:ChangeStateFromFourriereMecano', data.current.value.vehicle, false)
            end,
            function(data, menu)
                    menu.close()
            end
    )
    end)
end
-- Fin Afficher les listes des vehicules de fourriere


-- Fonction qui permet de rentrer un vehicule
function StockVehicleMenu(KindOfVehicle)
    local playerPed  = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed,  false) then
            local vehicle = GetVehiclePedIsIn(playerPed,false)
            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                    local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
                    if GotTrailer then
                            local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
                            ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
                                    if(valid) then
                                            for k,v in pairs (carInstance) do
                                                    if ESX.Math.Trim(v.plate) == ESX.Math.Trim(trailerProps.plate) then
                                                            table.remove(carInstance, k)
                                                    end
                                            end
                                            DeleteEntity(TrailerHandle)
                                            TriggerServerEvent('eden_garage:modifystate', ESX.Math.Trim(trailerProps.plate), true)
                                            TriggerEvent('esx:showNotification', 'Trailer cß╗ºa bß║ín ─æ├ú l╞░u trong nh├á ─æß╗â xe')
                                    else
                                            TriggerEvent('esx:showNotification', 'Bạn không phải chủ phương tiện này')
                                    end
                            end,trailerProps, KindOfVehicle)
                    else
                            local vehicleProps = GetVehicleProperties(vehicle)
                        --     exports['mythic_notify']:DoLongHudText('error', vehicleProps.plate)
                            ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
                                    if(valid) then
                                            for k,v in pairs (carInstance) do
                                                    if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
                                                            table.remove(carInstance, k)
                                                    end
                                            end
                                            DeleteEntity(vehicle)
                                            TriggerServerEvent('eden_garage:modifystate', ESX.Math.Trim(vehicleProps.plate), true)
                                            TriggerEvent('esx:showNotification', 'Phương tiện của bạn đã cất trong nhà xe')
                                    else
                                            TriggerEvent('esx:showNotification', 'Bạn không phải chủ phương tiện này')
                                    end
                            end,vehicleProps, KindOfVehicle)
                    end
            else
                    TriggerEvent('esx:showNotification', 'Bß║ín kh├┤ng phß║úi ng╞░ß╗¥i ─æiß╗üu khiß╗ân ph╞░╞íng tiß╗çn')
            end
    else
            TriggerEvent('esx:showNotification', 'Không có phương tiện nào gần đây')
    end
end
-- Fin fonction qui permet de rentrer un vehicule

-- Fonction qui permet de rentrer un vehicule dans fourriere
function StockVehicleFourriereMenu()
    local playerPed  = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed,  false) then
            local vehicle =GetVehiclePedIsIn(playerPed,false)
            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                    local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
                    if GotTrailer then
                            local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
                            ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
                                    if(valid) then
                                            DeleteVehicle(TrailerHandle)
                                            TriggerServerEvent('eden_garage:ChangeStateFromFourriereMecano', trailerProps, true)
                                            TriggerEvent('esx:showNotification', 'Ph╞░╞íng tiß╗çn ─æ├ú ─æ╞░ß╗úc l╞░u')
                                    else
                                            TriggerEvent('esx:showNotification', 'Bạn không phải chủ phương tiện này ß╗ƒ ─æ├óy')
                                    end
                            end,trailerProps)
                    else
                            local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
                            ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
                                    if(valid) then
                                            DeleteVehicle(vehicle)
                                            TriggerServerEvent('eden_garage:ChangeStateFromFourriereMecano', vehicleProps, true)
                                            TriggerEvent('esx:showNotification', 'Ph╞░╞íng tiß╗çn ─æ├ú ─æ╞░ß╗úc l╞░u')
                                    else
                                            TriggerEvent('esx:showNotification', 'Kh├┤ng thß╗â l╞░u ph╞░╞íng tiß╗çn n├áy')
                                    end
                            end,vehicleProps)
                    end
            else
                    TriggerEvent('esx:showNotification', 'Bß║ín kh├┤ng phß║úi ng╞░ß╗¥i ─æiß╗üu khiß╗ân ph╞░╞íng tiß╗çn')
            end
    else
            TriggerEvent('esx:showNotification', 'Kh├┤ng c├│ ph╞░╞íng tiß╗çn n├áo ß╗ƒ ─æ├óy')
    end
end
-- Fin fonction qui permet de rentrer un vehicule dans fourriere
--Fin fonction Menu


--Fonction pour spawn vehicule
function SpawnVehicle(vehicle, garage, KindOfVehicle, engineHealth, bodyHealth)
    local duped = ESX.DumpTable(garage)
    local dongco = engineHealth
    local thanxe = bodyHealth
    if ESX.Game.IsSpawnPointClear({ x = garage.SpawnPoint.Pos.x, y = garage.SpawnPoint.Pos.y, z = garage.SpawnPoint.Pos.z + 1}, 3.0) then
            ESX.Game.SpawnVehicle(vehicle.model, {
                    x = garage.SpawnPoint.Pos.x,
                    y = garage.SpawnPoint.Pos.y,
                    z = garage.SpawnPoint.Pos.z + 1
                    },garage.SpawnPoint.Heading, function(callback_vehicle)
                            ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
                            SetVehicleEngineHealth(callback_vehicle, dongco and dongco + 0.0 or 1000.0)
                            SetVehicleBodyHealth(callback_vehicle, thanxe and thanxe + 0.0 or 1000.0)
                            if vehicle["windows"] then
                                    for windowId = 1, 13, 1 do
                                            if vehicle["windows"][windowId] == false then
                                                    SmashVehicleWindow(callback_vehicle, windowId)
                                            end
                                    end
                            end

                            if vehicle["tyres"] then
                                    for tyreId = 1, 7, 1 do
                                            if vehicle["tyres"][tyreId] ~= false then
                                                    SetVehicleTyreBurst(callback_vehicle, tyreId, true, 1000)
                                            end
                                    end
                            end

                            if vehicle["doors"] then
                                    for doorId = 0, 5, 1 do
                                            if vehicle["doors"][doorId] ~= false then
                                                    SetVehicleDoorBroken(callback_vehicle, doorId - 1, true)
                                            end
                                    end
                            end
                            TriggerEvent('controlsave', callback_vehicle)
                            local carplate = ESX.Math.Trim(GetVehicleNumberPlateText(callback_vehicle))
                            table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
                            if KindOfVehicle == 'brewer' or KindOfVehicle == 'joaillerie' or KindOfVehicle == 'fermier' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'vignerons' or KindOfVehicle == 'tabac' then
                                    TriggerEvent('esx_jobs1:addplate', carplate)
                                    TriggerEvent('esx_jobs2:addplate', carplate)
                            end
                    end)
            TriggerServerEvent('eden_garage:modifystate', ESX.Math.Trim(vehicle.plate), false)
    else
            ESX.ShowNotification('Khu vực lấy xe bị chặn')
    end
end
--Fin fonction pour spawn vehicule

--Fonction pour spawn vehicule fourriere mecano
function SpawnVehicleMecano(vehicle, garage)
    ESX.Game.SpawnVehicle(vehicle.model, {
            x = garage.SpawnPoint.Pos.x,
            y = garage.SpawnPoint.Pos.y,
            z = garage.SpawnPoint.Pos.z + 1
            },garage.SpawnPoint.Heading, function(callback_vehicle)
                    TriggerEvent('controlsave', callback_vehicle)
                    ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
            end)
    TriggerServerEvent('eden_garage:ChangeStateFromFourriereMecano', vehicle, false)
end
--Fin fonction pour spawn vehicule fourriere mecano

function ReturnVehicleMenu(garage, KindOfVehicle)

    ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
            local elements = {}
            if not table.empty(vehicles) then
                    for _,v in pairs(vehicles) do
                            v.vehicle2 = json.decode(v.vehicle)
                            local hashVehicule = v.vehicle2.model
                            local vehicleName
                            local labelvehicle
                            if v.vehiclename == 'voiture' then
                                    vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
                            else
                                    vehicleName = v.vehiclename
                            end
                            if v.vehicle2.engineHealth ~= nil then
                                    engineHealth = v.vehicle2.engineHealth
                            else
                                    engineHealth = 1000
                            end
                            if v.vehicle2.bodyHealth ~= nil then
                                    bodyHealth = v.vehicle2.bodyHealth
                            else
                                    bodyHealth = 1000
                            end
                            if v.vehicle2.fuelLevel ~= nil then
                                    fuelLevel = v.vehicle2.fuelLevel
                            else
                                    fuelLevel = 100
                            end
                            if v.vehicle2.vehicleType ~= nil then
                                    vehicleType = v.vehicle2.vehicleType
                            else
                                    vehicleType = 1
                            end

                            if v.fourrieremecano then
                                    labelvehicle = vehicleName..': Hư Hỏng'
                                    table.insert(elements, {label =labelvehicle , value = 'fourrieremecano'})
                            else
                                    labelvehicle = vehicleName..': Xe mất'
                                    table.insert(elements, {label =labelvehicle , value = v, name = vehicleName, plate = v.plate , state = v.state, vehicle = v.vehicle, garage = curGaragea, KindOfVehicle = curKindOfVehicle, x = garage.SpawnPoint.Pos.x, y = garage.SpawnPoint.Pos.y, z = garage.SpawnPoint.Pos.z, Heading = garage.SpawnPoint.Heading, engineHealth = engineHealth, bodyHealth = bodyHealth, fuelLevel = fuelLevel, vehicleType = vehicleType})
                            end

                    end
                    SetNuiFocus(true, true)
                            SendNUIMessage({
                                    type = "shop",
                                    pos = "returnVehicle",
                                    result = elements,
                                    price = Config.Price,
                            })
            else
                    ESX.ShowNotification('Không có phương tiện nào của bạn')
            end

            --[[ ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'return_vehicle',
            {
                    title    = 'Garage',
                    align    = 'top-left',
                    elements = elements,
            },
            function(data, menu)
                    if data.current.value == 'fourrieremecano' then
                            ESX.ShowNotification("T├¼m cß║únh s├ít hoß║╖c thß╗ú sß╗¡a xe ─æß╗â chuß╗Öc xe cß╗ºa bß║ín")
                    elseif data.current.value ~= nil then
                            local iscaronearth = false
                            for k,v in pairs (carInstance) do
                                    if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
                                            if DoesEntityExist(v.vehicleentity) then
                                                    iscaronearth = true
                                            else
                                                    table.remove(carInstance, k)
                                                    iscaronearth = false
                                            end
                                    end
                            end
                            if not iscaronearth then
                                    ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
                                            if hasEnoughMoney then
                                                    menu.close()
                                                    SpawnVehicle(data.current.value, garage, KindOfVehicle)
                                            else
                                                    ESX.ShowNotification('Bß║ín kh├┤ng c├│ ─æß╗º tiß╗ün')
                                            end
                                    end)
                            else
                                    ESX.ShowNotification("Bß║ín kh├┤ng thß╗â lß║Ñy ph╞░╞íng tiß╗çn n├áy ra, v├¼ n├│ ─æ├ú tß╗ôn tß║íi")
                            end
                    end
            end,
            function(data, menu)
                    menu.close()
            end
            ) ]]
    end, KindOfVehicle)
end

function exitmarker()
    ESX.UI.Menu.CloseAll()
end

RegisterNetEvent("ft_libs:OnClientReady")
AddEventHandler('ft_libs:OnClientReady', function()
    for k,v in pairs (Config.Garages) do
            this_Garage = v
			-- turn off chuoc xe menu
            -- exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_garage", {
            --         marker = {
            --                 weight = v.Marker.w,
            --                 height = v.Marker.h,
            --                 red = v.Marker.r,
            --                 green = v.Marker.g,
            --                 blue = v.Marker.b,
            --         },
            --         trigger = {
            --                 weight = v.Marker.w,
            --                 active = {
            --                         callback = function()
            --                                 exports.ft_libs:HelpPromt(v.HelpPrompt)
            --                                 if IsControlJustPressed(1, 38) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
            --                                         v.Functionmenu(v, "personal")
            --                                         GUI.Time = GetGameTimer()
            --                                 end
            --                         end,
            --                 },
            --                 exit = {
            --                         callback = exitmarker
            --                 },
            --         },
            --         blip = {
            --                 text = v.Name,
            --                 colorId = Config.Blip.color,
            --                 imageId = Config.Blip.sprite,
            --         },
            --         locations = {
            --                 v.Pos
            --         },
            -- })
            exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint", {
                    marker = {
                            weight = v.SpawnPoint.Marker.w,
                            height = v.SpawnPoint.Marker.h,
                            red = v.SpawnPoint.Marker.r,
                            green = v.SpawnPoint.Marker.g,
                            blue = v.SpawnPoint.Marker.b,
                    },
                    trigger = {
                            weight = v.SpawnPoint.Marker.w,
                            active = {
                                    callback = function()
                                            exports.ft_libs:HelpPromt(v.SpawnPoint.HelpPrompt)
                                            if IsControlJustPressed(1, 38) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
                                                    v.SpawnPoint.Functionmenu(v, "personal")
                                                    GUI.Time = GetGameTimer()
                                            end
                                    end,
                            },
                            exit = {
                                    callback = exitmarker
                            },
                    },
                    locations = {
                            {
                                    x = v.SpawnPoint.Pos.x,
                                    y = v.SpawnPoint.Pos.y,
                                    z = v.SpawnPoint.Pos.z,
                            },
                    },
            })
            exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_deletepoint", {
                    marker = {
                            weight = v.DeletePoint.Marker.w,
                            height = v.DeletePoint.Marker.h,
                            red = v.DeletePoint.Marker.r,
                            green = v.DeletePoint.Marker.g,
                            blue = v.DeletePoint.Marker.b,
                    },
                    trigger = {
                            weight = v.DeletePoint.Marker.w,
                            active = {
                                    callback = function()
                                            exports.ft_libs:HelpPromt(v.DeletePoint.HelpPrompt)
                                            if IsControlJustPressed(1, 38) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
                                                    v.DeletePoint.Functionmenu("personal")
                                                    GUI.Time = GetGameTimer()
                                            end
                                    end,
                            },
                            exit = {
                                    callback = exitmarker
                            },
                    },
                    locations = {
                            {
                                    x = v.DeletePoint.Pos.x,
                                    y = v.DeletePoint.Pos.y,
                                    z = v.DeletePoint.Pos.z,
                            },
                    },
            })
    end
end)

-- Fin controle touche
function dump(o, nb)
if nb == nil then
nb = 0
end
if type(o) == 'table' then
  local s = ''
  for i = 1, nb + 1, 1 do
    s = s .. "    "
  end
  s = '{\n'
  for k,v in pairs(o) do
     if type(k) ~= 'number' then k = '"'..k..'"' end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
     s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
  end
  for i = 1, nb, 1 do
    s = s .. "    "
  end
  return s .. '}'
else
  return tostring(o)
end
end

function table.empty (self)
for _, _ in pairs(self) do
    return false
end
return true
end

--- garage societe

RegisterNetEvent('esx_eden_garage:ListVehiclesMenu')
AddEventHandler('esx_eden_garage:ListVehiclesMenu', function(garage, society)
    ListVehiclesMenu(garage, society)
end)

RegisterNetEvent('esx_eden_garage:OpenMenuGarage')
AddEventHandler('esx_eden_garage:OpenMenuGarage', function(garage, society)
    OpenMenuGarage(garage, society)
end)

RegisterNetEvent('esx_eden_garage:houseGarage')
AddEventHandler('esx_eden_garage:houseGarage', function(coords, society)
    houseGarage(coords, society)
end)

RegisterNetEvent('esx_eden_garage:StockVehicleMenu')
AddEventHandler('esx_eden_garage:StockVehicleMenu', function(society)
    StockVehicleMenu(society)
end)
GetVehicleProperties = function(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}
        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end
        for id = 1, 13 do
            local windowId = IsVehicleWindowIntact(vehicle, id)
            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
        vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
        vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
        vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)
        vehicleProps["vehicleType"] = GetVehicleClass(vehicle)

        return vehicleProps
    end
end