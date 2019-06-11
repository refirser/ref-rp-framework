function LoadPlayer(ply)
	ply:LoadData()
end
hook.Add("PlayerInitialSpawn", "LoadPlayer", LoadPlayer)