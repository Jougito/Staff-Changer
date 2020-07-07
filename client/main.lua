--------------------------------
-- Cambio del status de staff --
--         por Jougito        --
--------------------------------

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/' .. Config.Command, 'Cambia el status de staff')
end)

RegisterNetEvent('sc:Print')
AddEventHandler('sc:Print', function(uGroup)

    print('Grupo establecido: ' .. uGroup)

end)
