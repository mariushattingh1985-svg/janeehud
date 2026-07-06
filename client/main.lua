local QBCore = exports['qb-core']:GetCoreObject()
local hudActive = true
local PlayerLoaded = false
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
    time = '00:00',
}

-- Initialize HUD
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print('^2[QB-HUD]^7 HUD Started')
end)

-- Player Loaded
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerLoaded = true
    print('^2[QB-HUD]^7 Player Loaded')
    SendNUIMessage({
        action = 'initialize',
        config = {},
    })
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerLoaded = false
end)

-- Main HUD Update Loop
CreateThread(function()
    while true do
        if PlayerLoaded then
            local ped = PlayerPedId()
            
            -- Update Health (0-100)
            local health = GetEntityHealth(ped)
            hudData.health = math.floor((health - 100) / 1.5)
            if hudData.health < 0 then hudData.health = 0 end
            if hudData.health > 100 then hudData.health = 100 end

            -- Update Armor (0-100)
            hudData.armor = GetPedArmour(ped)

            -- Update Speedometer
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local speed = GetEntitySpeed(vehicle)
                hudData.speedometer = math.floor(speed * 2.236936) -- mph
            else
                hudData.speedometer = 0
            end

            -- Update Time
            local hour = GetClockHours()
            local minute = GetClockMinutes()
            hudData.time = string.format("%02d:%02d", hour, minute)

            -- Update Location
            local coords = GetEntityCoords(ped)
            hudData.location = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))

            -- Send to NUI
            SendNUIMessage({
                action = 'updateHud',
                data = hudData,
            })
        end
        Wait(100)
    end
end)

-- Update from QBCore
RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
    if data.money then
        hudData.cash = data.money['cash'] or 0
        hudData.bank = data.money['bank'] or 0
    end
    if data.status then
        hudData.hunger = data.status['hunger'] or 100
        hudData.thirst = data.status['thirst'] or 100
        hudData.stress = data.status['stress'] or 0
    end
    
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end)

-- Money Changes
RegisterNetEvent('QBCore:Client:OnMoneyChange', function(data)
    if data.money then
        hudData.cash = data.money['cash'] or hudData.cash
        hudData.bank = data.money['bank'] or hudData.bank
    end
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end)

-- Status Changes
RegisterNetEvent('QBCore:Client:OnStatusChange', function(data)
    for k, v in pairs(data) do
        if k == 'hunger' then hudData.hunger = v end
        if k == 'thirst' then hudData.thirst = v end
        if k == 'stress' then hudData.stress = v end
    end
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end)

-- Toggle HUD Command
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

-- Exports
function ShowHud()
    hudActive = true
    SendNUIMessage({
        action = 'toggleHud',
        state = true,
    })
end

function HideHud()
    hudActive = false
    SendNUIMessage({
        action = 'toggleHud',
        state = false,
    })
end

function UpdateHud(newData)
    if newData then
        for key, value in pairs(newData) do
            if hudData[key] ~= nil then
                hudData[key] = value
            end
        end
        SendNUIMessage({
            action = 'updateHud',
            data = hudData,
        })
    end
end

function SetHealth(health)
    hudData.health = math.floor(math.max(0, math.min(100, health)))
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

function SetArmor(armor)
    hudData.armor = math.floor(math.max(0, math.min(100, armor)))
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

function SetHunger(hunger)
    hudData.hunger = math.floor(math.max(0, math.min(100, hunger)))
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

function SetThirst(thirst)
    hudData.thirst = math.floor(math.max(0, math.min(100, thirst)))
    SendNUIMessage({
        action = 'updateHud',
        data = hudData,
    })
end

function SetStress(stress)
    hudData.stress = math.floor(math.max(0, math.min(100, stress)))
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
exports('SetStress', SetStress)
