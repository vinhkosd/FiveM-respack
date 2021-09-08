
ESX				= nil 		--tạo biến có tên là ESX và đặt giá trị là nil(vô định)
isBusy = false				--tạo biến có tên là isBusy và đặt giá trị boolean là false
isActive = false			--tạo biến có tên là isActive và đặt giá trị boolean là false
local phonenumber = 'Không thể lấy dữ liệu'
Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Citizen.Wait(10000)
	ESX.TriggerServerCallback('getPhonenumber', function(cb)
		phonenumber = cb
	end)
	while true do
		miid2(0.670, 1.442, 1.0,1.0,0.30, "~b~Tên:~r~  ".. GetPlayerName(PlayerId()) .. "  ~b~ID:~r~  ".. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))) .. '', 255, 255, 255, 255)
		miid2(0.670, 1.462, 1.0,1.0,0.30, "~b~SĐT:~r~  "..phonenumber..'', 255, 255, 255, 255)
		Citizen.Wait(1)
	end
	SetTimeout(3600000, checkPlaytime)

end)
function checkPlaytime()
	TriggerEvent("XNL_NET:AddPlayerXP", 50)
	TriggerServerEvent("AddXp",50)
	ESX.ShowNotification('Bạn vừa nhận kinh nghiệm khi online đủ 1 tiếng')
	SetTimeout(3600000, checkPlaytime)
end

Citizen.CreateThread(function()
	local ped = PlayerPedId()
	while true do 
		Citizen.Wait(0)
		local veh = GetVehiclePedIsIn(ped, false)
		if GetPedInVehicleSeat(veh, -1) == ped then
			if isActive == false then
				isActive = true
				countTime()
			end
		else
			isActive = false
		end
	end
end)

function countTime()
	Citizen.CreateThread(function()
		local activeTime = 60
		while isActive == true do
			activeTime = activeTime - 1
			if activeTime == 0 then
				TriggerEvent("XNL_NET:AddPlayerXP",10)
				TriggerServerEvent("AddXp", 10)
				ESX.ShowNotification('Bạn vừa nhận 10 kinh nghiệm khi lái xe đủ 1 phút')
				activeTime = 60
			end
			Citizen.Wait(1000)
		end
	end)
end

function miid2(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
			
		
		