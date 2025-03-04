function MyPlayer()
    RageUI.Button('TP Waypoint', nil, { RightLabel = InsConfig.RightLabel }, true, {
        onSelected = function()
            plyPed = PlayerPedId()
            local waypointHandle = GetFirstBlipInfoId(8)

            if DoesBlipExist(waypointHandle) then
                Citizen.CreateThread(function()
                    local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                    local foundGround, zCoords, zPos = false, 0.0, 0.0

                    while not foundGround do
                        zCoords = zCoords + 100.0
                        RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                        Wait(10)
                        foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

                        if not foundGround and zCoords >= 2000.0 then
                            foundGround = true
                        end
                    end

                    SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos + 2.0)
                    InsHelper:clientNotification("~g~Vous avez été téléporté !")
                end) -- by ins
            else
                InsHelper:clientNotification("~r~Aucun marker sur la carte !")
            end
        end
    })



RageUI.Button('NoClip', nil, { RightLabel = InsConfig.RightLabel }, true, {
    onSelected = function()
        ExecuteCommand('InsNoclip')
    end
})


RageUI.Checkbox("Invisible", nil, adminInvisibility, { }, {
    onSelected = function(Index)
        adminInvisibility = Index
        if adminInvisibility then
            SetEntityVisible(PlayerPedId(), false)
        else
            SetEntityVisible(PlayerPedId(), true)
        end
    end
})

RageUI.Button('Heal', nil, { RightLabel = InsConfig.RightLabel }, true, {
    onSelected = function()
        ExecuteCommand('heal ' .. GetPlayerServerId(PlayerId()))
    end
})

RageUI.Button('Revive', nil, { RightLabel = InsConfig.RightLabel }, true, {
    onSelected = function()
        ExecuteCommand('revive ' .. GetPlayerServerId(PlayerId()))
    end
})



end