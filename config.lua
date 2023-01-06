Tech = {}

Tech.GroupStaff = {
    'admin'
}

Tech.Command = {
    enable = true,
    name = 'setped',


    resetPed = {
        enable = true,
        name = 'resetped'
    },
    removePermanentPed = {
        enable = true,
        name = 'removeped'
    }
}

Tech.MenuPed = {
    enable = true,
    staffOnly = true,
    alignMenu = 'top-left',
    key = 'F6',
    ped = {
        {
            label = 'Franklin',
            model = 'player_one'
        },
        {
            label = 'Resetta Ped',
            model = 'resetped' -- Don't Edit
        },
    }
}


Tech.Lang = {
    ['title_menu'] = "Menu Ped",
    ['reset_ped'] = 'Resetta Ped',
    ['description_key'] = 'Apri Menu Ped',
    ['no_ped'] = 'Ped Inesistente',
    ['set_ped'] = 'Setta Ped',
    ['id'] = "ID",
    ['name_ped'] = 'Nome Ped',
    ['permanent'] = 'Permanente',
    ['name_ped_invalid'] = 'Inserisci il nome del ped!',
    ['id_invalid'] = 'Inserisci l\'ID del player!',
    ['player_offline'] = 'Utente Offline',
    ['command_help_reset'] = 'Resetta Ped di un Utente',
    ['command_help_permanent'] = 'Rimuovi Ped Permanente da un Utente',
    ['chat_id'] = 'ID',
    ['chat_id_description'] = "Inserisci l\'ID del player",
}
