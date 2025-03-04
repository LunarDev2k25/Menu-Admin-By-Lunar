delGunStaffActive = false

function GetPlayerIdFromPed(id)
    local toreturn = 0
    for i = 0,900000 do
        if NetworkIsPlayerActive(i) then
            if GetPlayerPed(i) == id then
                toreturn = GetPlayerServerId(i)
                break
            end
        end
    end
    return toreturn 
end

function boolStaffGun()
    CreateThread(function()
        local result2, entity2
        while delGunStaffActive do
            SetWeaponDamageModifier(InsConfig.StaffGunName, 0.0)
            SetAmmoInClip(PlayerPedId(), InsConfig.StaffGunName, 6)
            Wait(5)
            if IsControlJustReleased(0, 24) then
                local weapon = GetSelectedPedWeapon(PlayerPedId())

                if weapon == GetHashKey(InsConfig.StaffGunName) then
                    result2, entity2 = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    if entity2 ~= 0 then
                        if IsEntityAVehicle(entity2) then -- Véhicule
                            showVehicleMenu(entity2)
                        elseif IsEntityAPed(entity2) and IsPedAPlayer(entity2) then -- Joueur
                            targetPlayer = GetPlayerIdFromPed(entity2)
                            if PlayersList then
                                for k, v in pairs(PlayersList) do
                                    if v.source == targetPlayer then
                                        selectedPlayer = k
                                    end
                                end
                                if PlayersList then
                                    if open then
                                        RageUI.NextMenu = adminGestPlayer
                                    else
                                        open = false
                                        RageUI.NextMenu = adminGestPlayer
                                        OpenMenu()
                                    end
                                end
                            end
                        elseif GetVehiclePedIsIn(entity2, false) ~= 0 then
                            showVehicleMenu(GetVehiclePedIsIn(entity2, false))
                        else
                            vehmenuOpen = false
                            RageUI.CloseAll()
                            RageUI.Visible(mainMenuVeh, false)
                        end
                    end
                end
            end
        end
    end) -- by ins
end

local vehmenuOpen = false
local mainMenuVeh = RageUI.CreateMenu(InsConfig.MenuTitle, 'MENU GESTION VEHICULE')

function showVehicleMenu(veh)
    local vehicle = veh
    if vehmenuOpen then
        vehmenuOpen = false
        RageUI.CloseAll()
        RageUI.Visible(mainMenuVeh, false)
        Wait(10)
    end
    vehmenuOpen = true
    RageUI.Visible(mainMenuVeh, true)
    CreateThread(function()
        while vehmenuOpen do
            Wait(1)
            RageUI.IsVisible(mainMenuVeh, function()
                if InsHelper:getAcces(player, 'delVeh') then
                    RageUI.Button("Supprimer le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
                        onActive = function()
                            local vehiclePos = GetEntityCoords(vehicle)
                            DrawMarker(21, vehiclePos.x, vehiclePos.y, vehiclePos.z + 1.3, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 255, 0, 0, 255, true, true, p19, true)
                        end,
                        onSelected = function()
                            if DoesEntityExist(vehicle) then
                                deleteVeh(vehicle)
                            end
                        end
                    })
                else
                    RageUI.Button('Supprimer le véhicule', nil, {}, false, {})
                end
                if InsHelper:getAcces(player, 'repairVeh') then
                    RageUI.Button("Réparer le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
                        onActive = function()
                            local vehiclePos = GetEntityCoords(vehicle)
                            DrawMarker(21, vehiclePos.x, vehiclePos.y, vehiclePos.z + 1.3, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 255, 0, 0, 255, true, true, p19, true)
                        end,
                        onSelected = function()
                            if DoesEntityExist(vehicle) then
                                repairVeh(vehicle)
                            end
                        end
                    })
                else
                    RageUI.Button('Réparer le véhicule', nil, {}, false, {})
                end
                if InsHelper:getAcces(player, 'retournerVeh') then
                    RageUI.Button("Retourner le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
                        onActive = function()
                            local playerPed = PlayerPedId()
                            local playerCoords = GetEntityCoords(playerPed)
                            local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                            local vehiclePos = GetEntityCoords(vehicle)
                            DrawMarker(21, vehiclePos.x, vehiclePos.y, vehiclePos.z + 1.3, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 255, 0, 0, 255, true, true, p19, true)
                        end,
                        onSelected = function()
                            local playerPed = PlayerPedId()
                            local playerCoords = GetEntityCoords(playerPed)
                            local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                            --local modelName = KeyboardInput('InsPlate', "Veuillez entrer la "..c.."plaque~s~ du véhicule", '', 8)
            
                            if DoesEntityExist(vehicle) then
                                retournerVeh(vehicle, modelName)
                            end
                        end
                    })
                else
                    RageUI.Button('Retourner le véhicule', nil, {}, false, {})
                end
                if InsHelper:getAcces(player, 'fuelVeh') then
                    RageUI.Button("Faire le plein du véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
                        onActive = function()
                            local playerPed = PlayerPedId()
                            local playerCoords = GetEntityCoords(playerPed)
                            local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                            local vehiclePos = GetEntityCoords(vehicle)
                            DrawMarker(21, vehiclePos.x, vehiclePos.y, vehiclePos.z + 1.3, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3,0.3, 0.3, 255, 0, 0, 255, true, true, p19, true)
                        end,
                        onSelected = function()
                            local playerPed = PlayerPedId()
                            local playerCoords = GetEntityCoords(playerPed)
                            local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                            --local modelName = KeyboardInput('InsPlate', "Veuillez entrer la "..c.."plaque~s~ du véhicule", '', 8)
            
                            if DoesEntityExist(vehicle) then
                                gazVeh(vehicle, modelName)
                            end
                        end
                    })
                else
                    RageUI.Button('Faire le plein du véhicule', nil, {}, false, {})
                end
            end) -- by ins
        end
    end) -- by ins
end