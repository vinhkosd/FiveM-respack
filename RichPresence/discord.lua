Citizen.CreateThread(function()
    while true do
        --This is the Application ID (Replace this with you own)
        SetDiscordAppId(661815695331255272)

        --Here you will have to put the image name for the "large" icon.
        SetDiscordRichPresenceAsset('96')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('VNC ROLEPLAY')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('zua')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Tham gia và trải nghiệm ngay nào !!')

        --It updates every one minute just in case.
        Citizen.Wait(60000)
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        players = {}
        local pid = GetPlayerServerId(PlayerId())
        local pName = GetPlayerName(PlayerId())
        for i = 0, 255 do
            if NetworkIsPlayerActive( i ) then
                table.insert( players, i )
            end
        end

        SetRichPresence(#players.. "/256 [ID: "..pid.."] "..pName)
    end
end)