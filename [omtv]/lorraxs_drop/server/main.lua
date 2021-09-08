ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local isLooting = false

AddEventHandler('onResourceStart', function(name)
	if name ~= 'lorraxs_drop' then
		CancelEvent()
	else
		--toaDo = getRandom()
		--SetTimeout(Config.ThoiGianDrop, GuiToaDo(toaDo))
		SetTimeout(10000,GuiToaDo)

	end
end)

AddEventHandler('es:playerLoaded', function(source, user) 
	if daLoot == false then
		TriggerClientEvent('lorraxs_drop:toaDo', source, posX, posY)
	end
end)

RegisterServerEvent('lorraxs_drop:daLoot')
AddEventHandler('lorraxs_drop:daLoot', function()
	isLooting = false
	daLoot = true
	local ranDom = getRandomPhanthuong()
	local xPlayer = ESX.GetPlayerFromId(source)
	if ranDom.type == 'error' then
		TriggerClientEvent('esx:showNotification', source, ranDom.msg)
		dropWebhook(GetPlayerName(source).." đã nhận được "..ranDom.msg.." từ kho báu")
	elseif ranDom.type == 'weapon' then
		--TriggerClientEvent('lorraxs_drop:addWeapon', source, ranDom.phanthuong)
		xPlayer.addWeapon(ranDom.phanthuong)
		print(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		dropWebhook(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu"})
	elseif ranDom.type == 'item' then
		xPlayer.addInventoryItem(ranDom.phanthuong, 5)
		print(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		dropWebhook(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu"})
	elseif ranDom.type == 'money' then
		xPlayer.addMoney(ranDom.phanthuong)
		dropWebhook(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		print(GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu")
		TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = GetPlayerName(source).." đã nhận được "..ranDom.phanthuong.." từ kho báu"})
	end
	TriggerClientEvent('lorraxs_drop:deleteDrop', -1)
	SetTimeout(5400000, GuiToaDo)
	ESX.ClearTimeout(deleteTimeout)
	print('lorraxs_drop: Looted by '..GetPlayerName(source))
end)

RegisterServerEvent('lorraxs_drop:syncDrop')
AddEventHandler('lorraxs_drop:syncDrop', function()
	if daLoot == false then
		TriggerClientEvent('lorraxs_drop:toaDo', source, posX, posY)
	end
end)

ESX.RegisterServerCallback('lorraxs_drop:isLooting', function(source, cb)
	if isLooting == false then
		cb(false)
		isLooting = true
		lootingTimeout = ESX.SetTimeout(120000, clearLooting)
		print('false')
	else
		cb(true)
		print('true')
	end
end)

RegisterServerEvent('lorraxs_drop:stopLoot')
AddEventHandler('lorraxs_drop:stopLoot', function()
	if isLooting == true then
		isLooting = false
		ESX.ClearTimeout(lootingTimeout)
		print('false')
	end
end)
		
function clearLooting()
	if isLooting == true then
		isLooting = false
	end
end		
		
function dropWebhook(text)
	local connect = {
		{
			["color"] = "8663711",
			["title"] = 'săn kho báu',
			["description"] = text,
			["footer"] = {
				["text"] = 'săn kho báu',
				["icon_url"] = 'https://i.imgur.com/IkT64Pn.png',
			},
		}
	}
	PerformHttpRequest('https://discordapp.com/api/webhooks/680402481343103006/uK-YHO3vJW-3ozbukvs2KASoI0-p5NLbICY0f_sWZwqiV4L-pG-J3TMH7LVZI_M5O8ey', function(err, text, headers) end, 'POST', json.encode({username = 'Thinh', embeds = connect}), { ['Content-Type'] = 'application/json' })	
end
