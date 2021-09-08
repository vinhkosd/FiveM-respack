local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("esx-ecobottles:sellBottles")
AddEventHandler("esx-ecobottles:sellBottles", function()
    local player = ESX.GetPlayerFromId(source)

    local currentBottles = player.getInventoryItem("bottle")["count"]
    
    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random((Config.BottleReward[1] or 1), (Config.BottleReward[2] or 4))

        player.removeInventoryItem("bottle", currentBottles)
        player.addMoney(randomMoney * currentBottles)

        TriggerClientEvent("esx:showNotification", source, ("ban da cho cua hang %s chai, va duoc tra $%s."):format(currentBottles, currentBottles * randomMoney))
    else
        TriggerClientEvent("esx:showNotification", source, "ban khong co chai de ban cho cua hang.")
    end
end)

RegisterServerEvent("esx-ecobottles:retrieveBottle")
AddEventHandler("esx-ecobottles:retrieveBottle", function()
    local player = ESX.GetPlayerFromId(source)

    math.randomseed(os.time())
    local luck = math.random(0, 69)
    local randomBottle = math.random((Config.BottleRecieve[1] or 1), (Config.BottleRecieve[2] or 6))

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent("esx:showNotification", source, "thung rac khong co gi.")
    else
        player.addInventoryItem("bottle", randomBottle)
        TriggerClientEvent("esx:showNotification", source, ("ban tim thay x%s chai"):format(randomBottle))
    end
end)