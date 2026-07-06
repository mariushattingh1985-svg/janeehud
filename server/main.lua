local QBCore = exports['qb-core']:GetCoreObject()

-- Server-side HUD initialization
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print('^2[Janee HUD]^7 Server script started successfully!^0')
end)

-- Player Join
AddEventHandler('playerJoining', function()
    print('^3[Janee HUD]^7 Player joining...')
end)

-- Player Loaded
AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    print('^3[Janee HUD]^7 Player ' .. Player.PlayerData.charinfo.firstname .. ' loaded')
end)

-- Player Left
AddEventHandler('playerDropped', function(reason)
    print('^3[Janee HUD]^7 Player left. Reason: ' .. reason)
end)
