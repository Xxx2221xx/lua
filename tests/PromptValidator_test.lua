-- tests/PromptValidator_test.lua
local PromptValidator = require(game.ServerScriptService.src.Validation.PromptValidator)

local function testValidPrompt()
    local valid, msg, cleaned = PromptValidator.validate("a beautiful forest with tall trees")
    assert(valid == true, "Valid prompt should pass")
    assert(cleaned ~= nil, "Cleaned prompt should not be nil")
    print("✓ Valid prompt test passed")
end

local function testEmptyPrompt()
    local valid, msg = PromptValidator.validate("")
    assert(valid == false, "Empty prompt should fail")
    assert(string.find(msg, "empty") ~= nil, "Error message should mention empty")
    print("✓ Empty prompt test passed")
end

local function testTooLong()
    local longPrompt = string.rep("a", 501)
    local valid, msg = PromptValidator.validate(longPrompt)
    assert(valid == false, "Prompt >500 chars should fail")
    assert(string.find(msg, "too long") ~= nil, "Error should mention length")
    print("✓ Too long prompt test passed")
end

local function testSpecialCharacters()
    local promptWithSpecial = "a castle with symbols"
    local valid, msg, cleaned = PromptValidator.validate(promptWithSpecial)
    assert(valid == true, "Special chars should be cleaned, not rejected")
    print("✓ Special characters test passed")
end

testValidPrompt()
testEmptyPrompt()
testTooLong()
testSpecialCharacters()
print("\nAll PromptValidator tests passed!")
