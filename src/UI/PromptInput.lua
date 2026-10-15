-- src/UI/PromptInput.lua
local PromptInput = {}

function PromptInput.createInputFrame()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PromptGui"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local inputBox = Instance.new("TextBox")
    inputBox.Name = "PromptInput"
    inputBox.Size = UDim2.new(0, 400, 0, 50)
    inputBox.Position = UDim2.new(0.5, -200, 0, 20)
    inputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 18
    inputBox.PlaceholderText = "Enter prompt..."
    inputBox.Parent = screenGui

    local submitButton = Instance.new("TextButton")
    submitButton.Name = "SubmitButton"
    submitButton.Size = UDim2.new(0, 100, 0, 50)
    submitButton.Position = UDim2.new(0.5, 110, 0, 20)
    submitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.Text = "Generate"
    submitButton.Parent = screenGui

    return inputBox, submitButton, screenGui
end

return PromptInput
