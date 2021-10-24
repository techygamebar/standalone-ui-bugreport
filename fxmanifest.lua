fx_version 'bodacious'
game 'gta5'
description 'Bug Report Center'
version '1.0.1'
url "https://github.com/AsepctDEVS"
ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/script.js",
    "ui/style.css",
}

server_scripts { 
    'server.lua',
    'config.lua'
    }
client_script 'client.lua'
