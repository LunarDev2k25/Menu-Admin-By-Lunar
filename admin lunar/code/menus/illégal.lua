function Menuillegal()
    RageUI.Button('Mettre en feu le joueur', nil, {}, true, {
        onSelected = function()
            local playerId = KeyboardInput("ID du joueur", "", 10)
            if playerId then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(playerId)))
                if targetPed == 0 then
                    ESX.ShowNotification('~r~Joueur non connecté')
                    return
                end
                StartEntityFire(targetPed)
            end
        end
    })

    RageUI.Button('Arrêter de mettre en feu', nil, {}, true, {
        onSelected = function()
            local playerId = KeyboardInput("ID du joueur", "", 10)
            if playerId then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(playerId)))
                if targetPed == 0 then
                    ESX.ShowNotification('~r~Joueur non connecté')
                    return
                end
                StopEntityFire(targetPed)
            end
        end
    })

    RageUI.Button('Envoyer dans les aires', nil, {}, true, {
        onSelected = function()
            local playerId = KeyboardInput("ID du joueur", "", 10)
            if playerId then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(playerId)))
                if targetPed == 0 then
                    ESX.ShowNotification('~r~Joueur non connecté')
                    return
                end
                ApplyForceToEntity(targetPed, 1, 0.0, 0.0, 200.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
            end
        end
    })

    RageUI.Button('Mettre dans une cage', nil, {}, true, {
        onSelected = function()
            local playerId = KeyboardInput("ID du joueur", "", 10)
            if playerId then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(playerId)))
                if targetPed == 0 then
                    ESX.ShowNotification('~r~Joueur non connecté')
                    return
                end
                local coords = GetEntityCoords(targetPed)
                local prop = CreateObject(GetHashKey("prop_container_ld_pu"), coords.x, coords.y, coords.z-1, true, true, true)
                FreezeEntityPosition(prop, true)
            end
        end
    })

    RageUI.Button('Retirer de la cage', nil, {}, true, {
        onSelected = function()
            local playerId = KeyboardInput("ID du joueur", "", 10)
            if playerId then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(tonumber(playerId)))
                if targetPed == 0 then
                    ESX.ShowNotification('~r~Joueur non connecté')
                    return
                end
                local coords = GetEntityCoords(targetPed)
                local props = GetGamePool('CObject')
                for _, prop in ipairs(props) do
                    if GetHashKey("prop_container_ld_pu") == GetEntityModel(prop) then
                        if #(GetEntityCoords(prop) - coords) < 3.0 then
                            DeleteEntity(prop)
                        end
                    end
                end
            end
        end
    })
end