local meta = FindMetaTable("Player")

function meta:SaveLevel()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	local data = {
		["level"] = self:GetLevel(),
		["exp"] = self:GetEXP(),
	}
	
	file.Write("rf_data/" .. id .. "/level.txt", util.TableToKeyValues(data))
end

function meta:LoadLevel()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. id, "DATA") then
		file.CreateDir("rf_data/" .. id)
	end
	
	if !file.Exists("rf_data/" .. id .. "/level.txt", "DATA") then
		self:SaveLevel()
	else
		local data = util.KeyValuesToTable("rf_data/" .. id .. "/level.txt", "DATA")
		
		self:SetLevel(tonumber(data.level))
		self:SetEXP(tonumber(data.exp))
	end
end

function load_level(ply)
	ply:LoadLevel()
end
hook.Add("PlayerInitialSpawn", "load_level", load_level)
