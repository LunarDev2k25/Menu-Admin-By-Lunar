local colour_index= {
	primary = {1,5},
	secondary = {1,5}
}

local selectedPrimaryColor = {
	r = 0,
	g = 0,
	b = 0,
}

function MenuVehicle()
    if IsControlPressed(0, 19) then
        SetMouseCursorActiveThisFrame()
    end
    if InsHelper:getAcces(player, 'spawnVeh') then
        RageUI.Button("Spawn un véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onSelected = function()
                local modelName = exports['input']:ShowSync('Nom du véhicule', nil, 320., 'small_text')
                InsHelper:spawnVehicle(modelName)
            end
        })
    else
        RageUI.Button('Spawn un véhicule', nil, {}, false, {})
    end
    if InsHelper:getAcces(player, 'repairVeh') then
        RageUI.Button("Réparer le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
            end,
            onSelected = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)

                if DoesEntityExist(vehicle) then
                    repairVeh(vehicle)
                end
            end
        })
    else
        RageUI.Button('Réparer le véhicule', nil, {}, false, {})
    end
    if InsHelper:getAcces(player, 'fuelVeh') then
        RageUI.Button("Essence maximale", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
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
        RageUI.Button('Essence maximum', nil, {}, false, {})
    end

    if InsHelper:getAcces(player, 'fullPerf') then
        RageUI.Button("Performance maximum", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onSelected = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
    
                if DoesEntityExist(vehicle) then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 11, 3, false)
                    SetVehicleMod(vehicle, 12, 2, false)
                    SetVehicleMod(vehicle, 13, 2, false)
                    SetVehicleMod(vehicle, 15, 3, false)
                    SetVehicleMod(vehicle, 16, 4, false)
                    ToggleVehicleMod(vehicle, 17, true)
                    ToggleVehicleMod(vehicle, 18, true)
                    ToggleVehicleMod(vehicle, 19, true)
                    ToggleVehicleMod(vehicle, 21, true)
                    SetVehicleTyresCanBurst(vehicle, false)
                    SetVehicleWheelType(vehicle, 7)
                    SetVehicleMod(vehicle, 23, 21, false)
                    SetVehicleMod(vehicle, 24, 21, false)
                    SetVehicleNumberPlateTextIndex(vehicle, 5)
                    InsHelper:clientNotification("~g~Véhicule full performance !")
                end
            end
        })
    else
        RageUI.Button('Performance maximum', nil, {}, false, {})
    end

    if InsHelper:getAcces(player, 'maxArmor') then
        RageUI.Button("Blindage Maximum", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onSelected = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
    
                if DoesEntityExist(vehicle) then
                    SetVehicleModKit(vehicle, 0)
                    SetVehicleMod(vehicle, 16, 4, false)
                    SetVehicleMod(vehicle, 15, 3, false)
                    SetVehicleMod(vehicle, 14, 14, false)
                    SetVehicleMod(vehicle, 13, 2, false)
                    SetEntityHealth(vehicle, 1000)
                    SetVehicleWindowTint(vehicle, 1)
                    InsHelper:clientNotification("~g~Blindage maximum appliqué !")
                end
            end
        })
    else
        RageUI.Button('Blindage Maximum', nil, {}, false, {})
    end
    
    
    
    
    if InsHelper:getAcces(player, 'cleanVeh') then
        RageUI.Button("Nettoyer le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
            end,
            onSelected = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)

                if DoesEntityExist(vehicle) then
                    cleanVeh(vehicle)
                end
            end
        })
    else
        RageUI.Button('Nettoyer le véhicule', nil, {}, false, {})
    end
  --[[ if InsHelper:getAcces(player, 'plateVeh') then
        RageUI.Button("Changer la plaque", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
            end,
            onSelected = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local modelName = exports['input']:ShowSync('Changer la plaque', nil, 320., 'small_text')

                if DoesEntityExist(vehicle) then
                    plateVeh(vehicle, modelName)
                end
            end
        })
    else
        RageUI.Button('Changer la plaque', nil, {}, false, {})
    end --]]
 --[[   if InsHelper:getAcces(player, 'retournerVeh') then
        RageUI.Button("Freeze/Unfreeze", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
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
        RageUI.Button('Freeze/Unfreeze', nil, {}, false, {})
    end --]]
    if InsHelper:getAcces(player, 'retournerVeh') then
        RageUI.Button("Retourner le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
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
    if InsHelper:getAcces(player, 'delVeh') then
        RageUI.Button("Supprimer le véhicule", nil, {RightLabel = InsConfig.RightLabel}, true, {
            onActive = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)
                local vehiclePos = GetEntityCoords(vehicle)
            end,
            onSelected = function()
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local vehicle = ESX.Game.GetClosestVehicle(playerCoords)

                if DoesEntityExist(vehicle) then
                    deleteVeh(vehicle)
                end
            end
        })
    else
        RageUI.Button('Supprimer le véhicule', nil, {}, false, {})
    end
end