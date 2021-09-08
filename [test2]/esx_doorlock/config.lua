Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	--[[{
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 434.747, y = -980.618, z = 30.839},
		textCoords = {x = 434.747, y = -981.50, z = 31.50},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.5
	},

	{
		objName = 'v_ilev_ph_door002',
		objCoords  = {x = 434.747, y = -983.215, z = 30.839},
		textCoords = {x = 434.747, y = -982.50, z = 31.50},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.5
	},]]--

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objCoords  = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -984.050, z = 44.834},
		authorizedJobs = { 'police' },
		locked = true
	},

		-- Portão Mecanico
		{
			objName = 'lr_prop_supermod_door_01',
			objCoords  = {x = -205.27, y = -1310.39, z = 31.44},
			textCoords = {x = -205.67, y = -1310.69, z = 32.3},
			authorizedJobs = { 'mechanic' },
			locked = true
		},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 452.618, y = -982.702, z = 30.689},
		textCoords = {x = 453.079, y = -982.600, z = 31.739},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 447.238, y = -980.630, z = 30.689},
		textCoords = {x = 447.200, y = -980.010, z = 31.739},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 443.97, y = -989.033, z = 30.6896},
		textCoords = {x = 444.020, y = -989.445, z = 31.739},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4
	},

	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = {x = 445.37, y = -988.705, z = 30.6896},
		textCoords = {x = 445.350, y = -989.445, z = 31.739},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4
	},
	{
	    objName = 'prop_ld_jail_door',
		objCoords  = {x = 1455.43, y = 1132.98, z = 114.33},
		textCoords = {x = 1455.43, y = 1132.98, z = 114.33},
		authorizedJobs = { 'abatedor_1' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- 1
		objCoords  = {x = 1469.0, y = 1149.41, z = 114.33},
		textCoords = {x = 1468.40, y = 1150.10, z = 114.32},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- 2
		objCoords  = {x = 1460.14, y = 1144.92, z = 114.33},
		textCoords = {x = 1459.70, y = 1144.30, z = 114.33},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- 3
		objCoords  = {x = 1447.36, y = 1149.45, z = 114.33},
		textCoords = {x = 1446.90, y = 1149.90, z = 114.33},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- 4
		objCoords  = {x = 1442.91, y = 1159.46, z = 114.33},
		textCoords = {x = 1442.41, y = 1158.90, z = 114.33},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- 5
		objCoords  = {x = 1447.34, y = 1164.2,  z = 114.33},
		textCoords = {x = 1446.80, y = 1164.60,  z = 114.33},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- 6
		objCoords  = {x = 1469.08, y = 1164.19, z = 114.32},
		textCoords = {x = 1468.55, y = 1164.59, z = 114.32},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'prop_ld_jail_door', -- processamento de leite
		objCoords  = {x = 1460.67, y = 1046.32, z = 114.33},
		textCoords = {x = 1460.27, y = 1045.95, z = 114.30},
		authorizedJobs = { 'leiteiro' },
		locked = true,
		distance = 2
	},
	{
		objName = 'v_ilev_lostdoor',
		objCoords  = {x = 981.94, y = -102.99, z = 74.85},
		textCoords = {x = 981.64, y = -102.79, z = 75.25},
		authorizedJobs = { 'motoclub' },
		locked = true
	},

	-- 
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 463.815, y = -992.686, z = 24.9149},
		textCoords = {x = 463.30, y = -992.686, z = 25.10},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.381, y = -993.651, z = 24.914},
		textCoords = {x = 461.806, y = -993.308, z = 25.064},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.331, y = -998.152, z = 24.914},
		textCoords = {x = 461.806, y = -998.800, z = 25.064},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.704, y = -1001.92, z = 24.9149},
		textCoords = {x = 461.806, y = -1002.450, z = 25.064},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objCoords  = {x = 463.478, y = -1003.538, z = 25.005},
		textCoords = {x = 464.00, y = -1003.50, z = 25.50},
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 467.371, y = -1014.452, z = 26.536},
		textCoords = {x = 468.09, y = -1014.452, z = 27.1362},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4
	},

	{
		objName = 'v_ilev_rc_door2',
		objCoords  = {x = 469.967, y = -1014.452, z = 26.536},
		textCoords = {x = 469.35, y = -1014.452, z = 27.136},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objCoords  = {x = 488.894, y = -1017.210, z = 27.146},
		textCoords = {x = 488.894, y = -1020.210, z = 30.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objCoords  = {x = 1855.105, y = 3683.516, z = 34.266},
		textCoords = {x = 1855.105, y = 3683.516, z = 35.00},
		authorizedJobs = { 'police' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.14, y = 6015.685, z = 32.00},
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5
	},

	{
		objName = 'v_ilev_shrf2door',
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.951, y = 6016.622, z = 32.00},
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1844.998, y = 2604.810, z = 44.638},
		textCoords = {x = 1844.998, y = 2608.50, z = 48.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
		textCoords = {x = 420.133, y = -1021.00, z = 32.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}