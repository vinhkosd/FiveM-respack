-----[ CHANGE THIS ]-------------------------------------------
local minutesBetweenAnnouncements = 900
local prefix = "^[📩 Tin nhắn tự động 📩]^0"
local suffix = "^0."
local messages = {
    '^1Tham gia với bọn mình tại http://discord.gg/tYzdnJf ',
    '^1Bug, cheat, hack, sử dụng phần mềm thứ 3 can thiệp vào game chúng mình sẽ vĩnh viễn nói lời tạm biệt! ',
    '^1Không spam, gây war trên kênh chat! Hãy là người tham gia cộng đồng Roleplay có ý thức! ',
    '^1Nộp đơn xin việc cảnh sát, bác sĩ, thành lập băng đảng, tuyển dụng thành viên tại discord để nhanh chóng được duyệt và làm việc! ',
	'^1Menu nhanh - Nhấn phím F1. Liên lạc với Cảnh sát, đội cứu hộ, bác sĩ bằng cách mở điện thoại chọn mục yêu thích! ',
}
local ignorelist = {
    "ip:127.0.0.2",
    "steam:012345678901234",
}
---------------------------------------------------------------

--  Extra info:
--  You can use ^0-^9 in your messages to change text color.
--  You only need to change the messages above,
--  the code below shouldn't be touched.
--  The prefix string will be placed before every message.
--  The suffix string will be placed after every message.
--  You can set the suffix/prefix to "" to disable them.
--  Add player identifiers (eg: ip:127.0.0.1 or steam:123456)
--  to the ignorelist. Anyone on that ignore list will not
--  receive the automessages. This could be useful if you want
--  to send help messages to new players, but your staff won't
--  get annoyed by the spam. Leave the ignore list empty to
--  always announce to everyone.

---------------------------------------------------------------














-------[ CODE, NO NEED TO TOUCH THIS PART! ]---------
local playerSpawned = false
local playerIsOnIgnoreList = false
local timeout = minutesBetweenAnnouncements * 400
local playerIdentifiers = {}
local messagesEnabled = true
local count = 0
for _ in pairs(messages) do count = count + 1 end

RegisterNetEvent('va:setPlayerIdentifiers')
AddEventHandler('va:setPlayerIdentifiers', function(playerIds)
    if playerIds == nil then
        playerIdentifiers = {"null", "null"}
    else
        playerIdentifiers = playerIds
    end
end)

RegisterNetEvent('va:toggleAutoMessage')
AddEventHandler('va:toggleAutoMessage', function(source)
    if messagesEnabled then
        messagesEnabled = false
        TriggerEvent('chatMessage', '', { 255, 255, 255 }, "^3Automessages are now ^1disabled^3.")
    else
        messagesEnabled = true
        TriggerEvent('chatMessage', '', { 255, 255, 255 }, "^3Automessages are now ^2enabled^3.")
    end
end)

function checkForPlayerOnIgnoreList()
    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        for i, id in pairs(playerIdentifiers) do
            for x, ignoreItem in pairs(ignorelist) do
                if id == ignoreItem then
                    playerIsOnIgnoreList = true
                end
            end
        end
    end)
end

function sendMessages()
    local i = 1
    Citizen.CreateThread(function()
        Citizen.Wait(2000)
        if (playerIsOnIgnoreList == false) then
            while true do
                if (messagesEnabled == true) then
                    TriggerEvent('chatMessage', '', { 255, 255, 255 }, prefix .. " " .. messages[i] .. suffix)
                    i = i + 1
                    if (i == (count + 1)) then
                        i = 1
                    end
                else
                    print('automessages is disabled')
                end
                Citizen.Wait(timeout)
            end
        else
            print('Player on ignore list.')
        end
    end)
end

AddEventHandler('playerSpawned', function()
    if playerSpawned == false then
        Citizen.CreateThread(function()
            Citizen.Wait(2000)
            TriggerServerEvent('va:getPlayerIdentifiers')
            Citizen.Wait(2000)
            checkForPlayerOnIgnoreList()
            Citizen.Wait(2000)
            sendMessages()
            playerSpawned = true
        end)
    end
end)
-----------------------------------------------------