-- src/Validation/PromptValidator.lua
local Config = require(game.ServerScriptService.src.Config)

local PromptValidator = {}

local SPECIAL_CHARS_PATTERN = "[^%w%s%p]"

function PromptValidator.validate(prompt)
    -- Check empty
    if not prompt or string.len(prompt:gsub("%s", "")) == 0 then
        return false, "Prompt cannot be empty", nil
    end

    -- Check length
    if string.len(prompt) > 500 then
        return false, "Prompt is too long (max 500 characters). Please refine your description.", nil
    end

    -- Clean special chars
    local cleaned = prompt:gsub(SPECIAL_CHARS_PATTERN, "")
    cleaned = cleaned:gsub("%s+", " "):match("^%s*(.-)%s*$")

    if string.len(cleaned) == 0 then
        return false, "Prompt contains only special characters. Please use descriptive text.", nil
    end

    return true, "Valid prompt", cleaned
end

return PromptValidator
