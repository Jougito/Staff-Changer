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
            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7" .. _U('group_not_found')}, color = Color.Staff })
        end
        Update = UpdateIdentity(uID, nGroup)
        if Update == 1 then
            if Config.aSystem == 'es_admin' then
                TriggerClientEvent('es_admin:setGroup', uID, nGroup)
            elseif Config.aSystem == 'kc_admin' then
                TriggerClientEvent("kc_admin:get_group", uID, nGroup)
            end
            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7" .. _U('enable_permissions') }, color = Color.Staff })
            TriggerClientEvent('sc:Print', uID, nGroup)
        elseif Update == 0 then
            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7" .. _U('error_enable_permissions') }, color = Color.Staff })
            TriggerClientEvent('sc:Print', uID, uGroup.group)
        end
    elseif uGroup.group ~= 'user' then
        Update = UpdateIdentity(uID, 'user')
        if Update == 1 then
            if Config.aSystem == 'es_admin' then
                TriggerClientEvent('es_admin:setGroup', uID, 'user')
            elseif Config.aSystem == 'kc_admin' then
                TriggerClientEvent("kc_admin:get_group", uID, 'user')
            end
            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7" .. _U('disable_permissions') }, color = Color.Staff })
            TriggerClientEvent('sc:Print', uID, 'user')
        elseif Update == 0 then
            TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7" .. _U('error_disable_permissions') }, color = Color.Staff })
            TriggerClientEvent('sc:Print', uID, uGroup.group)
        end
    else
        TriggerClientEvent('chat:addMessage', uID, { args = { "[".. Label.Staff .."]", "^7" .. _U('insufficient_permissions') }, color = Color.Staff })
        TriggerClientEvent('sc:Print', uID, uGroup.group)
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

local CurrentVersion = '1.0.2'
local GithubResourceName = 'Staff-Changer'

PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
    PerformHttpRequest('https://raw.githubusercontent.com/Jougito/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGELOG', function(Error, Changes, Header)
        print('^0')
        print('^6[Staff Changer]^0 Checking for updates...')
        print('^0')
        print('^6[Staff Changer]^0 Current version: ^5' .. CurrentVersion .. '^0')
        print('^6[Staff Changer]^0 Updater version: ^5' .. NewestVersion .. '^0')
        print('^0')
        if CurrentVersion ~= NewestVersion then
            print('^6[Staff Changer]^0 Your script is ^8outdated^0!')
            print('^0')
            print('^6[Staff Changer] ^3CHANGELOG ^5' .. NewestVersion .. ':^0')
            print('^3')
            print(Changes)
            print('^0')
            print('^6[Staff Changer]^0 You ^8are not^0 running the newest stable version of ^5Staff Changer^0. Please update: https://github.com/Jougito/Staff-Changer')
        else
            print('^6[Staff Changer]^0 Your script is ^2up to update^0')
        end
        print('^0')
    end)
end)
