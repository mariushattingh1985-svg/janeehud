local QBCore = exports['qb-core']:GetCoreObject()

-- Get players count
QBCore.Functions.CreateCallback('GetPlayers', function(source, cb)
    cb(#GetPlayers())
end)

-- Get bank money
QBCore.Functions.CreateCallback('GetMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        cb(Player.PlayerData.money.bank)
    else
        cb(0)
    end
end)

RegisterNetEvent('QBCore:UpdatePlayer', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        TriggerClientEvent('QBCore:Player:SetPlayerData', source, Player.PlayerData)
    end
end)
