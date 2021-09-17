local arrayWeight = Config.localWeight
local VehicleList, VehicleInventory = {}, {}
local DataStoresIndex, DataStores, SharedDataStores = {}, {}, {}
Items = {}

AddEventHandler("onMySQLReady", function()
    local result = MySQL.Sync.fetchAll("SELECT * FROM trunk_inventory")
    local data

    MySQL.Async.execute("DELETE FROM `trunk_inventory` WHERE `owned` = 0", {})

    if #result ~= 0 then
      for i = 1, #result, 1 do
        local plate = result[i].plate
        local owned = result[i].owned
        local data = (result[i].data == nil and {} or json.decode(result[i].data))
        local dataStore = CreateDataStore(plate, owned, data)
        SharedDataStores[plate] = dataStore
      end
    end
end)

RegisterServerEvent("esx_trunk_inventory:getOwnedVehicule")
AddEventHandler("esx_trunk_inventory:getOwnedVehicule", function()
    local vehicules = {}
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner", {
        ["@owner"] = xPlayer.identifier
      }, function(result)
        if result ~= nil and #result > 0 then
          for _, v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            table.insert(vehicules, {plate = vehicle.plate})
          end
        end
        TriggerClientEvent("esx_trunk_inventory:setOwnedVehicule", _source, vehicules)
      end)
end)

function getItemWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if ESX.Items[item] ~= nil then
      itemWeight = ESX.Items[item].weight
    end
  end
  return itemWeight
end

function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemWeight = Config.DefaultWeight
        if ESX.Items[inventory[i].name] ~= nil then
          itemWeight = ESX.Items[inventory[i].name].weight
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
      end
    end
  end
  return weight
end

function getTotalInventoryWeight(plate)
  local total
  TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
      local W_weapons = getInventoryWeight(store.get("weapons") or {})
      local W_coffre = getInventoryWeight(store.get("coffre") or {})
      local W_blackMoney = 0
      local blackAccount = (store.get("black_money")) or 0
      if blackAccount ~= 0 then
        W_blackMoney = blackAccount[1].amount / 10
      end
      total = W_weapons + W_coffre + W_blackMoney
    end)
  return total
end

ESX.RegisterServerCallback("esx_trunk:getInventoryV", function(source, cb, plate)
    TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
        local blackMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)
        cb(
          {
            blackMoney = blackMoney,
            items = items,
            weapons = weapons,
            weight = weight
        })
      end)
end)

RegisterServerEvent("esx_trunk:getItem")
AddEventHandler("esx_trunk:getItem", function(plate, type, item, count, max, owned)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
      local targetItem = xPlayer.getInventoryItem(item)
      if targetItem.limit == -1 or xPlayer.canCarryItem(item, count) then
        TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                if (coffre[i].count >= count and count > 0) then
                  xPlayer.addInventoryItem(item, count)
                  if (coffre[i].count - count) == 0 then
                    table.remove(coffre, i)
                  else
                    coffre[i].count = coffre[i].count - count
                  end
                  break
                else
                  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("invalid_quantity") } )
                end
              end
            end

            store.set("coffre", coffre)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
          end)
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("player_inv_no_space") } )
      end
    end

    if type == "item_account" then
      TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
          local blackMoney = store.get("black_money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("black_money", blackMoney)
            xPlayer.addAccountMoney(item, count)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
          else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("invalid_amount") } )
          end
        end)
    end

    if type == "item_weapon" then
      TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          local weaponName = nil
          local ammo = nil

          for i = 1, #storeWeapons, 1 do
            if storeWeapons[i].name == item then
              weaponName = storeWeapons[i].name
              ammo = storeWeapons[i].ammo

              table.remove(storeWeapons, i)

              break
            end
          end

          store.set("weapons", storeWeapons)

          xPlayer.addWeapon(weaponName, ammo)

          local blackMoney = 0
          local items = {}
          local weapons = {}
          weapons = (store.get("weapons") or {})

          local blackAccount = (store.get("black_money")) or 0
          if blackAccount ~= 0 then
            blackMoney = blackAccount[1].amount
          end

          local coffre = (store.get("coffre") or {})
          for i = 1, #coffre, 1 do
            table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
          end

          local weight = getTotalInventoryWeight(plate)

          text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
          data = {plate = plate, max = max, myVeh = owned, text = text}
          TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
        end)
    end
end)

RegisterServerEvent("esx_trunk:putItem")
AddEventHandler("esx_trunk:putItem", function(plate, type, item, count, max, owned, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

    if type == "item_standard" then
      local playerItemCount = xPlayer.getInventoryItem(item).count

      if (playerItemCount >= count and count > 0) then
        TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
            local found = false
            local coffre = (store.get("coffre") or {})

            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                coffre[i].count = coffre[i].count + count
                found = true
              end
            end
            if not found then
              table.insert(
                coffre,
                {
                  name = item,
                  count = count
                })
            end
            if (getTotalInventoryWeight(plate) + (getItemWeight(item) * count)) > max then
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("insufficient_space") } )
            else
              -- Checks passed, storing the item.
              xPlayer.removeInventoryItem(item, count)
	      store.set("coffre", coffre)

              MySQL.Async.execute("UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate", {
                  ["@plate"] = plate,
                  ["@owned"] = owned
              })
            end
          end)
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("invalid_quantity") } )
      end
    end

    if type == "item_account" then
      local playerAccountMoney = xPlayer.getAccount(item).money

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
            local blackMoney = (store.get("black_money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end

            if (getTotalInventoryWeight(plate) + blackMoney[1].amount / 10) > max then
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("insufficient_space") } )
            else
              -- Checks passed. Storing the item.
              xPlayer.removeAccountMoney(item, count)
              store.set("black_money", blackMoney)

              MySQL.Async.execute("UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate", {
                  ["@plate"] = plate,
                  ["@owned"] = owned
              })
            end
          end)
      else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("invalid_amount") } )
      end
    end

    if type == "item_weapon" then
      TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          table.insert(
            storeWeapons,
            {
              name = item,
              label = label,
              ammo = count
            }
          )
          if (getTotalInventoryWeight(plate) + (getItemWeight(item))) > max then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U("insufficient_space") } )
          else
            store.set("weapons", storeWeapons)
            xPlayer.removeWeapon(item)

            MySQL.Async.execute("UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate", {
                ["@plate"] = plate,
                ["@owned"] = owned
            })
          end
        end)
    end

    TriggerEvent("esx_trunk:getSharedDataStore", plate, function(store)
        local blackMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)

        text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
        data = {plate = plate, max = max, myVeh = owned, text = text}
        TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
      end)
end)

ESX.RegisterServerCallback("esx_trunk:getPlayerInventory", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount("black_money").money
    local items = xPlayer.inventory

    cb({blackMoney = blackMoney, items = items})
end)

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

function loadInvent(plate)
  local result =
    MySQL.Sync.fetchAll("SELECT * FROM trunk_inventory WHERE plate = @plate", {
      ["@plate"] = plate
    })
  local data = nil
  if #result ~= 0 then
    for i = 1, #result, 1 do
      local plate = result[i].plate
      local owned = result[i].owned
      local data = (result[i].data == nil and {} or json.decode(result[i].data))
      local dataStore = CreateDataStore(plate, owned, data)
      SharedDataStores[plate] = dataStore
    end
  end
end

function getOwnedVehicule(plate)
  local found = false
  if listPlate then
    for k, v in pairs(listPlate) do
      if string.find(plate, v) ~= nil then
        found = true
        break
      end
    end
  end
  if not found then
    local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
    while result == nil do
      Wait(5)
    end
    if result ~= nil and #result > 0 then
      for _, v in pairs(result) do
        local vehicle = json.decode(v.vehicle)
        if vehicle.plate == plate then
          found = true
          break
        end
      end
    end
  end
  return found
end

function MakeDataStore(plate)
  local data = {}
  local owned = getOwnedVehicule(plate)
  local dataStore = CreateDataStore(plate, owned, data)
  SharedDataStores[plate] = dataStore
  MySQL.Async.execute("INSERT INTO trunk_inventory(plate,data,owned) VALUES (@plate,'{}',@owned)", {
      ["@plate"] = plate,
      ["@owned"] = owned
  })
  loadInvent(plate)
end

function GetSharedDataStore(plate)
  if SharedDataStores[plate] == nil then
    MakeDataStore(plate)
  end
  return SharedDataStores[plate]
end

AddEventHandler("esx_trunk:getSharedDataStore", function(plate, cb)
    cb(GetSharedDataStore(plate))
end)

ESX.RegisterServerCallback('esx_inventoryhud:checkOwner',function(source,cb, plate)
  local _source = source
  local identifier = GetPlayerIdentifiers(_source)[1]
  local vehplate = ESX.Math.Trim(plate)
  local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles where plate=@plate and owner=@identifier",{['@plate'] = vehplate, ['@identifier'] = identifier});
  while result == nil do
    Wait(5)
  end
  if #result ~= 0 then
    cb(true)
  else
    cb(false)
  end
  -- , function(result)
  --   print(result[1])
  --   if result[1] ~= nil then--chủ xe
  --     cb(true)
  --   else
  --     cb(false)
  --   end
  -- end)
end)