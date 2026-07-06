local QBCore = exports['qb-core']:GetCoreObject()

-- Sync player data when loaded
RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    Wait(1000)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('QBCore:Player:SetPlayerData', src, Player.PlayerData)
    end
end)

-- Player joining
AddEventHandler('playerJoining', function()
    local src = source
    print('^2[QB-HUD]^7 Player ' .. src .. ' joining')
end)

-- Player dropped
AddEventHandler('playerDropped', function(reason)
    print('^3[QB-HUD]^7 Player dropped. Reason: ' .. reason)
end)
