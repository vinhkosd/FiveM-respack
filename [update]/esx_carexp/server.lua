ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('getPhonenumber', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local phonenumber = getNumberPhone(xPlayer.identifier)
	cb(phonenumber)
end)


function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end