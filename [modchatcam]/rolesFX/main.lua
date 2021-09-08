ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = removenormal(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    else     
		local xPlayer = ESX.GetPlayerFromId(Source)
		str = xPlayer.job.label
		str = str:gsub("^%l", string.upper)
        TriggerClientEvent('chatMessage', -1, "^7[^3 ".. str .." ^7] ( ^5".. Name .." ^7)^3: " , { 255, 255, 255 }, Msg)           
    end
end)

function removenormal(input, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(input, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end