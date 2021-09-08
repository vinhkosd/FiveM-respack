Config = {}

Config.Locale = 'en'
Config.RequiredCopsWeed  = 1
Config.ThoiGianBan = 2000
Config.Delays = {
	WeedProcessing = 1000 * 3 -- 1000 * Số giây chế biến
}
Config.GiaBan1 = 2500
Config.GiaBan2 = 3000
Config.GiaBan3 = 3500
Config.GiaBan4 = 4000
Config.GiaBan5 = 4500
Config.GiaBan6 = 5000
Config.GiaBan7 = 5500
Config.GiaBan8 = 6000
Config.GiaBan9 = 6500

Config.GiveBlack = true -- bật chức năng này để bán được tiền bẩn

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_weedfield'), color = 2, sprite = 496, radius = 100.0, show = true},
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_weedprocessing'), color = 1, sprite = 496, radius = 100.0, show = true},
	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 5, sprite = 378, radius = 25.0, show = true},
}

