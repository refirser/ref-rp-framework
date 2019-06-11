local meta = FindMetaTable("Player")

function meta:SaveCharacter()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	local data = {
		["name"] = self:GetNWString("name"),
		["desc"] = self:GetNWString("desc"),
		["model"] = self:GetNWString("mdl"),
	}
	
	file.Write("rf_data/" .. id .. "/char.txt", util.TableToKeyValues(data))
	
	local data = namedata or {}
	file.Write("rf_data/name.txt", util.TableToKeyValues(namedata))
end

function meta:LoadCharacter()
	local id = string.Replace(self:SteamID(), ":", "!")
	
	if !file.Exists("rf_data/" .. id .. "/char.txt", "DATA") then
		self:SaveCharacter()
	else
		local data = util.KeyValuesToTable(file.Read("rf_data/" .. id .. "/char.txt", "DATA"))
			self:SetNWString("name", data.name)
			self:SetNWString("desc", data.desc)
			self:SetNWString("mdl", data.model)
			
			if data.model ~= "" then
				self:SetModel(data.model)
			end
			
			self:SetNWBool("char", true)
	end
	
	namedata = util.KeyValuesToTable(file.Read("rf_data/name.txt", "DATA")) or {}
end

hook.Add("PlayerInitialSpawn", "load_char", function(ply)
	ply:LoadCharacter()
end)

hook.Add("ShowTeam", "char_menu", function(ply)
	--if !ply:GetNWBool("char") then
		ply:SendLua([[open_char_menu()]])
	--else
		--Notify(ply, "캐릭터를 커스텀 할 권한이 없습니다.", 5)
	--end
end)