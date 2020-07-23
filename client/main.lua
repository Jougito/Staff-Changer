--------------------------------
-- Cambio del status de staff --
--         por Jougito        --
--------------------------------

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/' .. Config.Command, _U('command_suggestion'))
end)

RegisterNetEvent('sc:Print')
AddEventHandler('sc:Print', function(uGroup)

    print('^3' .. _U('group_set') .. ': ^5' .. uGroup .. '^0')

end)
