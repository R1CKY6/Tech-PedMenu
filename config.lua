Config = {}


Config.Key = 'F6'


Config.AdminGroup = 'admin'


Config.OnlyAdmin = true


Config.EnableCommand = true

Config.CommandName = 'setped'


Config.AlignMenu = 'top-left'

Config.Ped = {
    {
        label = "Franklin",
        model = "player_one",
        OnlyUser = {
            enable = false,
            discord = ""
        }
     },
     {
        label = "Trevor",
        model = "player_two",
        OnlyUser = {
            enable = false,
            discord = ""
        }
     },
     {
        label = "Michael",
        model = "player_zero",
        OnlyUser = {
            enable = true,
            discord = "638415863682170881"
        }
     },
}




Ricky_Lang = {
     ['title'] = "Ped Menu",
     ['reset_model'] = "Reset Model",
     ['error'] = "Error: Invalid Model or Player ID",
     ['no_permission'] = "You don't have permission to do this!",
     ['command_help'] = "Set ped to a specific player",
     ['chat_id'] = "ID",
     ['chat_model'] = "Model",
     ['chat_id_description'] = "Enter the player ID",
     ['chat_model_description'] = "Enter the model name",
}