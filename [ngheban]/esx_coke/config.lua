Config = {}

Config.Locale = 'en'
Config.RequiredCopsCoke  = 1
Config.ThoiGianBan = 2000
Config.Delays = {
	WeedProcessing = 1000 * 3 -- 1000 * Số giây chế biến
}
Config.GiaBan1 = 4000
Config.GiaBan2 = 4500
Config.GiaBan3 = 5000
Config.GiaBan4 = 5500
Config.GiaBan5 = 6000
Config.GiaBan6 = 7500
Config.GiaBan7 = 7500
Config.GiaBan8 = 7500
Config.GiaBan9 = 7500

Config.GiveBlack = true -- bật chức năng này để bán được tiền bẩn

Config.CircleZones = {
	WeedField = {coords = vector3(2621.22,-1671.33,20.77), name = _U('blip_weedfield'), color = 2, sprite = 501, radius = 100.0, show = true},

	DrugDealer = {coords = vector3(-315.23,-2776.39,5.0), name = _U('blip_drugdealer'), color = 5, sprite = 501, radius = 100.0, show = true},
	WeedProcessing = {coords = vector3(-882.06,364.36,85.36), name = _U('blip_weedprocessing'), color = 1, sprite = 501, radius = 100.0, show = true}


}

