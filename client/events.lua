local QBCore = exports['qb-core']:GetCoreObject()

-- Listen for player data updates
RegisterNetEvent('QBCore:Client:OnMoneyChange', function(data)
    TriggerEvent('hud:client:UpdatePlayerData')
end)

-- Listen for job updates
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    TriggerEvent('hud:client:UpdatePlayerData')
end)

-- Listen for status updates
RegisterNetEvent('QBCore:Client:OnStatusChange', function(status, amount)
    TriggerEvent('hud:client:UpdatePlayerData')
end)

-- Voice indicator
RegisterNetEvent('hud:client:SetTalking', function(state)
    SendNUIMessage({
        action = 'updateStatus',
        status = 'talking',
        state = state,
    })
end)

-- Speaker indicator
RegisterNetEvent('hud:client:SetSpeaker', function(state)
    SendNUIMessage({
        action = 'updateStatus',
        status = 'speaker',
        state = state,
    })
end)

-- Recording indicator
RegisterNetEvent('hud:client:SetRecording', function(state)
    SendNUIMessage({
        action = 'updateStatus',
        status = 'recording',
        state = state,
    })
end)

-- Handcuff indicator
RegisterNetEvent('hud:client:SetHandcuffed', function(state)
    SendNUIMessage({
        action = 'updateStatus',
        status = 'handcuffed',
        state = state,
    })
end)

-- Show notification
RegisterNetEvent('hud:client:ShowNotification', function(data)
    SendNUIMessage({
        action = 'notify',
        data = data,
    })
end)
