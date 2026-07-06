Utils = {}

-- Round a number to decimal places
function Utils.Round(num, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Format currency
function Utils.FormatMoney(amount)
    return string.format("$%d", math.floor(amount))
end

-- Format time
function Utils.FormatTime(hour, minute)
    return string.format("%02d:%02d", hour, minute)
end

-- Get distance between two points
function Utils.GetDistance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

-- Convert speed to unit
function Utils.ConvertSpeed(speed, unit)
    if unit == 'kmh' then
        return math.floor(speed * 3.6)
    elseif unit == 'ms' then
        return math.floor(speed)
    else -- mph
        return math.floor(speed * 2.236936)
    end
end

-- Check if player is in vehicle
function Utils.IsPlayerInVehicle()
    return GetVehiclePedIsIn(PlayerPedId(), false) ~= 0
end

-- Get player ped
function Utils.GetPlayerPed()
    return PlayerPedId()
end

-- Log debug message
function Utils.Log(message)
    print("^2[Janee HUD]^7 " .. message)
end

-- Log debug error
function Utils.LogError(message)
    print("^1[Janee HUD ERROR]^7 " .. message)
end

return Utils
