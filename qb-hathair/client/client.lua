
QBCore = exports['qb-core']:GetCoreObject()

local savedHair = nil

-- Function to check if the ped is male
local function isMalePed(ped)
    local model = GetEntityModel(ped)
    return model == GetHashKey("mp_m_freemode_01")
end

RegisterCommand("hathair", function(source, args, rawCommand)
    local ped = PlayerPedId()
    local isMale = isMalePed(ped)

    if savedHair == nil then
        -- Save the current hair
        local hairDrawable = GetPedDrawableVariation(ped, 2)
        local hairTexture = GetPedTextureVariation(ped, 2)
        savedHair = {drawable = hairDrawable, texture = hairTexture}

        -- Set the player to be bald based on gender
        if isMale then
            SetPedComponentVariation(ped, 2, 1, 0, 2)  -- Male bald hairstyle
        else
            SetPedComponentVariation(ped, 2, 0, 0, 2)  -- Female bald hairstyle
        end
        QBCore.Functions.Notify("Your hair has been saved and you are now bald.", "success")
    else
        -- Restore the saved hair
        SetPedComponentVariation(ped, 2, savedHair.drawable, savedHair.texture, 2)
        savedHair = nil
        QBCore.Functions.Notify("Your hair has been restored.", "success")
    end
end, false)

-- Debug to ensure the script is loaded
print("qb-hathair script loaded successfully")
