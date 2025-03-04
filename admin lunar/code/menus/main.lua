local displayReportHUD = false

function MenuMain()
    RageUI.Checkbox(
        adminStaffmode and "Désactiver le mode admin" or "Activer le mode admin",
        nil,
        adminStaffmode, {}, {
            onSelected = function(Index)
                adminStaffmode = Index
            end,
            onChecked = function()
                InsStaffMode = true
                TriggerServerEvent('InsAdmin:ChangeStaffMode', 'on')
                InsHelper:onStaffModeON()
            end,
            onUnChecked = function()
                InsHelper:onStaffModeOFF()
                if noclipActive then
                    ExecuteCommand('InsNoclip')
                end
                InsStaffMode = false
                isNameShown = false
                TriggerServerEvent('InsAdmin:ChangeStaffMode', 'off')
                adminPseudo = false
                boolPseudo = false
                for i, v in pairs(Ins.GamerTags) do
                    RemoveMpGamerTag(v.tags)
                end
                Ins.GamerTags = {}
                SetEntityVisible(PlayerPedId(), true)
                boolHud = false
                boolInvincible = false
                boolSuperjump = false
                boolCoords = false
                boolSupersprint = false
            end
        }
    )

    if not adminStaffmode then
        RageUI.Checkbox(
            "Afficher le nombre de reports", 
            nil, 
            displayReportHUD, 
            {}, 
            {
                onChecked = function()
                    displayReportHUD = true
                end,
                onUnChecked = function()
                    displayReportHUD = false
                end
            }
        )
    end
    

    if adminStaffmode then

        if InsHelper:getAcces(player, 'myplayer') then
            RageUI.Button('Mon joueur', nil, { RightLabel = InsConfig.RightLabel }, true, {}, myplayer)
        else
            RageUI.Button('Mon joueur', nil, {}, false, {})
        end

        if InsHelper:getAcces(player, 'alentour') then
            RageUI.Button('Autour de moi', nil, { RightLabel = InsConfig.RightLabel }, true, {}, alentour)
        else
            RageUI.Button('Autour de moi', nil, {}, false, {})
        end

        if InsHelper:getAcces(player, 'subReports') then
            RageUI.Button('Reports '..c..'('..ReportsInfos.Waiting..')', nil, {RightLabel = InsConfig.RightLabel}, true, {
                onSelected = function()
                    Callback.triggerServerCallback('Ins:getReportList', function(table)
                        Reports = table
                        ReportsInfos.Waiting = 0
                        ReportsInfos.Taked = 0
                        for k, v in pairs(Reports) do
                            if v.state == 'waiting' then
                                ReportsInfos.Waiting = ReportsInfos.Waiting + 1
                            elseif v.state == 'taked' then
                                ReportsInfos.Taked = ReportsInfos.Taked + 1
                            end
                        end
                    end) -- by ins
                end
            }, adminReports)
        else
            RageUI.Button('Reports '..c..'('..ReportsInfos.Waiting..')', nil, {}, false, {})
        end

        if InsHelper:getAcces(player, 'subPlayers') then
    local players = GetActivePlayers()
    local playerCount = #players

    RageUI.Button('Liste des joueurs', nil, {RightLabel = tostring(playerCount)}, true, {
        onSelected = function()
        end
    }, adminPlayers)
else
    RageUI.Button('Liste des joueurs', nil, {}, false, {})
end

    --[[   if InsHelper:getAcces(player, 'subPlayers') then
            RageUI.Button('Tous les joueurs', nil, {RightLabel = InsConfig.RightLabel}, true, {
                onSelected = function()
                    -- InsAdmin:retrievePlayers OLD
                end
            }, adminPlayers)
        else
            RageUI.Button('Tous les joueurs', nil, {}, false, {})
        end --]]

        if InsHelper:getAcces(player, 'subVehicle') then
            RageUI.Button('Véhicules', nil, { RightLabel = InsConfig.RightLabel }, true, {}, adminVehicle)
        else
            RageUI.Button('Véhicules', nil, {}, false, {})
        end

        if InsHelper:getAcces(player, 'subPersonnel') then
            RageUI.Button('Préférences', nil, { RightLabel = InsConfig.RightLabel }, true, {}, adminPerso)
        else
            RageUI.Button('Préférences', nil, {}, false, {})
        end

        if InsHelper:getAcces(player, 'subPersonnel') then
            RageUI.Button('Menu Troll', nil, { RightLabel = InsConfig.RightLabel }, true, {}, adminillegal)
        else
            RageUI.Button('Menu Troll', nil, {}, false, {})
        end

        if player.rank == 'owner' then
            RageUI.Button('Ranks', nil, { RightLabel = InsConfig.RightLabel }, true, {
                onSelected = function()
                    Callback.triggerServerCallback('InsAdmin:getRanksList', function(ranks)
                        RanksList = ranks
                    end) -- by ins
                end
            }, adminRanks)
        else
            RageUI.Button('Ranks', nil, {}, false, {})
        end
    end
end

























Citizen.CreateThread(function()
    while true do
        if displayReportHUD then
            reportsWaiting = ReportsInfos.Waiting
            reportsInProgress = ReportsInfos.Taked
            DrawTextOnScreen("Report en attentes : ~r~" .. reportsWaiting .. " ~s~| Report en cours de traitement : ~y~" .. reportsInProgress, 0.5, 0.015, 0.3)
        end
        Citizen.Wait(0)
    end
end) -- by ins


-- Functions
function DrawTextOnScreen(text, x, y, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropShadow(0, 0, 0, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end