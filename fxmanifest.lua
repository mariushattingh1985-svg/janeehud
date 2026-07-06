fx_version 'cerulean'
game 'gta5'

author 'Janee HUD'
description 'Advanced QB-HUD System'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua',
    'client/events.lua',
}

server_scripts {
    'server/main.lua',
    'server/events.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/app.js',
    'html/js/hud.js',
}

exports {
    'ShowHud',
    'HideHud',
    'UpdateHud',
    'SetHealth',
    'SetArmor',
    'SetHunger',
    'SetThirst',
    'SetStress',
}

dependencies {
    'qb-core',
}
