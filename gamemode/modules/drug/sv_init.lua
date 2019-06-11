util.AddNetworkString("send_bank");

AddCommand("add_drug", function(ply, args)
	drugtable = drugtable or {}
	drugtable[#drugtable + 1] = tostring(ply:GetPos())
	local ent = ents.Create("obj_drug")
		ent:SetPos(ply:GetPos())
		ent:Spawn()
	save_drug()
end)

AddCommand("밀매", function(ply, args)
	if drugtable then
		local bool = false;
		
		for k, v in pairs(drugtable) do
			local pos = util.StringToType(v, "Vector")
			if pos:Distance(ply:GetPos()) <= 200 then
				bool = true;
				break
			end
		end
	
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
			if v:GetClass() == "obj_drug" then
				bool = true;
				break
			end
		end
		
		if bool then
			ply:SendLua([[OpenShop()]])
		else
			send_chat(ply, "근처에 밀매 위치가 존재하지 않습니다.", Color(255, 0, 0, 255))
		end
	else
		send_chat(ply, "근처에 밀매 위치가 존재하지 않습니다.", Color(255, 0, 0, 255))
	end
end)


function save_drug()
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. game.GetMap(), "DATA") then
		file.CreateDir("rf_data/" .. game.GetMap())
	end
	
	drugtable = drugtable or {}
	file.Write("rf_data/" .. game.GetMap() .. "/drug.txt", util.TableToKeyValues(drugtable))
end

function load_drug()
	if !file.Exists("rf_data/" .. game.GetMap() .. "/drug.txt", "DATA") then
		save_drug()
	else
		local data = util.KeyValuesToTable(file.Read("rf_data/" .. game.GetMap() .. "/drug.txt", "DATA"))
		
		for k, v in pairs(data) do
			v = util.StringToType(v, "Vector")
			
			local ent = ents.Create("obj_drug")
				ent:SetPos(v)
				ent:Spawn()			
		end
		
		drugtable = data
	end
end
hook.Add("InitPostEntity", "load_drug", load_drug)