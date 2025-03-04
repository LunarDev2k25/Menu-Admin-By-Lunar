local displayReportHUD = false



local effetsones = false



local IndexTenue = 1
local TenueList = {}

function MenuPersonnalMain()
--[[    if InsHelper:getAcces(player, 'noclip') then
        RageUI.Checkbox("Activer le mode vole", nil, noclipActive, {}, {
            onChecked = function()
                ExecuteCommand('InsNoclip')
            end,
            onUnChecked = function()
                ExecuteCommand('InsNoclip')
            end
        })
    else
        RageUI.Button('Activer le mode vole', nil, {}, false, {})
    end --]]
    if InsHelper:getAcces(player, 'blips') then
        RageUI.Checkbox("Afficher les blips", nil, adminShowBlipsPlayers, { }, {
            onSelected = function(Index)
                adminShowBlipsPlayers = Index
            end,
            onChecked = function()
                adminBlips()
            end,
            onUnChecked = function()
                adminBlips()
            end
        })
    else
        RageUI.Button('Afficher les blips', nil, {}, false, {})
    end



    Citizen.CreateThread(function()
        while true do
            if displayReportHUD then
                -- Using the existing ReportsInfos values
                reportsWaiting = ReportsInfos.Waiting
                reportsInProgress = ReportsInfos.Taked
                
                -- Draw the text on screen
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

    if InsHelper:getAcces(player, 'showreports') then
        RageUI.Checkbox("Afficher les reports", nil, displayReportHUD, { }, {
            onSelected = function(Index)
                displayReportHUD = Index
            end,
            onChecked = function()
                displayReportHUD = true
            end,
            onUnChecked = function()
                displayReportHUD = false
            end
        })
    else
        RageUI.Button('Afficher les reports', nil, {}, false, {})
    end

    if InsHelper:getAcces(player, 'pseudos') then
        RageUI.Checkbox("Afficher le nom des joueurs", nil, adminPseudo, {}, {
            onSelected = function(Index)
                adminPseudo = Index
            end,
            onChecked = function()
                InsHelper:displayNames(true)
            end,
            onUnChecked = function()
                InsHelper:displayNames(false)
            end
        })	
    else
        RageUI.Button('Afficher le nom des joueurs', nil, {}, false, {})
    end


    for i=1, 6 do  -- Since you have 6 outfits in config
        TenueList[i] = "Tenue "..i
    end
    
    RageUI.List("Changer de tenue", TenueList, IndexTenue, "Choisissez votre tenue", {}, true, {
        onListChange = function(Index, Item)
            IndexTenue = Index
            TriggerEvent('skinchanger:getSkin', function(skin)
                local clothesSkin = InsConfig.staffSkins[Index]
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            end) -- by ins
        end
    })


    if InsHelper:getAcces(player, 'effetsonores') then
        RageUI.Checkbox("Activer les effets sonores lors d'un report", nil, effetsones, {}, {
            onSelected = function(Index)
                effetsones = Index
            end,
            onChecked = function()
                effetsones = true
            end,
            onUnChecked = function()
                effetsones = false
            end
        })	
    else
        RageUI.Button('Activer les effets sonores lors d\'un report', nil, {}, false, {})
    end


    
end

local playerSkin = nil

function applySkin(outfitNumber)
    if InsConfig.staffSkins[outfitNumber] then
        TriggerEvent('skinchanger:getSkin', function(skin)
            playerSkin = skin
            local newSkin = InsConfig.staffSkins[outfitNumber]
            TriggerEvent('skinchanger:loadClothes', skin, newSkin)
            TriggerEvent('skinchanger:loadSkin', newSkin)
        end) -- by ins
    end
end

function resetSkin()
    if playerSkin then
        TriggerEvent('skinchanger:loadSkin', playerSkin)
        playerSkin = nil
    end
end

   --[[ if InsHelper:getAcces(player, 'invisible') then
        RageUI.Checkbox("Se rendre invisible", nil, adminInvisibility, { }, {
            onSelected = function(Index)
                adminInvisibility = Index
                if adminInvisibility then
                    SetEntityVisible(PlayerPedId(), false)
                else
                    SetEntityVisible(PlayerPedId(), true)
                end
            end
        })
    else
        RageUI.Button('Se rendre invisible', nil, {}, false, {})
    end --]]
 --[[   if InsHelper:getAcces(player, 'invincible') then
        RageUI.Checkbox("Se rendre invincible", nil, adminInvinsible, { }, {
            onSelected = function(Index)
                adminInvinsible = Index
            end,
            onChecked = function()
                boolInvincibleIns()
            end,
            onUnChecked = function()
                boolInvincible = false
            end
        })
    else
        RageUI.Button('Se rendre invincible', nil, {}, false, {})
    end --]]
  --[[  RageUI.Checkbox("Afficher les informations", nil, adminHud, { }, {
        onSelected = function(Index)
            adminHud = Index
        end,
        onChecked = function()
            boolHudInfos()
        end,
        onUnChecked = function()
            boolHud = false
        end
    }) 
    if InsHelper:getAcces(player, 'superpower') then
        RageUI.Checkbox("Activer le super saut", nil, adminJump, { }, {
            onSelected = function(Index)
                adminJump = Index
            end,
            onChecked = function()
                boolSuperjumpIns()
            end,
            onUnChecked = function()
                boolSuperjump = false
            end
        })
    else
        RageUI.Button('Activer le super saut', nil, {}, false, {})
    end
    if InsHelper:getAcces(player, 'superpower') then
        RageUI.Checkbox("Activer le super sprint", nil, adminSprint, { }, {
            onSelected = function(Index)
                adminSprint = Index
            end,
            onChecked = function()
                boolSupersprintIns()
            end,
            onUnChecked = function()
                boolSupersprint = false
            end
        })
    else
        RageUI.Button('Activer le super sprint', nil, {}, false, {})
    end
    -- if InsHelper:getAcces(player, 'delgun') then
    --     RageUI.Checkbox("Delgun", nil, delgun, { }, {
    --         onSelected = function(Index)
    --             delgun = Index
    --         end,
    --         onChecked = function()
    --             boolDelgunIns()
    --         end,
    --         onUnChecked = function()
    --             boolDelgun = false
    --         end
    --     })
    -- else
    --     RageUI.Button('Delgun', nil, {}, false, {})
    -- end
    if InsHelper:getAcces(player, 'coords') then
        RageUI.Checkbox("Afficher les coordonnées", nil, adminCoords, { }, {
            onSelected = function(Index)
                adminCoords = Index
            end,
            onChecked = function()
                boolCoordsIns()
            end,
            onUnChecked = function()
                boolCoords = false
            end
        })
    else
        RageUI.Button('Afficher les coordonnées', nil, {}, false, {})
    end
    if InsHelper:getAcces(player, 'teleportation') then
        RageUI.Button('Se téléporer au marker', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                plyPed = PlayerPedId()
                local waypointHandle = GetFirstBlipInfoId(8)

                if DoesBlipExist(waypointHandle) then
                    Citizen.CreateThread(function()
                        local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                        local foundGround, zCoords, zPos = false, -500.0, 0.0

                        while not foundGround do
                            zCoords = zCoords + 10.0
                            RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                            Wait(10)
                            foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

                            if not foundGround and zCoords >= 2000.0 then
                                foundGround = true
                            end
                        end

                        SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos)
                        InsHelper:clientNotification("~g~Vous avez été téléporté !")
                    end) -- by ins
                else
                    InsHelper:clientNotification("~r~Aucun marker sur la carte !")
                end
            end
        })
        RageUI.List('Téléportations rapide', InsConfig.FastTravel, IndexFasttravel, nil, {}, true, {
            onListChange = function(Index, Item)
                IndexFasttravel = Index;
            end,
            onSelected = function(Index, Item)
                SetEntityCoords(PlayerPedId(), Item.Position)
            end
        })    
        RageUI.Button('Téléportations custom', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                Callback.triggerServerCallback('InsAdmin:getTP', function(tp)
                    TpList = tp
                end) -- by ins
            end
        }, adminMyTeleports)
    else
        RageUI.Button('Se téléporer au marker', nil, {}, false, {})
        RageUI.Button('Téléportations rapide', nil, {}, false, {})
        RageUI.Button('Téléportations custom', nil, {}, false, {})
    end --]]
