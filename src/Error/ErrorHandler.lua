-- src/Error/ErrorHandler.lua
local ErrorHandler = {}

function ErrorHandler.log(level, message, context)
    context = context or {}
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local logMessage = string.format("[%s] [%s] %s", timestamp, level:upper(), message)

    if level == "ERROR" then
        warn(logMessage)
    else
        print(logMessage)
    end
end

function ErrorHandler.handleGenerationFailure(errorMessage)
    ErrorHandler.log("ERROR", "Generation failed: " .. errorMessage)
end

return ErrorHandler
