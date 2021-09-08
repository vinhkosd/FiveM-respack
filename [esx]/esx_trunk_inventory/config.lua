local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.CheckOwnership = true -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = Keys["Y"]

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10

Config.localWeight = {
    alive_chicken           = 1000,
    slaughtered_chicken     = 1000,
    packaged_chicken        = 1000,
    fish                    = 1000,
    washedstones            = 1000,
    copper                  = 200,
    iron                    = 200,
    gold                    = 200,
    diamond                 = 200,
    wood                    = 1000,
    cutted_wood             = 1000,
    packaged_plank          = 250,
    petrol                  = 12000,
    petrol_raffin           = 12000,
    essence                 = 12000,
    wool                    = 1000,
    fabric                  = 500,
    clothe                  = 1000,
    water                   = 250,
    bread                   = 250,
    contrat                 = 1000,
    armor                   = 5000,
    cutting_pliers          = 500,
    handcuff                = 500,
    bandage                 = 500,
    medikit                 = 5000,
    weed                    = 2000,
    weed_pooch              = 6000,
    coke                    = 2000,
    coke_pooch              = 6000,
    meth                    = 2000,
    meth_pooch              = 6000,
    opium                   = 2000,
    opium_pooch             = 6000,
    meat                    = 1000,
    leather                 = 1000,
    firstaidkit             = 1500,
    defibrillateur          = 5000,
    gazbottle               = 500,
    fixtool                 = 5000,
    carotool                = 8000,
    blowpipe                = 1000,
    fixkit                  = 5000,
    carokit                 = 1000,
    fishbait                = 1000,
    fishingrod              = 3000,
    shark                   = 30000,
    turtle                  = 10000,
    turtlebait              = 1000,
    bangdan                 = 5000,
    pizza                   = 500,
    scratchoff              = 10,
    scratchoff_used         = 10,
    jewels                  = 2000,
    money                   = 10,
	black_money             = 10,
    stones                  = 1000,
    washedstones            = 1000,
    goban                   = 2000,
    goban_pooch             = 6000,
    cannabis                = 2000,
    marijuana               = 400,
    cup                     = 5000,
    thep                    = 1000,
    nhua                    = 1000,
    than                    = 1000,
    medikit                 = 5000,
    wine                    = 250,
    hifi                    = 5000



}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 50000, --Off-road
    [10] = 300000, --Industrial   --- xe 300 kg
    [11] = 300000, --Utility
    [12] = 100000, --Vans
    [13] = 0, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 30000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 30000, --Commercial
    [21] = 50000 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
