--------------------------------
-- Cambio del status de staff --
--         por Jougito        --
--------------------------------

RegisterCommand(Config.Command, function(source, args, rawCommand)

    local uID = source
    local uGroup = GetIdentity(uID)
    local Update = nil
    local nGroup = nil

    if uGroup.group == 'user' and uGroup.permission > 0 then
        if uGroup.permission == 1 then
            nGroup = 'helper'
        elseif uGroup.permission == 2 then
            nGroup = 'mod'
        elseif uGroup.permission == 3 then
            nGroup = 'admin'
        elseif uGroup.permission == 4 then
            nGroup = 'superadmin'
        else
            nGroup = 'user'
            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7No se ha encontrado el grupo" }, color = Color.Staff })
        end
        TriggerEvent("es:setPlayerData", uID, "group", nGroup, function(response, success)
            Update = UpdateIdentity(uID, nGroup)
            if Update == 1 then
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7Activado permisos de staff" }, color = Color.Staff })
                TriggerClientEvent('sc:Print', uID, nGroup)
            elseif Update == 0 then
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7No se ha podido activar los permisos" }, color = Color.Staff })
                TriggerClientEvent('sc:Print', uID, 'No modificado')
            end
        end)
    elseif uGroup.group ~= 'user' then
        TriggerEvent("es:setPlayerData", uID, "group", 'user', function(response, success)
            Update = UpdateIdentity(uID, 'user')
            if Update == 1 then
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7Desactivado permisos de staff" }, color = Color.Staff })
                TriggerClientEvent('sc:Print', uID, 'user')
            elseif Update == 0 then
                TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7No se ha podido desactivar los permisos" }, color = Color.Staff })
                TriggerClientEvent('sc:Print', uID, 'No modificado')
            end
        end)
    else
        TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7No tienes permisos para usar ese comando" }, color = Color.Staff })
        TriggerClientEvent('sc:Print', uID, 'No modificado')
    end

end, false)

-- Funciones

function GetIdentity(source)

    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
    
    if result[1] ~= nil then
    
        local identity = result[1]

        return {
            identifier = identity['identifier'],
            name = identity['name'],
            firstname = identity['firstname'],
            lastname = identity['lastname'],
            dateofbirth = identity['dateofbirth'],
            sex = identity['sex'],
            height = identity['height'],
            job = identity['job'],
            permission = identity['permission_level'],
            group = identity['group']
        }
    else
        return nil
    end
end

function UpdateIdentity(source, group)

    local identifier = GetPlayerIdentifiers(source)[1]
    local result = MySQL.Sync.fetchAll("UPDATE users SET `group` = @group WHERE identifier = @identifier", {['@group'] = group, ['@identifier'] = identifier})
    
    if result then
        return 1
    else
        return 0
    end
end

-- Version Checking - DON'T TOUCH THIS

local CurrentVersion = '1.0.0'
local GithubResourceName = 'Staff-Changer'

PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
    PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGELOG', function(Error, Changes, Header)
        print('\n')
        print('[Staff Changer] Checking for updates...')
        print('')
        print('[Staff Changer] Current version: ' .. CurrentVersion)
        print('[Staff Changer] Updater version: ' .. NewestVersion)
        print('')
        if CurrentVersion ~= NewestVersion then
            print('[Staff Changer] Your script is outdated!')
            print('')
            print('[Staff Changer] CHANGELOG ' .. NewestVersion .. ':')
            print('')
            print(Changes)
            print('')
            print('[Staff Changer] You are not running the newest stable version of Staff Changer. Please update: https://github.com/Jougito/Staff-Changer')
        else
            print('[Staff Changer] Your script is up-to-update')
        end
        print('\n')
    end)
end)
