Config = {}
Config.DropLocation = {						--Tọa độ drop
	vector3(-6.45, 742.85, 201.85),
}

Config.ThoiGianDrop = 30*60*1000 
--Config.ThoiGianDrop = 2*60*60*1000 -- Thời gian mỗi lần drop ( 3 tiếng)
Config.ThoiGianBienMat = 10*60*1000	-- Thời gian biến mất (5 phút)
Config.PhanThuong = {
	tien = math.random(1, 300000),
	sung = {
		'WEAPON_PISTOL',
        'WEAPON_SMG',
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_PUMPSHOTGUN',
        'WEAPON_DAGGER',
        'WEAPON_KNIFE',
        'WEAPON_COMPACTRIFLE',
        'WEAPON_BULLPUPSHOTGUN',
        'WEAPON_CARBINERIFLE',
        'WEAPON_MICROSMG',
        'WEAPON_SNIPERRIFLE'
	},
	item = {
		'khungren',
		'water',
		'than',
		'fixkit',
		'drill',
		'clip',
		'cup'
		
	},ChucBanMayMan = 'Bạn đen vãi cả loằn',
}	
	