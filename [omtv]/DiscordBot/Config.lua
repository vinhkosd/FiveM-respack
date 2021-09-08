DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/703491580450832425/NuueFsd0bW0DSF-tjWP5yqIFHnOgB9m-VT4-I9bzWEXDD6Uz-v_lbBcRw8N8bJcYcjB'
DiscordKhoiDongServer = 'https://discordapp.com/api/webhooks/703491580450832425/NuueFIG8sdW0DSF-tjWP5yqIFHnOgB9m-VT4-I9bzWEXDD6Uz-v_lbBcRw8N8bJcYcjB'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/703491421273063454/qxEvsNR5ThL0ZpIEaEdoPFDAq2o6vBSXbq1dbZl_12lnDCjL-gKDrn1-DpSIRRBpixK-'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/703491488402898955/9h9Yo4KrZmGzxDLeU3UFOs3O88A7NvTAWgHhs-v9pmgxAw9U6Lo93WPnvoDCdC3ih9rf'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://imgur.com/GHdqIkW.png'

SystemName = 'Server BOT'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/AnotherCommand', 'https://discordapp.com/api/webhooks/676723435910420484/vJww7Qf-t2kk5Ax1OwpxUR6QTxkUJtygxJIJQ5wDqP2R-AXDv-tj7CfOAJuEsIZpJBM1'},
					  {'/AnotherCommand2', 'https://discordapp.com/api/webhooks/676712335910420484/vJww7Qf-t2kk5Ax1OwpxUR6QTxkUJtygxJIJQ5wDqP2R-AXDv-tj7CfOAJuEsIZpJBM1'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

