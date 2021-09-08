ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_miner:givestone")
AddEventHandler("esx_miner:givestone", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        local randomChance = math.random(1, 100)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('vang').count < 100 then
                TriggerClientEvent("esx_miner:givestone", source)
                if randomChance < 5 then
                    xPlayer.addInventoryItem("diamond", 1)
                    TriggerClientEvent('esx:showNotification', _source, 'Bạn đã đào được ~b~x1 Kim Cuong')
                    TriggerClientEvent("XNL_NET:AddPlayerXP", source, math.random(15, 30))
                    TriggerEvent("AddXp2", source, math.random(15, 30))                      
                elseif randomChance > 5 and randomChance < 10 then
                    xPlayer.addInventoryItem("gold", 1)
                    TriggerClientEvent('esx:showNotification', _source, 'Bạn đã đào được ~b~x1 Vàng')
                    TriggerClientEvent("XNL_NET:AddPlayerXP", source, math.random(10, 20))
                    TriggerEvent("AddXp2", source, math.random(10, 20))                      
                elseif randomChance > 10 and randomChance < 25 then
                    xPlayer.addInventoryItem("iron", 1)
                    TriggerClientEvent('esx:showNotification', _source, 'Bạn đã đào được ~b~x1 Sắt')
                    TriggerClientEvent("XNL_NET:AddPlayerXP", source, math.random(5, 10))
                    TriggerEvent("AddXp2", source, math.random(5, 10))                      
                elseif randomChance > 25 and randomChance < 40 then
                    xPlayer.addInventoryItem("copper", 1)
                    TriggerClientEvent('esx:showNotification', _source, 'Bạn đã đào được ~b~x1 Đồng')
                    TriggerClientEvent("XNL_NET:AddPlayerXP", source, math.random(5, 10))
                    TriggerEvent("AddXp2", source, math.random(5, 10))                      
                elseif randomChance < 99 then
                    xPlayer.addInventoryItem("vang", 1)
                    TriggerClientEvent('esx:showNotification', _source, 'Bạn đã đào được ~b~x1 Đá')
                    TriggerClientEvent("XNL_NET:AddPlayerXP", source, math.random(5, 10))
                    TriggerEvent("AddXp2", source, math.random(5, 10))                    
                end  
            end
        end
    end)

RegisterNetEvent("esx_miner:selldiamond")
AddEventHandler("esx_miner:selldiamond", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('diamond').count > 0 then
                local pieniadze = Config.DiamondPrice
                xPlayer.removeInventoryItem('diamond', 1)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã bán ~b~x1 Kim Cương')
            elseif xPlayer.getInventoryItem('diamond').count < 1 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn không đủ đồ để bán !')
            end
        end
    end)

RegisterNetEvent("esx_miner:sellgold")
AddEventHandler("esx_miner:sellgold", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('gold').count > 4 then
                local pieniadze = Config.GoldPrice
                xPlayer.removeInventoryItem('gold', 5)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã bán ~b~x5 Vàng')
            elseif xPlayer.getInventoryItem('gold').count < 5 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn phải có đủ ~b~x5 Vàng để bán !')
            end
        end
    end)

RegisterNetEvent("esx_miner:selliron")
AddEventHandler("esx_miner:selliron", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('iron').count > 4 then
                local pieniadze = Config.IronPrice
                xPlayer.removeInventoryItem('iron', 5)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã bán ~b~x5 Sắt')
            elseif xPlayer.getInventoryItem('iron').count < 5 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn phải có đủ ~b~x5 Sắt để bán !')
            end
        end
    end)

RegisterNetEvent("esx_miner:sellcopper")
AddEventHandler("esx_miner:sellcopper", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('copper').count > 9 then
                local pieniadze = Config.CopperPrice
                xPlayer.removeInventoryItem('copper', 10)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã bán ~b~x10 Đồng')
            elseif xPlayer.getInventoryItem('copper').count < 10 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn phải có đủ ~b~x10 Đồng để bán !')
            end
        end
    end)


RegisterNetEvent("esx_miner:sellstones")
AddEventHandler("esx_miner:sellstones", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('vang').count > 24 then
                local pieniadze = Config.StonesPrice
                xPlayer.removeInventoryItem('vang', 25)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'Bạn đã bán ~b~x25 Đá')
            elseif xPlayer.getInventoryItem('vang').count < 25 then
                TriggerClientEvent('esx:showNotification', source, 'Bạn phải có đủ ~b~x25 Đá để bán !')
            end
        end
    end)
