-- src/Clients/ClaudeClient.lua
local Config = require(game.ServerScriptService.src.Config)
local HttpUtils = require(game.ServerScriptService.src.HttpUtils)

local ClaudeClient = {}

function ClaudeClient.elaborateScene(prompt)
    local systemPrompt = "You are a 3D environment designer. Given a primary object description, elaborate on a cohesive surrounding environment. Return ONLY valid JSON with terrain_type, terrain_features, secondary_objects, lighting_mood, atmosphere, color_palette, camera_framing."

    local messages = {
        {
            role = "user",
            content = "Primary object: " .. prompt .. "\n\nElaborate on the surrounding environment."
        }
    }

    local body = {
        model = Config.CLAUDE_MODEL,
        max_tokens = 1000,
        system = systemPrompt,
        messages = messages
    }

    local headers = {
        ["x-api-key"] = Config.CLAUDE_API_KEY,
        ["anthropic-version"] = "2023-06-01"
    }

    local url = Config.CLAUDE_API_BASE .. "/messages"

    local success, response = HttpUtils.post(url, body, headers)

    if not success then
        return false, nil, "Claude API request failed: " .. tostring(response)
    end

    if not response.content or not response.content[1] then
        return false, nil, "Unexpected Claude response format"
    end

    local responseText = response.content[1].text

    local success_parse, sceneConfig = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), responseText)

    if not success_parse then
        return false, nil, "Failed to parse Claude response as JSON"
    end

    return true, sceneConfig, nil
end

return ClaudeClient
