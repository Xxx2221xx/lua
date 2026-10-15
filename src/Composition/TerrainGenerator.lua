-- src/Composition/TerrainGenerator.lua
local Config = require(game.ServerScriptService.src.Config)

local TerrainGenerator = {}

local TERRAIN_MATERIAL_MAP = {
    ["grass"] = Enum.Material.Grass,
    ["sand"] = Enum.Material.Sand,
    ["snow"] = Enum.Material.Snow,
    ["rock"] = Enum.Material.Rock,
    ["water"] = Enum.Material.Water,
    ["concrete"] = Enum.Material.Concrete,
    ["mud"] = Enum.Material.Mud,
}

function TerrainGenerator.generateTerrain(sceneConfig)
    local terrain = Instance.new("Terrain")
    terrain.Parent = workspace

    local terrainType = sceneConfig.terrain_type or "grass"
    local material = TERRAIN_MATERIAL_MAP[terrainType] or Enum.Material.Grass

    local size = Config.TERRAIN_SIZE
    local baseHeight = 10

    terrain:FillBall(Vector3.new(size/2, baseHeight, size/2), 50, material)

    local features = sceneConfig.terrain_features or {}
    for _, feature in ipairs(features) do
        if feature == "rolling_hills" then
            for i = 1, 5 do
                local x = math.random(20, size - 20)
                local z = math.random(20, size - 20)
                local h = baseHeight + math.random(10, 30)
                terrain:FillBall(Vector3.new(x, h, z), 30, material)
            end
        elseif feature == "cliff" then
            local x = size / 2
            local z = size / 2
            for i = 1, 15 do
                terrain:FillBall(Vector3.new(x + i*5, baseHeight + i*5, z), 20, material)
            end
        end
    end

    return terrain
end

return TerrainGenerator
