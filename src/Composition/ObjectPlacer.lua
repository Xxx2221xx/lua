-- src/Composition/ObjectPlacer.lua
local Config = require(game.ServerScriptService.src.Config)

local ObjectPlacer = {}

function ObjectPlacer.placeObjects(modelUrl, sceneConfig)
    local primaryObject = Instance.new("MeshPart")
    primaryObject.Name = "PrimaryObject"
    primaryObject.Size = Vector3.new(100, 100, 100)
    primaryObject.Position = Vector3.new(Config.TERRAIN_SIZE / 2, 50, Config.TERRAIN_SIZE / 2)
    primaryObject.CanCollide = false
    primaryObject.Parent = workspace

    local secondaryObjects = {}
    local secondaryCount = 0
    local maxSecondary = Config.MAX_SECONDARY_OBJECTS

    for _, objConfig in ipairs(sceneConfig.secondary_objects or {}) do
        local objType = objConfig.type
        local count = objConfig.count or 1
        local basePos = objConfig.position or {50, 50}

        if secondaryCount >= maxSecondary then break end

        for i = 1, count do
            if secondaryCount >= maxSecondary then break end

            local obj = Instance.new("Part")
            obj.Name = objType .. "_" .. i
            obj.Shape = Enum.PartType.Ball
            obj.Size = Vector3.new(5, 5, 5)
            obj.BrickColor = BrickColor.new("Medium stone grey")
            obj.Position = Vector3.new(
                basePos[1] + math.random(-20, 20),
                20,
                basePos[2] + math.random(-20, 20)
            )
            obj.CanCollide = false
            obj.Parent = workspace

            table.insert(secondaryObjects, obj)
            secondaryCount = secondaryCount + 1
        end
    end

    return primaryObject, secondaryObjects
end

return ObjectPlacer
