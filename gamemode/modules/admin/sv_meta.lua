local meta = FindMetaTable("Player")

function meta:SaveAdminNick()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	file.Write("rf_data/" .. id .. "/admin.txt", self:GetNWString("adminnick"))
end

function meta:LoadAdminNick()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if file.Exists("rf_data/" .. id .. "/admin.txt", "DATA") then
		self:SetNWString("adminnick", file.Read("rf_data/" .. id .. "/admin.txt", "DATA"))
	end
end

function load_admin(ply)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		ply:LoadAdminNick()
	end
end
hook.Add("PlayerInitialSpawn", "load_admin", load_admin)