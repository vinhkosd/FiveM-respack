ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
	
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT `exp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
		--print(result[1].exp)
        xpbd = result[1].exp
		TriggerClientEvent('XNL_NET:AddPlayerXP', _source , xpbd)
    end)
    
    Wait(0)
    
end)	

-- RegisterServerEvent('rank_loadexp')
-- AddEventHandler('rank_loadexp', function()
	-- local _source = source
	-- print(_source)
    -- local xPlayer = ESX.GetPlayerFromId(_source)
	-- print('aaa')
	-- MySQL.Async.fetchAll('SELECT `exp` FROM users WHERE identifier = @identifier', {
		-- ['@identifier'] = xPlayer.identifier
	-- }, function(result)
        -- -- print(result[1].rank)
		-- local dumpedTable = ESX.DumpTable(result)

-- print(dumpedTable)

		
        -- xpbd = result[1].exp
		-- TriggerClientEvent('XNL_NET:AddPlayerXP', _source , xpbd)
    -- end)
    
    -- Wait(0)
    
-- end)	

RegisterServerEvent('AddXp')
AddEventHandler('AddXp',function(value)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT `exp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
       local xpbd = result[1].exp
   	
	MySQL.Async.fetchAll("UPDATE users SET exp = @xp WHERE identifier = @identifier",
                {
                 ['@identifier'] = xPlayer.identifier,
				 ['@xp'] = xpbd + (value)
                }
                )
	 end)
end)

AddEventHandler('AddXp2',function(source, value)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT `exp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
       local xpbd = result[1].exp
   	
	MySQL.Async.fetchAll("UPDATE users SET exp = @xp WHERE identifier = @identifier",
                {
                 ['@identifier'] = xPlayer.identifier,
				 ['@xp'] = xpbd + (value)
                }
                )
	 end)
end)


RegisterServerEvent('RemoveXp')
AddEventHandler('RemoveXp',function(value)
	
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT `exp` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
   	 end)
end)
