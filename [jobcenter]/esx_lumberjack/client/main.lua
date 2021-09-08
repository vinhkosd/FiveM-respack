local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local blipActive = false
local woodActive = false
local cutwoodActive = false
local firstspawn = false
local showblips = true
local impacts = 0
local timer = 0
local chatgo = {
  {name="Tiều Phu | Chặt Gỗ", id=238, x=-583.71, y=5490.41, z=55.8}
}
local bango = {
  {name="Tiều Phu | Bán Gỗ", id=238, x=-567.44, y=5253.6, z=70.47}   
}
local locations = {
    { ['x'] = -583.71,  ['y'] = 5490.41,  ['z'] = 55.8},
    { ['x'] = -589.24,  ['y'] = 5493.62,  ['z'] = 54.41},
    { ['x'] = -573.26,  ['y'] = 5508.21,  ['z'] = 55.58},
    { ['x'] = -567.73,  ['y'] = 5502.3,  ['z'] = 57.44},
    { ['x'] = -580.24,  ['y'] = 5471.66,  ['z'] = 59.56},
    { ['x'] = -597.18,  ['y'] = 5474.68,  ['z'] = 56.08},
    { ['x'] = -595.1,  ['y'] = 5452.43,  ['z'] = 59.36},
    { ['x'] = -586.34,  ['y'] = 5547.94,  ['z'] = 60.31},
    { ['x'] = -590.37,  ['y'] = 5451.55,  ['z'] = 59.9},
    { ['x'] = -567.68,  ['y'] = 5457.0,  ['z'] = 61.85},                        
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    if showblips then
      for k,v in ipairs(chatgo)do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 1.4)
        SetBlipColour (blip, 26)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(v.name))
        EndTextCommandSetBlipName(blip)
      end
    end
end)

Citizen.CreateThread(function()
    if showblips then
      for k,v in ipairs(bango)do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 1.4)
        SetBlipColour (blip, 26)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(tostring(v.name))
        EndTextCommandSetBlipName(blip)
      end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if PlayerData.job ~= nil and PlayerData.job.name == 'miner' and not IsEntityDead( ped ) then
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and woodActive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        ESX.ShowHelpNotification("~o~Nhấn ~g~[E]~o~ để bắt đầu chặt gỗ.")
                            if IsControlJustReleased(1, 51) then
                                Givewood()
                                woodActive = true
                            end
                        end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if PlayerData.job ~= nil and PlayerData.job.name == 'miner' and not IsEntityDead( ped ) then
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Sell1X, Config.Sell1Y, Config.Sell1Z, true) < 2 then
                ESX.ShowHelpNotification("~o~Nhấn ~g~[E]~o~ để bán gỗ.")
                    if IsControlJustReleased(1, 51) then
                        SellWood()                          
            end
        end
    end
 end)
    

Citizen.CreateThread(function()
    local hash = GetHashKey("ig_old_man2")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.Sell1X, Config.Sell1Y, Config.Sell1Z, 70.0, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetBlockingOfNonTemporaryEvents(npc, true)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
    end
end)

function SellWood()
    local elements = {
        {label = 'Bán Gỗ',   value = 'cutted_wood'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Sell_actions', {
        title    = 'Người Mua Gỗ',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'cutted_wood' then
            menu.close()
            TriggerServerEvent("esx_lumberjack:sellwood")
        end
    end)
end

function Givewood()
    Citizen.CreateThread(function()
        exports['progressBars']:startUI(12500, "Đang Chặt Gỗ")
        while impacts < 5 do
            Citizen.Wait(1)
		local ped = PlayerPedId()	
                RequestAnimDict("amb@world_human_hammering@male@base")
                Citizen.Wait(100)
                TaskPlayAnim((ped), "amb@world_human_hammering@male@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                FreezeEntityPosition(PlayerPedId(),true)                  
                if impacts == 0 then
                    axe = CreateObject(GetHashKey("prop_tool_hammer"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)                        
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                FreezeEntityPosition(PlayerPedId(),false)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    woodActive = false
                    impacts = 0
                    TriggerServerEvent("esx_lumberjack:givewood") 
                    break
                end        
        end
    end)
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end
