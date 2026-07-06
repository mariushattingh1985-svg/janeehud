local QBCore = exports['qb-core']:GetCoreObject()
local Config = require('shared.config')
local Utils = require('shared.utils')

local hudActive = true
local hudData = {
    health = 100,
    armor = 0,
    hunger = 100,
    thirst = 100,
    stress = 0,
    cash = 0,
    bank = 0,
    speedometer = 0,
    location = 'Unknown',
    direction = 'N',
    time = '00:00',
    talking = false,
    speaker = false,
}

-- Initialize HUD
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    SendNUIMessage({
        action = 'initialize',
        config = Config,
    })
    Utils.Log('HUD Initialized')
end)

-- Update HUD every tick
AddEventHandler('playerSpawned', function()
    TriggerEvent('hud:client:UpdateHud')
end)

-- Main HUD Update Loop
CreateThread(function()
    while true do
        Wait(Config.UpdateInterval)

        local ped = Utils.GetPlayerPed()
        
        -- Update Health
        hudData.health = math.floor((GetEntityHealth(ped) - 100) / 1.5)
        if hudData.health < 0 then hudData.health = 0 end
        if hudData.health > 100 then hudData.health = 100 end

        -- Update Armor
        hudData.armor = GetPedArmour(ped)

        -- Update Speedometer
        if Utils.IsPlayerInVehicle() then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local speed = GetEntitySpeed(vehicle)
            hudData.speedometer = Utils.ConvertSpeed(speed, Config.Speedometer.unit)
        else
            hudData.speedometer = 0
        end

        -- Update Time
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        hudData.time = Utils.FormatTime(hour, minute)

        -- Update Location
        local playerCoords = GetEntityCoords(ped)
        hudData.location = GetZoneName(playerCoords)

        -- Send to NUI
        SendNUIMessage({
            action = 'updateHud',
            data = hudData,
        })
    end
end)

-- Handle Player Data
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('hud:client:UpdatePlayerData')
end)

AddEventHandler('hud:client:UpdatePlayerData', function()
    if QBCore.Player and QBCore.Player.PlayerData then
        local PlayerData = QBCore.Player.PlayerData
        hudData.cash = PlayerData.money['cash'] or 0
        hudData.bank = PlayerData.money['bank'] or 0
        hudData.hunger = PlayerData.status['hunger'] or 100
        hudData.thirst = PlayerData.status['thirst'] or 100
        hudData.stress = PlayerData.status['stress'] or 0
    end
end)

-- Toggle HUD
RegisterCommand('togglehud', function(source, args, rawCommand)
    hudActive = not hudActive
    SendNUIMessage({
        action = 'toggleHud',
        state = hudActive,
    })
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {'HUD', hudActive and 'HUD Enabled' or 'HUD Disabled'},
    })
end)

-- Show HUD Export
function ShowHud()
    hudActive = true
    SendNUIMessage({
        action = 'toggleHud',
        state = true,
    })
end

-- Hide HUD Export
function HideHud()
    hudActive = false
    SendNUIMessage({
        action = 'toggleHud',
        state = false,
    })
end

-- Update HUD Export
function UpdateHud(newData)
    hudData = newData
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

-- Set Health Export
function SetHealth(health)
    hudData.health = math.floor(health)
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

-- Set Armor Export
function SetArmor(armor)
    hudData.armor = math.floor(armor)
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

-- Set Hunger Export
function SetHunger(hunger)
    hudData.hunger = math.floor(hunger)
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

-- Set Thirst Export
function SetThirst(thirst)
    hudData.thirst = math.floor(thirst)
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

exports('ShowHud', ShowHud)
exports('HideHud', HideHud)
exports('UpdateHud', UpdateHud)
exports('SetHealth', SetHealth)
exports('SetArmor', SetArmor)
exports('SetHunger', SetHunger)
exports('SetThirst', SetThirst)
