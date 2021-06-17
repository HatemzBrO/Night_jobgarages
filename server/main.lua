

ESX.RegisterServerCallback('night_garage:checkmoney', function(source,cb, money)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local has = xPlayer.getMoney()

    if money ~= nil then
        if has >= money then
            cb(true)
        else
            cb(false)
        end
    end

end) 

ESX.RegisterServerCallback('night_garage:checkbank', function(source,cb, account)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local has = xPlayer.getAccount('bank')

    if account ~= nil then
        if has >= account then
            cb(true)
        else
            cb(false)
        end
    end

end) 

RegisterServerEvent('night_money:garage')
AddEventHandler('night_money:garage', function(money,dinero)
    local user = source
    local xPlayer = ESX.GetPlayerFromId(user)

    if xPlayer then
        xPlayer.removeAccountMoney(money,dinero)
    end
end) 





