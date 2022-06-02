ESX = exports.es_extended.getSharedObject()


SetPed = function(id, model) 
  TriggerClientEvent('ricky:setped', id, model)
end


exports('SetPed', SetPed)


ESX.RegisterServerCallback('ricky:getDiscordId', function(source, cb) 
  local discordId = false
  for k,v in pairs(GetPlayerIdentifiers(source))do
    if string.sub(v, 1, string.len("discord:")) == "discord:" then
      discordId = v:gsub("discord:", "")
    end
  end
  cb(discordId)
end)



ESX.RegisterServerCallback('ricky:checkadmin', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Group = xPlayer.getGroup()
  cb(Group)
end)

  

if Config.EnableCommand then
RegisterCommand(Config.CommandName, function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Target = ESX.GetPlayerFromId(args[1])
    local Group = xPlayer.getGroup()
    local Id = tonumber(args[1])
    local Model = args[2]

    if Group == Config.AdminGroup then
        if Target then
          SetPed(Id, Model)
        else
            xPlayer.showNotification(Ricky_Lang['error'])
        end
      else
        xPlayer.showNotification(Ricky_Lang['no_permission'])
    end
end)
end
