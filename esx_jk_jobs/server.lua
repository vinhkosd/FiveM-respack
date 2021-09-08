ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_empregos:setJobunemployed')
AddEventHandler('esx_empregos:setJobunemployed', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("unemployed", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Bạn đã nghỉ việc ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('esx_empregos:setJobt')
AddEventHandler('esx_empregos:setJobt', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("taxi", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~ ' .. xPlayer.getName())
end)

RegisterServerEvent('esx_empregos:setJobfisherman')
AddEventHandler('esx_empregos:setJobfisherman', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("fisherman", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('esx_empregos:setJobminer')
AddEventHandler('esx_empregos:setJobminer', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("miner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobfueler')
AddEventHandler('esx_empregos:setJobfueler', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("fueler", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobslaughterer')
AddEventHandler('esx_empregos:setJobslaughterer', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("slaughterer", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobtailor')
AddEventHandler('esx_empregos:setJobtailor', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("tailor", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJoblumberjack')
AddEventHandler('esx_empregos:setJoblumberjack', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("lumberjack", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJobreporter')
AddEventHandler('esx_empregos:setJobreporter', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("reporter", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('esx_empregos:setJoblangbam')
AddEventHandler('esx_empregos:setJobmechanic', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("langbam", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('esx_empregos:setJobgarbage')
AddEventHandler('esx_empregos:setJobgarbage', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("garbage", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Chúc mừng bạn đã xin được việc, ~g~' .. xPlayer.getName())	
end)