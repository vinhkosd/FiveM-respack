-- Menu state
local showMenu = false
local IsDead   = false

-- Keybind Lookup table
local keybindControls = {
	["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["Backspace"] = 177, ["Tab"] = 37, ["q"] = 44, ["w"] = 32, ["e"] = 38, ["r"] = 45, ["t"] = 245, ["y"] = 246, ["u"] = 303, ["p"] = 199, ["["] = 39, ["]"] = 40, ["Enter"] = 18, ["CapsLock"] = 137, ["a"] = 34, ["s"] = 8, ["d"] = 9, ["f"] = 23, ["g"] = 47, ["h"] = 74, ["k"] = 311, ["l"] = 182, ["Shift"] = 21, ["z"] = 20, ["x"] = 73, ["c"] = 26, ["v"] = 0, ["b"] = 29, ["n"] = 249, ["m"] = 244, [","] = 82, ["."] = 81, ["Home"] = 213, ["PageUp"] = 10, ["PageDown"] = 11, ["Delete"] = 178
}

-- Main thread
Citizen.CreateThread(function()
    -- Update every frame
    while true do
        Citizen.Wait(0)
        local menuConfig = {
            {
                id = "Shop Donate",
                icon = "#vnrp-cashshop",
                title = "Shop Donate",
                functionName = "cashshop:client:open"
            },
            {
                id = "Profile",
                icon = "#profile",
                title = "Thông Tin",
                functionName = "ui:tatui"
            },
            {
                id = "NgheNghiep",
                icon = "#NgheNghiep",
                title = "Hướng Dẫn",
                functionName = "rpk_help:start"
            },
            {
                id = "Khóa Xe",
                icon = "#RemoteCar",
                title = "Khóa Xe",
                functionName = "rpk_carlock:carlock"
            },
            {
                id = "Menu Xe",
                icon = "#RemoteCar",
                title = "Menu Xe",
                functionName = "vehcontrol:openExternal"
            },
            {
                id = "Tài Xỉu",
                icon = "#TaiXiu",
                title = "Tài Xỉu",
                functionName = "taixiu:mo"
            }
        }
        -- Loop through all menus in config
        if IsControlPressed(0, keybindControls["~"]) then
            -- Init UI
            showMenu = true
            SendNUIMessage({
                type = 'show',
                data = menuConfig,
                resourceName = GetCurrentResourceName(),
                menuKeyBind = "~"
            })

            -- Set cursor position and set focus
            SetCursorLocation(0.5, 0.5)
            SetNuiFocus(true, true)

            -- Play sound
            PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

            -- Prevent menu from showing again until key is released
            while showMenu == true do Citizen.Wait(100) end
            Citizen.Wait(100)
            while IsControlPressed(0, keybindControl) do Citizen.Wait(100) end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 200) then
            CloseMenu()
        end
    end
end)

function CloseMenu()
    showMenu = false
    SendNUIMessage(
        {
            type = "destroy"
        }
    )
    SetNuiFocus(false, false)
end

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('triggerAction', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'destroy'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Run command
    -- ExecuteCommand(data.command)
    print(json.encode(data));
    TriggerEvent(data.action)
    -- Send ACK to callback function
    cb('ok')
end)


