Config = {}

Config.Locale = 'en'
Config.RequiredCopsweed  = 1
Config.MaxWeedsSpawn  = 100
Config.ThoiGianBan = 2000
Config.Delays = {
	weedProcessing = 1000 * 3 -- 1000 * Số giây chế biến
}
Config.GiaBan1 = 1000
Config.GiaBan2 = 1000
Config.GiaBan3 = 1200
Config.GiaBan4 = 1300
Config.GiaBan5 = 2000
Config.GiaBan6 = 2500
Config.GiaBan7 = 3000
Config.GiaBan8 = 3500
Config.GiaBan9 = 4000

Config.GiveBlack = true -- bật chức năng này để bán được tiền bẩn

Config.CircleZones = {
	weedField = {coords = vector3(309.51,4343.45,49.81), name = _U('blip_weedField'), color = 2, sprite = 496, radius = 100.0, show = true},
	weedProcessing = {coords = vector3(2330.3,2571.5,46.68), name = _U('blip_weedProcessing'), color = 1, sprite = 496, radius = 100.0, show = true},
	DrugDealer = {coords = vector3(-1172.16,-1571.75,4.66), name = _U('blip_drugdealer'), color = 5, sprite = 496, radius = 100.0, show = true}


}

