# LEGACY FUEL FOR ESX & NON-ESX  
# EDITED VERSION BY XxFri3ndlyxX  

# FEATURE  

- Adapted to use Petrol volume from the vehicle handling. Most car holds 65 Litres. Some higher some less.  
- Fuel Display in litre and not in %  
- Syncs with fuel gauge from Sexy Speedometer.  
For support join discord https://discord.gg/xncafqk


# TODO List.  
- Ability to disable jerry purchase at the pump.  
- Adding electric charger for electric vehicles.

### About
Started off as my first script, and for whatever reason, I decided to release the disguisting pile of shit. Felt bad after some time for leaving so many people with this horror of a script, so ended up spending a few hours rewriting it, so here you go. (:

### Installation
1) Download the latest version in the "code" tab on GitHub.
2) Drag & drop the folder into your `resources` server folder.
3) Configure the config file to your liking.
4) Add `start LegacyFuel` to your server config.

### Exports
There are currently two (client-sided) exports available, which should help you control the fuel level for vehicles whenever needed.

```
SetFuel(--[[Vehicle--]] vehicle, --[[Float/Int: (0-100)--]] value)
GetFuel(--[[Vehicle--]] vehicle) -- Returns the vehicle's fuel level.
```

**Example usage:**
```
function SpawnVehicle(modelHash)
    local vehicle = CreateVehicle(modelHash, coords.x, coords.y, coords.z, true, false)

    exports["LegacyFuel"]:SetFuel(vehicle, 100)
end

function StoreVehicleInGarage(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    local fuelLevel = exports["LegacyFuel"]:GetFuel(vehicle)

    TriggerServerEvent('vehiclesStored', plate, fuel)
end
```
