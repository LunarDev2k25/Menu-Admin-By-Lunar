local isFrozen = false

local isWatching = false


function MenuPlayers()
    if InsHelper:getAcces(player, 'subStaffs') then
        RageUI.Button('Voir la liste des staffs', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                Callback.triggerServerCallback('InsAdmin:getStaffs', function(cb, cb2)
                    StaffListtt = cb
                    Identifier = cb2
                end) -- by ins
            end
        }, adminStaffs)
    end
    if playersList ~= nil and playersStaffsList ~= nil then
    end
    RageUI.List("Filtrer", InsRechercheSys, InsRechercheSysIndex, nil, {RightLabel = ""}, true, {
        onListChange = function(Index)
            InsRechercheSysIndex = Index
            InsRecherche = InsRechercheSysIndex
        end,
        onSelected = function(Index)
            --{"Pseudo", "ID", "Prénom", "Nom"}
            if InsRecherche == 1 then
                InsRechercheEcrit = exports['input']:ShowSync('Pseudo', nil, 320., 'small_text')
            elseif InsRecherche == 2 then
                InsRechercheEcrit = exports['input']:ShowSync('Id', nil, 320., 'small_text')
            elseif InsRecherche == 3 then
                InsRechercheEcrit = exports['input']:ShowSync('Métier', nil, 320., 'small_text')
            elseif InsRecherche == 4 then
                InsRechercheEcrit = exports['input']:ShowSync('Id unique', nil, 320., 'small_text')
            end
            if not InsRechercheEcrit then
                InsRechercheEcrit = nil
                InsHelper:clientNotification('~g~La recherche a été annulé !')
            end
            if InsRechercheEcrit ~= nil then
                InsHelper:clientNotification('~g~Recherche configuré sur "'..InsRechercheEcrit..'"')
            end
        end
    })
    if InsRechercheEcrit then
        RageUI.Button('~r~Annuler la recherche', nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, {
            onSelected = function()
                InsRechercheEcrit = nil
            end		
        })
    end
    if InsRechercheEcrit then
        Separator('Résulatat(s) de votre recherche')
    elseif InsShowStaff then
        Separator('Staff(s) connecté(s)')
    else
    end
    if PlayersList then
        for k, v in pairs(PlayersList) do
            if InsShowInZone then
                for _, player in ipairs(GetActivePlayers()) do
                    if GetPlayerServerId(player) == v.source then
                        if InsRechercheEcrit then
                            if InsRecherche == 1 then
                                if string.find(v.name, InsRechercheEcrit) then
                                    if colorsText[v.rankColor] then
                                        RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    else
                                        RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    end
                                end
                            elseif InsRecherche == 2 then
                                if string.find(v.source, InsRechercheEcrit) then
                                    if colorsText[v.rankColor] then
                                        RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    else
                                        RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    end
                                end
                            elseif InsRecherche == 3 then
                                if string.find(v.job1, InsRechercheEcrit) then
                                    if colorsText[v.rankColor] then
                                        RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    else
                                        RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    end
                                end
                            elseif InsRecherche == 4 then
                                if string.find(v.uid, InsRechercheEcrit) then
                                    if colorsText[v.rankColor] then
                                        RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    else
                                        RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                            onSelected = function()
                                                selectedPlayer = k
                                            end
                                        }, adminGestPlayer)
                                    end
                                end
                            end
                        else
                            if colorsText[v.rankColor] then
                                RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            else
                                RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            end
                        end
                    end
                end
            elseif InsShowStaff then
                if InsRechercheEcrit then
                    if InsRecherche == 1 then
                        if string.find(v.name, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            else
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            end
                        end
                    elseif InsRecherche == 2 then
                        if string.find(v.source, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            else
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            end
                        end
                    elseif InsRecherche == 3 then
                        if string.find(v.job1, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            else
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            end
                        end
                    elseif InsRecherche == 4 then
                        if string.find(v.uid, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            else
                                if v.rankName ~= 'user' then
                                    RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                        onSelected = function()
                                            selectedPlayer = k
                                        end
                                    }, adminGestPlayer)
                                end
                            end
                        end
                    end
                else
                    if colorsText[v.rankColor] then
                        if v.rankName ~= 'user' then
                            RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                onSelected = function()
                                    selectedPlayer = k
                                end
                            }, adminGestPlayer)
                        end
                    else
                        if v.rankName ~= 'user' then
                            RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                onSelected = function()
                                    selectedPlayer = k
                                end
                            }, adminGestPlayer)
                        end
                    end
                end
            else
                if InsRechercheEcrit then
                    if InsRecherche == 1 then
                        if string.find(v.name, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            else
                                RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            end
                        end
                    elseif InsRecherche == 2 then
                        if string.find(v.source, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            else
                                RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            end
                        end
                    elseif InsRecherche == 3 then
                        if string.find(v.job1, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            else
                                RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            end
                        end
                    elseif InsRecherche == 4 then
                        if string.find(v.uid, InsRechercheEcrit) then
                            if colorsText[v.rankColor] then
                                RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            else
                                RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                                    onSelected = function()
                                        selectedPlayer = k
                                    end
                                }, adminGestPlayer)
                            end
                        end
                    end
                else
                    if colorsText[v.rankColor] then
                        RageUI.Button(v.name..' '..colorsText[v.rankColor]..''..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                            onSelected = function()
                                selectedPlayer = k
                            end
                        }, adminGestPlayer)
                    else
                        RageUI.Button(v.name..' '..v.rankLabel, 'Métier : '..c..''..v.job1..'~s~\nOrganisation : '..c..''..v.job2..'~s~\nUnique ID : '..c..''..v.uid..'', {RightLabel = v.source..' '..InsConfig.RightLabel}, true, {
                            onSelected = function()
                                selectedPlayer = k
                            end
                        }, adminGestPlayer)
                    end
                end
            end
        end
    end
end

function menuGestPlayer()
    local s = PlayersList[selectedPlayer]
    if s then
        if colorsText[s.rankColor] then
            --RageUI.Separator(s.name..' ~s~'..colorsText[s.rankColor]..''..s.rankLabel)
            --RageUI.Separator('ID Temporaire : '..c..''..s.source..'~s~ | ID Unique : '..c..''..s.uid..'') 
        else
            --RageUI.Separator(s.name..' ~s~[Joueur]')
           --RageUI.Separator('ID Temporaire : '..c..''..s.source..'~s~ | ID Unique : '..c..''..s.uid..'') 
        end
        if InsHelper:getAcces(player, 'spectate') then
            RageUI.Checkbox("Spectate", nil, spectate, {}, {
                onSelected = function(Index)
                    spectate = Index
                end,
                onChecked = function()
                    spectate = true
                    boolSpect(s.source, PlayersList[selectedPlayer], s.name)
                end,
                onUnChecked = function()
                    spectate = false
                end
            })
        else
            RageUI.Button('Spectate', nil, {}, false, {})
        end 
        if InsHelper:getAcces(player, 'teleportation') then
            RageUI.Button('Goto', nil, { RightLabel = InsConfig.RightLabel }, true, {
                onSelected = function()
                    TriggerServerEvent('InsAdmin:Teleport', 'goto', s.source)
                end
            })
            RageUI.Button('Goto en noclip', nil, { RightLabel = InsConfig.RightLabel }, true, {
                onSelected = function()
                    TriggerServerEvent('InsAdmin:Teleport', 'goto', s.source)
                end
            })
            RageUI.Button('Bring', nil, { RightLabel = InsConfig.RightLabel }, true, {
                onSelected = function()
                    TriggerServerEvent('InsAdmin:Teleport', 'bring', s.source)
                end
            })
            RageUI.Button('Bring Back', nil, { RightLabel = InsConfig.RightLabel }, true, {
                onSelected = function()
                    TriggerServerEvent('InsAdmin:Teleport', 'bringback', s.source)
                end
            })
            -- RageUI.Button('Bring back', nil, { RightLabel = InsConfig.RightLabel }, true, {
            --     onSelected = function()
            --         TriggerServerEvent('InsAdmin:Teleport', 'bringback', s.source)
            --     end
            -- })
        else
            RageUI.Button('Téléportation', nil, {}, false, {})
            RageUI.Button('Téléportation(s) custom', nil, {}, false, {})
        end
        if InsHelper:getAcces(player, 'sendMsg') then
            RageUI.Button('Message', nil, {RightLabel = InsConfig.RightLabel}, true, {
                onSelected = function()
                    local InsMsg = exports['input']:ShowSync('Envoyer un message', nil, 320., 'small_text')
                    if InsMsg and InsMsg ~= '' then
                        ExecuteCommand('msg '..s.source..' '..InsMsg)
                    else
                        InsHelper:clientNotification('~r~Vous avez annulé l\'action')
                    end
                end		
            })
        else
            RageUI.Button('Message', nil, {}, false, {})
        end
        RageUI.Button("Point GPS sur sa position", "Placer un point GPS sur la position du joueur", {RightLabel = "→"}, true, {
            onSelected = function()
                local s = PlayersList[selectedPlayer]
                if s then
                    local ped = GetPlayerPed(GetPlayerFromServerId(s.source))
                    local pos = GetEntityCoords(ped)
                    SetNewWaypoint(pos.x, pos.y)
                    ESX.ShowNotification("~g~Point GPS placé sur " .. s.name)
                end
            end
        })
        RageUI.Button("Informations", nil, {RightLabel = "→"}, true, {
            onSelected = function()
                local s = PlayersList[selectedPlayer]
                if s then
                    local gang = s.job2 or "NoGang"
                    ESX.ShowNotification(string.format("~b~Informations de %s~s~\n~y~Pseudo FiveM: ~s~%s\n~y~Job: ~s~%s\n~y~Gang: ~s~%s\n~g~Argent: ~s~%s$\n~b~Banque: ~s~%s$\n~r~Sale: ~s~%s$", 
                        s.name,
                        GetPlayerName(GetPlayerFromServerId(s.source)),
                        s.job1,
                        gang,
                        s.money,
                        s.bank,
                        s.black_money
                    ))
                end
            end
        })
        RageUI.Button("Véhicules", "Gestion des véhicules", {RightLabel = "→"}, true, {
            onSelected = function()
                local s = PlayersList[selectedPlayer]
                if s then
                    RageUI.Button("Réparer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local ped = GetPlayerPed(GetPlayerFromServerId(s.source))
                            local vehicle = GetVehiclePedIsIn(ped, false)
                            if vehicle ~= 0 then
                                SetVehicleFixed(vehicle)
                                SetVehicleDeformationFixed(vehicle)
                                SetVehicleUndriveable(vehicle, false)
                                ESX.ShowNotification("~g~Véhicule réparé")
                            end
                        end
                    })
        
                    RageUI.Button("Supprimer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local ped = GetPlayerPed(GetPlayerFromServerId(s.source))
                            local vehicle = GetVehiclePedIsIn(ped, false)
                            if vehicle ~= 0 then
                                DeleteEntity(vehicle)
                                ESX.ShowNotification("~r~Véhicule supprimé")
                            end
                        end
                    })
        
                    RageUI.Button("Nettoyer", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local ped = GetPlayerPed(GetPlayerFromServerId(s.source))
                            local vehicle = GetVehiclePedIsIn(ped, false)
                            if vehicle ~= 0 then
                                SetVehicleDirtLevel(vehicle, 0.0)
                                ESX.ShowNotification("~g~Véhicule nettoyé")
                            end
                        end
                    })
                end
            end
        })
        RageUI.Button("Regarder l'écran", nil, {RightLabel = isWatching and "~g~ON" or "~r~OFF"}, true, {
            onSelected = function()
                local s = PlayersList[selectedPlayer]
                if s then
                    isWatching = true
                    ExecuteCommand('testscreenshot ' .. s.source)
                    
                    SetTimeout(5000, function()
                        isWatching = false
                    end) -- by ins
                end
            end
        })
        
        
        

        
        RageUI.Button('~y~Kick~s~', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                InsSanction = exports['input']:ShowSync('Raison du kick', nil, 320., 'small_text')
                if InsSanction then
                    ExecuteCommand('kick '..PlayersList[selectedPlayer].source..' '..InsSanction)
                else
                    InsHelper:clientNotification('~r~L\'action a été annulé')
                end
            end
        })
        RageUI.Button("~y~Entrer dans l'instance~s~", nil, {RightLabel = "→"}, true, {
            onSelected = function()
                local targetId = KeyboardInput('Instance ID', 'ID du joueur', '', 10)
                if targetId then
                    TriggerServerEvent('instance:enterEvent', targetId)
                end
            end
        })
        
        RageUI.Button("~y~Sortir de l'instance~s~", nil, {RightLabel = "→"}, true, {
            onSelected = function()
                TriggerServerEvent('instance:exitEvent')
            end
        })
        RageUI.Button('~y~Avertissement~s~', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                InsSanction = exports['input']:ShowSync('Avertissement', nil, 320., 'small_text')
                if InsSanction then
                    ExecuteCommand('warn '..PlayersList[selectedPlayer].source..' '..InsSanction)
                else
                    InsHelper:clientNotification('~r~L\'action a été annulé')
                end
            end
        })
        RageUI.Button('~r~Ban~s~', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                InsSanction = exports['input']:ShowSync('Temps du ban', nil, 320., 'small_text')
                InsSanction2 = exports['input']:ShowSync('Raison du ban', nil, 320., 'small_text')
                if InsSanction and InsSanction2 then
                    ExecuteCommand('ban '..PlayersList[selectedPlayer].source..' '..InsSanction..' '..InsSanction2)
                else
                    InsHelper:clientNotification('~r~L\'action a été annulé')
                end
            end
        })
   --[[     RageUI.Button('~r~Jail~s~', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                InsSanction = exports['input']:ShowSync('Temps de jail', nil, 320., 'small_text')
                InsSanction2 = exports['input']:ShowSync('Raison du jail', nil, 320., 'small_text')
                if InsSanction and InsSanction2 then
                    ExecuteCommand('jail '..PlayersList[selectedPlayer].source..' '..InsSanction..' '..InsSanction2)
                else
                    InsHelper:clientNotification('~r~L\'action a été annulé')
                end
            end
        }) --]]
        RageUI.Button('Historique des sanctions', nil, {RightLabel = InsConfig.RightLabel}, true, {
            onSelected = function()
                sanctionSelectedId = s.source
                sanctionSelectedName = s.name
                Callback.triggerServerCallback('InsAdmin:getSanctionsOfPlayer', function(list)
                    adminSanctions = list
                end, s.uid)
            end        
        }, adminGestPlayerSanctions)

        RageUI.Button("Freeze", nil, {RightLabel = isFrozen and "~r~ON" or "~g~OFF"}, true, {
            onSelected = function()
                local s = PlayersList[selectedPlayer]
                if s then
                    isFrozen = not isFrozen
                    TriggerServerEvent('InsAdmin:freezePlayer', s.source, isFrozen)
                    ESX.ShowNotification(isFrozen and "~g~Joueur freeze" or "~r~Joueur unfreeze")
                end
            end
        })

        RageUI.Button('Revive', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                InsHelper:revivePlayer(s.source, s.name)
            end
        })
        RageUI.Button('Heal', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                InsHelper:healPlayer(s.source, s.name)
            end
        })
    
    if adminSanctions == nil then
    else
        if #adminSanctions ~= 0 then
            for k, v in pairs(adminSanctions) do
                RageUI.Button(v.sanctionType..' par le staff "'..v.staff..'"', "Raison : "..v.sanctionDesc.."\nLe "..v.date, {RightLabel = '(ID : '..v.id..')'}, true, {
                    onSelected = function()
                        --A FINIR FDP
                    end		
                })
            end
        else
            RageUI.Separator()
            RageUI.Separator('~g~Aucune sanction pour ce joueur')
            RageUI.Separator()
        end
    end
        if InsHelper:getAcces(player, 'spawnVeh') then
        else
            RageUI.Button('Donner un véhicule au joueur', nil, {}, false, {})
        end
        InsHelper:CustomMenuPlayers(PlayersList[selectedPlayer])
        for k, v in pairs(InsMenus.players) do
            if v.type == 'button' then
                if v.perm then
                    if InsHelper:getAcces(player, v.perm) then
                        if subMenu then
                            RageUI.Button(v.name, v.desc, v.rightLabel, true, {
                                onActive = function()
                                    v.onActive()
                                end,
                                onSelected = function()
                                    v.onSelected()
                                end
                            }, subMenu)
                        else
                            RageUI.Button(v.name, v.desc, v.rightLabel, true, {
                                onActive = function()
                                    v.onActive()
                                end,
                                onSelected = function()
                                    v.onSelected()
                                end
                            })
                        end
                    else
                        RageUI.Button(v.name, v.desc, {}, false, {})
                    end
                else
                    if subMenu then
                        RageUI.Button(v.name, v.desc, v.rightLabel, true, {
                            onActive = function()
                                v.onActive()
                            end,
                            onSelected = function()
                                v.onSelected()
                            end
                        }, subMenu)
                    else
                        RageUI.Button(v.name, v.desc, v.rightLabel, true, {
                            onActive = function()
                                v.onActive()
                            end,
                            onSelected = function()
                                v.onSelected()
                            end
                        })
                    end
                end
            elseif v.type == 'separator' then
                RageUI.Separator(v.name)
            else
                RageUI.Button('~r~Erreur de configuration', nil, {}, false, {})
            end
        end
    else
        RageUI.Separator()
        RageUI.Separator('~r~Ce joueur n\'est plus connecté')
        RageUI.Separator()
    end
end

function menuGestPlayerItems()
    if InsHelper:getAcces(player, 'give') then
        RageUI.Button('Give', nil, {RightLabel = InsConfig.RightLabel}, true, {
            onSelected = function()
                local InsMsg = exports['input']:ShowSync("Nom de l'item", nil, 320., 'small_text')
                local InsMsg2 = exports['input']:ShowSync('Quantité', nil, 320., 'small_text')
                givePlayer(sanctionSelectedId, InsMsg, InsMsg2)
            end		
        })
        if itemsList then
            RageUI.List("Filtrer par lettre", LettresItems, LettresItemsIndex, nil, {}, true, {
                onListChange = function(Index)
                    LettresItemsIndex = Index
                end
            })
            if LettresItemsIndex == 1 then
                for k, v in pairs(itemsList) do
                    RageUI.Button(v.label..' ~c~('..v.name..')', nil, {RightLabel = InsConfig.RightLabel}, true, {
                        onSelected = function()
                            local InsMsg2 = exports['input']:ShowSync('Quantité', nil, 320., 'small_text')
                            givePlayer(sanctionSelectedId, v.name, InsMsg2)
                        end
                    })
                end
            else
                for k, v in pairs(itemsList) do
                    local premierCaractere = string.sub(v.label, 1, 1)
                    if string.lower(premierCaractere) == LettresItems[LettresItemsIndex] then
                        RageUI.Button(v.label..' ~c~('..v.name..')', nil, {RightLabel = InsConfig.RightLabel}, true, {
                            onSelected = function()
                                local InsMsg2 = exports['input']:ShowSync('Quantité', nil, 320., 'small_text')
                                givePlayer(sanctionSelectedId, v.name, InsMsg2)
                            end
                        })
                    end
                end 
            end
        else
            RageUI.Button('Filtrer par lettre', nil, {}, false, {})
            RageUI.Separator('')
            RageUI.Separator('~r~Chargement des items...')
            RageUI.Separator('')
        end
    else
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
        RageUI.Separator('Anti-triche InsAdmin :)')
    end
end

function menuGestPlayerInventory()
    local s = PlayersList[selectedPlayer]
    if s then
        if colorsText[s.rankColor] then
            RageUI.Separator(s.name..' ~s~'..colorsText[s.rankColor]..''..s.rankLabel)
            RageUI.Separator('ID Temporaire : '..c..''..s.source..'~s~ | ID Unique : '..c..''..s.uid..'') 
        else
            RageUI.Separator(s.name..' ~s~[Joueur]')
            RageUI.Separator('ID Temporaire : '..c..''..s.source..'~s~ | ID Unique : '..c..''..s.uid..'') 
        end
        Separator('Inventaire du joueur')
        if adminInventory and adminInventory2 then
            for k, v in pairs(adminInventory) do
                if v.count ~= 0 then
                    RageUI.List(v.label..' '..c..'x'..v.count..' ~c~('..v.name..')', InsGestinventory, (InsGestinventory.Index or 1), false, {}, true, {
                        onListChange = function(Index)
                            InsGestinventory.Index = Index
                        end,
                        onSelected = function(Index)
                            if InsGestinventory.Index == 1 then
                                if InsHelper:getAcces(player, 'prendre') then
                                    -- prendre
                                    local InsInventory = exports['input']:ShowSync('Quantité que vous voulez prendre', nil, 320., 'small_text')
                                    if tonumber(InsInventory) then
                                        if tonumber(InsInventory) > v.count then
                                            InsHelper:clientNotification('~r~Impossible de prendre plus de '..v.label)
                                        else
                                            TriggerServerEvent('Ins:GestInventoryPlayer', 'rob', tonumber(InsInventory), v, sanctionSelectedId)
                                        end
                                    else
                                        InsHelper:clientNotification('~r~Vous devez entrer un nombre !')
                                    end
                                else
                                    InsHelper:clientNotification('~r~Vous avez pas la permission !')
                                end
                            else
                                if InsHelper:getAcces(player, 'delete') then
                                    -- suppr
                                    local InsInventory = exports['input']:ShowSync('Quantité que vous voulez supprimez', nil, 320., 'small_text')
                                    if tonumber(InsInventory) then
                                        if tonumber(InsInventory) > v.count then
                                            InsHelper:clientNotification('~r~Impossible de prendre plus de '..v.label)
                                        else
                                            TriggerServerEvent('Ins:GestInventoryPlayer', 'delete', tonumber(InsInventory), v, sanctionSelectedId)
                                        end
                                    else
                                        InsHelper:clientNotification('~r~Vous devez entrer un nombre !')
                                    end
                                else
                                    InsHelper:clientNotification('~r~Vous avez pas la permission !')
                                end
                            end
                        end
                    })
                end
            end
            for k, v in pairs(adminInventory2) do
                if v.name then
                    RageUI.List(v.label..' '..c..'x'..v.ammo..' ~c~('..v.name..')', InsGestinventory, (InsGestinventory.Index or 1), false, {}, true, {
                        onListChange = function(Index)
                            InsGestinventory.Index = Index
                        end,
                        onSelected = function(Index)
                            if InsGestinventory.Index == 1 then
                                -- prendre
                                if InsHelper:getAcces(player, 'prendre') then
                                    TriggerServerEvent('Ins:GestInventoryPlayer', 'rob2', v.ammo, v, sanctionSelectedId)
                                else
                                    InsHelper:clientNotification('~r~Vous avez pas la permission !')
                                end
                                -- local InsInventory = KeyboardInput('InsMsg', "Entrez le "..c.."nombre~s~ de "..v.label.." que vous voulez prendre", '', 5)
                                -- if tonumber(InsInventory) then
                                --     if tonumber(InsInventory) > v.count then
                                --         InsHelper:clientNotification('~r~Impossible de prendre plus de '..v.label)
                                --     else
                                --         TriggerServerEvent('Ins:GestInventoryPlayer', 'rob', tonumber(InsInventory), v, sanctionSelectedId)
                                --     end
                                -- else
                                --     InsHelper:clientNotification('~r~Vous devez entrer un nombre !')
                                -- end
                            else
                                -- suppr
                                if InsHelper:getAcces(player, 'delete') then
                                    TriggerServerEvent('Ins:GestInventoryPlayer', 'delete2', v.ammo, v, sanctionSelectedId)
                                else
                                    InsHelper:clientNotification('~r~Vous avez pas la permission !')
                                end
                                -- local InsInventory = KeyboardInput('InsMsg', "Entrez le "..c.."nombre~s~ de "..v.label.." que vous voulez supprimer", '', 5)
                                -- if tonumber(InsInventory) then
                                --     if tonumber(InsInventory) > v.count then
                                --         InsHelper:clientNotification('~r~Impossible de prendre plus de '..v.label)
                                --     else
                                --         TriggerServerEvent('Ins:GestInventoryPlayer', 'delete', tonumber(InsInventory), v, sanctionSelectedId)
                                --     end
                                -- else
                                --     InsHelper:clientNotification('~r~Vous devez entrer un nombre !')
                                -- end
                            end
                        end
                    })
                else
                    RageUI.Button('Arme inconnue ?', 'Cette arme n\'a pas été reconnu', {}, false, {})
                end
            end
        else
            RageUI.Separator()
            RageUI.Separator('~r~Chargement de l\'inventaire')
            RageUI.Separator()
        end
    else
        RageUI.Separator()
        RageUI.Separator('~r~Ce joueur n\'est plus connecté')
        RageUI.Separator()
    end
end


RegisterNetEvent('enterInstanceEvent')
AddEventHandler('enterInstanceEvent', function(instance)
    NetworkSetInSpectatorMode(true, GetPlayerPed(instance.id))
    ESX.ShowNotification('~g~Vous avez rejoint l\'instance du joueur ID: ' .. instance.id)
end) -- by ins

RegisterNetEvent('exitInstanceEvent')
AddEventHandler('exitInstanceEvent', function()
    NetworkSetInSpectatorMode(false, GetPlayerPed(-1))
    ESX.ShowNotification('~r~Vous avez quitté l\'instance')
end) -- by ins

RegisterNetEvent('InsAdmin:freeze')
AddEventHandler('InsAdmin:freeze', function(state)
    FreezeEntityPosition(PlayerPedId(), state)
end) -- by ins
