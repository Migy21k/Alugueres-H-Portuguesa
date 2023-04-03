fx_version "adamant"
game "gta5"

author "Migy21k"
description "Alugueres há Portuguesa"

client_scripts {
    'client/main.lua'

}

server_scripts {
    "server/*.lua"
}

ui_page {
    "html/index.html"
}

files {
    'html/index.html',
    'html/script.js',
    'html/index2.js',
    'html/style.css',
    'html/img/*.png'
}

shared_scripts {
    "config.lua"
}

