-- src/Error/Fallbacks.lua
local Config = require(game.ServerScriptService.src.Config)

local Fallbacks = {}

function Fallbacks.degradeScene(reason)
    local fallbackConfig = {}

    if reason == "low_performance" then
        fallbackConfig = {
            disable_bloom = true,
            disable_particles = true,
            reduce_lights = true,
            max_secondary_objects = 10
        }
    elseif reason == "timeout" then
        fallbackConfig = {
            use_default_terrain = true,
            use_simple_objects = true,
            disable_effects = true
        }
    end

    return fallbackConfig
end

return Fallbacks
