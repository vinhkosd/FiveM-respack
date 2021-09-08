local type = {money=1,item=2,weapon=3} -- no touchey, thank you
Config = {}

Config.claimed = "~g~Bạn đã nhận được quà!"
Config.rewards = {
    {
        type = type.money,
        value = 100000
    },
    {
        type = type.item,
        item = "clip",
        count = 3
    },
    {
        type = type.item,
        item = "bread",
        count = 5
    },
    {
        type = type.weapon,
        weapon = "WEAPON_PISTOL", -- if they already have the weapon, they'll only get the ammo
        ammo = 100
    }
}

Config.random_rewards_enabled = true
Config.random_rewards = {
    {
        chance = 90, -- this can be any whole number (higher = better chance)
        {
            type = type.money,
            value = 10000
        },
        {
            type = type.money,
            value = 50000
        },
        {
            type = type.money,
            value = 25000
        }
    },
    {
        chance = 10,
        {
            type = type.item,
            item = "contract",
            count = 1
        },
		{
            type = type.item,
            item = "bulletproof",
            count = 2
        },
		{
            type = type.item,
            item = "clip",
            count = 2
        },
		{
            type = type.weapon,
            weapon = "WEAPON_PISTOL", -- if they already have the weapon, they'll only get the ammo
            ammo = 200
        }
    }
}