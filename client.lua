ESX = exports.es_extended.getSharedObject()
local idDiscord = nil

RegisterKeyMapping('pedmenu', 'Apri Menu Ped', 'keyboard', Config.Key)



RegisterCommand('pedmenu', function()
    if Config.OnlyAdmin then
    ESX.TriggerServerCallback('ricky:checkadmin', function(Group)
        if Group == Config.AdminGroup then
    ApriMenu()
        end
      end)
    else
        ApriMenu()
    end
end)

TriggerEvent('chat:addSuggestion', '/'..Config.CommandName, Ricky_Lang['command_help'], {
    { name=Ricky_Lang['chat_id'], help=Ricky_Lang['chat_id_description'] },
    { name=Ricky_Lang['chat_model'], help=Ricky_Lang['chat_model_description'] }
})


TriggerEvent('chat:removeSuggestion', '/pedmenu')




ApriMenu = function()
        local elements = {}
        ESX.TriggerServerCallback('ricky:getDiscordId', function(discordId)
            idDiscord = discordId
        end)
        for k,v in pairs(Config.Ped) do
                Wait(40)
              if v.OnlyUser.enable and v.OnlyUser.discord == idDiscord then
                table.insert(elements, {
                    label = v.label,
                    model = v.model
                })
            end
    if not v.OnlyUser.enable then      
            table.insert(elements, {
                label = v.label,
                model = v.model
            })
        end
    end
    table.insert(elements, {
        label = Ricky_Lang['reset_model'],
        value = 'reset_model'
    })
        ESX.UI.Menu.Open('default',GetCurrentResourceName(), 'ped_menu4',
        { 
        title = Ricky_Lang['title'], 
        align = Config.AlignMenu, 
        elements = elements 
        }, function(data, menu)
        local model = data.current.model
        local value = data.current.value
        SetPed(model)
        if value == 'reset_model' then
            ResetPed()
        end
        end, function(data, menu) 
        menu.close() 
        end)
end

SetPed = function(model)
    model = GetHashKey(model)


    ESX.Streaming.RequestModel(model, function()
        SetPlayerModel(PlayerId(), model)
    end)
end


ResetPed = function()
  local MalePed = 'mp_m_freemode_01'
  local FemalePed = 'mp_f_freemode_01'

  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
	ESX.Streaming.RequestModel(MalePed, function()
		SetPlayerModel(PlayerId(), MalePed)
		TriggerEvent('skinchanger:loadSkin', {sex = 0})

          end)
    else
            ESX.Streaming.RequestModel(FemalePed, function()
            SetPlayerModel(PlayerId(), FemalePed)
            TriggerEvent('skinchanger:loadSkin', {sex = 1})
        end) 
      end
	end)
end



Staff = function()
    ESX.TriggerServerCallback('ricky:checkadminpedmenu', function(Group)
        if Group == Config.AdminGroup then
            return true
        else
            return false
        end
    end)
end

exports('SetPed', SetPed)

RegisterNetEvent('ricky:setped')
AddEventHandler('ricky:setped', function(model)
    SetPed(model)
end)

