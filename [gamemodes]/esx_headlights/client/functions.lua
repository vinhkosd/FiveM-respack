--[[ 
                 Headlight Menu - by BoutProduction
]]

function OpenHeadlightMenu()
    local elems = {
        {label = 'Mở menu', value = 'open_list'},

}
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ColourMenu',{
        title = 'Headlight Colours',
        align = 'top-left',
        elements = elems
    },
    function(data, menu)
        if data.current.value == 'open_list' then 
            ColourList()
        end

    end,
    function(data, menu)
        menu.close()
    end)
end

--[[
    All Colours
]]

function ColourList()
        local elems = {
            {label = 'Xanh đậm', value = '1'},
            {label = 'Xanh nhạt', value = '2'},
            {label = 'Xanh ngọc', value = '3'},
            {label = 'Xanh lá cây', value = '4'},
            {label = 'Vàng', value = '5'},
            {label = 'Vàng đậm', value = '6'},
            {label = 'Cam', value = '7'},
            {label = 'Đỏ', value = '8'},
            {label = 'Hồng', value = '9'},
            {label = 'Hồng đậm', value = '10'},
            {label = 'Tím đậm', value = '11'},
            {label = 'Tím nhạt', value = '12'},

        }
    
        ESX.UI.Menu.CloseAll()
    
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ColourMenu',{
            title = 'Headlight Colours',
            align = 'top-left',
            elements = elems
        },
        function(data, menu)
            if data.current.value == '1' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 1)
            end
            if data.current.value == '2' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 2)
            end
            if data.current.value == '3' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 3)
            end
            if data.current.value == '4' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 4)
            end
            if data.current.value == '5' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 5)
            end
            if data.current.value == '6' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 6)
            end
            if data.current.value == '7' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 7)
            end
            if data.current.value == '8' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 8)
            end
            if data.current.value == '9' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 9)
            end
            if data.current.value == '10' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 10)
            end
            if data.current.value == '11' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 11)
            end
            if data.current.value == '12' then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            ToggleVehicleMod(veh, 22, true) -- Xenon
            SetVehicleHeadlightsColour(veh, 12)
            end
    end,
    function(data, menu)
        menu.close()
    end)
end

--[[
    Marker, Blip and help text
]]

local location = {
	{x = 226.2346,y = -762.4706,z = 30.81816},

}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(location) do
            DrawMarker(20, location[k].x, location[k].y, location[k].z, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 255, 50, 255, 100, true, true, 2, true, false, false, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(location) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, location[k].x, location[k].y, location[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Nhấn [E] để thay đổi màu sắc đèn xe")
				if IsControlJustPressed(1,51) then 
					OpenHeadlightMenu()
				end
            end
        end
    end
end)


	-- Create blips
	Citizen.CreateThread(function()
        for k in pairs(location) do
			local blip = AddBlipForCoord(226.2346, -762.4706, 30.81816)

			SetBlipSprite (blip, 643)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, 8)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Đổi Màu Đèn Xe")
			EndTextCommandSetBlipName(blip)
		end
	end)
