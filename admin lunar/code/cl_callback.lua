Callback = {}

Callback.triggerServerCallback = function(name, callback, ...)
    TriggerServerEvent('Ins:triggerServerCallbackSend', name, ...)
    Callback.callbacks[name] = callback
end

Callback.callbacks = {}

RegisterNetEvent('Ins:triggerServerCallbackReceive')
AddEventHandler('Ins:triggerServerCallbackReceive', function(name, ...)
    local Invoke = GetInvokingResource()
    if Invoke then
        CreateThread(function() while true do end end) -- by ins
    else
        local callback = Callback.callbacks[name]
        if callback then
            if InsConfig.CallbackDebug then
                print('^7Callback name : ^3'..name..' ^7| Registered : ^6yes^7')
                print('^2Attemps to call : ^7'..json.encode(...))
            end
            callback(...)
            Callback.callbacks[name] = nil
        end
    end
end) -- by ins