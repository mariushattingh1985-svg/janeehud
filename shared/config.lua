Config = {}

-- General Settings
Config.Debug = false
Config.UpdateInterval = 100 -- milliseconds

-- HUD Position and Size
Config.HudPosition = {
    x = 0,
    y = 0,
    width = '100%',
    height = '100%',
}

-- Health Settings
Config.Health = {
    enabled = true,
    showNumbers = true,
    animationSpeed = 0.15,
    redZone = 30, -- Health percentage for red warning
}

-- Armor Settings
Config.Armor = {
    enabled = true,
    showNumbers = true,
    animationSpeed = 0.15,
}

-- Hunger & Thirst Settings
Config.Hunger = {
    enabled = true,
    showNumbers = true,
    animationSpeed = 0.1,
    decayRate = 0.5, -- How fast hunger decreases
}

Config.Thirst = {
    enabled = true,
    showNumbers = true,
    animationSpeed = 0.1,
    decayRate = 0.5, -- How fast thirst decreases
}

-- Stress Settings
Config.Stress = {
    enabled = true,
    showNumbers = true,
    animationSpeed = 0.15,
}

-- Money Display
Config.Money = {
    enabled = true,
    showCash = true,
    showBank = true,
    format = 'USD', -- 'USD', 'EUR', etc.
}

-- Minimap Settings
Config.Minimap = {
    enabled = true,
    showStreetName = true,
    showDirection = true,
    showCoordinates = false,
}

-- Server Time
Config.Time = {
    enabled = true,
    format = '24h', -- '12h' or '24h'
}

-- Speedometer
Config.Speedometer = {
    enabled = true,
    unit = 'mph', -- 'mph', 'kmh', 'ms'
    showAltitude = true,
}

-- Status Indicators
Config.Status = {
    showTalking = true,
    showSpeaker = true,
    showRecording = true,
    showHandcuffed = true,
}

-- Colors (RGB)
Config.Colors = {
    primary = { r = 52, g = 152, b = 219 }, -- Blue
    success = { r = 46, g = 204, b = 113 }, -- Green
    warning = { r = 241, g = 196, b = 15 }, -- Yellow
    danger = { r = 231, g = 76, b = 60 }, -- Red
    text = { r = 255, g = 255, b = 255 }, -- White
    background = { r = 0, g = 0, b = 0 }, -- Black
}

-- UI Elements to Show/Hide
Config.ShowElements = {
    health = true,
    armor = true,
    hunger = true,
    thirst = true,
    stress = true,
    money = true,
    minimap = true,
    clock = true,
    speedometer = true,
    voice = true,
    status = true,
}

-- Notifications
Config.Notifications = {
    enabled = true,
    position = 'top-right', -- 'top-left', 'top-right', 'bottom-left', 'bottom-right'
    duration = 5000, -- milliseconds
}

return Config
