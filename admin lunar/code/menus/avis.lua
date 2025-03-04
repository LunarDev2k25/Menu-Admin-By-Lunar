--TriggerClientEvent('Ins:LaisseUnAvis', player.source, InsHelper:getIdentifier(xPlayer.source))

RegisterNetEvent('Ins:LaisseUnAvis')
AddEventHandler('Ins:LaisseUnAvis', function(staffName)
    openAvisMenu(staffName)
end) -- by ins

local avis = {
    open = false,
}

mainMenuAvis = RageUI.CreateMenu('Avis', 'MENU NOTER LE STAFF')
avis = {Index = 3, "1/5", "2/5", "3/5", "4/5", "5/5"}
mainMenuAvis.Closed = function()
	avis.open = false
    -- InsHelper:clientNotification('~r~Aucune note attribué')
    TriggerServerEvent('InsAdmin:setAvisStaff', 5)
end

function openAvisMenu(staffName)
    avis.open = false
    open = false
    Wait(100)
    if staffName then
        avis.open = true
        RageUI.Visible(mainMenuAvis, true)
        CreateThread(function()
            while avis.open do
                Wait(1)
                RageUI.IsVisible(mainMenuAvis, function()
                    RageUI.Separator('Laisser un avis sur le staff '..InsConfig.ColorMenu..'"'..staffName..'"')
                    RageUI.List("Note pour le staff", avis, (avis.Index or 1), 'Une note de 5/5 sera donné si vous fermez ce menu', {}, true, {
                        onListChange = function(Index)
                            avis.Index = Index
                        end,
                        onSelected = function(Index)
                            RageUI.CloseAll()
                            avis.open = false
                            TriggerServerEvent('InsAdmin:setAvisStaff', avis.Index)
                        end,
                    })
                    RageUI.Button('Envoyer la note pour le staff', 'Une note de 5/5 sera donné si vous fermez ce menu', {RightLabel = InsConfig.RightLabel}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                            avis.open = false
                            TriggerServerEvent('InsAdmin:setAvisStaff', avis.Index)
                        end
                    })
                end) -- by ins
            end
        end) -- by ins
    end
end