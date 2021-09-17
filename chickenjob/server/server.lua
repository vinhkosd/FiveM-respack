ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)



RegisterServerEvent('gg-chickenjob:getNewChicken')

AddEventHandler('gg-chickenjob:getNewChicken', function()

    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)

    local pick = ''

    -- local targetItem = xPlayer.getInventoryItem('alive_chicken')
    if xPlayer.canCarryItem('alive_chicken', 3) then
        TriggerClientEvent("pNotify:SendNotification", source, {
            text = "Bạn nhận được 3 gà sống!",
            type = "success",
            queue = "global",
            timeout = 8000,
            layout = "bottomRight"
        })
        xPlayer.addInventoryItem('alive_chicken', 3)
    else
        TriggerClientEvent("pNotify:SendNotification", source, {
            text = "Túi đã đầy!",
            type = "error",
            queue = "global",
            timeout = 8000,
            layout = "bottomRight"
        })
    end
    -- Player.Functions.AddItem('alive_chicken', 3)

    -- TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['alive_chicken'], "add")

end)



RegisterServerEvent('gg-chickenjob:startChicken')

AddEventHandler('gg-chickenjob:startChicken', function()

    local src = source

    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)



    --   if TriggerClientEvent("QBCore:Notify", src, "Lets Catch The Chicken Dumbass!", "Success", 8000) then
        -- Player.Functions.RemoveMoney('cash', 500)
    --   end

end)



RegisterServerEvent('gg-chickenjob:getcutChicken')

AddEventHandler('gg-chickenjob:getcutChicken', function()

    local src = source

    local Player = QBCore.Functions.GetPlayer(src)

    local pick = ''



      if TriggerClientEvent("QBCore:Notify", src, "Well! You slaughtered chicken.", "Success", 8000) then

          Player.Functions.RemoveItem('alivechicken', 1)

          Player.Functions.AddItem('slaughteredchicken', 1)

          TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['alivechicken'], "remove")

          TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['slaughteredchicken'], "add")

      end

end)



RegisterServerEvent('gg-chickenjob:getpackedChicken')

AddEventHandler('gg-chickenjob:getpackedChicken', function()

    local src = source

    local Player = QBCore.Functions.GetPlayer(src)

    local pick = ''



      if TriggerClientEvent("QBCore:Notify", src, "You Packed Slaughtered chicken .", "Success", 8000) then

          Player.Functions.RemoveItem('slaughteredchicken', 1)

          Player.Functions.AddItem('packagedchicken', 1)

          TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['slaughteredchicken'], "remove")

          TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['packagedchicken'], "add")

      end

end)





local ItemList = {

    ["packagedchicken"] = math.random(250, 350),

}



RegisterServerEvent('gg-chickenjob:sell')

AddEventHandler('gg-chickenjob:sell', function()

    local src = source

    local price = 0

    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 

        for k, v in pairs(Player.PlayerData.items) do 

            if Player.PlayerData.items[k] ~= nil then 

                if ItemList[Player.PlayerData.items[k].name] ~= nil then 

                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)

                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)

                end

            end

        end

        Player.Functions.AddMoney("cash", price, "sold-items")

        TriggerClientEvent('QBCore:Notify', src, "You have sold your items")

    else

        TriggerClientEvent('QBCore:Notify', src, "You don't have items")

    end

end)