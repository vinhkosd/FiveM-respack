

RegisterFontFile("arial")

fontId = RegisterFontId("arial font")



-----------

-- 3D ME --

-----------



Citizen.CreateThread(function()

    TriggerEvent('chat:addSuggestion', '/me', 'Để nói chuyện mà admin không check đc.')

end)



local nbrDisplaying = 1



RegisterCommand('me', function(source, args, raw)

    -- local text = string.sub(raw, 4)



    local text = '*' -- edit here if you want to change the language : EN: the person / FR: la personne

    for i = 1,#args do

        text = text .. ' ' .. args[i]

    end

    text = text .. ' *'

    TriggerServerEvent('3dme:shareDisplay', text)

end)



RegisterNetEvent('3dme:triggerDisplay')

AddEventHandler('3dme:triggerDisplay', function(text, source)

    local offset = 1 + (nbrDisplaying*0.15)

    Display(GetPlayerFromServerId(source), text, offset)

end)



function Display(mePlayer, text, offset)

    local displaying = true



    Citizen.CreateThread(function()

        Wait(10000)

        displaying = false

    end)

    

    Citizen.CreateThread(function()

        nbrDisplaying = nbrDisplaying + 1

        while displaying do

            Wait(0)

            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)

            local coords = GetEntityCoords(PlayerPedId(), false)

            local dist = Vdist2(coordsMe, coords)

            if dist < 500 then

                 DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.250, text)

            end

        end

        nbrDisplaying = nbrDisplaying - 1

    end)

end



function DrawText3D(x,y,z, text)

    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    local p = GetGameplayCamCoords()

    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)

    local scale = (1 / distance) * 2

    local fov = (1 / GetGameplayCamFov()) * 100

    local scale = scale * fov

    if onScreen then

        SetTextScale(0.35, 0.35)

        SetTextFont(fontId)

        SetTextProportional(1)

        SetTextColour(255, 255, 255, 215)

        SetTextEntry("STRING")

        SetTextCentre(1)

        AddTextComponentString(text)

        DrawText(_x,_y)

        local factor = (string.len(text)) / 370

        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 100)

    end

end





