local QBCore = exports['qb-core']:GetCoreObject()

-- Broadcast HUD update to all players
RegisterNetEvent('hud:server:BroadcastUpdate', function(data)
    TriggerClientEvent('hud:client:UpdateHud', -1, data)
end)

-- Update specific player HUD
RegisterNetEvent('hud:server:UpdatePlayerHud', function(playerId, data)
    TriggerClientEvent('hud:client:UpdateHud', playerId, data)
end)

-- Notify all players
RegisterNetEvent('hud:server:NotifyAll', function(data)
    TriggerClientEvent('hud:client:ShowNotification', -1, data)
end)

-- Notify specific player
RegisterNetEvent('hud:server:NotifyPlayer', function(playerId, data)
    TriggerClientEvent('hud:client:ShowNotification', playerId, data)
end)
