InsStaffMode = false

RegisterKeyMapping('InsAdminmenu', 'Ouvrir le menu de modération', 'keyboard', 'F10')

open = false
player = false
j = json
adminPseudo = false
TpList = nil
Staffs = nil
PlayersList = nil
RanksList = {}
local firstopen = true
spectate = false
delgun = false
LettresItems = {"Aucun", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
LettresItemsIndex = 1
InsTeleportation = {Index = 1, "Goto", "Bring", "Bring back"}
InsGestinventory = {Index = 1, "Prendre", "Supprimer"}
IndexFasttravel = 1
InsRechercheSys = {"Pseudo", "ID", "Métier", "ID Unique"}   
InsRechercheSysIndex = 1
InsRecherche = 1
paramList = InsPermissions
playerGroup = nil
adminReportsWaiting = false
InsAdminSanctions = {Index = 1, "Warn", "Kick", "Jail", "Ban"}
sanctionSelectedName = '?'
sanctionSelectedId = '?'
Identifier = ''
InsShowInZone = false
InsShowStaff = false
c = InsConfig.ColorMenu
colorsNb = {
    ["1"] = 'red',
    ["2"] = 'orange',
    ["3"] = 'yellow',
    ["4"] = 'green',
    ["5"] = 'blue',
    ["6"] = 'purple',
    ["7"] = 'gray',
    ["8"] = 'white',
    ["9"] = 'black',
}
colorsText = {
    ['red'] = '~r~',
    ['orange'] = '~o~',
    ['yellow'] = '~y~',
    ['green'] = '~g~',
    ['blue'] = '~b~',
    ['purple'] = '~p~',
    ['gray'] = '~m~',
    ['white'] = '~s~',
    ['black'] = '~u~',
}

paraColorList = {Index = 1, "Rouge", "Orange", "Jaune", "Vert", "Bleu", "Violet", "Gris", "Blanc", "Noir"}
paramRank = {
    rank = nil,
    label = nil,
    power = nil,
    perms = nil,
    color = 'red',
}

RegisterNetEvent('Ins:receiveStaffInfosRanks')
AddEventHandler('Ins:receiveStaffInfosRanks', function(group)
    playerGroup = group
    player = playerGroup
end) -- by ins

RegisterNetEvent('Ins:RefreshClientInfos')
AddEventHandler('Ins:RefreshClientInfos', function(perms, desacAll)
    firstopen = true
    InsHelper:onStaffModeOFF()
    if noclipActive then
        ExecuteCommand('InsNoclip')
    end
    Callback.triggerServerCallback('InsAdmin:getRank', function(group)
        playerGroup = group
        player = playerGroup
    end) -- by ins

    adminStaffmode = false
    InsStaffMode = false
    isNameShown = false
    
    adminPseudo = false
    boolPseudo = false
    for i, v in pairs(Ins.GamerTags) do
        RemoveMpGamerTag(v.tags)
    end
    Ins.GamerTags = {};
    SetEntityVisible(PlayerPedId(), true)
    boolHud = false
    boolInvincible = false
    boolSuperjump = false
    boolCoords = false
    boolSupersprint = false

    playerGroup = perms
    player = playerGroup
    RageUI.CloseAll()
    open = false

    InsHelper:clientNotification('~g~Vos permissions ont été refresh !')
end) -- by ins

mainMenu = RageUI.CreateMenu(InsConfig.MenuTitle, InsConfig.MenuSubTitle, -1000, 0)
adminPerso = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'Préférences', -1000, 0)
adminillegal = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'Troll', -1000, 0)
alentour = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'Joueurs à proximité', -1000, 0)
myplayer = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'Mon joueur', -1000, 0)
adminRanks = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'MENU GESTION DES RANKS', -1000, 0)
adminRankscreate = RageUI.CreateSubMenu(adminRanks, InsConfig.MenuTitle, 'MENU GESTION DES RANKS', -1000, 0)
adminMyTeleports = RageUI.CreateSubMenu(adminPerso, InsConfig.MenuTitle, 'MENU TELEPORTATIONS', -1000, 0)
adminReports = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'MENU GESTION REPORTS', -1000, 0)
adminReportsActions = RageUI.CreateSubMenu(adminReports, InsConfig.MenuTitle, 'MENU GESTION DU REPORT', -1000, 0)
adminPlayers = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'MENU GESTION DES JOUEURS', -1000, 0)
adminStaffs = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'MENU GESTION DES STAFFS', -1000, 0)
adminVehicle = RageUI.CreateSubMenu(mainMenu, InsConfig.MenuTitle, 'MENU GESTION VEHICULE', -1000, 0)
adminGestPlayer = RageUI.CreateSubMenu(adminPlayers, InsConfig.MenuTitle, 'MENU GESTION DU JOUEUR', -1000, 0)
adminGestPlayerSanctions = RageUI.CreateSubMenu(adminGestPlayer, InsConfig.MenuTitle, 'MENU GESTION DES SANCTIONS', -1000, 0)
adminGestPlayerInventory = RageUI.CreateSubMenu(adminGestPlayer, InsConfig.MenuTitle, 'MENU GESTION INVENTAIRE', -1000, 0)
adminGestPlayerItems = RageUI.CreateSubMenu(adminGestPlayer, InsConfig.MenuTitle, 'MENU GESTION ITEMS', -1000, 0)
adminMyTeleports2 = RageUI.CreateSubMenu(adminGestPlayer, InsConfig.MenuTitle, 'MENU GESTION ITEMS', -1000, 0)

adminPlayerInfo = RageUI.CreateSubMenu(adminGestPlayer, "Administration", "Informations du joueur")


mainMenu.Closed = function()
	open = false
end

adminReportsActions.Closed = function()
	nlcReportList = nil
	TriggerServerEvent('Ins:GetReportList')
end

RegisterCommand('InsAdminmenu', function()
    scaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end
    if firstopen then
        Callback.triggerServerCallback('InsAdmin:getRank', function(group)
            playerGroup = group
            player = playerGroup
        end) -- by ins
        while playerGroup == nil do
            Wait(1)
        end
        if InsHelper:getAcces(player, 'menu') then
            OpenMenu()
        else
            InsHelper:clientNotification("~r~Vous n'avez pas la permission")
        end
        firstopen = false
    else
        if InsHelper:getAcces(player, 'menu') then
            OpenMenu()
        else
            InsHelper:clientNotification("~r~Vous n'avez pas la permission")
        end
    end
end) -- by ins



function OpenMenu()
    if open then
        open = false
        RageUI.CloseAll()
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true
        RageUI.Visible(mainMenu, true)
        -- Ins.Players = Ins.Helper:OnGetPlayers()
        -- Ins.PlayersStaff = Ins.Helper:OnGetStaffPlayers()
        CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()
                    MenuMain()
                end) -- by ins
                RageUI.IsVisible(adminRanks, function()
                    MenuRank()
                end) -- by ins
                RageUI.IsVisible(adminRankscreate, function()
                    MenuCreateRank()                
                end) -- by ins
                RageUI.IsVisible(adminReports, function()
                    MenuReportsMain()
                end) -- by ins
                RageUI.IsVisible(adminPlayers, function()
                    MenuPlayers()
                end) -- by ins
                RageUI.IsVisible(adminReportsActions, function()
                    MenuReportsActions()
                end) -- by ins
                RageUI.IsVisible(adminMyTeleports, function()
                    MenuTeleport()
                end) -- by ins
                RageUI.IsVisible(adminMyTeleports2, function()
                    MenuTeleport2()
                end) -- by ins
                RageUI.IsVisible(adminPerso, function()
                    MenuPersonnalMain()
                end) -- by ins
                RageUI.IsVisible(adminillegal, function()
                    Menuillegal()
                end) -- by ins
                RageUI.IsVisible(alentour, function()
                    Alentour()
                end) -- by ins
                RageUI.IsVisible(myplayer,function()
                    MyPlayer()
                end) -- by ins
                RageUI.IsVisible(adminStaffs, function()
                    MenuStaffs()
                end) -- by ins
                RageUI.IsVisible(adminVehicle, function()
                    MenuVehicle()
                end) -- by ins
                RageUI.IsVisible(adminGestPlayer, function()
                    menuGestPlayer()
                end) -- by ins
                RageUI.IsVisible(adminGestPlayerSanctions, function()
                    menuGestPlayerSantions()
                end) -- by ins
                RageUI.IsVisible(adminGestPlayerInventory, function()
                    menuGestPlayerInventory()
                end) -- by ins
                RageUI.IsVisible(adminGestPlayerItems, function()
                    menuGestPlayerItems()
                end) -- by ins
                Wait(1)
            end
        end) -- by ins
    end
end


if InsConfig.Authenticator then
    RegisterCommand('auth', function(source, args)
        print('Check server console')
        TriggerServerEvent('Ins:auth', args[1])
    end) -- by ins
end


local function ShowPedPreview(playerID)
    local pedModel = GetEntityModel(GetPlayerPed(playerID)) -- Récupère le modèle du ped
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end

    -- Position pour prévisualiser le ped
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local displayPed = CreatePed(4, pedModel, x + 2.0, y, z, 0.0, false, true)
    SetEntityVisible(displayPed, true, false)
    SetEntityInvincible(displayPed, true)
    FreezeEntityPosition(displayPed, true)

    -- Supprime le ped après fermeture
    Citizen.Wait(5000) -- Temps d'affichage (par exemple 5 secondes)
    DeleteEntity(displayPed)
end
