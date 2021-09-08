Config = {}

Config.Locale = 'br'

Config.serverLogo = ''

Config.font = {
	name 	= 'Oswald',
	url 	= 'https://fonts.googleapis.com/css?family=Oswald:300,400,700,900&display=swap'
}

Config.date = {
	format	 	= 'default',
	AmPm		= false
}





Config.voice = {

	levels = {
		default = 5.0,
		shout = 12.0,
		whisper = 1.0,
		current = 0
	},
	
	keys = {
		distance 	= 'Y', -- HOME
	}
}






Config.vehicle = {
	speedUnit = 'KMH', -- KMH or MPH
	maxSpeed = 240,

	useLegacyFuel = false, -- if you use the LegacyFuel script, set this  to true. If not, set to false

	seatbelt = {
		playBuckleSound 	= true,
		playUnbuckleSound 	= true,
		playUnsafeSound 	= true
	},

	keys = {
		seatbelt 	= 'B', -- G
		cruiser		= 'CAPS', -- CAPS
		signalLeft	= 'LEFT', -- Arrow Left
		signalRight	= 'RIGHT', -- Arrow Right
		signalBoth	= 'DOWN', -- Arrow Down
	}
}






Config.ui = {
	showJob		 		= true,

	showWalletMoney 	= true,
	showBankMoney 		= true,
	showBlackMoney 		= true,
	showSocietyMoney	= true,

	showDate 			= false,
	showLocation 		= false,

	showHealth			= true,
	showArmor	 		= true,
	showStamina	 		= true,
	showHunger 			= true,
	showThirst	 		= true,

	showMinimap			= true,

	showVoice	 		= false
}