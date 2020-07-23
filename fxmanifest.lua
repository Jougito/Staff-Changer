fx_version 'adamant'

game 'gta5'

author 'Jougito'

description 'Sistema para activar y desactivar el estatus de staff'

version '1.0.2'

client_scripts {
    'locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'config.lua',
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'locale.lua',
    'locales/es.lua',
    'locales/en.lua',
    'config.lua',
    'server/main.lua'
}
