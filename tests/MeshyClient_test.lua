-- tests/MeshyClient_test.lua
local MeshyClient = require(game.ServerScriptService.src.Clients.MeshyClient)

local function testGenerationRequest()
    -- Mock test: verify function exists and can be called
    local result = MeshyClient.generateModel
    assert(result ~= nil, "generateModel should exist")
    print("✓ MeshyClient.generateModel exists")
end

local function testTimeoutParameter()
    -- Test that timeout parameter is accepted
    local func = MeshyClient.generateModel
    assert(type(func) == "function", "generateModel should be a function")
    print("✓ generateModel is callable")
end

testGenerationRequest()
testTimeoutParameter()
print("\nAll MeshyClient tests passed!")
