# Trew HUD UI
Custom UI created for ESX Framework.

# Requirements
* [es_extended](https://github.com/ESX-Org/es_extended)
* [esx_society](https://github.com/ESX-Org/esx_society)
* [esx_addonaccount](https://github.com/ESX-Org/esx_addonaccount)

# Optional
* [esx_basicneeds](https://github.com/ESX-Org/esx_basicneeds)
* [esx_status](https://github.com/ESX-Org/esx_status)
* [LegacyFuel](https://github.com/InZidiuZ/LegacyFuel)

# Post Installation
* Go to **es_extended config.lua** and turn **Config.EnableHud** to **false**
* Go to **esx_basicneeds] main.lua** and replace this code

```

    TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
    	return true
    end, function(status)
    	status.remove(1000)
    end)
    
    TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
    	return true
    end, function(status)
    	status.remove(750)
    end)

```

for this one

```

    TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
    	return false
    end, function(status)
    	status.remove(1000)
    end)
    
    TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
    	return false
    end, function(status)
    	status.remove(750)
    end)

```
