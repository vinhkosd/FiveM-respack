Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 30.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 6
Config.TimerBeforeNewRob    = 2700 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 100   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["bank2cua"] = {
		position = { x = 252.64, y = 221.38, z = 101.68 },
		reward = math.random(350000, 500000),
		nameOfStore = "Pacific Bank ( Bank 2 cửa )",
		secondsRemaining = 1500, -- seconds
		lastRobbed = 0
	},
	["bank9h"] = {
		position = { x = -2954.07, y = 486.3, z = 15.68 },
		reward = math.random(350000, 500000),
		nameOfStore = "Fleeca Bank ( Cao tốc 9H )",
		secondsRemaining = 1500, -- seconds
		lastRobbed = 0
	},
	["banksamac"] = {
		position = { x = 1176.37, y = 2712.78, z = 38.09 },
		reward = math.random(350000, 500000),
		nameOfStore = "Fleeca Bank ( Bank Sa Mạc )",
		secondsRemaining = 1500, -- seconds
		lastRobbed = 0
	},
	["bank8h"] = {
		position = { x = -1205.83, y = -336.68, z = 37.76 },
		reward = math.random(350000, 500000),
		nameOfStore = "Fleeca Bank ( Thành phố 8H )",
		secondsRemaining = 1500, -- seconds
		lastRobbed = 0
	},
	["banktt"] = {
		position = { x = 146.59, y = -1045.88, z = 29.37 },
		reward = math.random(350000, 500000),
		nameOfStore = "Fleeca Bank ( Trung tâm )",
		secondsRemaining = 1500, -- seconds
		lastRobbed = 0
	}
}
