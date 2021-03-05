local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_miner")
vRPCminer = Tunnel.getInterface("vRP_miner","vRP_miner")

vRPminer = {}
Tunnel.bindInterface("vRP_miner",vRPminer)
Proxy.addInterface("vRP_miner",vRPminer)


RegisterServerEvent('vRP_miner:Pay')
AddEventHandler('vRP_miner:Pay', function()
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    if player then
        vRP.giveMoney({user_id,10000})
		vRPclient.notify(player, {"[~o~Bibo~w~] Du modtog ~g~10000 kr. ~w~for at klare din job ~p~Miner~w~!"})
	end
end)


