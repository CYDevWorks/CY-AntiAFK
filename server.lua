RegisterServerEvent("cy-antiafk:kickPlayer")
AddEventHandler("cy-antiafk:kickPlayer", function(reason)
    local _source = source
    print("Kicking player " .. GetPlayerName(_source) .. " for AFK.")
    DropPlayer(_source, reason)
end)
