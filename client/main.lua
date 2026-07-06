local QBCore = exports['qb-core']:GetCoreObject()
local PlayerLoaded = false
local hudVisible = true

local hudData = {
    health = 100,
    armor = 0,
    hunger = 100,
    thirst = 100,
    stress = 0,
    cash = 0,
    bank = 0,
    job = 'Unemployed',
    jobGrade = '',
    speed = 0,
    location = 'Los Santos',
    street = 'Unknown',
    time = '00:00',
    date = '01/01/2024',
    players = 0,
}

-- Player Loaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerLoaded = true
    print('^2[QB-HUD]^7 Player loaded - HUD started')
    UpdatePlayerData()
    SendNUIMessage({
        action = 'initialize',
        data = hudData,
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerLoaded = false
end)

-- Update player data from QBCore
function UpdatePlayerData()
    if not QBCore.Player then return end
    
    local PlayerData = QBCore.Player.PlayerData
    if not PlayerData then return end
    
    hudData.cash = PlayerData.money['cash'] or 0
    hudData.bank = PlayerData.money['bank'] or 0
    hudData.hunger = PlayerData.status['hunger'] or 100
    hudData.thirst = PlayerData.status['thirst'] or 100
    hudData.stress = PlayerData.status['stress'] or 0
    
    if PlayerData.job then
        hudData.job = PlayerData.job.label or 'Unemployed'
        hudData.jobGrade = PlayerData.job.grade.name or ''
    end
end

-- Listen for QBCore events
RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
    UpdatePlayerData()
end)

RegisterNetEvent('QBCore:Client:OnMoneyChange', function(data)
    if data.money then
        hudData.cash = data.money['cash'] or hudData.cash
        hudData.bank = data.money['bank'] or hudData.bank
    end
end)

RegisterNetEvent('QBCore:Client:OnStatusChange', function(data)
    for k, v in pairs(data) do
        if k == 'hunger' then hudData.hunger = v end
        if k == 'thirst' then hudData.thirst = v end
        if k == 'stress' then hudData.stress = v end
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    hudData.job = JobInfo.label or 'Unemployed'
    hudData.jobGrade = JobInfo.grade.name or ''
end)

-- Main Update Loop
CreateThread(function()
    while true do
        if PlayerLoaded then
            local ped = PlayerPedId()
            
            -- Health (0-100)
            local health = GetEntityHealth(ped)
            hudData.health = math.floor((health - 100) / 1.5)
            if hudData.health < 0 then hudData.health = 0 end
            if hudData.health > 100 then hudData.health = 100 end
            
            -- Armor (0-100)
            hudData.armor = GetPedArmour(ped)
            
            -- Location and Street
            local coords = GetEntityCoords(ped)
            local zoneId = GetNameOfZone(coords.x, coords.y, coords.z)
            hudData.location = GetLabelText(zoneId) or 'Unknown'
            
            local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            hudData.street = GetStreetNameFromHashKey(streetHash) or 'Unknown Street'
            
            -- Time
            local hour = GetClockHours()
            local minute = GetClockMinutes()
            hudData.time = string.format("%02d:%02d", hour, minute)
            
            -- Speed (only in vehicle)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local speed = GetEntitySpeed(vehicle)
                hudData.speed = math.floor(speed * 2.236936) -- Convert to MPH
            else
                hudData.speed = 0
            end
            
            -- Get player count
            hudData.players = #GetPlayers()
            
            -- Send to NUI
            SendNUIMessage({
                action = 'updateData',
                data = hudData,
            })
        end
        Wait(100)
    end
end)

-- Commands
RegisterCommand('togglehud', function()
    hudVisible = not hudVisible
    SendNUIMessage({
        action = 'setVisible',
        visible = hudVisible,
    })
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {'HUD', hudVisible and 'HUD Enabled' or 'HUD Disabled'},
    })
end)

-- Exports
function ShowHud()
    hudVisible = true
    SendNUIMessage({ action = 'setVisible', visible = true })
end

function HideHud()
    hudVisible = false
    SendNUIMessage({ action = 'setVisible', visible = false })
end

function UpdateHud(data)
    if data then
        for k, v in pairs(data) do
            if hudData[k] ~= nil then
                hudData[k] = v
            end
        end
    end
    SendNUIMessage({ action = 'updateData', data = hudData })
end

exports('ShowHud', ShowHud)
exports('HideHud', HideHud)
exports('UpdateHud', UpdateHud)
