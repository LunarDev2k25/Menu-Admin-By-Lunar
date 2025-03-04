function MenuTeleport()
    RageUI.Button('Crée une nouvelle téléportation', nil, { RightLabel = InsConfig.RightLabel }, true, {
        onSelected = function()
            InsCreatetp = KeyboardInput('InsCreatetp', "Entrez le "..InsConfig.ColorMenu.."nom~s~ de la téléportation", '', 20)
            if InsCreatetp ~= '' or InsCreatetp ~= nil then
                Coords = GetEntityCoords(PlayerPedId())
            else
                InsHelper:clientNotification('~r~Veuillez donner un nom au votre téléportation custom !')
            end
        end,
        onActive = function()
            if Coords ~= nil then
                DrawMarker(21, Coords, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 245, 66, 66, 255, true, true, p19, true)                                
            end
        end
    })
    if Coords ~= nil then
        RageUI.Button('Changer la position', nil, { RightLabel = InsConfig.RightLabel }, true, {
            onSelected = function()
                Coords = GetEntityCoords(PlayerPedId())
            end,
            onActive = function()
                if Coords ~= nil then
                    DrawMarker(21, Coords, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 245, 66, 66, 255, true, true, p19, true)                                
                end
            end
        })
        RageUI.Button('~g~Confirmer la création', nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
            onSelected = function()
                TriggerServerEvent('InsAdmi:CreateCustomTP', InsCreatetp, Coords)
                InsHelper:clientNotification('~g~La téléportation a été crée !')
                InsCreatetp = nil
                Coords = nil
                CreateThread(function()
                    Wait(100)
                    Callback.triggerServerCallback('InsAdmin:getTP', function(tp)
                        TpList = tp
                    end) -- by ins
                end) -- by ins
            end,
            onActive = function()
                if Coords ~= nil then
                    DrawMarker(21, Coords, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 245, 66, 66, 255, true, true, p19, true)                                
                end
            end
        })
        RageUI.Button('~r~Annuler la création', nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, {
            onSelected = function()
                InsHelper:clientNotification('~r~La création a été annulé !')
                InsCreatetp = nil
                Coords = nil
            end,
            onActive = function()
                if Coords ~= nil then
                    DrawMarker(21, Coords, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 245, 66, 66, 255, true, true, p19, true)                                
                end
            end
        })
    end
    RageUI.Checkbox("Mode suppression", nil, adminDeletemode, { }, {
        onSelected = function(Index)
            adminDeletemode = Index
        end
    })
    Separator('Vos téléportations custom')
    if TpList == nil then
        if json.encode(TpList) ~= '[]' then
            RageUI.Separator()
            RageUI.Separator('~r~Chargement de vos données...')
            RageUI.Separator()
        else
            RageUI.Separator()
            RageUI.Separator('~r~Vous n\'avez pas de téléportation définie !')
            RageUI.Separator()
        end
    else
        for k,v in pairs(TpList) do 
            if adminDeletemode then
                RageUI.Button(v.label, 'ID Unique : '..v.id, { RightLabel = '🗑' }, true, {
                    onSelected = function()
                        TriggerServerEvent('InsAdmin:DeleteCustomTP', v.id)
                        CreateThread(function()
                            Wait(100)
                            Callback.triggerServerCallback('InsAdmin:getTP', function(tp)
                                TpList = tp
                            end) -- by ins
                        end) -- by ins
                    end
                })
            else
                RageUI.Button(v.label, nil, { RightLabel = InsConfig.RightLabel }, true, {
                    onSelected = function()
                        SetEntityCoords(PlayerPedId(), json.decode(v.coords.x), json.decode(v.coords.y), json.decode(v.coords.z))
                    end
                })
            end
        end
    end
end