-- Client Utilities

local Utils = {}

-- Format number with commas
function Utils.FormatNumber(num)
    local formatted = tostring(num)
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

-- Get player from ID
function Utils.GetPlayerFromId(id)
    local players = QBCore.Functions.GetPlayers()
    for _, player in ipairs(players) do
        if player == id then
            return QBCore.Functions.GetPlayer(player)
        end
    end
    return nil
end

-- Notify player
function Utils.Notify(title, message, type)
    TriggerEvent('chat:addMessage', {
        color = type == 'error' and {255, 0, 0} or {0, 255, 0},
        multiline = true,
        args = {title, message},
    })
end

-- Progress bar
function Utils.Progress(duration, label)
    TriggerEvent('progressbar:client:progress', {
        name = label,
        duration = duration,
        label = label,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = 'combat@damage@rb_writhe',
            anim = 'rb_writhe_loop',
            flags = 49,
        },
        prop = {},
    })
end

return Utils
