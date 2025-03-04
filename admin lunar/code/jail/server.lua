jail = {}
playerInjail = {}
local antispamJail = {}

Callback.registerServerCallback('Ins:getJail', function(source)
    return {jail[InsHelper:getIdentifier(source)]}
end) -- by ins

RegisterNetEvent('Ins:updatejailTime')
AddEventHandler('Ins:updatejailTime', function()
    local _src = source
    if jail[InsHelper:getIdentifier(_src)] then
        local time = tonumber(jail[InsHelper:getIdentifier(_src)].time)
        local result = time - 60.0

        if not antispamJail['id:'.._src] then
            antispamJail['id:'.._src] = true
            Citizen.SetTimeout(56000, function() antispamJail['id:'.._src] = nil end) -- by ins
        else
            DropPlayer(source, "InsShield : Tentative de triche (bypass trigger : \"InsAdmin:updatejailTime\")")
        end

        if 60.0 >= result then
            jail[InsHelper:getIdentifier(_src)] = nil 
            local identifier = InsHelper:getIdentifier(_src)
            MySQL.Async.execute('DELETE FROM Ins_jail WHERE identifier = @identifier', {
                ['@identifier'] = identifier,
            }, function(rowsChanged)
                InsHelper:serverNotification(_src, '~g~Vous êtes sorti de jail !')
                print('^0[^2!^0] ^2server.lua ^0=> Le joueur ^4'..InsHelper:getPlayerName(_src)..'^0 vient de ^1sortir^0 de jail')
                TriggerClientEvent('Ins:finishjailTime', _src)
            end) -- by ins
        else
            MySQL.Async.execute('UPDATE Ins_jail SET time = @time WHERE identifier = @identifier', {
                ['@time'] = ""..result.."",
                ['@identifier'] = InsHelper:getIdentifier(_src),
            })
        end
    end
end) -- by ins

RegisterCommand('unjail', function(source, arg)
    local _src = source
    local idPlayer = tonumber(arg[1])
    if source == 0 then
        if idPlayer then
            local xTarget = InsHelper:getPlayerFromId(idPlayer)
            if xTarget then
                local identifier = InsHelper:getIdentifier(xTarget.source)
                if jail[identifier] then
                    jail[identifier] = nil
                    TriggerClientEvent('Ins:finishjailTime', idPlayer)
                    InsHelper:serverNotification(idPlayer, '~g~Vous avez été unjail par '..GetPlayerName(idPlayer)..' !')
                    MySQL.Async.execute('DELETE FROM Ins_jail WHERE identifier = @identifier', {
                        ['@identifier'] = InsHelper:getIdentifier(xTarget.source),
                    })
                else
                    print('^2La personne n\'est pas en jail !')
                end
            else
                print('^2Ce joueur n\'est pas connecté !')
            end
        else
            print('^2Précisez l\'ID de la personne a unjail !')
        end
    else
        local xPlayer = InsHelper:getPlayerFromId(source)
        if xPlayer then
            local permission = exports.InsAdmin:checkAcces(source, 'jail')
            if permission then
                local idPlayer = tonumber(arg[1])

                local xTarget = InsHelper:getPlayerFromId(idPlayer)
                if xTarget then
                    local identifier = InsHelper:getIdentifier(xTarget.source)
                    if jail[identifier] then
                        jail[identifier] = nil
                        TriggerClientEvent('Ins:finishjailTime', idPlayer)
                        InsHelper:serverNotification(idPlayer, '~g~Vous avez été unjail par '..GetPlayerName(idPlayer)..' !')
                        MySQL.Async.execute('DELETE FROM Ins_jail WHERE identifier = @identifier', {
                            ['@identifier'] = InsHelper:getIdentifier(xTarget.source),
                        })
                        InsHelper:serverNotification(xPlayer.source, '~g~Le joueur a été unjail !')
                    else
                        InsHelper:serverNotification(xPlayer.source, '~r~La personne n\'est pas en jail !')
                    end
                else
                    InsHelper:serverNotification(xPlayer.source, '~r~Ce joueur n\'est pas connecté !')
                end
            else
                InsHelper:serverNotification(xPlayer.source, '~r~Tu n\'as pas la permission !')
            end
        end
    end
end) -- by ins

RegisterCommand('jail', function(source, arg)
    local _src = source
    if source == 0 then
        local idPlayer = tonumber(arg[1])
        local xTarget = InsHelper:getPlayerFromId(idPlayer)
        local time = tonumber(arg[2])
        local raison = table.concat(arg, ' ', 3)
        if xTarget then
            if time then
                local date = os.date("%d")..'/'..os.date("%m")..'/'..os.date("%Y")..' à '..os.date("%H")..'h'..os.date("%M")..' et '..os.date("%S")..' secondes'
                if raison then
                    setInJail(_src, xTarget, 'Console', time * 60, date, raison)
                else
                    setInJail(_src, xTarget, 'Console', time * 60, date, 'Aucune raison indiqué')
                end
            else
                print('^2Veuillez préciser un temps en minute')
            end
        else
            print('^2Ce joueur n\'est pas connecté !')
        end
    else
        local xPlayer = InsHelper:getPlayerFromId(source)
        if PlayersRanks[InsHelper:getIdentifier(xPlayer.source)] then
            local idPlayer = tonumber(arg[1])
            local xTarget = InsHelper:getPlayerFromId(idPlayer)
            local time = tonumber(arg[2])
            local raison = table.concat(arg, ' ', 3)
            if xTarget then
                if time then
                    local date = os.date("%d")..'/'..os.date("%m")..'/'..os.date("%Y")..' à '..os.date("%H")..'h'..os.date("%M")..' et '..os.date("%S")..' secondes'
                    if raison then
                        setInJail(_src, xTarget, InsHelper:getPlayerName(xPlayer.source), time * 60, date, raison)
                    else
                        setInJail(_src, xTarget, InsHelper:getPlayerName(xPlayer.source), time * 60, date, 'Aucune raison indiqué')
                    end
                else
                    InsHelper:serverNotification(xPlayer.source, '~r~Veuillez préciser un temps en minute')
                end
            else
                InsHelper:serverNotification(xPlayer.source, '~r~Ce joueur n\'est pas connecté !')
            end
        else
            InsHelper:serverNotification(xPlayer.source, '~r~Tu n\'as pas la permission !')
        end
    end
end) -- by ins

function setInJail(src, xTargett, staffName, time, date, raison)
    local xTarget = xTargett
    local identifier = InsHelper:getIdentifier(xTarget.source)
    if jail[identifier] then
        if src == 0 then
            print('^2Ce joueur été déjà en jail ! Son temps de jail a été mis a jour')
        else
            InsHelper:serverNotification(src, '~r~Ce joueur été déjà en jail ! Son temps de jail a été mis a jour')
        end
    end
    jail[identifier] = {
        identifier = identifier,
        staffName = staffName,
        time = time,
        date = date,
        raison = raison,
    }
    TriggerClientEvent('Ins:SendClientToJail', xTarget.source, jail[identifier])
    MySQL.Async.execute('INSERT INTO Ins_jail (identifier, staffName, time, date, raison) VALUES (@identifier, @staffName, @time, @date, @raison)', {
        ['@identifier'] = jail[identifier].identifier,
        ['@staffName'] = jail[identifier].staffName,
        ['@time'] = jail[identifier].time,
        ['@date'] = jail[identifier].date,
        ['@raison'] = jail[identifier].raison,
    })
    print('^0[^2!^0] ^2server.lua ^0=> Le joueur ^4'..InsHelper:getPlayerName(xTarget.source)..'^0 a été mis en jail par ^1'..InsHelper:getPlayerName(src))
    if src == 0 then
        print('^2Le joueur est désormais en jail')
    else
        InsHelper:serverNotification(src, '~g~Le joueur est désormais en jail')
    end
end

function loadJail()
    MySQL.Async.fetchAll('SELECT * FROM Ins_jail', {}, function(results)
        print('^0[^2!^0] ^2server.lua ^0=> La base de données a enregistré ^3' .. #results .. ' ^0personnes actuellement en jail')
		for k, v in pairs(results) do
            jail[v.identifier] = {
                identifier = v.identifier,
                staffName = InsHelper:getTextFromAscii(v.staffName),
                time = v.time,
                date = v.date,
                raison = v.raison,
            }
        end
    end) -- by ins
end

MySQL.ready(function()
    loadJail()
end) -- by ins