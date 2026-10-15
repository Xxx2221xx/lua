-- src/Composition/SceneComposer.lua
local Config = require(game.ServerScriptService.src.Config)
local PromptValidator = require(game.ServerScriptService.src.Validation.PromptValidator)
local MeshyClient = require(game.ServerScriptService.src.Clients.MeshyClient)
local ProceduralSceneGenerator = require(game.ServerScriptService.src.Generation.ProceduralSceneGenerator)
local TerrainGenerator = require(game.ServerScriptService.src.Composition.TerrainGenerator)
local ObjectPlacer = require(game.ServerScriptService.src.Composition.ObjectPlacer)
local LightingRig = require(game.ServerScriptService.src.Visual.LightingRig)
local ParticleEffects = require(game.ServerScriptService.src.Visual.ParticleEffects)
local CameraController = require(game.ServerScriptService.src.Camera.CameraController)
local ErrorHandler = require(game.ServerScriptService.src.Error.ErrorHandler)
local Fallbacks = require(game.ServerScriptService.src.Error.Fallbacks)

local SceneComposer = {}

function SceneComposer.generateScene(prompt)
    ErrorHandler.log("INFO", "Starting scene generation for prompt: " .. prompt)

    local isValid, validMsg, cleanedPrompt = PromptValidator.validate(prompt)
    if not isValid then
        ErrorHandler.log("ERROR", "Prompt validation failed: " .. validMsg)
        return false, nil, validMsg
    end

    ErrorHandler.log("INFO", "Prompt validated: " .. cleanedPrompt)

    local meshySuccess, modelUrl, meshyErr = MeshyClient.generateModel(cleanedPrompt, Config.GENERATION_TIMEOUT_MESHY)
    if not meshySuccess then
        ErrorHandler.log("ERROR", "Meshy generation failed: " .. tostring(meshyErr))
        return false, nil, meshyErr
    end

    local sceneConfig = ProceduralSceneGenerator.generateScene(cleanedPrompt)
    ErrorHandler.log("INFO", "Scene config generated procedurally")

    local terrain = TerrainGenerator.generateTerrain(sceneConfig)
    local primaryObject, secondaryObjects = ObjectPlacer.placeObjects(modelUrl, sceneConfig)
    local lights = LightingRig.setupLighting(sceneConfig)
    local emitters = ParticleEffects.setupEffects(sceneConfig)

    ErrorHandler.log("INFO", "Scene composition complete")

    CameraController.setupCamera(primaryObject.Position, sceneConfig)

    local scene = {
        primaryObject = primaryObject,
        secondaryObjects = secondaryObjects,
        terrain = terrain,
        lights = lights,
        emitters = emitters,
        config = sceneConfig
    }

    ErrorHandler.log("INFO", "Scene generation successful")
    return true, scene, nil
end

return SceneComposer
