local ESX = exports.es_extended:getSharedObject()


if Tech.MenuPed.enable then 
    RegisterKeyMapping('-+menuped', Tech.Lang['description_key'], 'keyboard', Tech.MenuPed.key)
    RegisterCommand('-+menuped', function(source, args, rawCommand)
        ESX.TriggerServerCallback('ricky:info', function(info)
            if Tech.MenuPed.staffOnly then 
                for k,v in pairs(Tech.GroupStaff) do 
                if info.gruppo == v then
                    MenuPed()
                end
            end
            else
                MenuPed()
            end
        end)
    end)
    TriggerEvent('chat:removeSuggestion', '/-+menuped')
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    ESX.TriggerServerCallback('ricky:info', function(info)
      if info.ped ~= nil then 
           SetPed(info.ped)
        return 
      end
    end)
end)


MenuPed = function()
   local elementi = Tech.MenuPed.ped
   ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_ped', {
   title    = Tech.Lang['title_menu'],
   align    = Tech.MenuPed.alignMenu,
   elements = Tech.MenuPed.ped
  }, function(data, menu)
    SetPed(data.current.model)
  end, function(data, menu)
      menu.close()
  end)
end

SetPed = function(model)
    if model == 'resetped' then 
        ResetPed()
        return 
    end
    if IsModelInCdimage(model) and IsModelValid(model) then
      RequestModel(model)
      while not HasModelLoaded(model) do
        Citizen.Wait(0)
      end
      SetPlayerModel(PlayerId(), model)
      SetModelAsNoLongerNeeded(model)
    else
        ESX.ShowNotification(Tech.Lang['no_ped'])
    end
end


ResetPed = function()
    local maschio = 'mp_m_freemode_01'
    local femmina = 'mp_f_reemode_01'
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then 
        RequestModel(maschio)
        while not HasModelLoaded(maschio) do
          Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), maschio)
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
          end)
      else
        RequestModel(femmina)
        while not HasModelLoaded(femmina) do
          Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), femmina)
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
          end)
      end
    end)
end

if Tech.Command.enable then 
 RegisterCommand(Tech.Command.name, function(source, args, rawCommand)
      local input = lib.inputDialog(Tech.Lang['set_ped'], {
        {type ="number", label = Tech.Lang['id']},
        {type ="input", placeholder = Tech.Lang['name_ped']},
        {type = "checkbox", label = Tech.Lang['permanent']}
      })
      if input then
        if input[1] == nil then  
            ESX.ShowNotificaion(Tech.Lang['id_invalid'])
            return
        elseif input[2] == nil then 
            ESX.ShowNotificaion(Tech.Lang['name_ped_invalid'])
            return
        else
            TriggerServerEvent('ricky:setPed', input[1], input[2], input[3])
        end
      end
 end)
end

if Tech.Command.removePermanentPed.enable then 
    RegisterCommand(Tech.Command.removePermanentPed.name, function(source, args, rawCommand)
        local id = args[1]
        TriggerServerEvent('ricky:removePermanentPed', id)
    end)

    TriggerEvent('chat:addSuggestion', '/'..Tech.Command.removePermanentPed.name, Tech.Lang['command_help_permanent'], {
        { name=Tech.Lang['chat_id'], help=Tech.Lang['chat_id_description'] },
    })
end


if Tech.Command.resetPed.enable then 
    RegisterCommand(Tech.Command.resetPed.name, function(source, args, rawCommand)
        local id = args[1]
        TriggerServerEvent('ricky:setPed', id, 'resetped', false)
    end)

    TriggerEvent('chat:addSuggestion', '/'..Tech.Command.resetPed.name, Tech.Lang['command_help_reset'], {
        { name=Tech.Lang['chat_id'], help=Tech.Lang['chat_id_description'] },
    })
end

RegisterNetEvent('ricky:setped')
AddEventHandler('ricky:setped', function(model)
  SetPed(model)
end)
RegisterNetEvent('ricky:resetped')
AddEventHandler('ricky:resetped', function()
  ResetPed()
end)

exports('SetPed', SetPed)
exports('ResetPed', ResetPed)
