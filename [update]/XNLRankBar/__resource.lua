client_script '@lorraxsProtector/main.lua'
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}


export 'Exp_XNL_SetInitialXPLevels'
export 'Exp_XNL_AddPlayerXP'
export 'Exp_XNL_RemovePlayerXP'
export 'Exp_XNL_GetCurrentPlayerXP'
export 'Exp_XNL_GetLevelFromXP'
export 'Exp_XNL_GetCurrentPlayer'
export 'Exp_XNL_GetCurrentPlayerLevel'




