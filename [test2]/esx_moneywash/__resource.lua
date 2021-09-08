client_script '@lorraxsProtector/main.lua'
version '0.0.1'

server_scripts {

'@es_extended/locale.lua',
'locales/en.lua',
'config.lua',
'server/esx_wash_sv.lua'
}

client_scripts {
'@es_extended/locale.lua',
'locales/en.lua',
'config.lua',
'client/esx_wash_cl.lua'
}

ui_page 'html/ui.html'

files {
'html/ui.html',
'html/pdown.ttf',
'html/img/cursor.png',
'html/css/app.css',
'html/style.css',
'html/scripts/app.js',
'html/media/img/bg.png',
'html/media/img/circle.png',
'html/media/img/curve.png',
'html/media/img/fingerprint.png',
'html/media/img/fingerprint.jpg',
'html/media/img/graph.png',
'html/media/img/logo-big.png',
'html/media/img/logo-top.png'
}
