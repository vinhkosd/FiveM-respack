--[[
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]]

ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('giap2', function(source)
	TriggerClientEvent("vongquaymayman-dungitem", source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('giap2', 1)
end)

RegisterServerEvent("vongquaymayman-kiemtracoin")
AddEventHandler("vongquaymayman-kiemtracoin", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local money = xPlayer.getMoney()
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll("select * from users where identifier=@identifier",{['@identifier'] = identifier}, function(data) 
	--TriggerClientEvent('mythic_notify:client:SendAlert', -1, { type = 'error', text = 'asdasdasd '..data[1].coin})
		if data[1].coin >= Config.priceCoin then
			MySQL.Sync.execute("UPDATE users SET coin=@coin WHERE identifier=@identifier", {['@identifier'] = identifier, ['@coin'] = data[1].coin-1})
			TriggerClientEvent("vongquaymayman-dutien",_source)
		elseif money >= Config.priceMoney then
			xPlayer.removeMoney(Config.priceMoney)
			TriggerClientEvent("vongquaymayman-dutien",_source)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Không đủ coin hoac tien'})
		end
	end)
end)

RegisterServerEvent("vongquaymayman-addtien")
AddEventHandler("vongquaymayman-addtien", function(tien)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = tonumber(tien)
	xPlayer.addMoney(money)
end)

RegisterServerEvent("vongquaymayman-additem")
AddEventHandler("vongquaymayman-additem", function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, 1)
end)

RegisterServerEvent('vongquaymayman:addWeapon')
AddEventHandler('vongquaymayman:addWeapon', function(weapon)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, 200)
	--MySQL.Sync.execute("INSERT INTO owned_weapon (identifier, name) VALUES (@identifier, @name)", {['@identifier'] = xPlayer.identifier, ['@name'] = weapon})
	--TriggerClientEvent('weaponcheck:update', source)
end)

RegisterServerEvent("vongquaymayman-thongbao")
AddEventHandler("vongquaymayman-thongbao", function(thongbao)
	local _source = source
	TriggerClientEvent('esx:showNotification', -1, thongbao)
	local currentDatetime = os.date("%Y-%m-%d %H:%M:%S")
	local logFile,errorReason = io.open("vongquaymayman.log","a")
	if not logFile then return print(errorReason) end
	local formattedLog = string.format("[%s] [LorraxsCheck] %s",currentDatetime," "..thongbao)
	logFile:write(formattedLog.."\n")
	logFile:close()
end)

RegisterServerEvent("vongquaymayman-autocoin")
AddEventHandler("vongquaymayman-autocoin", function()
	local _source = source
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Sync.execute("UPDATE users SET coin=coin + 1 WHERE identifier=@identifier", {['@identifier'] = identifier})
	TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Bạn đã nhận được 1 coin'})
end)

RegisterServerEvent("vongquaymayman-addcoin")
AddEventHandler("vongquaymayman-addcoin", function(id,money)
	local identifier = GetPlayerIdentifiers(id)[1]
	local coin = money
	MySQL.Sync.execute("UPDATE users SET coin=coin + @coin WHERE identifier=@identifier", {['@identifier'] = identifier, ['@coin'] = coin})
	TriggerClientEvent('mythic_notify:client:SendAlert', id, { type = 'inform', text = 'Bạn đã nhận được '..coin})
end

)

RegisterServerEvent("vongquaymayman-log")
AddEventHandler("vongquaymayman-log", function(text)
	local currentDatetime = os.date("%Y-%m-%d %H:%M:%S")
	local logFile,errorReason = io.open("vongquaymayman.log","a")
	if not logFile then return print(errorReason) end
	local formattedLog = string.format("[%s] [LorraxsCheck] %s",currentDatetime,text)
	logFile:write(formattedLog.."\n")
	logFile:close()
end)

ESX.RegisterServerCallback('vongquaymayman-getcoin', function(source, cb)
    local _source = source
	--local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll("select * from users where identifier=@identifier",{['@identifier'] = identifier}, function(data) 
		if data[1] ~= nil then
			cb(data[1].coin)
		end
	end)
end)

TriggerEvent('es:addGroupCommand', 'addcoin', '_dev', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			if args[2] ~= nil then
			print(('add coin '):format(GetPlayerName(source)))
			TriggerEvent('vongquaymayman-addcoin', tonumber(args[1]), tonumber(args[2]))
			end
		end
	end
	end,function(source, args, user)
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end,{help = ''})