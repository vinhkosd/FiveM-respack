--------------------------------------------------
--                 _   _ _     _                --
--       Made by  | \ | | |   (_)               --
--       ___  __ _|  \| | |__  _  ___           --
--      / __|/ _` | . ` | '_ \| |/ _ \          --
--      \__ \ (_| | |\  | | | | |  __/          --
--      |___/\__,_\_| \_/_| |_| |\___|          --
--                           _/ |               --
--                          |__/  2019          --
--                                              --
--    https://forum.fivem.net/u/stianhje/       --
--------------------------------------------------

-------------------------------------------------------------------------------
-- ESX
-------------------------------------------------------------------------------
local lastRevives = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------------------------------------------------------------------
-- Get Money / Remove money
-------------------------------------------------------------------------------
RegisterServerEvent('sawu_hookers:pay')
AddEventHandler('sawu_hookers:pay', function(boolean)
    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local xPlayers  = ESX.GetPlayers()

    if (boolean == true) then
        if xPlayer.getMoney() >= Config.BlowjobPrice then
            xPlayer.removeMoney(Config.BlowjobPrice)
            TriggerClientEvent('sawu_hookers:startBlowjob', _source)
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You payed: ' .. Config.BlowjobPrice ..' $' })
            -- this adds money to society_nightclub
            if Config.SocietyNightclub then
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
                    account.addMoney(Config.BlowjobPrice)
                end)
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You do not have enough money' })
            TriggerClientEvent('sawu_hookers:noMoney', _source)
        end  
    else
        if xPlayer.getMoney() >= Config.SexPrice then
            xPlayer.removeMoney(Config.SexPrice)
            TriggerClientEvent('sawu_hookers:startSex', _source)
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You payed: ' .. Config.SexPrice ..' $' })
            -- this adds money to society_nightclub
            if Config.SocietyNightclub then
                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
                    account.addMoney(Config.SexPrice)
                end)
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You do not have enough money' })
            TriggerClientEvent('sawu_hookers:noMoney', _source)
        end 
    end
end)


ESX.RegisterServerCallback('sawu_hookers:countAmbulance', function(src, cb)
	local esxPlayers = ESX.GetPlayers()
    local MedsConnected = 0
    local message = ""

    for i=1, #esxPlayers, 1 do
        local esxPlayer = ESX.GetPlayerFromId(esxPlayers[i])
        if esxPlayer.job.name == 'ambulance' then
            MedsConnected = MedsConnected + 1
        end
    end

    if MedsConnected == 0 then
        local xTarget = ESX.GetPlayerFromId(source)
        -- local diedTime = lastRevives[xTarget]
        
        -- if diedTime ~= nil then
        --     local waitPeriod = diedTime + (60 * 1000)
        --     if(GetGameTimer() < waitPeriod)then
        --         local seconds = math.ceil((waitPeriod - GetGameTimer()) / 1000)
        --         local message = ""
        --         if(seconds > 60)then
        --             local minutes = math.floor((seconds / 60))
        --             seconds = math.ceil(seconds-(minutes*60))
        --         end
        --         message = "Bạn đã hồi sinh trước đó. Vui lòng chờ "..seconds.." giây"
        --     else
        --         --set last died time
        --         lastRevives[xTarget] = GetGameTimer()
        --     end
        -- else
        --     --set lastdiedtime
        --     lastRevives[xTarget] = GetGameTimer()
        -- end
        message = "revive"
    else
        message = "Không thể hồi sinh khi có bác sĩ online"
    end

    cb(message)
end)