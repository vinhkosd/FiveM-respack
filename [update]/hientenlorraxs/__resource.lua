client_script '@lorraxsProtector/main.lua'
resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
}

-- server scripts
server_scripts{ 

  "deathmessages-server.lua",

}

-- client scripts
client_scripts{

  "deathmessages-client.lua",

 }
 
