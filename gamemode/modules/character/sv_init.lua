util.AddNetworkString("character");
util.AddNetworkString("character_remove");
util.AddNetworkString("stat");

net.Receive("character", function(len, ply)
	local bool = net.ReadBool();
	local name = net.ReadString();
	local desc = net.ReadString();
	local model = net.ReadString();
	
	
	if bool then
		namedata = namedata or {}
	
		if !table.HasValue(namedata, name) then
			ply:Spawn()
			
			ply:SetNWString("name", name)
			ply:SetNWString("desc", desc)
			ply:SetNWString("mdl", model)
			ply:SetModel(model)
			
			ply:SaveCharacter()
			
			namedata[#namedata + 1] = name
			
			ply:SetNoDraw(false)
			
			ply:SetNWBool("char", true)
		else
			Notify(ply, "이름이 중복됬습니다. 다시 생성해주세요.", 5)
			timer.Simple(5, function()
				if IsValid(ply) then
					ply:SendLua([[init_char()]])	
				end
			end)
		
		end
	else
		if !ply:GetNWBool("char") then
			ply:ConCommand("disconnected")
		end
	end
end)

net.Receive("character_remove", function(len, ply)
	ply:SetNoDraw(true)

	if table.HasValue(namedata, ply:GetNWString("name")) then
		table.RemoveByValue(ply:GetNWString("name"))
	end
	
	ply:SetNWString("name", "")
	ply:SetNWString("desc", "")
	ply:SetNWString("mdl", "")
	
	ply:SetNWInt("stat_point", 5)
	
	ply:SetNWBool("char", false)
	
	ply:SendLua([[init_char()]])
end)

net.Receive("stat", function(len, ply)
	local bool = net.ReadBool();
	local stat = net.ReadString();
	
	if bool then
		if ply:GetNWInt("stat_point") > 0 then
			ply:SetStat(stat, ply:GetStat(stat) + 1)
			ply:SetNWInt("stat_point", ply:GetNWInt("stat_point") - 1)
		end
	else
		ply:SetStat(stat, ply:GetStat(stat) - 1)
		ply:SetNWInt("stat_point", ply:GetNWInt("stat_point") + 1)
	end
end)