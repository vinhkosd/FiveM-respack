local lastSelectedVehicleEntity
local startCountDown
local testDriveEntity
local lastPlayerCoords
local hashListLoadedOnMemory = {}
local vehcategory = nil
local inTheShop = false
local profileName
local profileMoney
local vehiclesTable = {}
local provisoryObject = {}
local rgbColorSelected = {255,255,255,}
local rgbSecondaryColorSelected = {255,255,255,}

ESX = nil
Vehicles = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        local ped = PlayerPedId()
        local sleep = true
        for i = 1, #Config.Shops do
        local actualShop = Config.Shops[i].coords
        local dist = #(actualShop - GetEntityCoords(ped))
            if dist <= 5 then
                sleep = false
                DrawMarker(2, actualShop.x, actualShop.y, actualShop.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.2, 0.1, 255, 0, 0, 155, 0, 0, 0, 1, 0, 0, 0)
                if dist <= 2.5 then
                    DrawText3Ds(actualShop.x, actualShop.y, actualShop.z + 0.2, '[~g~E~w~] - Browse Vehicle Shop')
                    if IsControlJustPressed(0, 38) then
                        vehcategory = Config.Shops[i].category
                        OpenVehicleShop()
                    end
                end
            end
        end
        if sleep then
            Wait(500)
        end
    end
end)


RegisterNetEvent('qb-vehicleshop.receiveInfo')
AddEventHandler('qb-vehicleshop.receiveInfo', function(bank, name)
    if name then
        profileName = name
    end
    profileMoney = bank
end)


RegisterNetEvent('qb-vehicleshop.successfulbuy')
AddEventHandler('qb-vehicleshop.successfulbuy', function(vehicleName,vehiclePlate,value)    
    SendNUIMessage(
        {
            type = "successful-buy",
            vehicleName = vehicleName,
            vehiclePlate = vehiclePlate,
            value = value
        }
    )       
    CloseNui()
end)

RegisterNetEvent('qb-vehicleshop.notify')
AddEventHandler('qb-vehicleshop.notify', function(type, message)    
    SendNUIMessage(
        {
            type = "notify",
            typenotify = type,
            message = message,
        }
    ) 
end)

RegisterNetEvent('qb-vehicleshop.vehiclesInfos')
AddEventHandler('qb-vehicleshop.vehiclesInfos', function() 
    print(vehcategory)
    -- print(json.encode(Vehicles))
    for k,v in pairs(Vehicles) do 
        -- if v.shop == vehcategory then
            vehiclesTable[v.category] = {}   
        -- end
        -- print(v.category)
    end 

    for k,v in pairs(Vehicles) do
        -- if vehiclesTable[v.category] == nil then
        --     vehiclesTable[v.category] = {}
        -- end

        -- if v.shop == vehcategory then
            provisoryObject = {
                brand = v.brand,
                name = v.name,
                price = v.price,
                model = v.model,
                qtd = 5000,
            }
            -- print(json.encode(provisoryObject))
            table.insert(vehiclesTable[v.category], provisoryObject)
        -- end
    end
end)

function OpenVehicleShop()
    inTheShop = true
    TriggerServerEvent("qb-vehicleshop.requestInfo")
    Citizen.Wait(500)
    TriggerEvent('qb-vehicleshop.vehiclesInfos')
    Citizen.Wait(1000)
    -- print(json.encode(vehiclesTable))
    SendNUIMessage(
        {
            data = vehiclesTable,
            type = "display",
            playerName = profileName,
            playerMoney = profileMoney,
            testDrive = Config.TestDrive
        }
    )
    SetNuiFocus(true, true)
    RequestCollisionAtCoord(x, y, z)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 974.1, -2997.94, -39.00, 216.5, 0.00, 0.00, 60.00, false, 0)
    PointCamAtCoord(cam, 979.1, -3003.00, -40.50)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1, true, true)
    SetFocusPosAndVel(974.1, -2997.94, -39.72, 0.0, 0.0, 0.0)
    DisplayHud(false)
    DisplayRadar(false)

    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end
end

function updateSelectedVehicle(model)
    local hash = GetHashKey(model)

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end

    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end
  --  lastSelectedVehicleEntity = CreateVehicle(hash, 404.99, -949.60, -99.98, 50.117, 0, 1)
    
  lastSelectedVehicleEntity = CreateVehicle(hash, 978.19, -3001.99, -40.62, 89.5, 0, 1)


    local vehicleData = {}

    
    vehicleData.traction = GetVehicleMaxTraction(lastSelectedVehicleEntity)


    vehicleData.breaking = GetVehicleMaxBraking(lastSelectedVehicleEntity) * 0.9650553    
    if vehicleData.breaking >= 1.0 then
        vehicleData.breaking = 1.0
    end

    vehicleData.maxSpeed = GetVehicleEstimatedMaxSpeed(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.maxSpeed >= 50.0 then
        vehicleData.maxSpeed = 50.0
    end

    vehicleData.acceleration = GetVehicleAcceleration(lastSelectedVehicleEntity) * 2.6
    if  vehicleData.acceleration >= 1.0 then
        vehicleData.acceleration = 1.0
    end


    SendNUIMessage(
        {
            data = vehicleData,
            type = "updateVehicleInfos",        
        }
    )

    SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity,  rgbColorSelected[1], rgbColorSelected[2], rgbColorSelected[3])
    SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity,  rgbSecondaryColorSelected[1], rgbSecondaryColorSelected[2], rgbSecondaryColorSelected[3])
    SetEntityHeading(lastSelectedVehicleEntity, 89.5)
end


function rotation(dir)
    local entityRot = GetEntityHeading(lastSelectedVehicleEntity) + dir
    SetEntityHeading(lastSelectedVehicleEntity, entityRot % 360)
end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(2)
        else
            rotation(-2)
        end
        cb("ok")
    end
)


RegisterNUICallback(
    "SpawnVehicle",
    function(data, cb)
        updateSelectedVehicle(data.modelcar)
    end
)



RegisterNUICallback(
    "RGBVehicle",
    function(data, cb)
        if data.primary then
            rgbColorSelected = data.color
            SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity, math.ceil(data.color[1]), math.ceil(data.color[2]), math.ceil(data.color[3]) )
        else
            rgbSecondaryColorSelected = data.color
            SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity, math.ceil(data.color[1]), math.ceil(data.color[2]), math.ceil(data.color[3]))
        end
    end
)

RegisterNUICallback(
    "Buy",
    function(data, cb)

        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
        vehicleProps.plate = newPlate
        print("newPlate")
        print(newPlate)
        TriggerServerEvent('qb-vehicleshop.CheckMoneyForVeh',data.modelcar, data.sale, data.name, vehicleProps)

        Wait(1500)        
        -- SendNUIMessage(
        --     {
        --         type = "updateMoney",
        --         playerMoney = profileMoney
        --     }
        -- )
    end
)


RegisterNetEvent('qb-vehicleshop.spawnVehicle')
AddEventHandler('qb-vehicleshop.spawnVehicle', function(model, plate)    
    local hash = GetHashKey(model)

    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    
    local vehicleBuy = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
    SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
    SetVehicleNumberPlateText(vehicleBuy, plate)
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicleBuy))
    
    SetVehicleCustomPrimaryColour(vehicleBuy,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
    SetVehicleCustomSecondaryColour(vehicleBuy,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))
end)

RegisterNetEvent('qb-vehicleshop.sendVehicles')
AddEventHandler('qb-vehicleshop.sendVehicles', function (vehicles)
	Vehicles = vehicles
end)

RegisterNUICallback(
    "TestDrive",
    function(data, cb)        
        if Config.TestDrive then
            startCountDown = true

            local hash = GetHashKey(data.vehicleModel)

            lastPlayerCoords = GetEntityCoords(PlayerPedId())

            if not HasModelLoaded(hash) then
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
            end
        
            if testDriveEntity ~= nil then
                DeleteEntity(testDriveEntity)
            end
        
            testDriveEntity = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
            SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(testDriveEntity))
            local timeGG = GetGameTimer()

            
            SetVehicleCustomPrimaryColour(testDriveEntity,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
            SetVehicleCustomSecondaryColour(testDriveEntity,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))

            CloseNui()

            while startCountDown do
                local countTime
                Citizen.Wait(1)
                if GetGameTimer() < timeGG+tonumber(1000*Config.TestDriveTime) then
                    local secondsLeft = GetGameTimer() - timeGG
                    drawTxt('Test Drive Time Remaining: ' .. math.ceil(Config.TestDriveTime - secondsLeft/1000),4,0.5,0.93,0.50,255,255,255,180)
                else
                    DeleteEntity(testDriveEntity)
                    SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                    startCountDown = false
                end
            end        
        end
    end
)


RegisterNUICallback(
    "menuSelected",
    function(data, cb)
        local categoryVehicles

        local playerIdx = GetPlayerFromServerId(source)
        local ped = GetPlayerPed(playerIdx)
        
        if data.menuId ~= 'all' then
            categoryVehicles = vehiclesTable[data.menuId]
        else
            SendNUIMessage(
                {
                    data = vehiclesTable,
                    type = "display",
                    playerName = GetPlayerName(ped)
                }
            )
            return
        end

        SendNUIMessage(
            {
                data = categoryVehicles,
                type = "menu"
            }
        )
    end
)


RegisterNUICallback(
    "Close",
    function(data, cb)
        CloseNui()       
    end
)

function CloseNui()
    SendNUIMessage(
        {
            type = "hide"
        }
    )
    SetNuiFocus(false, false)
    if inTheShop then
        if lastSelectedVehicleEntity ~= nil then
            DeleteVehicle(lastSelectedVehicleEntity)
        end
        RenderScriptCams(false)
        DestroyAllCams(true)
        SetFocusEntity(GetPlayerPed(PlayerId())) 
        DisplayHud(true)
        DisplayRadar(true)
    end
    inTheShop = false
    vehiclesTable = {}
    provisoryObject = {}
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


local blip 

-- Create Blips
Citizen.CreateThread(function ()

    for i = 1, #Config.Blip do    
        local actualShop = Config.Blip[i]
        blip = AddBlipForCoord(actualShop.x, actualShop.y, actualShop.z)

        SetBlipSprite (blip, 326)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Car Dealer')
        EndTextCommandSetBlipName(blip)
    end
end)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
           CloseNui()
           RemoveBlip(blip)
        end
    end
)
