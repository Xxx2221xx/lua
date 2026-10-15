-- src/Visual/MaterialLibrary.lua
local MaterialLibrary = {}

local MATERIALS = {
    ["metal_polished"] = {enum = Enum.Material.Metal, color = Color3.fromRGB(200, 200, 200)},
    ["rock_rough"] = {enum = Enum.Material.Rock, color = Color3.fromRGB(120, 100, 80)},
    ["grass"] = {enum = Enum.Material.Grass, color = Color3.fromRGB(50, 150, 50)},
    ["water"] = {enum = Enum.Material.Water, color = Color3.fromRGB(50, 100, 200)},
    ["concrete"] = {enum = Enum.Material.Concrete, color = Color3.fromRGB(150, 150, 150)},
}

function MaterialLibrary.applyMaterial(part, materialType)
    local matDef = MATERIALS[materialType]

    if not matDef then
        warn("Material type not found: " .. tostring(materialType))
        return false
    end

    part.Material = matDef.enum
    part.Color = matDef.color

    return true
end

function MaterialLibrary.getMaterials()
    return MATERIALS
end

return MaterialLibrary
