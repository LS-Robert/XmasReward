local display = false

ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("xmasreward", function(source, args)
    SetDisplay(not display)
    ExecuteCommand('e box')
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback('addBonus', function()
    TriggerServerEvent('addBonus')
end)

RegisterNetEvent('showWaitMessage')
AddEventHandler('showWaitMessage', function(timeLeft)
    SendNUIMessage({
        type = "wait",
        timeLeft = timeLeft,
    })
end)

RegisterNetEvent('showNotification')
AddEventHandler('showNotification', function(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end)

function SetDisplay(value)
    display = value
    SetNuiFocus(value, value)
    SendNUIMessage({
        type = "ui",
        status = value,
    })
end
