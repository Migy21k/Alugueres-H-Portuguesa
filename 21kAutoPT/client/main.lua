--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV
aESX = nil
local setTimerStarte = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)-- tempo de espera
  end
end)

local display = false
local peds = {} 
local car_names = {}
local car_prices = {}

for i = 1, #config.cars, 1 do
	car_names[i] = config.cars[i].car_name
end

for i = 1, #config.cars, 1 do
	car_prices[i] = config.cars[i].car_price
end



RegisterNUICallback("exit", function(data)
    SetDisplay(display)
end)

RegisterNUICallback("returncar", function(data)
    TriggerEvent("21kauto:returncar",source)
end)

RegisterNUICallback("rentcar", function(data)
    TriggerServerEvent("21kautopt:checkMoney",data.car_name,data.number)
end)


RegisterNetEvent('meeth-rantcar:opennui', function(data)
    SetDisplay(not display,car_names,car_prices)
end)


RegisterNetEvent('21k-auto:rentcar', function(carname)



ESX.Game.SpawnVehicle(carname, config.CarSpawnLocation.airport, config.CarSpawnLocation.airport.y, function(vehicle)
    SetVehicleNumberPlateText(car, "21k-dev")
	
        exports['LegacyFuel']:SetFuel(car, 100.0)
        SetEntityHeading(car, config.CarSpawnLocation.airport.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(car))
        SetVehicleEngineOn(car, true, true)

			
	

end)
local ped = PlayerPedId()
local car = GetVehiclePedIsIn(ped,true) 
			ESX.Game.DeleteVehicle(car)
	ESX.ShowHelpNotification("O Carro esta Alugado durante 15 minutos")-- se alterares o tempo troca isto
			setTimerStarte = true
			Citizen.SetTimeout(config.RentTime, function()
			TriggerEvent("21kauto:returncar",source)
				PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
			end)

			Citizen.SetTimeout(Config.WarningRentTime1, function()
				ESX.ShowHelpNotification("Falta 6 minutos para acabar o aluguer")-- se alterares o tempo troca isto
			end)

			Citizen.SetTimeout(Config.WarningRentTime2, function()
				ESX.ShowHelpNotification("Falta 1 minuto para acabar o aluguer")-- se alterares o tempo troca isto
			end)

    SetDisplay(display)
end)



RegisterNetEvent('21kauto:returncar', function()
	local ped = PlayerPedId()

	if IsPedInAnyVehicle(ped) then
			local car = GetVehiclePedIsIn(ped,true) 
			ESX.Game.DeleteVehicle(car)
			--SetEntityCoords(ped, config.PlayerReturnLocation.airport.x, config.PlayerReturnLocation.airport.y, config.PlayerReturnLocation.airport.z, 0, 0, 0, false) 
			SetEntityHeading(ped, config.PlayerReturnLocation.airport.y)
            SetDisplay(display)
    else
        SetDisplay(display)
	end
end)

--ESTA PARTE AQUI É TIRADA DA INTERNET PARA FAZER ALGUNS TESTES NÃO MEXER!
Citizen.CreateThread(function()
    local time = 10 -- 10 seconds
    while (time ~= 0) do -- Whist we have time to wait
        Wait( 1000 ) -- Wait a second
        time = time - 1
        -- 1 Second should have past by now
    end
    -- When the above loop has finished, 10 seconds should have passed. We can now do something
    TriggerEvent("21kauto:returncar",source) -- Call the client event "unjail"
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.55, 0.55)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.00, 41, 11, 41, 100)
end

Citizen.CreateThread(function()
while true do
	sleep = 200
	local ped = PlayerPedId()
	local kordinat = GetEntityCoords(ped)
	local dist = GetDistanceBetweenCoords(kordinat, 109.5597, -1088.195, 28.3, true) 
	if dist < 5.0 then
		sleep = 5
	end
	if dist < 4.0 then
		DrawText3D(109.5597, -1088.195, 29.4, ('~g~[E]~s~ Alugar um Carro'))
		if IsControlJustReleased(0, 46) then
			TriggerEvent("meeth-rantcar:opennui")
		end
	end
	Citizen.Wait(sleep)
end
end)




function SetDisplay(bool,car_names,car_prices)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        car_names = car_names,
        car_prices = car_prices,
        status = bool,
    })
end



Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)







--------------- THREADS

CreateThread(function()
	while true do
		Wait(500)
		for k = 1, #config.PedList, 1 do
			v = config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)

			if dist < 50.0 and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end

			if dist >= 50.0 and peds[k] then
				for i = 255, 0, -51 do
					Wait(50)
					SetEntityAlpha(peds[k].ped, i, false)
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end)

nearPed = function(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end

	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("Nenhum gênero fornecido! Verifique sua configuração!")
	end	

	ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	SetEntityAlpha(ped, 0, false)

	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) 
	end
	for i = 0, 255, 51 do
		Wait(50)
		SetEntityAlpha(ped, i, false)
	end

	return ped
end


Citizen.CreateThread(function()
	rentairport = AddBlipForCoord(config.CarSpawnLocation.airport)
	SetBlipSprite(rentairport, 523)
	SetBlipDisplay(rentairport, 4)
	SetBlipScale(rentairport, 1.0)
	SetBlipColour(rentairport, 31)
    SetBlipAsShortRange(rentairport, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("ALUGUERES HÁ PORTUGUESA")-- nome do blip
    EndTextCommandSetBlipName(rentairport)
end)
--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV--MIGY21KDEV