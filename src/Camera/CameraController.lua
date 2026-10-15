-- src/Camera/CameraController.lua
local Config = require(game.ServerScriptService.src.Config)

local CameraController = {}

function CameraController.setupCamera(targetPosition, sceneConfig)
    local camera = workspace.CurrentCamera

    local framing = sceneConfig.camera_framing or {position = {0, 80, 200}, lookAt = {0, 50, 0}}

    camera.Focus = CFrame.new(targetPosition)
    camera.CFrame = CFrame.new(
        targetPosition + Vector3.new(framing.position[1], framing.position[2], framing.position[3]),
        targetPosition + Vector3.new(framing.lookAt[1], framing.lookAt[2], framing.lookAt[3])
    )

    return true
end

return CameraController
