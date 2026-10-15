-- src/Generation/ProceduralSceneGenerator.lua
local Config = require(game.ServerScriptService.src.Config)

local ProceduralSceneGenerator = {}

-- Keyword mapping for scene generation
local KEYWORD_MAP = {
    -- Terrain types
    ["forest"] = {terrain = "grass", features = {"rolling_hills", "cliff"}},
    ["desert"] = {terrain = "sand", features = {"rolling_hills"}},
    ["snow"] = {terrain = "snow", features = {"rolling_hills"}},
    ["mountain"] = {terrain = "rock", features = {"cliff", "rolling_hills"}},
    ["water"] = {terrain = "water", features = {}},
    ["ocean"] = {terrain = "water", features = {}},
    ["beach"] = {terrain = "sand", features = {}},
    ["rocky"] = {terrain = "rock", features = {"cliff"}},
    ["grass"] = {terrain = "grass", features = {"rolling_hills"}},

    -- Lighting moods
    ["sunset"] = {mood = "warm_sunset"},
    ["sunrise"] = {mood = "warm_sunset"},
    ["night"] = {mood = "cool_night"},
    ["dark"] = {mood = "cool_night"},
    ["bright"] = {mood = "neutral"},
    ["sunny"] = {mood = "neutral"},
    ["gloomy"] = {mood = "cool_night"},
    ["golden"] = {mood = "warm_sunset"},

    -- Atmosphere
    ["rain"] = {atmosphere = "rainy"},
    ["rainy"] = {atmosphere = "rainy"},
    ["fog"] = {atmosphere = "foggy"},
    ["foggy"] = {atmosphere = "foggy"},
    ["misty"] = {atmosphere = "misty"},
    ["stormy"] = {atmosphere = "rainy"},
    ["clear"] = {atmosphere = "clear"},
}

-- Secondary objects mapping
local OBJECT_PATTERNS = {
    ["tree"] = {type = "tree", count = 8},
    ["trees"] = {type = "tree", count = 10},
    ["rock"] = {type = "rock", count = 5},
    ["rocks"] = {type = "rock", count = 8},
    ["bush"] = {type = "bush", count = 6},
    ["building"] = {type = "structure", count = 2},
    ["house"] = {type = "structure", count = 3},
    ["castle"] = {type = "structure", count = 1},
    ["tower"] = {type = "structure", count = 2},
}

function ProceduralSceneGenerator.generateScene(prompt)
    prompt = prompt:lower()

    -- Initialize defaults
    local config = {
        terrain_type = "grass",
        terrain_features = {"rolling_hills"},
        secondary_objects = {},
        lighting_mood = "neutral",
        atmosphere = "clear",
        color_palette = {"#90EE90", "#228B22", "#FFD700"},
        camera_framing = {position = {0, 80, 200}, lookAt = {0, 50, 0}}
    }

    -- Parse keywords
    for keyword, settings in pairs(KEYWORD_MAP) do
        if string.find(prompt, keyword) then
            if settings.terrain then
                config.terrain_type = settings.terrain
            end
            if settings.features then
                config.terrain_features = settings.features
            end
            if settings.mood then
                config.lighting_mood = settings.mood
            end
            if settings.atmosphere then
                config.atmosphere = settings.atmosphere
            end
        end
    end

    -- Extract secondary objects
    local addedObjects = {}
    for objKeyword, objConfig in pairs(OBJECT_PATTERNS) do
        if string.find(prompt, objKeyword) then
            if not addedObjects[objConfig.type] then
                table.insert(config.secondary_objects, {
                    type = objConfig.type,
                    position = {50 + math.random(-30, 30), 50 + math.random(-30, 30)},
                    count = math.min(objConfig.count, Config.MAX_SECONDARY_OBJECTS / 2)
                })
                addedObjects[objConfig.type] = true
            end
        end
    end

    -- If no objects detected, add some defaults based on terrain
    if #config.secondary_objects == 0 then
        if config.terrain_type == "grass" or config.terrain_type == "rock" then
            table.insert(config.secondary_objects, {
                type = "tree",
                position = {math.random(30, 70), math.random(30, 70)},
                count = 5
            })
        end
    end

    -- Adjust colors based on mood
    if config.lighting_mood == "warm_sunset" then
        config.color_palette = {"#FF6347", "#FFB84D", "#FF8C00"}
    elseif config.lighting_mood == "cool_night" then
        config.color_palette = {"#191970", "#4B0082", "#87CEEB"}
    else
        config.color_palette = {"#90EE90", "#228B22", "#FFD700"}
    end

    return config
end

return ProceduralSceneGenerator
