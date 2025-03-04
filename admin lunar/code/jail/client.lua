Citizen.CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsPlayerActive(PlayerId()) then
            Callback.triggerServerCallback('Ins:getJail', function(table)
                if table then
                    openjailMenu(table)
                end
            end) -- by ins
            break
		end
	end
end) -- by ins

local jail = {
    open = false,
}

mainMenujail = RageUI.CreateMenu('Jail', 'MENU DE PRISON')
mainMenujail.Closable = false

RegisterNetEvent('Ins:SendClientToJail')
AddEventHandler('Ins:SendClientToJail', function(table)
    openjailMenu(table)
end) -- by ins

local time = 999999999 

function boolCountjailTime(timeGet)
    time = timeGet / 60
    CreateThread(function()
        while jail.open do
            Wait(1000 * 60)
            if time == 0 then
                jail.open = false
            else
                time = time - 1
            end
            TriggerServerEvent('Ins:updatejailTime')
        end
    end) -- by ins
end

RegisterNetEvent('Ins:finishjailTime')
AddEventHandler('Ins:finishjailTime', function(table)
    jail.open = false
    RageUI.CloseAll()
    Wait(100)
    SetEntityCoords(PlayerPedId(), InsConfig.PrisonExit)
    if InsConfig.GiveVehicleOnExit then
        InsHelper:spawnVehicle(InsConfig.GiveVehicleOnExit)
    end
end) -- by ins

function openjailMenu(table)
    jail.open = false
    RageUI.CloseAll()
    Wait(100)
    SetEntityCoords(PlayerPedId(), InsConfig.PrisonPos)
    boolCountjailTime(tonumber(table.time))
    jail.open = true
    RageUI.Visible(mainMenujail, true)
    CreateThread(function()
        while jail.open do
            Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), InsConfig.PrisonPos, true) > InsConfig.Distance then
                SetEntityCoords(PlayerPedId(), InsConfig.PrisonPos)
            end
            RageUI.IsVisible(mainMenujail, function()
                -- RageUI.Separator('Vous avez été jail par '..table.staffName)
                -- --RageUI.Separator('Vous avez été jail par '..table.staffName)
                -- --RageUI.Button('Il vous reste encore '..time..' minutes et ', nil, {}, true, {})
                -- --RageUI.Button('Jail le '..table.date, nil, {}, true, {})
                -- --RageUI.Button('Vous avez été jail par '..table.staffName, nil, {}, true, {})
                -- RageUI.Button('Il vous reste '..time..' secondes', nil, {}, true, {})
                RageUI.Separator('↓ Vous êtes actellement en prison ↓')
                if time == 1 then
                    RageUI.Button(("Temps restant :"), 'Pour contester une sanction, merci de se rendre dans le salon vocal besoin d\'aide sur le Discord du serveur', {RightLabel = ''..time..' minute'}, true, {})
                else
                    RageUI.Button(("Temps restant :"), 'Pour contester une sanction, merci de se rendre dans le salon vocal besoin d\'aide sur le Discord du serveur', {RightLabel = ''..time..' minutes'}, true, {})
                end
                RageUI.Button(("Jail par :"), 'Pour contester une sanction, merci de se rendre dans le salon vocal besoin d\'aide sur le Discord du serveur', {RightLabel = ''..table.staffName..''}, true, {})
                RageUI.Button(("Raison du jail :"), 'Pour contester une sanction, merci de se rendre dans le salon vocal besoin d\'aide sur le Discord du serveur', {RightLabel = ''..table.raison..''}, true, {})
                RageUI.Separator('↓ Pour contester une sanction ↓')
            end) -- by ins
        end
    end) -- by ins
end