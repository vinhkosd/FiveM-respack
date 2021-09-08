Config = {}

Config.Locale = 'en'
Config.RequiredCopsopium  = 1
Config.ThoiGianBan = 3000
Config.Delays = {
	WeedProcessing = 1000 * 3 -- 1000 * Số giây chế biến
}
Config.LicenseEnable = false
Config.GiaBan = 4000

Config.GiveBlack = true -- bật chức năng này để bán được tiền bẩn

Config.CircleZones = {
	WeedField = {coords = vector3(-1524.5,4621.14,33.17), name = _U('blip_weedfield'), color = 2, sprite = 497, radius = 100.0, show = true},

	DrugDealer = {coords = vector3(1010.64,-2901.15,4.9), name = _U('blip_drugdealer'), color = 5, sprite = 497, radius = 100.0, show = true},
	WeedProcessing = {coords = vector3(3296.4,5190.99,18.45), name = _U('blip_weedprocessing'), color = 1, sprite = 497, radius = 100.0, show = true}


}

