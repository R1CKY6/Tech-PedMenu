fx_version 'cerulean'
lua54 'yes' 
game 'gta5' 

author 'R1CKY®#2220'
description 'Tech Dev. | Sistema Ped'
version '1.0'


client_scripts {
    'client.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}
server_scripts {
   '@mysql-async/lib/MySQL.lua',
    'server.lua'
}
