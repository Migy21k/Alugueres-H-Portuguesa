--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV
ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)-- esperar alguns segundos segundos
  end
end)

RegisterNetEvent("21kautopt:checkMoney")
AddEventHandler("21kautopt:checkMoney", function(name,number)
    local src = source
    local user = ESX.GetPlayerFromId(src)

    local car_price = config.cars[number].car_price
    local car_name = name
    
    local bank = user.getAccount('bank').money

    if bank >= car_price then
      user.removeAccountMoney('bank', car_price)
      TriggerEvent('Notification',"Car has been rented for $"..car_price)-- não mexer
        TriggerClientEvent('21k-auto:rentcar',source, car_name)
    else
      TriggerEvent('Notification',"Não tens dinheiro sufeciente..")-- alterar se quiseres
    end
    

end)
--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV