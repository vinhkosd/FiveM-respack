ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Start of Dark Net

TriggerEvent('3f294aef-7e99-44f1-8b86-3112f60fd31b', 'darknet', _U('phone_darknet'), true, false, true, true)

function OnDarkNetItemChange(source)

	local xPlayer  = ESX.GetPlayerFromId(source)
	local found    = false
	local darknet  = xPlayer.getInventoryItem('darknet')
	
	if darknet.count > 0 then
		found = true
	end
	
	if found then
		TriggerEvent('fd51d387-8fc7-4986-90c5-005d1d1d5928', 'darknet', source)
	else
		TriggerEvent('d1baa9a9-cf22-4da0-8d12-57dad978e9bb', 'darknet', source)
	end
	
end

RegisterServerEvent('c350682e-7f07-4cca-bddb-42685edf4d1d')
AddEventHandler('c350682e-7f07-4cca-bddb-42685edf4d1d', function(phoneNumber)
--AddEventHandler('654ad190-b4fd-4a61-b079-61ae04937334', function(source)

	local xPlayer  = ESX.GetPlayerFromId(source)
	local darknet  = xPlayer.getInventoryItem('darknet')

	if darknet.count > 0 then
		TriggerEvent('fd51d387-8fc7-4986-90c5-005d1d1d5928', 'darknet', source)
	end

end)

AddEventHandler('0163c4b8-0d3d-4d6a-8d5c-5503c2629b37', function(source)
	TriggerEvent('d1baa9a9-cf22-4da0-8d12-57dad978e9bb', 'darknet', source)
end)

AddEventHandler('280a2410-7544-4a7b-b606-c9583a62ef46', function(source, item, count)
	if item.name == 'darknet' then
		OnDarkNetItemChange(source)
	end
end)

AddEventHandler('f975141b-1981-40c9-ab96-693240376878', function(source, item, count)
	if item.name == 'darknet' then
		OnDarkNetItemChange(source)
	end
end)

-- End of Dark Net

-- Oxygen Mask
ESX.RegisterUsableItem('scuba_suit', function(source)
	TriggerClientEvent('49596255-85c7-4967-aec7-8241137e998a', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('scuba_suit', 1)
end)

-- Bullet-Proof Vest
ESX.RegisterUsableItem('bulletproof', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('1e9e8337-2043-49ae-9648-b2a675338a80', source)
	xPlayer.removeInventoryItem('bulletproof', 1)
end)

-- First Aid Kit
ESX.RegisterUsableItem('firstaidkit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('f47c93aa-d224-4567-9e3a-b0b321ffab60', source)
	xPlayer.removeInventoryItem('firstaidkit', 1)
end)

-- Weapon Clip
ESX.RegisterUsableItem('clip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('d5b9907c-3c57-4298-9547-52a8e10e030f', source)
	xPlayer.removeInventoryItem('clip', 1)
end)
-- Coke 
ESX.RegisterUsableItem('cokebag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('f1150656-87dc-4f6b-809f-768df84f2984', source)
	xPlayer.removeInventoryItem('cokebag', 1)
end)
-- Giap1
ESX.RegisterUsableItem('giap3', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_extraitems:useGiap3', source)
	xPlayer.removeInventoryItem('giap3', 1)
end)
