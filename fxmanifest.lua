fx_version 'cerulean'
game 'gta5'

author 'Professional HUD'
description 'Modern QB-HUD System - Production Ready'
version '2.0.0'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/app.js',
}

exports {
    'ShowHud',
    'HideHud',
    'UpdateHud',
}

dependencies {
    'qb-core',
}
