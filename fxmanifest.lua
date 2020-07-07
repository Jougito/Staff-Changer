fx_version 'adamant'

game 'gta5'

author 'Jougito'

description 'Sistema para activar y desactivar el estatus de staff'

version '1.0.0'

client_scripts {
    'config.lua',
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}
