


resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
dependency 'ft_libs'
ui_page('html/index.html') 
files({
	'html/index.html',
	'html/script.js',
	'html/style.css',
	  'html/img/burger.png',
	  'html/img/bottle.png',
	'html/font/vibes.ttf',
	'html/img/box.png',
	  'html/img/carticon.png',
  })

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
	'config.lua',
	'version.lua',
}
client_script {
	'client.lua',
	'config.lua',
}
