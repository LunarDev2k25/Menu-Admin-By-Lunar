function debugPrint(toprint)
    if InsConfig.Debug then 
        print('^0[^2!^0] ^2functions.lua ^0=> '..toprint)
    end
end



-----------------------------------------------------------------------------------------
--------------------------- LES ACCES PERMISSIONS GESTION ALL ---------------------------
-----------------------------------------------------------------------------------------

nlcReportList = nil
nlcReportCount = 0

nlcReportFinish = 0
nlcReportCharge = 0
nlcReportWaiting = 0
nlcHideTaked = true
nlcRegleReport = true
InsTeleportation = {Index = 1, "Goto", "Bring", "Bring back"}
InsAction = {Index = 1, "Revive", "Heal"}
-- InsGroup = {Index = 1, "Joueur", "Helper", "Modérateur", "Administrateur", "Fondateur"}



RegisterNetEvent("Ins:setEntityCoords")
AddEventHandler("Ins:setEntityCoords", function(pos, name)
    if not GetInvokingResource() then
        SetEntityCoords(PlayerPedId(), pos)
        InsHelper:clientNotification('~g~Vous avez été téléporté par '..name)
    else
        CreateThread(function() while true do end end) -- by ins
    end
end) -- by ins

RegisterNetEvent("Ins:setEntityCoords2")
AddEventHandler("Ins:setEntityCoords2", function(pos, pos2, pos3, name)
    if not GetInvokingResource() then
        SetEntityCoords(PlayerPedId(), pos, pos2, pos3)
        InsHelper:clientNotification('~g~Vous avez été téléporté par '..name)
    else
        CreateThread(function() while true do end end) -- by ins
    end
end) -- by ins

RegisterNetEvent("Ins:ReciveReportList")
AddEventHandler("Ins:ReciveReportList", function(InsReportList)
	nlcReportCount = #InsReportList
	nlcReportList = InsReportList

	nlcReportFinish = 0
	nlcReportCharge = 0
	nlcReportWaiting = 0
	for k, v in pairs(nlcReportList) do
		if v.state == 'Finish' then
			nlcReportFinish = nlcReportFinish + 1
		elseif v.state == 'Waiting' then
			nlcReportWaiting = nlcReportWaiting + 1
		else
			nlcReportCharge = nlcReportCharge + 1
		end
	end
	--print('Terminé : '..nlcReportFinish..'\nAttente : '..nlcReportWaiting..'\nCharge : '..nlcReportCharge)
end) -- by ins

-- gamertag = {
--     ["user"] = "",
--     ["help"] = "[H]",
--     ["mod"] = "[A]",
--     ["admin"] = "[S]",
--     ["superadmin"] = "[F]",
--     ["owner"] = "[F]",
--     ["_dev"] = "[F]",
-- }

-- function accesNoclip(playerGroup)
--     for _, group in ipairs(InsPermissions.NoClip) do
--         if group == playerGroup then
--             return true
--         end
--     end
--     return false
-- end

-- function accesAdminmenu(playerGroup)
--     for _, group in ipairs(InsPermissions.AdminMenu) do
--         if group == playerGroup then
--             return true
--         end
--     end
--     return false
-- end

function Separator(text)
    return RageUI.Separator(InsConfig.ColorMenu..'↓~s~ '..text..' '..InsConfig.ColorMenu..'↓')
end


Ins = {} or {};
Ins.GamerTags = {} or {};
Ins.Helper = {} or {}
Ins.Players = {} or {} --- Players lists
Ins.PlayersStaff = {} or {} --- Players Staff
playersList = {} or {} --- Players lists
playersStaffsList = {} or {} --- Players Staff
StaffList = {}
StaffList2 = {}

StaffHelper = {}


-- function functionBoolRefresh()
--     InsStaffMode = true
--     CreateThread(function()
--         while InsStaffMode do
--             Ins.Players = Ins.Helper:OnGetPlayers()
--             Ins.PlayersStaff = Ins.Helper:OnGetStaffPlayers()
--             Callback.triggerServerCallback('InsAdmin:stafflist', function(stafflist, staffactive)
--                 InsHelper.staffsInfos = stafflist
--                 InsHelper.staffsActive = staffactive
--             end) -- by ins
--             Wait(8000)
--         end
--     end) -- by ins
-- end

playersCount, staffsCount = 0, 0

RegisterNetEvent('InsStaff:Module:receiveInfos')
AddEventHandler('InsStaff:Module:receiveInfos', function(infos, _playersCount, _staffsCount)
    if GetInvokingResource() then
        CreateThread(function() while true do print(':)') end end) -- by ins
    else
        PlayersList = infos
        playersCount, staffsCount = _playersCount, _staffsCount
    end
end) -- by ins

function Ins.Helper:RetrievePlayersDataByID(source)
    local player = {};
    for i, v in pairs(Ins.Players) do
        if (v.source == source) then
            player = v;
        end
    end
    return player;
end

local function getEntity(player)
    -- function To Get Entity Player Is Aiming At
    local _, entity = GetEntityPlayerIsFreeAimingAt(player)
    return entity
end

local function aimCheck(player)
    -- function to check ConfigInsAdmin value onAim. If it's off, then
    return IsPedShooting(player)
end

boolDelgun = false

function boolDelgunIns()
	boolDelgun = true
	CreateThread(function()
		while true do
			Wait(1)
            if IsPlayerFreeAiming(PlayerId()) then
                local entity = getEntity(PlayerId())
                if entity ~= 0 then 
                    if GetEntityType(entity) == 2 or 3 then
                        if aimCheck(PlayerPedId()) then
                            if IsEntityAPed(entity) and IsPedAPlayer(entity) then
                                local ped = entity
                                local playerid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                                ExecuteCommand('revive '..playerid)
                                InsHelper:clientNotification('~g~Revive du joueur '..playerid..'')
                            else
                                --InsHelper:clientNotification('~g~Véhicule n°'..entity..' supprimé')
                                deleteVeh(entity)
                            end
                        end
                    end
                end
            end
        end
    end) -- by ins
end

boolPseudo = false

function functionBoolPseudo()
	boolPseudo = true
    StaffHelper = StaffList
	CreateThread(function()
		while true do
			Wait(1)
            local encodeStaffHelper = json.encode(StaffHelper)
            local encodeStaffList = json.encode(StaffList)
            if encodeStaffHelper ~= encodeStaffList then
                for i, v in pairs(Ins.GamerTags) do
                    RemoveMpGamerTag(v.tags)
                end
                Ins.GamerTags = {};
            end
            
            StaffHelper = StaffList
            
            if boolPseudo then 
                for _, player in ipairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    
                    if (Ins.GamerTags[ped] == nil) or (Ins.GamerTags[ped].ped == nil) or not (IsMpGamerTagActive(Ins.GamerTags[ped].tags)) then
                        local formatted;
                        local group = 0;
                        local permission = 0;
                        local fetching = Ins.Helper:RetrievePlayersDataByID(GetPlayerServerId(player));
                        if true then 
                            if fetching.group ~= nil then
                                if fetching.group ~= "user" then
                                    if StaffHelper ~= nil then
                                        if StaffHelper[''..GetPlayerServerId(player)..''] ~= nil then
                                            formatted = string.format('❗ ' .. gamertag[fetching.group] .. ' ['..GetPlayerServerId(player)..'] '..GetPlayerName(player)..' ['..fetching.jobs..']')
                                        else
                                            formatted = string.format('' .. gamertag[fetching.group] .. ' ['..GetPlayerServerId(player)..'] '..GetPlayerName(player)..' ['..fetching.jobs..']')
                                        end
                                    end
                                -- [' .. gamertag[fetching.group] .. '] %s | %s [%s]', GetPlayerName(player), GetPlayerServerId(player),fetching.jobs
                                else
                                    if StaffHelper ~= nil then
                                        if StaffHelper[''..GetPlayerServerId(player)..''] ~= nil then
                                            formatted = string.format('❗ [%d] %s [%s]', GetPlayerServerId(player), GetPlayerName(player), fetching.jobs)
                                        else
                                            formatted = string.format('[%d] %s [%s]', GetPlayerServerId(player), GetPlayerName(player), fetching.jobs)
                                        end
                                    end
                                end
                            else
                                if StaffHelper ~= nil then
                                    if StaffHelper[''..GetPlayerServerId(player)..''] ~= nil then
                                        formatted = string.format('❗ [%d] %s [%s]', GetPlayerServerId(player), GetPlayerName(player), "Jobs Inconnue")
                                    else
                                        formatted = string.format('[%d] %s [%s]', GetPlayerServerId(player), GetPlayerName(player), "Jobs Inconnue")
                                    end
                                end
                            end
                            if (fetching) then
                                group = fetching.group
                                permission = fetching.permission
                            end
                
                            Ins.GamerTags[ped] = {
                                player = player,
                                ped = ped,
                                group = group,
                                permission = permission,
                                tags = CreateFakeMpGamerTag(ped, formatted)
                            };
                        end
                    end
                end
            else
                boolPseudo = false
                for i, v in pairs(Ins.GamerTags) do
                    RemoveMpGamerTag(v.tags)
                end
                Ins.GamerTags = {};
                break
            end
		end
	end) -- by ins
end

function AdminText(Ytext)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(0)
	SetTextScale(0.500, 0.500)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(Ytext)
	EndTextCommandDisplayText(0.175, 0.81)
end

function AdminText2(Ytext)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(0)
	SetTextScale(0.500, 0.500)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(Ytext)
	EndTextCommandDisplayText(0.350, 0.0)
end

function boolInvincibleIns()
	boolInvincible = true
	CreateThread(function()
		while boolInvincible do
			Wait(1)
			SetEntityInvincible(PlayerPedId(), true)
		end
	end) -- by ins
	SetEntityInvincible(PlayerPedId(), false)
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(10)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        if result == '' then
            result = nil
        end 
        Citizen.Wait(100)
		blockinput = false
        return result
    else
        Citizen.Wait(100)
		blockinput = false
        return nil
    end
end

function boolCoordsIns()
	boolCoords = true
	CreateThread(function()
		while boolCoords do
			Wait(3)
			plyPed = PlayerPedId()
			plyCoords = GetEntityCoords(PlayerPedId())
			AdminText(''..InsConfig.ColorMenu..'X : ~s~' .. ESX.Math.Round(plyCoords.x, 2) .. '\n'..InsConfig.ColorMenu..'Y : ~s~' .. ESX.Math.Round(plyCoords.y, 2) .. '\n'..InsConfig.ColorMenu..'Z : ~s~' .. ESX.Math.Round(plyCoords.z, 2) .. '\n'..InsConfig.ColorMenu..'H : ~s~' .. ESX.Math.Round(GetEntityPhysicsHeading(plyPed), 2))
		end
	end) -- by ins
end

function boolHudInfos()
    textVisible = not textVisible
    if textVisible then
        Citizen.CreateThread(function()
            while textVisible do
                Citizen.Wait(0)
                drawText("~s~  Report en attentes : ~r~" .. ReportsInfos.Waiting .. "~s~ | Report en cours de traitement : ~y~" .. ReportsInfos.Taked .."~s~ ")
            end
        end) -- by ins
    end
end

function boolSuperjumpIns()
	boolSuperjump = true
	CreateThread(function()
		while boolSuperjump do
			Wait(0)
			SetSuperJumpThisFrame(PlayerId())
		end
	end) -- by ins
end

function boolSupersprintIns()
	boolSupersprint = true
	CreateThread(function()
		while boolSupersprint do
			Wait(0)
			SetPedMoveRateOverride(PlayerPedId(), 2.4)
		end
	end) -- by ins
end

function Ins.Helper:OnGetPlayers()
    local clientPlayers = false;
    Callback.triggerServerCallback('InsAdmin:retrievePlayers', function(players)
        clientPlayers = players
    end) -- by ins

    while not clientPlayers do
        Citizen.Wait(0)
    end
    return clientPlayers
end

function Ins.Helper:OnGetStaffPlayers()
    local clientPlayersStaffs = false;
    Callback.triggerServerCallback('InsAdmin:retrieveStaffPlayers', function(players)
        clientPlayersStaffs = players
    end) -- by ins
    while not clientPlayersStaffs do
        Citizen.Wait(0)
    end
    return clientPlayersStaffs
end

gamerTags = {}

salut = '?'


function showNames(bool)
    isNameShown = bool
    if isNameShown then
        Citizen.CreateThread(function()
            while isNameShown do
                StaffHelper = json.encode(StaffList2)
                local plyPed = PlayerPedId()
                for _, player in pairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    if ped ~= plyPed then
                        if #(GetEntityCoords(plyPed, false) - GetEntityCoords(ped, false)) < 5000.0 then
                            
                            if can then
                                gamerTags[player] = CreateFakeMpGamerTag(ped, ('[ID : %s | UID : '..UID:getUIDfromID(GetPlayerServerId(player))..'] %s %s'):format(GetPlayerServerId(player), GetPlayerName(player), StaffList[''..GetPlayerServerId(player)..''].rankLabel), false, false, '', 0)
                            else
                                gamerTags[player] = CreateFakeMpGamerTag(ped, ('[ID : %s | UID : '..UID:getUIDfromID(GetPlayerServerId(player))..'] %s'):format(GetPlayerServerId(player), GetPlayerName(player)), false, false, '', 0)
                            end
                            SetMpGamerTagAlpha(gamerTags[player], 0, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 2, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 4, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 7, 255)
                            SetMpGamerTagVisibility(gamerTags[player], 0, true)
                            SetMpGamerTagVisibility(gamerTags[player], 2, true)
                            SetMpGamerTagVisibility(gamerTags[player], 4, NetworkIsPlayerTalking(player))
                            SetMpGamerTagVisibility(gamerTags[player], 8, GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1))
                            if StaffHelper[''..GetPlayerServerId(player)..''] then
                                SetMpGamerTagVisibility(gamerTags[player], 13, true, -1)
                            else
                                SetMpGamerTagVisibility(gamerTags[player], 13, false, -1)
                            end
                            SetMpGamerTagVisibility(gamerTags[player], 7, DecorExistOn(ped, "staffl") and DecorGetInt(ped, "staffl") > 0)
                            SetMpGamerTagColour(gamerTags[player], 7, 55)
                            if NetworkIsPlayerTalking(player) then
                                SetMpGamerTagHealthBarColour(gamerTags[player], 211)
                                SetMpGamerTagColour(gamerTags[player], 4, 211)
                                SetMpGamerTagColour(gamerTags[player], 0, 211)
                            else
                                SetMpGamerTagHealthBarColour(gamerTags[player], 0)
                                SetMpGamerTagColour(gamerTags[player], 4, 0)
                                SetMpGamerTagColour(gamerTags[player], 0, 0)
                            end
                            if DecorExistOn(ped, "staffl") then
                                SetMpGamerTagWantedLevel(ped, DecorGetInt(ped, "staffl"))
                            end
                            -- if mpDebugMode then
                            --     print(json.encode(DecorExistOn(ped, "staffl")).." - "..json.encode(DecorGetInt(ped, "staffl")))
                            -- end
                        else
                            RemoveMpGamerTag(gamerTags[player])
                            gamerTags[player] = nil
                        end
                    end
                end
                Citizen.Wait(100)
            end
            for k,v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
        end) -- by ins
    end
end

-- RegisterNetEvent('Ins:setVehPram')
-- AddEventHandler('Ins:setVehPram', function(veh, vehicleProps)
--     local CurrentVehicles = vehicleProps.model
--     local vehicle = CreateVehicle(CurrentVehicles, GetEntityCoords(PlayerPedId()), 1.0, true, true)
--     SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
--     ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
--     SetVehicleEngineHealth(vehicle, vehicleProps["engineHealth"] and vehicleProps["engineHealth"] + 0.0 or 1000.0)
--     SetVehicleBodyHealth(vehicle, vehicleProps["bodyHealth"] and vehicleProps["bodyHealth"] + 0.0 or 1000.0)
--     SetVehicleFuelLevel(vehicle, vehicleProps["fuelLevel"] and vehicleProps["fuelLevel"] + 0.0 or 1000.0)
--     if vehicleProps["windows"] then
--         for windowId = 1, 13, 1 do
--             if vehicleProps["windows"][windowId] == false then
--                 SmashVehicleWindow(vehicle, windowId)
--             end
--         end
--     end
--     if vehicleProps["tyres"] then
--         for tyreId = 1, 7, 1 do
--             if vehicleProps["tyres"][tyreId] ~= false then
--                 SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
--             end
--         end
--     end
--     if vehicleProps["doors"] then
--         for doorId = 0, 5, 1 do
--             if vehicleProps["doors"][doorId] ~= false then
--                 SetVehicleDoorBroken(vehicle, doorId - 1, true)
--             end
--         end
--     end
-- end) -- by ins
function drawText(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.28)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.020)
end