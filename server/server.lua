local lastReceived = {}
ESX = exports["es_extended"]:getSharedObject()

local function ExtractIdentifiers(src)
    local identifiers = { steam = "", ip = "", discord = "", license = "", xbl = "", live = "" }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then identifiers.steam = id
        elseif string.find(id, "ip") then identifiers.ip = id
        elseif string.find(id, "discord") then identifiers.discord = id
        elseif string.find(id, "license") then identifiers.license = id
        elseif string.find(id, "xbl") then identifiers.xbl = id
        elseif string.find(id, "live") then identifiers.live = id end
    end
    return identifiers
end

local function sendToDiscord(name, message, color, webhook, amount)
    local date = os.date('*t')
    local dateString = string.format('%02d-%02d-%02d %02d:%02d:%02d', date.year, date.month, date.day, date.hour, date.min, date.sec)
    local connect = { { ["color"] = color, ["title"] = ":christmas_tree: **".. name .."**", ["description"] = message .. "\nAmount: €" .. amount, ["footer"] = { ["text"] = "Xmas Money Claim Logs - " .. dateString } } }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "🎄 Xmas Money Claim Logs", embeds = connect, avatar_url = "https://imgur.com/aZIMrO9.jpg"}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('addBonus')
AddEventHandler('addBonus', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user_id = xPlayer.getIdentifier()
    local identifiers = ExtractIdentifiers(_source)
    local fivemLicense = identifiers.license
    local playerIp = GetPlayerEndpoint(_source)

    if lastReceived[user_id] and os.time() - lastReceived[user_id] < 24 * 60 * 60 then
        local timeLeft = 24 * 60 * 60 - (os.time() - lastReceived[user_id])
        TriggerClientEvent('showWaitMessage', _source, timeLeft)
    else
        local amount = math.random(Config.Min, Config.Max)
        xPlayer.addAccountMoney('bank', amount)
        lastReceived[user_id] = os.time()
        local message = "Player ID: " .. tostring(_source) .. "\nSteam Name: " .. GetPlayerName(_source) .. "\nIP: ||" .. playerIp .. "||\nFiveM License: " .. fivemLicense
        sendToDiscord("Xmas Money Claim", message, 65280, Config.WebhookAll, amount)
        TriggerClientEvent('showNotification', _source, "~g~🎁 You've received €" .. amount .. " in your bank account! 💰")
    end
end)
