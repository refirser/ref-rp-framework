local meta = FindMetaTable("Player")

function meta:SaveBank()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	local data = file.Write("rf_data/" .. id .. "/account.txt", tostring(self:GetAccountMoney()))
end

function meta:LoadBank()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. id, "DATA") then
		file.CreateDir("rf_data/" .. id)
	end
	
	if !file.Exists("rf_data/" .. id .. "/account.txt", "DATA") then
		self:SaveBank()
	else
		local data = file.Read("rf_data/" .. id .. "/account.txt", "DATA")
		self:SetAccountMoney(tonumber(data))
	end
end