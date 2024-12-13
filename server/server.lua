local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0) or "v1.0.0"
local expectedResourceName = "mg-radioanim" 

if GetCurrentResourceName() ~= expectedResourceName then
    print("^1Please do not change the folder name ! '" .. expectedResourceName .. "' ")
end

local function checkVersion()
    PerformHttpRequest("https://api.github.com/repos/Mg-Store/mg-radioanim/releases/latest", function(statusCode, response)
        local NewVersion = statusCode == 200 and json.decode(response).tag_name or nil
        if NewVersion and CurrentVersion ~= NewVersion then
            print("^1#########################################")
            print("^3[" .. expectedResourceName .. "] - New update available now!")
            print("^7Current version: ^1" .. CurrentVersion)
            print("^7New version: ^2" .. NewVersion)
            print("^3Download it now on the keymaster: https://keymaster.fivem.net/asset-grants")
            print("^1#########################################")
        else
            print("^2Your server has the latest version.")
        end
    end, "GET", "", {["User-Agent"] = "FiveM-server"})
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        checkVersion()
    end
end)