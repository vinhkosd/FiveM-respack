client_script '@lorraxsProtector/main.lua'
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Animations'

version '1.0.0'

files {
	'img/header/animations.jpg'
}

client_scripts {
	'config.lua',
	'client/main.lua',
	'@NativeUI/NativeUI.lua'
}

exports {
  'openAnimations'
}