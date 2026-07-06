local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    local src = source
    Wait(500)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('QBCore:Player:SetPlayerData', src, Player.PlayerData)
    end
end)

RegisterNetEvent('QBCore:Server:PlayerLoaded')
AddEventHandler('QBCore:Server:PlayerLoaded', function()
    local src = source
    Wait(500)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('QBCore:Player:SetPlayerData', src, Player.PlayerData)
    end
end)

AddEventHandler('playerJoining', function()
    print('^2[QB-HUD]^7 Player joining')
end)
