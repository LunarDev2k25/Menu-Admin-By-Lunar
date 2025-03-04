function Alentour()
    local filterType = "none"
    local filteredPlayer = nil
    
    RageUI.Button('Filtrer', "Entrez un ID ou un nom", { RightLabel = "→→" }, true, {
        onSelected = function()
            local input = KeyboardInput("ID ou Nom du joueur", "", 30)
            if input then
                if tonumber(input) then
                    for k, v in pairs(PlayersList) do
                        if v.source == tonumber(input) then
                            selectedPlayer = k
                            break
                        end
                    end
                else
                    for k, v in pairs(PlayersList) do
                        if string.find(string.lower(v.name), string.lower(input)) then
                            selectedPlayer = k
                            break
                        end
                    end
                end
            end
        end
    })
        for _, playerId in ipairs(GetActivePlayers()) do
            local coords = GetEntityCoords(PlayerPedId())
            local targetCoords = GetEntityCoords(GetPlayerPed(playerId))
            local distance = #(coords - targetCoords)
            if distance <= 50.0 then
                for k, v in pairs(PlayersList) do
                    if v.source == GetPlayerServerId(playerId) then
                        RageUI.Button(v.name.." ["..v.source.."] - "..math.floor(distance).."m", nil, { RightLabel = "→→" }, true, {
                            onSelected = function()
                                selectedPlayer = k
                                RageUI.Visible(adminGestPlayer, true)
                            end
                        })
                    end
                end
            end
        end
    end
    