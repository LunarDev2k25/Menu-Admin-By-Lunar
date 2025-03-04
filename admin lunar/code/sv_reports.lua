Reports = {}
ReportsSessionId = 0
ReportsInfos = {
    Active = 0,
    Taked = 0,
    Finish = 0,
}

Callback.registerServerCallback('Ins:getReportList', function(source)
    return {Reports}
end) -- by ins

RegisterCommand('report', function(source, args)
    local _src = source 
    local argument = table.concat(args, ' ', 1)
    local xPlayer = InsHelper:getPlayerFromId(_src)

    if _src == 0 then
        print(' ')
        print('Voici l\'état des reports actuellement :')
        print('Reports actif : '..ReportsInfos.Active)
        print('Reports en attente : '..ReportsInfos.Active - ReportsInfos.Taked.. '')
        print('Reports pris en charge : '..ReportsInfos.Taked)
        print('Reports terminé : '..ReportsInfos.Finish)
        print(' ')
    else
        if Reports[source] then
            InsHelper:serverNotification(xPlayer.source, '~r~Vous avez déjà un report actif')
            return
        else
            if argument == '' then
                if InsConfig.ReportRaison then
                    InsHelper:serverNotification(xPlayer.source, '~r~Vous devez indiquer une raison')
                    return
                else
                    argument = 'Aucune raison fournis'
                end
            end
            ReportsSessionId = ReportsSessionId + 1 
            local players = {}
            local xPlayers = ESX.GetPlayers()
            
            if PlayersRanks[InsHelper:getIdentifier(xPlayer.source)] then
                Reports[source] = {
                    date = os.date("%d")..'/'..os.date("%m")..'/'..os.date("%Y")..' à '..os.date("%H")..'h'..os.date("%M")..' et '..os.date("%S")..' secondes',
                    heure = os.date("%H")..'h'..os.date("%M")..' et '..os.date("%S")..' secondes',
                    uid = UID:getUIDfromID(_src),
                    source = _src,
                    name = GetPlayerName(_src),
                    rank = PlayersRanks[InsHelper:getIdentifier(xPlayer.source)].rank,
                    job1 = InsHelper:getJob(xPlayer.source).name,
                    job2 = InsHelper:getJob2(xPlayer.source).name,
                    rankName = PlayersRanks[InsHelper:getIdentifier(xPlayer.source)].rank,
                    rankLabel = '['..RanksList[PlayersRanks[InsHelper:getIdentifier(xPlayer.source)].rank].label..']',
                    rankColor = RanksList[PlayersRanks[InsHelper:getIdentifier(xPlayer.source)].rank].color,
                    rankPower = RanksList[PlayersRanks[InsHelper:getIdentifier(xPlayer.source)].rank].power,
                    raison = argument,
                    state = 'waiting',
                    takedBy = '?',
                    id = ReportsSessionId,
                }
            else
                Reports[source] = {
                    date = os.date("%d")..'/'..os.date("%m")..'/'..os.date("%Y")..' à '..os.date("%H")..'h'..os.date("%M")..' et '..os.date("%S")..' secondes',
                    heure = os.date("%H")..'h'..os.date("%M")..' et '..os.date("%S")..' secondes',
                    uid = UID:getUIDfromID(_src),
                    source = _src,
                    name = GetPlayerName(_src),
                    rank = 'Joueur',
                    job1 = InsHelper:getJob(xPlayer.source).name,
                    job2 = InsHelper:getJob2(xPlayer.source).name,
                    rankName = 'Joueur',
                    rankLabel = '[ Joueur ]',
                    rankColor = '~s~',
                    rankPower = 0,
                    raison = argument,
                    state = 'waiting',
                    takedBy = '?',
                    id = ReportsSessionId,
                }
            end

            local embed = {
                title = 'Création d\'un report',
                description = 'Le joueur `'..GetPlayerName(_src)..'` (ID : `'.._src..'` | UID : `'..UID:getUIDfromID(_src)..'`) vient de faire un report (Report n°`'..ReportsSessionId..'`)\nRaison du report : `'..argument..'`',
                color = 16777215,
                webhook = 'report',
            }

            InsHelper:sendWebhook(embed)

            InsHelper:serverNotification(xPlayer.source, '~g~Votre report a été envoyé !')

            for i=1, #xPlayers, 1 do
                local xPlayerS = InsHelper:getPlayerFromId(xPlayers[i])
                if xPlayerS then
                    if PlayersRanks[InsHelper:getIdentifier(xPlayerS.source)] then
                        InsHelper:serverNotification(xPlayerS.source, '~g~Un report vient d\'arriver ('..ReportsSessionId..') !')
                        TriggerClientEvent('Ins:ReceiveReportsList', xPlayerS.source, Reports)
                    end
                end
            end
        end
    end
end) -- by ins

RegisterServerEvent('Ins:updateReport')
AddEventHandler('Ins:updateReport', function(action, s)
    local xPlayer = InsHelper:getPlayerFromId(source)
    if PlayersRanks[InsHelper:getIdentifier(xPlayer.source)] then

        local players = {}
        local xPlayers = ESX.GetPlayers()

        if action == 'taked' then
            local embed = {
                title = 'Prise en charge d\'un report',
                description = 'Le joueur `'..GetPlayerName(source)..'` (ID : `'..source..'` | UID : `'..UID:getUIDfromID(source)..'`) vient de prendre en charge un report (Report n°`'..s.id..'`)\nRaison du report : `'..s.raison..'`',
                color = 4838724,
                webhook = 'report',
            }

            InsHelper:sendWebhook(embed)

            Reports[s.source].state = 'taked'
            Reports[s.source].takedBy = GetPlayerName(source)

            InsHelper:serverNotification(s.source, '~g~Report pris en charge par '..GetPlayerName(source)..' !')
            for i=1, #xPlayers, 1 do
                local xPlayerS = InsHelper:getPlayerFromId(xPlayers[i])
                if xPlayerS then
                    if PlayersRanks[InsHelper:getIdentifier(xPlayerS.source)] then
                        InsHelper:serverNotification(xPlayerS.source, '~g~Le staff '..GetPlayerName(source)..' a pris le report n°'..s.id..' en charge !')
                        TriggerClientEvent('Ins:ReceiveReportsList', xPlayerS.source, Reports)
                    end
                end
            end
        elseif action == 'finish' then
            local embed = {
                title = 'Fermeture d\'un report',
                description = 'Le joueur `'..GetPlayerName(source)..'` (ID : `'..source..'` | UID : `'..UID:getUIDfromID(source)..'`) vient de fermer un report (Report n°`'..s.id..'`)\nRaison du report : `'..s.raison..'`',
                color = 13976644,
                webhook = 'report',
            }

            InsHelper:sendWebhook(embed)

            local id = s.id
            Reports[s.source] = nil
            InsHelper:serverNotification(s.source, '~g~Report cloturé par '..GetPlayerName(source)..' !')
            antiCheatAvis['id:'..s.source] = InsHelper:getIdentifier(xPlayer.source)

            -- print('InsHelper:getIdentifier(xPlayer.source)', InsHelper:getIdentifier(xPlayer.source))
            -- print('antiCheatAvis[\'id:\'..source] : ', antiCheatAvis['id:'..source])
            -- print('xPlayer.source', xPlayer.source)

            TriggerClientEvent('Ins:LaisseUnAvis', s.source, GetPlayerName(source))
            for i=1, #xPlayers, 1 do
                local xPlayerS = InsHelper:getPlayerFromId(xPlayers[i])
                if xPlayerS then
                    if PlayersRanks[InsHelper:getIdentifier(xPlayerS.source)] then
                        InsHelper:serverNotification(xPlayerS.source, '~g~Le staff '..GetPlayerName(source)..' a cloturé le report n°'..id..'')
                        TriggerClientEvent('Ins:ReceiveReportsList', xPlayerS.source, Reports)
                    end
                end
            end
        else
            DropPlayer(source, "InsShield : Tentative de triche (bypass trigger : \"Ins:updateReport\")")
        end
    else
        DropPlayer(source, "InsShield : Tentative de triche (bypass trigger : \"Ins:updateReport\")")
    end
end) -- by ins