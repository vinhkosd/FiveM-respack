--[[
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Scoreboard'

version '1.0.0'



client_script {
				'config.lua',
				'client.lua'}


server_script {
'@async/async.lua',
'@mysql-async/lib/MySQL.lua',
'config.lua',
'server.lua',
}

ui_page 'html/quayso.html'

files {
	'html/quayso.html',
	'html/config.js',
	'html/jquery.min.js',
	'html/app.js',
	'html/style.css',
	'html/imgs/vongquay.png',
	'html/imgs/lorraxs.png',
	'html/imgs/stop.png',
	'html/imgs/start.png',
	

	
	
}