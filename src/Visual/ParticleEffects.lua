-- src/Visual/ParticleEffects.lua
local Config = require(game.ServerScriptService.src.Config)

local ParticleEffects = {}

function ParticleEffects.setupEffects(sceneConfig)
    local emitters = {}
    local atmosphere = sceneConfig.atmosphere or "clear"

    if atmosphere == "misty" or atmosphere == "foggy" then
        local dustEmitter = Instance.new("Part")
        dustEmitter.Name = "DustEmitter"
        dustEmitter.CanCollide = false
        dustEmitter.Transparency = 1
        dustEmitter.Size = Vector3.new(Config.TERRAIN_SIZE, 100, Config.TERRAIN_SIZE)
        dustEmitter.Position = Vector3.new(Config.TERRAIN_SIZE/2, 50, Config.TERRAIN_SIZE/2)
        dustEmitter.Parent = workspace

        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Parent = dustEmitter
        particleEmitter.Rate = 50
        particleEmitter.Lifetime = NumberRange.new(10)
        particleEmitter.Speed = NumberRange.new(5)
        particleEmitter.Enabled = true

        table.insert(emitters, dustEmitter)
    end

    if atmosphere == "rainy" then
        local rainEmitter = Instance.new("Part")
        rainEmitter.Name = "RainEmitter"
        rainEmitter.CanCollide = false
        rainEmitter.Transparency = 1
        rainEmitter.Size = Vector3.new(Config.TERRAIN_SIZE, 100, Config.TERRAIN_SIZE)
        rainEmitter.Position = Vector3.new(Config.TERRAIN_SIZE/2, 100, Config.TERRAIN_SIZE/2)
        rainEmitter.Parent = workspace

        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Parent = rainEmitter
        particleEmitter.Rate = 100
        particleEmitter.Lifetime = NumberRange.new(5)
        particleEmitter.Speed = NumberRange.new(30, 50)
        particleEmitter.Acceleration = Vector3.new(0, -50, 0)
        particleEmitter.Enabled = true

        table.insert(emitters, rainEmitter)
    end

    return emitters
end

return ParticleEffects
