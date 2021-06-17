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

	if Config.usemoney then
		ESX.TriggerServerCallback('night_garage:checkmoney', function(moneycheck)
			if moneycheck then
				if carro == 'sultanrs' then
					ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
					end)
					TriggerServerEvent('night_money:garage','money',1000)
				elseif 	carro == 'police' then
					ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
					end)
					TriggerServerEvent('night_money:garage','money',1000)
				elseif carro == 'manchez2' then
					ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
					end)
					TriggerServerEvent('night_money:garage','money',1000)
				end
			end
		end
		
	elseif not cConfig.usemoney then
		ESX.TriggerServerCallback('night_garage:checkbank', function(moneybank)
			if moneybank then
				if carro == 'sultanrs' then
					ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
					end)
					TriggerServerEvent('night_money:garage','bank',1000)
				elseif 	carro == 'police' then
					ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
					end)
					TriggerServerEvent('night_money:garage','bank',1000)
				elseif carro == 'manchez2' then
					ESX.Game.SpawnVehicle(carro, vector3(-214.94,-1013.21,29.29), 65.76, function(speed)
					end)
					TriggerServerEvent('night_money:garage','bank',1000)
				end
			end
		end
	end	

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
        
        
    })
end)

Citizen.CreateThread(function()
    local shopKeeps = {
		`cs_prolsec_02`
    }

    exports['bt-target']:AddTargetModel(shopKeeps, {
        options = {
            {
                event = 'Night:policegarage',
                icon = 'fas fa-glass-martini-alt',
                label = "Open police garage"
            },
        },
        job = {Config.policejob},
        distance = 1.5
    })
end)



