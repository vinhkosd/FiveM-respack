ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_lumberjack:givewood")
AddEventHandler("esx_lumberjack:givewood", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('wood').count < 50 then
                xPlayer.addInventoryItem('wood', 1)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã chặt được x~y~1~g~ Gỗ.')
                TriggerClientEvent("XNL_NET:AddPlayerXP", source, math.random(10, 20))
                TriggerEvent("AddXp2", source, math.random(10, 20))                    
            end
        end
    end)

RegisterNetEvent("esx_lumberjack:sellwood")
AddEventHandler("esx_lumberjack:sellwood", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('wood').count > 49 then
                local pieniadze = Config.WoodPrice
                xPlayer.removeInventoryItem('wood', 50)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã bán ~g~50 Gỗ')
            elseif xPlayer.getInventoryItem('wood').count < 49 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn phải đủ x50 ~r~Gỗ để bán.')
            end
        end
    end)
