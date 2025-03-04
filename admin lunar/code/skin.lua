--[[local playerSkin = nil

function applySkin(outfitNumber)
    if InsConfig.staffSkins[outfitNumber] then
        TriggerEvent('skinchanger:getSkin', function(skin)
            playerSkin = {
                sex = skin.sex,
                tshirt_1 = skin.tshirt_1,
                tshirt_2 = skin.tshirt_2,
                torso_1 = skin.torso_1,
                torso_2 = skin.torso_2,
                arms = skin.arms,
                pants_1 = skin.pants_1,
                pants_2 = skin.pants_2,
                shoes_1 = skin.shoes_1,
                shoes_2 = skin.shoes_2,
            }
            TriggerEvent('skinchanger:loadSkin', InsConfig.staffSkins[outfitNumber])
        end) -- by ins
    end
end

function resetSkin()
    if playerSkin then
        TriggerEvent('skinchanger:loadSkin', playerSkin)
        playerSkin = nil
    end
end
--]]