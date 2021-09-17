local PlayerData, vehiclePlate = {}, {}
local lastVehicle, entityWorld, globalplate
local lastOpen, CloseToVehicle = false, false
local arrayWeight = Config.localWeight
local lastChecked = 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
end)

AddEventHandler("onResourceStart", function()
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicule")
    lastChecked = GetGameTimer()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent("esx_trunk_inventory:setOwnedVehicule")
AddEventHandler("esx_trunk_inventory:setOwnedVehicule", function(vehicle)
    vehiclePlate = vehicle
    --print("vehiclePlate: ", ESX.DumpTable(vehiclePlate))
end)

function getItemyWeight(item)
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

function VehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

function VehicleInFrontESX() -- Pour le diagnostic, récupérer le véhicule devant le ped
  local vehicle, distance = ESX.Game.GetClosestVehicle()
  if vehicle ~= nil and distance < 3 then
      return vehicle
  else 
      return nil
  end
end

function openmenuvehicle()
  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local vehicle = VehicleInFront()
  globalplate = GetVehicleNumberPlateText(vehicle)
  local KindOfVehicle = "personal"

  if not IsPedInAnyVehicle(playerPed) then
    myVeh = false
    local vehicleFront = VehicleInFront()
    print(vehicleFront)
    if vehicleFront == nil then
      exports.pNotify:SendNotification(
        {
          text = _U("no_veh_nearby"),
          type = "error",
          timeout = 3000,
          layout = "bottomCenter",
          queue = "inventoryhud"
        }
      )
      return
    end
    -- local vFront = all_trim(GetVehicleNumberPlateText(vehicleFront))
    PlayerData = ESX.GetPlayerData()
    local successCallBack = false
    local vehicleProps = GetVehicleProperties(vehicleFront)
    print(vehicleProps)
    ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
      successCallBack = true
      if(valid) then
        myVeh = true--chủ phương tiện
      else
        TriggerEvent('esx:showNotification', 'Bạn không phải chủ phương tiện này')
      end
    end,vehicleProps, "personal")
    -- ESX.TriggerServerCallback('esx_inventoryhud:checkOwner',function(valid)
    --   successCallBack = true
    --   if(valid) then
    --     myVeh = true--chủ phương tiện
    --   end
    -- end, vFront)
    while successCallBack == false do
      Wait(0)
    end

    if not Config.CheckOwnership or (Config.AllowPolice and ESX.PlayerData.job.name == "police") or (Config.CheckOwnership and myVeh) then
      if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
        CloseToVehicle = true
        local vehFront = VehicleInFront()
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

        if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
          lastVehicle = vehFront
          local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
          local locked = GetVehicleDoorLockStatus(closecar)
          local class = GetVehicleClass(vehFront)
          ESX.UI.Menu.CloseAll()

          if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
            SetVehicleDoorShut(vehFront, 5, false)
          else
            if locked == 1 or class == 15 or class == 16 or class == 14 or class == 18 then
              SetVehicleDoorOpen(vehFront, 5, false, false)
              ESX.UI.Menu.CloseAll()

              if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
                CloseToVehicle = true
                OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), Config.VehicleLimit[class], myVeh)
              end
            else
              exports.pNotify:SendNotification(
                {
                  text = _U("trunk_closed"),
                  type = "error",
                  timeout = 3000,
                  layout = "bottomCenter",
                  queue = "inventoryhud"
                }
              )
              -- exports['mythic_notify']:SendAlert('error', _U("trunk_closed"))
            end
          end
        else
          exports.pNotify:SendNotification(
            {
              text = _U("no_veh_nearby"),
              type = "error",
              timeout = 3000,
              layout = "bottomCenter",
              queue = "inventoryhud"
            }
          )
          -- exports['mythic_notify']:SendAlert('error', _U("no_veh_nearby"))
        end
        lastOpen = true
      end
    else
      exports.pNotify:SendNotification(
        {
          text = _U("nacho_veh"),
          type = "error",
          timeout = 3000,
          layout = "bottomCenter",
          queue = "inventoryhud"
        }
      )
      -- exports['mythic_notify']:SendAlert('error', _U("nacho_veh"))
    end
  end
end

local count = 0

Citizen.CreateThread(function()
    while true do
      Wait(0)
      local pos = GetEntityCoords(GetPlayerPed(-1))
      if CloseToVehicle then
        local vehicle = GetClosestVehicle(pos["x"], pos["y"], pos["z"], 2.0, 0, 70)
        if DoesEntityExist(vehicle) then
          CloseToVehicle = true
        else
          CloseToVehicle = false
          lastOpen = false
          ESX.UI.Menu.CloseAll()
          SetVehicleDoorShut(lastVehicle, 5, false)
        end
      end
    end
end)

function OpenCoffreInventoryMenu(plate, max, myVeh)
  ESX.TriggerServerCallback("esx_trunk:getInventoryV", function(inventory)
      text = _U("trunk_info", plate, (inventory.weight / 1000), (max / 1000))
      data = {plate = plate, max = max, myVeh = myVeh, text = text}
      TriggerEvent("esx_inventoryhud:openTrunkInventory", data, inventory.blackMoney, inventory.items, inventory.weapons)
    end, plate
  )
end

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

GetVehicleProperties = function(vehicle)
  if DoesEntityExist(vehicle) then
      local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
      vehicleProps["tyres"] = {}
      vehicleProps["windows"] = {}
      vehicleProps["doors"] = {}
      for id = 1, 7 do
          local tyreId = IsVehicleTyreBurst(vehicle, id, false)
          if tyreId then
              vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
              if tyreId == false then
                  tyreId = IsVehicleTyreBurst(vehicle, id, true)
                  vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
              end
          else
              vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
          end
      end
      for id = 1, 13 do
          local windowId = IsVehicleWindowIntact(vehicle, id)
          if windowId ~= nil then
              vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
          else
              vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
          end
      end
      for id = 0, 5 do
          local doorId = IsVehicleDoorDamaged(vehicle, id)
          if doorId then
              vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
          else
              vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
          end
      end
      vehicleProps["engineHealth"] = GetVehicleEngineHealth(vehicle)
      vehicleProps["bodyHealth"] = GetVehicleBodyHealth(vehicle)
      vehicleProps["fuelLevel"] = GetVehicleFuelLevel(vehicle)
      vehicleProps["vehicleType"] = GetVehicleClass(vehicle)

      return vehicleProps
  end
end
