local ESX = exports.es_extended:getSharedObject()


ESX.RegisterServerCallback('ricky:info', function(source,cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  local result =  MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = xPlayer.identifier,
  })

  local info = {
    gruppo = xPlayer.getGroup(),
    ped = result[1].ped
  }
  cb(info)
end)


RegisterServerEvent('ricky:setPed')
AddEventHandler('ricky:setPed', function(id,model,permanent)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(id)

    if target == nil then 
        xPlayer.showNotification(Tech.Lang['player_offline'])
        return 
    end

TriggerClientEvent('ricky:setped', id, model)

if permanent then 
    MySQL.Sync.execute("UPDATE users SET ped = @ped WHERE identifier = @identifier", {
        ['@identifier'] = target.identifier,
        ['@ped'] = model
    })
end
end)

RegisterServerEvent('ricky:removePermanentPed')
AddEventHandler('ricky:removePermanentPed', function(id)
  local xPlayer = ESX.GetPlayerFromId(source)
  local target = ESX.GetPlayerFromId(id)

  if target == nil then 
      xPlayer.showNotification(Tech.Lang['player_offline'])
      return 
  end

  MySQL.Sync.execute("UPDATE users SET ped = @ped WHERE identifier = @identifier", {
    ['@identifier'] = target.identifier,
    ['@ped'] = nil
})
end)


SetPed = function(source, model)
  TriggerClientEvent('ricky:setped', source, model)
end

ResetPed = function(source)
  TriggerClientEvent('ricky:setped', source)
end

exports('SetPed', SetPed)
exports('ResetPed', ResetPed)
