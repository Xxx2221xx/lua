-- tests/ProceduralSceneGenerator_test.lua
local ProceduralSceneGenerator = require(game.ServerScriptService.src.Generation.ProceduralSceneGenerator)

local function testForestScene()
    local config = ProceduralSceneGenerator.generateScene("a beautiful forest with tall trees")
    assert(config.terrain_type == "grass", "Forest should generate grass terrain")
    assert(#config.secondary_objects > 0, "Should have secondary objects")
    print("✓ Forest scene generation works")
end

local function testDesertScene()
    local config = ProceduralSceneGenerator.generateScene("sandy desert under sunset")
    assert(config.terrain_type == "sand", "Desert should generate sand terrain")
    assert(config.lighting_mood == "warm_sunset", "Should detect sunset mood")
    print("✓ Desert scene generation works")
end

local function testNightScene()
    local config = ProceduralSceneGenerator.generateScene("dark night with fog")
    assert(config.lighting_mood == "cool_night", "Should detect night mood")
    assert(config.atmosphere == "foggy", "Should detect foggy atmosphere")
    print("✓ Night scene generation works")
end

local function testObjectDetection()
    local config = ProceduralSceneGenerator.generateScene("castle with towers and rocks")
    local hasStructure = false
    for _, obj in ipairs(config.secondary_objects) do
        if obj.type == "structure" then hasStructure = true end
    end
    assert(hasStructure, "Should detect structure objects")
    print("✓ Object detection works")
end

testForestScene()
testDesertScene()
testNightScene()
testObjectDetection()
print("\nAll ProceduralSceneGenerator tests passed!")
