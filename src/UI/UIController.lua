-- src/UI/UIController.lua
local Config = require(game.ServerScriptService.src.Config)
local SceneComposer = require(game.ServerScriptService.src.Composition.SceneComposer)
local PromptInput = require(game.ServerScriptService.src.UI.PromptInput)

local UIController = {}

function UIController.setupUI()
    local inputBox, submitButton, screenGui = PromptInput.createInputFrame()

    submitButton.MouseButton1Click:Connect(function()
        local prompt = inputBox.Text
        if prompt:len() > 0 then
            submitButton.Text = "Generating..."
            submitButton.Enabled = false

            local success, scene, err = SceneComposer.generateScene(prompt)

            if success then
                submitButton.Text = "Success!"
                inputBox.Text = ""
            else
                submitButton.Text = "Failed: " .. tostring(err)
            end

            submitButton.Enabled = true
        end
    end)

    return true
end

return UIController
