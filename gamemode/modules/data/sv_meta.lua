local meta = FindMetaTable("Player")

function meta:SaveData()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. id, "DATA") then
		file.CreateDir("rf_data/" .. id)
	end
	
	local data = {
		["money"] = self:GetMoney(),
		["job"] = self:GetJOB(),
	}
	
	file.Write("rf_data/" .. id .. "/data.txt", util.TableToKeyValues(data))
end

function meta:LoadData()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.Exists("rf_data/" .. id .. "/data.txt", "DATA") then
		self:SaveData()
	else
		local data = util.KeyValuesToTable(file.Read("rf_data/" .. id .. "/data.txt", "DATA"))
			self:SetMoney(data.money or 0)
			self:SetJOB(tonumber(data.job))
	end
end