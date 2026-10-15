-- tests/Config_test.lua
local Config = require(game.ServerScriptService.src.Config)

local function testConfigExists()
    assert(Config ~= nil, "Config should exist")
    print("✓ Config exists")
end

local function testApiEndpoints()
    assert(Config.MESHY_API_BASE == "https://api.meshy.ai/v1", "Meshy API base should be correct")
    assert(Config.CLAUDE_API_BASE == "https://api.anthropic.com/v1", "Claude API base should be correct")
    print("✓ API endpoints configured")
end

local function testConstraints()
    assert(Config.MAX_PRIMARY_POLY_COUNT == 100000, "Max poly count should be 100000")
    assert(Config.MAX_SECONDARY_OBJECTS == 25, "Max secondary objects should be 25")
    assert(Config.TERRAIN_SIZE == 256, "Terrain size should be 256")
    print("✓ Constraints configured")
end

testConfigExists()
testApiEndpoints()
testConstraints()
print("\nAll Config tests passed!")
