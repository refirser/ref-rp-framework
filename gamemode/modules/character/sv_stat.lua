local meta = FindMetaTable("Player")

function meta:SetStat(s, a)
	self:SetNWInt(s, a)
	
	self:SaveStat()
	self:SaveStatPoint()
end

function meta:SaveStat()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	local data = {}
	
	for k, v in pairs(CHAR_STAT) do
		data[k] = self:GetStat(k)
	end
	
	file.Write("rf_data/" .. id .. "/stat.txt", util.TableToKeyValues(data))
end

function meta:LoadStat()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. id, "DATA") then
		file.CreateDir("rf_data/" .. id)
	end
	
	if !file.Exists("rf_data/" .. id .. "/stat.txt", "DATA") then
		self:SaveStat()
	else
		local data = util.KeyValuesToTable(file.Read("rf_data/" .. id .. "/stat.txt", "DATA"))
		
		for k, v in pairs(data) do
			self:SetStat(k, tonumber(v))
		end
	end
end

function meta:SaveStatPoint()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	file.Write("rf_data/" .. id .. "/stat_point.txt", self:GetNWInt("stat_point"))
end

function meta:LoadStatPoint()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. id, "DATA") then
		file.CreateDir("rf_data/" .. id)
	end
	
	if !file.Exists("rf_data/" .. id .. "/stat_point.txt", "DATA") then
		self:SetNWInt("stat_point", 5)
		self:SaveStatPoint()
	else
		local data = file.Read("rf_data/" .. id .. "/stat_point.txt", "DATA")
		
		if isnumber(data) then
			self:SetNWInt("stat_point", tonumber(data))
		end
	end
end

function AddHookOnStat()
	for k, v in pairs(CHAR_STAT) do
		if v.hook then
			for k2, v2 in pairs(v.hook) do
				hook.Add(k2, k2 .. "_" .. k, v2)
			end
		end
	end
end
hook.Add("Initialize", "AddHookOnStat", AddHookOnStat)

function load_stat(ply)
	ply:LoadStat()
	ply:LoadStatPoint()
end
hook.Add("PlayerInitialSpawn", "load_stat", load_stat)