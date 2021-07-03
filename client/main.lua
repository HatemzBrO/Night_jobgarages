ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local PlayerData = {}
local genderNum = 0
local distancecheck = false


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(100)
		for k,v in pairs (Config.main) do
			local id = GetEntityCoords(PlayerPedId())
			local distancia = #(id - v.coords)
			
			if distancia < Config.Distancia and distancecheck == false then
				spawn(v.modelo, v.coords, v.heading, v.gender, v.animDict, v.animName)
				distancecheck = true
			end
			if distancia >= Config.Distancia and distancia <= Config.Distancia + 1 then
				
				distancecheck = false
				DeletePed(ped)
			end
		end
	end
	
	
end)

function spawn(modelo, coords, heading, gender, animDict, animName)
	
	RequestModel(GetHashKey(modelo))
	while not HasModelLoaded(GetHashKey(modelo)) do
		Citizen.Wait(1)
	end
	
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	end	

	
	local x, y, z = table.unpack(coords)
	ped = CreatePed(genderNum, GetHashKey(modelo), x, y, z - 1, heading, false, true)
		
	
	
	SetEntityAlpha(ped, 255, false)
	FreezeEntityPosition(ped, true) 
	SetEntityInvincible(ped, true) 
	SetBlockingOfNonTemporaryEvents(ped, true) 
	
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	
	
end

RegisterNetEvent('Night:garagepolice')
AddEventHandler('Night:garagepolice', function(vehicles)    
	local carro = vehicles.carro

	
	ESX.TriggerServerCallback('night_garage:checkmoney', function(moneycheck)
		if moneycheck then
			if carro == 'sultanrs' then
				ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
				end)
				TriggerServerEvent('night_money:garage','money',100)
			elseif 	carro == 'police' and moneycheck == 200 then
				ESX.Game.SpawnVehicle(carro, vector3(1866.5,3681.9,33.65), 212.16, function(speed)
				end)
				TriggerServerEvent('night_money:garage','money',200)
					
			elseif carro == 'manchez2' and moneycheck == 250 then
				ESX.Game.SpawnVehicle(carro, vector3(1872.49,3683.67,33.54), 244.51, function(speed)
				end)
				TriggerServerEvent('night_money:garage','money',250)
					
			else
				ESX.ShowNotification('No tienes el dinero suficiente')
			end	

		else
			notifies('you dont have anough money bud')
		end	
	end, 100)
		
	

end)

---police
RegisterNetEvent('Night:garagepolice2')
AddEventHandler('Night:garagepolice2', function(lol)
	local carro = lol.carro
	local xPlayer = PlayerPedId()

	
		
	if xPlayer then
		if carro == 'police3' then
			ESX.Game.SpawnVehicle(carro, vector3(1862.37,3679.71,33.67), 215.12, function(need)
			end)
			
		elseif 	carro == 'police' then
			ESX.Game.SpawnVehicle(carro, vector3(1866.5,3681.9,33.65), 212.16, function(need)
			end)
			
						
		elseif carro == 'manchez2' then
			ESX.Game.SpawnVehicle(carro, vector3(1872.49,3683.67,33.54), 244.51, function(need)     --- if you want to add more cars just copy this example and place another elseif with the car name and add it to nh context menu aswell
			end)
			
						   
		else
			notifies('No vehicle')
		end
		
	end	

end)

----ambulance
RegisterNetEvent('Night:garageambulance')
AddEventHandler('Night:garageambulance', function(lol)
	local carro = lol.carro
	local xPlayer = PlayerPedId()

	
		
	if xPlayer then
		if carro == 'ambulance' then
			ESX.Game.SpawnVehicle(carro, vector3(296.22,-604.75,43.31), 249.28, function(need)
			end)
			
		elseif 	carro == 'lguard' then
			ESX.Game.SpawnVehicle(carro, vector3(294.87,-607.97,43.33), 250.06, function(need)
			end)
			
						
		elseif carro == 'pranger' then
			ESX.Game.SpawnVehicle(carro, vector3(293.44,-611.24,43.47), 250.53, function(need)     --- if you want to add more cars just copy this example and place another elseif with the car name and add it to nh context menu aswell
			end)
			
						   
		else
			notifies('No vehicle')
		end
		
	end	

end)

---- delete cars
RegisterNetEvent('Night:policedele')
AddEventHandler('Night:policedele', function()

    
	notifies('Thanks for bring it back bad!')
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
    Wait(2000)
    NetworkFadeOutEntity(vehicle, true,false)
    Wait(2000)
    DeleteVehicle(vehicle)
      
end)





RegisterNetEvent('Night:policegarage', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "charger",
            txt = "take out charger",
            params = {
                event = "Night:garagepolice2",
                args = {
                    carro = 'police3',
                    
                }
            }
        },
        {
            id = 3,
            header = "police",
            txt = "take out patrol",
            params = {
                event = "Night:garagepolice2",
                args = {
                    carro = 'police',
                    
                }
            }
        },
        {
            id = 4,
            header = "bike",
            txt = "take out manchez",
            params = {
                event = "Night:garagepolice2",
                args = {
                    carro = 'manchez2',
                    
                }
            }
        },
		{
            id = 5,
            header = "delete vehicle",
            txt = "",
            params = {
                event = "Night:policedele",
                args = {
                    
                }
            }
        },
        
        
    })
end)

RegisterNetEvent('Night:policegaragemoney', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "sultanrs",
            txt = "Rent sultan",
            params = {
                event = "Night:garagepolice",
                args = {
                    carro = 'sultanrs',
                    
                }
            }
        },
        {
            id = 3,
            header = "police",
            txt = "Rent police",
            params = {
                event = "Night:garagepolice",
                args = {
                    carro = 'police',
                    
                }
            }
        },
        {
            id = 4,
            header = "bike",
            txt = "Rent bike",
            params = {
                event = "Night:garagepolice",
                args = {
                    carro = 'manchez2',
                    
                }
            }
        },
		{
            id = 5,
            header = "delete vehicle",
            txt = "",
            params = {
                event = "Night:policedele",
                args = {
                    
                }
            }
        },
        
        
    })
end)

RegisterNetEvent('Night:ambulance', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Ambulance garage",
            txt = ""
        },
        {
            id = 2,
            header = "ambulance",
            txt = "take out ambulance!",
            params = {
                event = "Night:garageambulance",
                args = {
                    carro = 'ambulance',
                    
                }
            }
        },
        {
            id = 3,
            header = "lguard",
            txt = "take out lguard",
            params = {
                event = "Night:garageambulance",
                args = {
                    carro = 'lguard',
                    
                }
            }
        },
        {
            id = 4,
            header = "pranger",
            txt = "take out pranger",
            params = {
                event = "Night:garageambulance",
                args = {
                    carro = 'pranger',
                    
                }
            }
        },
		{
            id = 5,
            header = "delete vehicle",
            txt = "",
            params = {
                event = "Night:policedele",
                args = {
                    
                }
            }
        },
        
        
    })
end)

Citizen.CreateThread(function()
    local shopKeeps = {
		`cs_prolsec_02`
    }

	local ems = {
		`s_f_y_scrubs_01`
	}

    exports['bt-target']:AddTargetModel(shopKeeps, {
        options = {
            {
                event = Config.event,
                icon = 'fas fa-car',
                label = "Open police garage"
            },
        },
        job = {Config.policejob},
        distance = 1.5
    })

	exports['bt-target']:AddTargetModel(ems, {
        options = {
            {
                event = Config.event2,
                icon = 'fas fa-car',
                label = "Open police garage"
            },
        },
        job = {Config.ambulancejob},
        distance = 1.5
    })

end)


function notifies(message)

    if Config.notitype == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.notitype == 'mythic' then
        exports['mythic_notify']:SendAlert('success', message, 10000)
    end

end   



