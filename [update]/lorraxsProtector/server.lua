local logs = 'https://discordapp.com/api/webhooks/691628364796002354/mrseP1k60wPYAc8OwpSC79wjvHetsTsI4m8-fyc5zcuTLhUvmhEoHI-Y_kCexh_raEMo'
RegisterServerEvent('lorraxsProtector_detected')
AddEventHandler('lorraxsProtector_detected', function(name)
	
	local _source = source
	local playername = GetPlayerName(_source)
	local steamid  = 'false'
    local license  = 'false'
    local discord  = 'false'
    local xbl      = 'false'
    local liveid   = 'false'
    local ip       = 'false'
    for k,v in pairs(GetPlayerIdentifiers(source))do
    print(v)
        
	      if string.sub(v, 1, string.len("steam:")) == "steam:" then
	        steamid = v
	      elseif string.sub(v, 1, string.len("license:")) == "license:" then
	        license = v
	      elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
	        xbl  = v
	      elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
	        ip = v
	      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
	        discord = v
	      elseif string.sub(v, 1, string.len("live:")) == "live:" then
	        liveid = v
	      end
    
  	end
  	local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "Endiez",
            ["description"] = "**Player: **"..playername.."**\n Detected: **"..name.."**\n Steam Hex: **"..steamid.."**\n License: **"..license.."**\n Ip: **"..ip.."**\n Discord: **"..discord.."**\n LiveID: **"..liveid,
	        ["footer"] = {
                ["text"] = 'DLRP',
                ["icon_url"] = 'https://i.imgur.com/4Vw3Seb.png',
            },
        }
	}
	PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "Endiez", embeds = connect}), { ['Content-Type'] = 'application/json' })

end)