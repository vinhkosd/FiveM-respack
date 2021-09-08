Config = {}

-- Ammo given by default to crafted weapons
Config.WeaponAmmo = 42

Config.Recipes = {
	-- Can be a normal ESX item
	["platin50"] = { 
		{item = "gold", quantity = 21 }, 
		{item = "copper", quantity = 10 },
		{item = "iron", quantity = 10 },
	},
	["medikit"] = { 
		{item = "bandage", quantity = 2 },
		{item = "cannabis", quantity = 10 },
		{item = "fabric", quantity = 10 },
	},
	["khuonbanh"] = { 
		{item = "cutted_wood", quantity = 10 }, 
		{item = "iron", quantity = 5 },
	},
	
	["fixkit"] = { 
		{item = "bandage", quantity = 2 }, 
		{item = "bottle", quantity = 20 },
		{item = "iron", quantity = 15 },
	},
	
	["clip"] = { 
		{item = "copper", quantity = 30 }, 
		{item = "iron", quantity = 20 },
	},
	
	["giap3"] = { 
		{item = "leather", quantity = 20 }, 
		{item = "fabric", quantity = 20 },
		{item = "giap2", quantity = 2 },
		{item = "iron", quantity = 15 },
		{item = "manhgiap", quantity = 25 },
	},
	
	["giap2"] = { 
		{item = "leather", quantity = 15 }, 
		{item = "fabric", quantity = 15 },
		{item = "bulletproof", quantity = 2 },
		{item = "iron", quantity = 10 },
		{item = "manhgiap", quantity = 20 },
	},
	
	['manhsung'] = {
	    {item = "clip", quantity = 10 },
		{item = "copper", quantity = 20},
	},
	
	-- Can be a weapon, must follow this format
	['WEAPON_ASSAULTRIFLE'] = { 
		{item = "diamond", quantity = 5 },
		{item = "gold", quantity = 5 },
		{item = "iron", quantity = 20 }, 
		{item = "copper", quantity = 20},
		{item = "manhsung", quantity = 30},
		{item = "clip", quantity = 1 },
	},
	
	['WEAPON_BULLPUPRIFLE'] = {
	    {item = "diamond", quantity = 80 },
		{item = "copper", quantity = 4200 },
		{item = "gold", quantity = 500 },
		{item = "iron", quantity = 1200 },
		{item = "packaged_plank", quantity = 1900 },
		{item = "bottle", quantity = 100 },
		{item = "manhsung", quantity = 50 },
		{item = "clip", quantity = 10 },
	},
		
	['WEAPON_ADVANCEDRIFLE'] = { 
		{item = "diamond", quantity = 5 },
		{item = "gold", quantity = 5 },
		{item = "iron", quantity = 20 }, 
		{item = "copper", quantity = 20},
		{item = "manhsung", quantity = 35},
		{item = "clip", quantity = 1 },
	},
	
	['WEAPON_COMPACTRIFLE'] = { 
		{item = "gold", quantity = 5 },
		{item = "diamond", quantity = 5 },
		{item = "iron", quantity = 35 }, 
		{item = "copper", quantity = 35},
		{item = "manhsung", quantity = 30},
		{item = "clip", quantity = 1 },
	},
	
	['WEAPON_APPISTOL'] = { 
		{item = "diamond", quantity = 10 },
		{item = "gold", quantity = 20 },
		{item = "clip", quantity = 10 },
		{item = "iron", quantity = 30 }, 
		{item = "copper", quantity = 40 },
		{item = "manhsung", quantity = 20 },
		{item = "bottle", quantity = 30 },
	},
	
	['WEAPON_ASSAULTSMG'] = { 
		{item = "diamond", quantity = 5 },
		{item = "gold", quantity = 5 },
		{item = "washed_stone", quantity = 2 },
		{item = "iron", quantity = 20 }, 
		{item = "copper", quantity = 20},
		{item = "manhsung", quantity = 25},
		{item = "clip", quantity = 1 },
	},
	
	['WEAPON_SMG'] = { 
		{item = "diamond", quantity = 10 },
		{item = "copper", quantity = 56 },
		{item = "gold", quantity = 21 },
		{item = "iron", quantity = 42 },
		{item = "packaged_plank", quantity = 100 },
		{item = "bottle", quantity = 50 },
		{item = "manhsung", quantity = 50 },
		{item = "clip", quantity = 10 },
	},
	
	['WEAPON_FIREWORK'] = { 
		{item = "thuocsung", quantity = 30 },
		{item = "iron", quantity = 50 },
		{item = "datlat", quantity = 20 }, 
		{item = "manhsung", quantity = 10},
	},
}

-- Enable a shop to access the crafting menu
Config.Shop = {
	useShop = true,
	shopCoordinates = { x=962.5, y=-1585.5, z=29.6 },
	shopName = "Chế tạo vật phẩm",
	shopBlipID = 588,
	zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
	zoneColor = { r = 255, g = 0, b = 0, a = 100 }
}

-- Enable crafting menu through a keyboard shortcut
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 303
}
