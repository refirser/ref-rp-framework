util.AddNetworkString("send_bank");

AddCommand("add_armory", function(ply, args)
	armorytable = armorytable or {}
	armorytable[#armorytable + 1] = tostring(ply:GetPos())
	local ent = ents.Create("obj_armory")
		ent:SetPos(ply:GetPos())
		ent:Spawn()
	save_armory()
end)

AddCommand("무장", function(ply, args)
	if armorytable then
		local bool = false;
		
		for k, v in pairs(armorytable) do
			local pos = util.StringToType(v, "Vector")
			if pos:Distance(ply:GetPos()) <= 200 then
				bool = true;
				break
			end
		end
		
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
			if v:GetClass() == "obj_armory" then
				bool = true;
				break
			end
		end
		
		if bool then
			if JOB && JOB[ply:GetJOB()] && JOB[ply:GetJOB()].Weapons then
				ply:RemoveAllAmmo()
				for k, v in pairs(JOB[ply:GetJOB()].Weapons) do
					ply:Give(v)
				end
			end
			
			if JOB && JOB[ply:GetJOB()] && JOB[ply:GetJOB()].Level && JOB[ply:GetJOB()].Level[ply:GetLevel()].Weapons then
				ply:RemoveAllAmmo()
				for k, v in pairs(JOB[ply:GetJOB()].Level[ply:GetLevel()].Weapons) do
					ply:Give(v)
				end			
			end
			
			send_chat(ply, "무장 완료하였습니다.", Color(255, 255, 255, 255))
		else
			send_chat(ply, "근처에 무장 위치가 존재하지 않습니다.", Color(255, 0, 0, 255))
		end
	else
		send_chat(ply, "근처에 무장 위치가 존재하지 않습니다.", Color(255, 0, 0, 255))
	end
end)


function save_armory()
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. game.GetMap(), "DATA") then
		file.CreateDir("rf_data/" .. game.GetMap())
	end
	
	armorytable = armorytable or {}
	file.Write("rf_data/" .. game.GetMap() .. "/armory.txt", util.TableToKeyValues(armorytable))
end

function load_armory()
	if !file.Exists("rf_data/" .. game.GetMap() .. "/armory.txt", "DATA") then
		save_armory()
	else
		local data = util.KeyValuesToTable(file.Read("rf_data/" .. game.GetMap() .. "/armory.txt", "DATA"))
		
		for k, v in pairs(data) do
			pos = util.StringToType(v, "Vector")
			
			local ent = ents.Create("obj_armory")
				ent:SetPos(pos)
				ent:Spawn()			
		end
		
		armorytable = data
	end
end
hook.Add("InitPostEntity", "load_armory", load_armory)