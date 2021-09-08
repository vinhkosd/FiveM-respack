ESX = nil
PlayerData                = {}
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)


ESX.RegisterServerCallback("esx_marker:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)
---showcommand---
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBlackMoneyFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('black_money')
	return account.money

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end
	
TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'showjob', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label

--TriggerClientEvent('esx:showNotification', _source, 'Bạn đang làm công việc : ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang làm việc tại: ' .. job .. ' - ' .. jobgrade})  
end, {help = "Check what job you have"})

TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'showcash', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local wallet 		= getMoneyFromUser(_source)

--TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. wallet .. ' ~s~trong ví của bạn~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. wallet .. ' trong ví'})
end, {help = "Check how much is trong ví của bạn"})

TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'showbank', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bank 			= getBankFromUser(_source)

--TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. bank .. ' ~s~trong ngân hàng~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. bank .. ' trong ngân hàng'})
end, {help = "Check how much is trong ngân hàng"})

TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'showdirty', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local black_money 	= getBlackMoneyFromUser(_source)

--TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. black_money .. ' ~s~tiền bẩn trong ví của bạn~g~ ')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'bạn đang có $' .. black_money .. ' tiền bẩn trong ví'})
end, {help = "Check how much tiền bẩn you have"})

TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'thongtin', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.label
    local jobgrade = xPlayer.job.grade_label
    local wallet 		= getMoneyFromUser(_source)
    local bank 			= getBankFromUser(_source)
    local black_money 	= getBlackMoneyFromUser(_source)
    if xPlayer.job.grade_name == 'boss' or xPlayer.job2.grade_name == 'boss' then
        local society = GetSociety(xPlayer.job.name)
        local society2 = GetSociety(xPlayer.job2.name)

		if society ~= nil then
			TriggerEvent('816b1e39-020b-46bc-b04e-defb11105d9a', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
        end
        
        if society2 ~= nil then
			TriggerEvent('816b1e39-020b-46bc-b04e-defb11105d9a', society2.account, function(account2)
				money2 = account2.money
			end)
		else
			money2 = 0
		end

                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang làm công việc : ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)	         
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang làm công việc : ' .. job .. ' - ' .. jobgrade})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. wallet .. ' ~s~trong ví của bạn~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. wallet .. ' trong ví của bạn'})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. bank .. ' ~s~trong ngân hàng~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. bank .. ' trong ngân hàng'})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. black_money .. ' ~s~tiền bẩn trong ví của bạn~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. black_money .. ' tiền bẩn trong ví của bạn'})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. money .. ' ~s~in the society account~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. money .. ' trong tài khoản công ty'})
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. money2 .. ' trong tài khoản bang hội'})
																	
	else

                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang làm công việc : ~g~' .. job .. ' ~s~-~g~ ' .. jobgrade)	         
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang làm công việc : ' .. job .. ' - ' .. jobgrade})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. wallet .. ' ~s~trong ví của bạn~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. wallet .. ' trong ví của bạn'})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. bank .. ' ~s~trong ngân hàng~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. bank .. ' trong ngân hàng'})
                Citizen.Wait(1500)
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. black_money .. ' ~s~tiền bẩn trong ví của bạn~g~ ')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. black_money .. ' tiền bẩn trong ví của bạn'})
                Citizen.Wait(1500)
	        --TriggerClientEvent('esx:showNotification', _source, '~r~Bạn không có quyền!')
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bạn không có quyền!'})
																	
	end
end, {help = "Check your society's balance"})

TriggerEvent('f3b16af0-102c-466a-8a32-1476ef835273', 'showsociety', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.job.grade_name == 'boss' then
		local society = GetSociety(xPlayer.job.name)

		if society ~= nil then
			TriggerEvent('816b1e39-020b-46bc-b04e-defb11105d9a', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end
		
                --TriggerClientEvent('esx:showNotification', _source, 'Bạn đang có ~g~$~g~' .. money .. ' ~s~in the society account~g~ ')
	        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Bạn đang có $' .. money .. ' trong công ty'})
																	
	else

	        --TriggerClientEvent('esx:showNotification', _source, '~r~Bạn không có quyền!')
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Bạn không có quyền!'})
																			
	end
end, {help = "Check your society's balance"})

TriggerEvent('d47eb1ed-d0e3-4421-8168-66e47a75dfa8', function(societies) 
	RegisteredSocieties = societies
end)

function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end

---Car wash--
RegisterServerEvent('2445d980-b482-4c45-b6ab-5852f8b4a660')
AddEventHandler('2445d980-b482-4c45-b6ab-5852f8b4a660', function(dirt)
	local xPlayer = ESX.GetPlayerFromId(source)
	if dirt > 1.0 then
	  if xPlayer.getMoney() >= 20 then
		xPlayer.removeMoney(20)
		TriggerClientEvent('e4c6ba59-f3c9-4d1a-9f09-f9fe1bb28928', source)
	  else
		TriggerClientEvent('4ed021f1-4361-4b4c-911c-3cffc0be99e0', source)
	  end	
	else
	  TriggerClientEvent('cafcae6a-440e-444f-9c44-3a43da01ffe6', source)
	end
end)

---giat sung-- 
--[[ CHECK USER FOR ADMIN OR WHITELIST ]]--
RegisterServerEvent('a4db3eb1-55cf-4451-8e23-58591c8b6f2d')
AddEventHandler('a4db3eb1-55cf-4451-8e23-58591c8b6f2d', function(playerId)
	local _source = source
	local deets = getIdentity(playerId)
	if deets.group == 'admin' or deets.group == 'superadmin' then
		TriggerClientEvent('fd69d3db-7810-46c6-9414-9ff655aa9654', _source, true)
	end
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
			group = identity['group']
		}
	else
		return nil
	end
end