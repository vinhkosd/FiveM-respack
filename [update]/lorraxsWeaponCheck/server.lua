ESX = nil
local logs = "https://discordapp.com/api/webhooks/699088965449416777/XXEbb9yPPKLhPVtDbuSmsd5AKqWhceFRnqwrIh9G5By3PVbFIl4Eo4UqV9MPXpFR34IR"
local logs2 = "https://discordapp.com/api/webhooks/698069689053478963/sQibEWyBLJinSnwoe1dAR0mpa3-hqe0J9zbN5wpEiUtTBK10kMBIyVGWVALAiib_HDiQ"


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
print('ANTIWEAPON : da khoi dong')
ESX.RegisterServerCallback('weaponcheck:getOwnedweapon', function(source, cb)
	--print('dasdasd')
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM owned_weapon WHERE identifier=@identifier', {['@identifier'] = xPlayer.identifier}, function(resuft)
		cb(resuft)
		--local dumpedTable = ESX.DumpTable(resuft)

		--print(dumpedTable)
	end)
end)


RegisterServerEvent('weaponcheck:kick')
AddEventHandler('weaponcheck:kick', function()
	DropPlayer(source, 'Hack')
end)

RegisterServerEvent('weaponcheck:removeWeapon')
AddEventHandler('weaponcheck:removeWeapon', function(weapon)
--print(weapon)
	local xPlayer = ESX.GetPlayerFromId(source)
	local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "Weapon Checker #1",
            ["description"] = "Player: "..xPlayer.name.."**\n Đã Bug súng: **"..weapon.."**\n Steam Hex: **"..xPlayer.identifier.."**",
	        ["footer"] = {
                ["text"] = 'HBRP',
                ["icon_url"] = 'https://media.discordapp.net/attachments/662258615050305566/672712564580417536/received_439857653302737.jpeg?width=577&height=577',
            },
        }
	}
	PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "weaponlog", embeds = connect}), { ['Content-Type'] = 'application/json' })
	xPlayer.removeWeapon(weapon)
end)

RegisterServerEvent('weaponcheck:damageKick')
AddEventHandler('weaponcheck:damageKick', function(id)
	--print(source, id)
	DropPlayer(id, 'Hack')
end)


ESX.RegisterUsableItem('hopdongsung', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('weaponcheck:getweapon', _source)
end)

RegisterServerEvent('weaponcheck:giveWeapon')
AddEventHandler('weaponcheck:giveWeapon', function()
	print(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('weaponcheck:getweapon', _source)
end)


RegisterServerEvent('weaponcheck:addWeapon')
AddEventHandler('weaponcheck:addWeapon', function(weaName)
	local xPlayer ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaName, 200)
	local result = MySQL.Sync.fetchAll('SELECT COUNT(*) as count FROM owned_weapon WHERE identifier = @identifier and name = @name', {
		['@identifier'] = xPlayer.identifier,
		['@name'] = weaName
	})
	if tonumber(result[1].count) == 0 then 
		MySQL.Sync.execute("INSERT INTO owned_weapon (identifier, name) VALUES (@identifier, @name)", {['@identifier'] = xPlayer.identifier, ['@name'] = weaName})
	end
	TriggerClientEvent('weaponcheck:update', source)
end)

AddEventHandler('weaponcheck:addWeapon2', function(id, weaName)
	local xPlayer = ESX.GetPlayerFromId(id)
	--xPlayer.addWeapon(weaName, 200)
	local result = MySQL.Sync.fetchAll('SELECT COUNT(*) as count FROM owned_weapon WHERE identifier = @identifier and name = @name', {
		['@identifier'] = xPlayer.identifier,
		['@name'] = weaName
	})
	if tonumber(result[1].count) == 0 then 
		MySQL.Sync.execute("INSERT INTO owned_weapon (identifier, name) VALUES (@identifier, @name)", {['@identifier'] = xPlayer.identifier, ['@name'] = weaName})
	end
	TriggerClientEvent('weaponcheck:update', id)
end)

AddEventHandler('weaponcheck:removeWeapon2', function(id, weaName)
	local xPlayer = ESX.GetPlayerFromId(id)
	--xPlayer.addWeapon(weaName, 200)
	local result = MySQL.Sync.fetchAll('SELECT COUNT(*) as count FROM owned_weapon WHERE identifier = @identifier and name = @name', {
		['@identifier'] = xPlayer.identifier,
		['@name'] = weaName
	})
	if tonumber(result[1].count) > 0 then 
		MySQL.Sync.execute("DELETE FROM owned_weapon WHERE identifier = @identifier and name = @name", {['@identifier'] = xPlayer.identifier, ['@name'] = weaName})
	end
	TriggerClientEvent('weaponcheck:update', id)
end)

RegisterServerEvent('weaponcheck:sellWeapon')
AddEventHandler('weaponcheck:sellWeapon', function(target, weaName)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_weapon WHERE identifier = @identifier AND name = @name', {
			['@identifier'] = xPlayer.identifier,
			['@name'] = weaName
		})
	if result[1] ~= nil then
		MySQL.Async.execute('UPDATE owned_weapon SET identifier = @target WHERE identifier = @identifier AND name = @name', {
			['@identifier'] = xPlayer.identifier,
			['@name'] = weaName,
			['@target'] = tPlayer.identifier
		}, function (rowsChanged)
			if rowsChanged ~= 0 then
				TriggerClientEvent('esx_contract:showAnim', _source)
				Wait(22000)
				TriggerClientEvent('esx_contract:showAnim', _target)
				Wait(22000)
				TriggerClientEvent('esx:showNotification', _source, 'Đã bán súng')
				TriggerClientEvent('esx:showNotification', _target, 'Đã mua súng')
				xPlayer.removeWeapon(weaName)
				tPlayer.addWeapon(weaName, 200)
				xPlayer.removeInventoryItem('hopdongsung', 1)
				TriggerClientEvent('weaponcheck:update', _source)
				TriggerClientEvent('weaponcheck:update', _target)
				local connect = {
					{
						["color"] = "8663711",
						["title"] = "Weapon Checker #1",
						["description"] = "**Người Chuyển:** "..xPlayer.name.."**\n Người Nhận: **"..tPlayer.name.."**\n Tên Súng: **"..weaName.."**",
						["footer"] = {
							["text"] = 'AETL',
							["icon_url"] = 'https://media.discordapp.net/attachments/662258615050305566/672712564580417536/received_439857653302737.jpeg?width=577&height=577',
						},
					}
				}
				PerformHttpRequest(logs2, function(err, text, headers) end, 'POST', json.encode({username = "GiaoDichSung", embeds = connect}), { ['Content-Type'] = 'application/json' })
			end
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Không có súng')
	end
end)

TriggerEvent('es:addGroupCommand', 'addweapon', 'superadmin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			if args[2] ~= nil and args[3] ~= nil then
				local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
				print(('add weapon '):format(GetPlayerName(source)))
				xPlayer.addWeapon(args[2], args[3])
				MySQL.Sync.execute("INSERT INTO owned_weapon (identifier, name) VALUES (@identifier, @name)", {['@identifier'] = xPlayer.identifier, ['@name'] = args[2]})
				TriggerClientEvent('weaponcheck:update', source)
				TriggerClientEvent('weaponcheck:update', tonumber(args[1]))
			end
		end
	end
	end,function(source, args, user)
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end,{help = ''})