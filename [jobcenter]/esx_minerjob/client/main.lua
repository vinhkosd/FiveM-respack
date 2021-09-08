local PlayerData                = {}
ESX                             = nil

local blip1 = {}
local blips = false
local mineActive = false
local firstspawn = false
local showblips = true
local impacts = 0
local timer = 0
local daoda = {
  {name="Thợ Mở | Đào Đá", id=365, x=2954.22, y=2794.63, z=40.83}
}
local banda = {
  {name="Thợ Mỏ | Bán Đá", id=365, x=2707.11, y=2777.26, z=37.88}	
}
local locations = {
    { ['x'] = 2954.22,  ['y'] = 2794.63,  ['z'] = 40.83},
    { ['x'] = 2960.38,  ['y'] = 2776.43,  ['z'] = 39.91},
    { ['x'] = 2934.56,  ['y'] = 2791.89,  ['z'] = 40.31},
    { ['x'] = 2944.13,  ['y'] = 2815.81,  ['z'] = 42.57},
    { ['x'] = 2956.29,  ['y'] = 2784.63,  ['z'] = 41.13},
    { ['x'] = 2950.46,  ['y'] = 2768.69,  ['z'] = 39.02},
    { ['x'] = 2936.02,  ['y'] = 2774.79,  ['z'] = 39.08},
    { ['x'] = 2927.32,  ['y'] = 2791.93,  ['z'] = 40.44},
    { ['x'] = 2926.91,  ['y'] = 2812.37,  ['z'] = 44.32},
    { ['x'] = 2950.63,  ['y'] = 2818.99,  ['z'] = 42.5},                        
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
	  for k,v in ipairs(daoda)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.4)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(banda)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.4)
		SetBlipColour (blip, 2)
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
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 155, 0, 0, 2, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                        ESX.ShowHelpNotification("Nhấn [E] để bắt đầu làm việc.")
                            if IsControlJustReleased(1, 51) then
                                Animation()
                                mineActive = true
                            end
                        end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    local ped = PlayerPedId()
            if PlayerData.job ~= nil and PlayerData.job.name == 'miner' and not IsEntityDead( ped ) then    
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 2 then
                ESX.ShowHelpNotification("Nhấn [E] để bán kim loại trong người")
                    if IsControlJustReleased(1, 51) then
                        Jeweler()                          
            end
        end
    end
 end)
    

Citizen.CreateThread(function()
    local hash = GetHashKey("ig_floyd")

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        Citizen.Wait(100)
    end

    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    if firstspawn == false then
        local npc = CreatePed(6, hash, Config.SellX, Config.SellY, Config.SellZ, 40.0, false, false)
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

function Jeweler()
    local elements = {
        {label = 'Bán Kim Cương',   value = 'diamonds'},
        {label = 'Bán Vàng',      value = 'gold'},
        {label = 'Bán Sắt',       value = 'iron'},
        {label = 'Bán Đồng',       value = 'copper'},
        {label = 'Bán Đá',       value = 'stones'},        
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'jeweler_actions', {
        title    = 'Đại Lý Trang Sức',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'diamonds' then
            menu.close()
            TriggerServerEvent("esx_miner:selldiamond")
        elseif data.current.value == 'gold' then
            menu.close()
            TriggerServerEvent("esx_miner:sellgold")
        elseif data.current.value == 'iron' then
            menu.close()
            TriggerServerEvent("esx_miner:selliron")
        elseif data.current.value == 'copper' then
            menu.close()
            TriggerServerEvent("esx_miner:sellcopper")
        elseif data.current.value == 'stones' then
            menu.close()
            TriggerServerEvent("esx_miner:sellstones")            
        end
    end)
end

function Animation()
    Citizen.CreateThread(function()
	exports['progressBars']:startUI(12500, "Đang Đào Đá")
        while impacts < 5 do
            Citizen.Wait(1)
        local ped = PlayerPedId()   
                RequestAnimDict("melee@large_wpn@streamed_core")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                end  
                Citizen.Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    TriggerServerEvent("esx_miner:givestone")                 
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