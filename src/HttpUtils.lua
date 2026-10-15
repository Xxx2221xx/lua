-- src/HttpUtils.lua
local HttpUtils = {}

function HttpUtils.post(url, body, headers)
    headers = headers or {}
    headers["Content-Type"] = "application/json"

    local success, response
    pcall(function()
        response = game:GetService("HttpService"):PostAsync(url, game:GetService("HttpService"):JSONEncode(body), Enum.HttpContentType.ApplicationJson, false, headers)
        success = true
    end)

    if success then
        return true, game:GetService("HttpService"):JSONDecode(response)
    else
        return false, response
    end
end

function HttpUtils.get(url, headers)
    headers = headers or {}

    local success, response
    pcall(function()
        response = game:GetService("HttpService"):GetAsync(url, false, headers)
        success = true
    end)

    if success then
        return true, game:GetService("HttpService"):JSONDecode(response)
    else
        return false, response
    end
end

return HttpUtils
