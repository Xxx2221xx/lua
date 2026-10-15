-- src/Clients/MeshyClient.lua
local Config = require(game.ServerScriptService.src.Config)
local HttpUtils = require(game.ServerScriptService.src.HttpUtils)

local MeshyClient = {}

function MeshyClient.generateModel(prompt, timeout)
    timeout = timeout or Config.GENERATION_TIMEOUT_MESHY

    -- MOCK MODE: Test without API key
    -- Comment this out and uncomment production code below when you have API key

    local mockUrl = "rbxasset://textures/face.png"
    wait(1)  -- Simulate processing
    return true, mockUrl, nil

    -- PRODUCTION CODE (uncomment with real API key):
    --[[
    local body = {
        mode = "preview",
        prompt = prompt,
        art_style = "realistic",
        negative_prompt = "low quality, blurry, distorted"
    }

    local headers = {
        ["Authorization"] = "Bearer " .. Config.MESHY_API_KEY,
    }

    local url = Config.MESHY_API_BASE .. "/text-to-3d"

    local success, response = HttpUtils.post(url, body, headers)

    if not success then
        return false, nil, "Meshy API request failed: " .. tostring(response)
    end

    local taskId = response.result.task_id
    if not taskId then
        return false, nil, "No task ID in Meshy response"
    end

    local elapsed = 0
    local pollInterval = 3

    while elapsed < timeout do
        wait(pollInterval)
        elapsed = elapsed + pollInterval

        local statusSuccess, statusResponse = HttpUtils.get(
            Config.MESHY_API_BASE .. "/text-to-3d/" .. taskId,
            headers
        )

        if statusSuccess and statusResponse.result.status == "SUCCEEDED" then
            return true, statusResponse.result.model_urls.glb, nil
        elseif statusSuccess and statusResponse.result.status == "FAILED" then
            return false, nil, "Meshy generation failed: " .. tostring(statusResponse.result.error)
        end
    end

    return false, nil, "Meshy generation timed out after " .. timeout .. " seconds"
    --]]
end

return MeshyClient
