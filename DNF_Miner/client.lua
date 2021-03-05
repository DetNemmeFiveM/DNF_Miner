vRPminerC = {}

pulamearafaele = nil

local pietre = {
	{-652.18688964844,5061.41796875,144.19654846191}, 
	{-630.28131103516,5043.3149414063,144.3895111084},
	{-621.99047851563,5042.115234375,144.4328918457}, 
	{-652.98284912109,5061.6938476563,144.21632385254},
}

local processLoc = {75.743522644043,6331.0659179688,31.225763320923}

local jobPoint = {-567.33221435547,5253.0068359375,70.466957092285}
local carSpawnPos = {-576.05834960938,5247.7451171875,70.471221923828}
local baza = {-571.58215332031,5252.0634765625,70.468124389648}

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(jobPoint[1], jobPoint[2],jobPoint[3])
    SetBlipSprite(blip, 385)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 46)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("[~p~Bibo~w~] Job Miner")
    EndTextCommandSetBlipName(blip)
end)

local isProcessing = false
local hasJob = false
local pietreTajate = false
local incepeSaLucrezi = false
local finisJob = false
local piatra = 0			

Citizen.CreateThread(function()
	carSpawned = false
	while true do
		Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		DrawMarker(20, -537.9462890625,5288.244140625,75.363456726074, 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
		DrawMarker(20, -527.2138671875,5289.208984375,74.090599060059, 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
		local carPos = GetEntityCoords(veh, false)
		if(Vdist(pos.x, pos.y, pos.z, jobPoint[1], jobPoint[2], jobPoint[3]) < 15.0)then
			DrawMarker(20, jobPoint[1], jobPoint[2], jobPoint[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
			if hasJob == false then
				if(Vdist(pos.x, pos.y, pos.z, jobPoint[1], jobPoint[2], jobPoint[3]) < 3.0) and not finisJob then
					notifica("[~o~Bibo~w~] Tryk ~INPUT_CONTEXT~ for at gå på jobbet ~p~Miner")
					if IsControlJustPressed(1,51) then
						hasJob = true
						txt("[~o~Bibo~w~] ~g~Tillykke! ~w~Nu er du: ~y~Miner~w~!")
						if hasJob == true and carSpawned == false then
							CreateMinerCar(carSpawnPos[1], carSpawnPos[2], carSpawnPos[3], 70.0)
							local arrBlip = AddBlipForCoord(-652.98284912109,5061.6938476563,144.21632385254)
							SetBlipSprite(arrBlip, 68)
							SetBlipRoute(arrBlip, true)
							SetBlipAsShortRange(arrBlip, false)
							incepeSaLucrezi = true
							-- Wait(10000)
							carSpawned = true
						end
					end
				end
			end
		end
		if hasJob == true and incepeSaLucrezi == true then
			if(Vdist(pos.x, pos.y, pos.z, -631.22332763672,5050.9799804688,144.10287475586) < 55.0)then
				for i,v in pairs(pietre) do
					DrawMarker(20, v[1], v[2], v[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
					if(Vdist(pos.x, pos.y, pos.z, v[1], v[2], v[3]) < 3.0)then
						DrawText3d(v[1], v[2], v[3]+0.4, "Tryk ~r~E ~w~hakke sten", 255)
						if IsControlJustPressed(1,51) then
							animPickAxe()
							-- Wait(20000)
							txt("Kør øver til arbejderne med stenene")
							local arrBlip = AddBlipForCoord(processLoc[1], processLoc[2], processLoc[3])
							SetBlipSprite(arrBlip, 68)
							SetBlipRoute(arrBlip, true)
							SetBlipAsShortRange(arrBlip, false)
							if piatra >= 1 then 
								pietreTajate = true
							end
						end
					end
				end
			end
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, processLoc[1], processLoc[2], processLoc[3]) < 6.5) and pietreTajate then
				notifica("Tryk på ~INPUT_CONTEXT~ for at få dine sten tjekket")
				if IsControlJustPressed(1,51) and pietreTajate then
					local theCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					FreezeEntityPosition(theCar, true)
					TaskLeaveVehicle(GetPlayerPed(-1), theCar, 0)
					txt("Læs alle stenene af bilen, de skal behandles!")
				end
				txt("[~o~Bibo~w~]Vent på, at arbejderne er færdige med at tjekke stenene!")
				Wait(10000)
				txt("[~o~Bibo~w~]Arbejderne har tjekket dine sten.")
				prelucrat = true
				SetNewWaypoint(jobPoint[1], jobPoint[2])
				txt("[~o~Bibo~w~] De ser fine ud, så kørnu tilbage til pladsen!")
				FreezeEntityPosition(theCar, false)
			end
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, baza[1], baza[2], baza[3]) < 20.0) and prelucrat then
				DrawMarker(20, baza[1], baza[2], baza[3], 0, 0, 0, 0, 0, 0, 0.6001,0.6001,0.6001, 5, 144, 51, 100, 0, 0, 0, 1, 0, 0, 0)
				notifica("Tryk på ~INPUT_CONTEXT~ for at aflevere dine sten!")
				if IsControlJustPressed(1,51) then
					TriggerServerEvent('vRP_miner:Pay')
					DeleteVehicle()
					pietreTajate = false
					hasJob = false
					finisJob = false
					incepeSaLucrezi = false
				end
			end
			local theCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if(Vdist(pos.x, pos.y, pos.z, carPos.x , carPos.y, carPos.z) > 105.0) and hasJob and incepeSaLucrezi and not DoesEntityExist(veh) then
				hasJob = false 
				incepeSaLucrezi = false
				finisJob = false
				pietreTajate = false
				txt("[~o~Bibo~w~]Du gik for langt væk fra bilen og missede missionen!")
			end
		end
	end
end)

function notifica(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function txt(msg) 
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(true, false)
end

-- function minereste()
-- 	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
-- 	local n = 0
-- 	local copac = GetHashKey("prop_log_01") 
-- 	while not HasModelLoaded(copac) and n < 100 do
-- 		RequestModel(copac)
-- 		Citizen.Wait(2)
-- 		n = n+1
-- 	end
-- 	-- RequestAnimDict("anim@heists@box_carry@")
-- 	-- TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
-- 	cvprop = CreateObject(GetHashKey('prop_log_01'), x+5,y,z-0.3, false)
-- 	AttachEntityToEntity(cvprop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, 'prop_log_01', -0.1, 5.0, 0.0, 90.0, 1, 1, 0, 1, 0, 1)
-- end

function animPickAxe()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
    while (not HasAnimDictLoaded("melee@large_wpn@streamed_core")) do 
        RequestAnimDict("melee@large_wpn@streamed_core")
        Citizen.Wait(5)
    end --      WORLD_HUMAN_GARDENER_LEAF_BLOWER
    local propaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(propaxe, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.08, -0.4, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
    TaskPlayAnim(GetPlayerPed(-1), "melee@large_wpn@streamed_core", "ground_attack_on_spot", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    FreezeEntityPosition(GetPlayerPed(-1),true)
	Citizen.Wait(20000)
	DeleteObject(propaxe)
	piatra = piatra + 1
    ClearPedTasksImmediately(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)
	DetachEntity(propaxe, 1, 1)
	DeleteObject(propaxe)
end

function CreateMinerCar(x,y,z,heading) -- van
	local hash = GetHashKey("Guardian")
    local n = 0
    while not HasModelLoaded(hash) and n < 500 do
        RequestModel(hash)
        Citizen.Wait(10)
        n = n+1
    end
    -- spawn car
    if HasModelLoaded(hash) then
        veh = CreateVehicle(hash,x,y,z,heading,true,false)
        SetEntityHeading(veh,heading)
        SetEntityInvincible(veh,false)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleLights(veh,2)
        SetVehicleColours(veh,147,41)
        SetVehicleNumberPlateTextIndex(veh,2)
		SetVehicleNumberPlateText(veh,"Miner")
		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetEntityAsMissionEntity(veh, true, true)
        for i = 0,24 do
            SetVehicleModKit(veh,0)
            RemoveVehicleMod(veh,i)
        end
    end
end

function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        SetDrawOrigin(x,y,z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end