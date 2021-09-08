Config = {}

Config.Locale = 'en'
Config.RequiredCopsSanHo  = 3
Config.RequiredCopsCoke  = 1
Config.Delays = {
	thoigianchebien = 1000 * 3
}
Config.ThoiGianBan = 3000
Config.GiaBan = 2500

Config.PimpGuy = {
	{ x= 1230.6, y= -2911.02, z= 8.3, name = "~y~Endiez", heading = 100.0, model = "s_m_y_devinsec_01" },
	{ x= -1124.84, y= 4893.3, z= 217.5, name = "~y~Endiez", heading = 0.0, model = "s_m_y_devinsec_01" },
	{ x= -1756.31, y= 427.23, z= 126.7, name = "~y~Endiez", heading = 72.0, model = "s_m_y_devinsec_01" },

}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 200000}
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	Haisanho = {coords = vector3(428.72, 7543.59, -52.31), name = _U('blip_weedfield'), color = 25, sprite = 527, radius = 100.0},
	Chebiensanho = {coords = vector3(3559.82, 3675.99, 28.12), name = _U('blip_weedprocessing'), color = 60, sprite = 464, radius = 100.0},

	DrugDealer = {coords = vector3(1230.6, -2911.02, 8.5), name = _U('blip_drugdealer'), color = 6, sprite = 527, radius = 100.0}

--[[	CokeField = {coords = vector3(2218.09, 5057.76, 46.95), name = "_U('blip_cokefield')", color = 2, sprite = 501, radius = 100.0},
	CokeProcessing = {coords = vector3(1099.64, -3194.25, -38.99), name = _U('blip_cokeprocessing'), color = 5, sprite = 501, radius = 100.0},
	DrugDealer2 = {coords = vector3(-1757.37, 427.51, 127.68), name = _U('blip_drugdealer'), color = 1, sprite = 501, radius = 25.0},
]]
}
Config.MarkerType = 27
Config.DrawDistance = 10.0
Config.ZoneSize     = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor  = {r = 100, g = 100, b = 204}
Config.Zones = {
	vector3(3559.82, 3675.99, 27.5),-- chế biến
	vector3(-1124.9,4894.4,218.47), 
	vector3(1230.6, -2911.02, 8.5),
	vector3(-1757.37, 427.51, 127.68)
}
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())

		for i=1, #Config.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones[i], true)

			if distưance < Config.DrawDistance then
				DrawMarker(Config.MarkerType, Config.Zones[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)]]
