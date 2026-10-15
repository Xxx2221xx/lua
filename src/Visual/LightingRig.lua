-- src/Visual/LightingRig.lua
local Config = require(game.ServerScriptService.src.Config)

local LightingRig = {}

local MOOD_PRESETS = {
    ["warm_sunset"] = {
        keyLight = {color = Color3.fromRGB(255, 140, 60), brightness = 1.0},
        fillLight = {color = Color3.fromRGB(100, 120, 150), brightness = 0.4},
        rimLight = {color = Color3.fromRGB(255, 180, 100), brightness = 0.5},
        ambient = {brightness = 0.35}
    },
    ["cool_night"] = {
        keyLight = {color = Color3.fromRGB(100, 150, 200), brightness = 0.7},
        fillLight = {color = Color3.fromRGB(50, 80, 120), brightness = 0.3},
        rimLight = {color = Color3.fromRGB(150, 180, 220), brightness = 0.4},
        ambient = {brightness = 0.25}
    },
    ["neutral"] = {
        keyLight = {color = Color3.fromRGB(255, 255, 255), brightness = 0.8},
        fillLight = {color = Color3.fromRGB(200, 200, 200), brightness = 0.4},
        rimLight = {color = Color3.fromRGB(255, 255, 255), brightness = 0.3},
        ambient = {brightness = 0.4}
    }
}

function LightingRig.setupLighting(sceneConfig)
    local mood = sceneConfig.lighting_mood or "neutral"
    local preset = MOOD_PRESETS[mood] or MOOD_PRESETS["neutral"]

    local lights = {}
    local center = Vector3.new(Config.TERRAIN_SIZE / 2, 100, Config.TERRAIN_SIZE / 2)

    -- Key light
    local keyLight = Instance.new("Part")
    keyLight.Name = "KeyLight"
    keyLight.CanCollide = false
    keyLight.CanTouch = false
    keyLight.Parent = workspace

    local keyLightEmitter = Instance.new("PointLight")
    keyLightEmitter.Parent = keyLight
    keyLightEmitter.Color = preset.keyLight.color
    keyLightEmitter.Brightness = preset.keyLight.brightness
    keyLightEmitter.Range = 150
    keyLight.Position = center + Vector3.new(100, 80, -100)

    table.insert(lights, keyLight)

    -- Fill light
    local fillLight = Instance.new("Part")
    fillLight.Name = "FillLight"
    fillLight.CanCollide = false
    fillLight.CanTouch = false
    fillLight.Parent = workspace

    local fillLightEmitter = Instance.new("PointLight")
    fillLightEmitter.Parent = fillLight
    fillLightEmitter.Color = preset.fillLight.color
    fillLightEmitter.Brightness = preset.fillLight.brightness
    fillLightEmitter.Range = 120
    fillLight.Position = center + Vector3.new(-80, 60, 100)

    table.insert(lights, fillLight)

    -- Ambient light
    local lighting = game:GetService("Lighting")
    local ambientValue = math.floor(200 * preset.ambient.brightness)
    lighting.Ambient = Color3.fromRGB(ambientValue, ambientValue, ambientValue)

    return lights
end

return LightingRig
