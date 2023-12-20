fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0.1'
author 'Anto Orza#6115'
description 'Z- Xmas Gift / Reward'

ui_page 'menu.html'

client_script 'client/client.lua'

server_script 'server/server.lua'

files {
    'menu.html',
    'assets/gift.png',
    'assets/xmas.mp3',
    'assets/christmaseve.ttf',
    'assets/snowfl.png',
}

shared_script {
    '@es_extended/imports.lua',
    'config.lua',
}

dependency 'es_extended'