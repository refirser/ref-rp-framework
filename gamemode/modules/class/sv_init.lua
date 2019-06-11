util.AddNetworkString("select_class");

function OpenClass(ply)
	ply:SendLua([[OpenClass()]])
end
hook.Add("ShowHelp", "OpenClass", OpenClass)

net.Receive("select_class", function(len,ply)
	local type = net.ReadString();
	local job = net.ReadInt(32);

	if type == "whitelist" then
		local target = net.ReadEntity();
		
		if target:GetJOB() ~= job then
			for k, v in pairs(target:GetWeapons()) do
				if JOB[target:GetJOB()].Weapons then
					if table.HasValue(JOB[target:GetJOB()].Weapons, v:GetClass()) then
						target:StripWeapon(v:GetClass())
					end
				end
			end		
			
			target:SetJOB(job)
			
			local nick = ""
			if ply:GetNWString("name") ~= "" then
				nick = ply:GetNWString("name")
			else
				nick = ply:Nick()
			end
			local target_nick = ""
			if target:GetNWString("name") ~= "" then
				target_nick = target:GetNWString("name")
			else
				target_nick = target:Nick()
			end			
			
			Notify(target, nick .. " 님이 당신에게 " .. JOB[target:GetJOB()].Name .. " 직업을 지급하였습니다.", 5)
			Notify(ply, target_nick .. " 님에게 " .. JOB[target:GetJOB()].Name .. " 직업을 지급하였습니다.", 5)		
			Notify(target, "캐릭터를 다시 커스텀 해주세요.", 5)
			
			target:SendLua([[open_char()]])
			
			if JOB[target:GetJOB()].GiveWeapon && JOB[target:GetJOB()].Weapons then
				for k, v in pairs(JOB[target:GetJOB()].Weapons) do
					target:Give(v)
				end			
			end
			
			target:SetModel(table.Random(JOB[target:GetJOB()].Model))
			
			target:SetNWBool("char", false)
			
			target:StripWeapon("uber_eat_bag_weap")
		else
			for k, v in pairs(target:GetWeapons()) do
				if JOB[target:GetJOB()].Weapons then
					if table.HasValue(JOB[target:GetJOB()].Weapons, v:GetClass()) then
						target:StripWeapon(v:GetClass())
					end
				end
			end	
			target:SetJOB(1)
			
			target:SetNWBool("char", false)
			
			local nick = ""
			if ply:GetNWString("name") ~= "" then
				nick = ply:GetNWString("name")
			else
				nick = ply:Nick()
			end
			local target_nick = ""
			if target:GetNWString("name") ~= "" then
				target_nick = target:GetNWString("name")
			else
				target_nick = target:Nick()
			end		
			
			Notify(target, nick .. " 님이 당신의 직업을 빼앗았습니다.", 5)
			Notify(ply, target_nick .. " 님의 직업을 빼앗았습니다.", 5)
			
			target:SendLua([[open_char()]])
			
			if JOB[target:GetJOB()].GiveWeapon && JOB[target:GetJOB()].Weapons then
				for k, v in pairs(JOB[target:GetJOB()].Weapons) do
					target:Give(v)
				end			
			end	
			
		end
		
		
	end
	
	if type == "job" then
		local count = 0;
		
		for k, v in pairs(player.GetAll()) do
			if v:GetJOB() == job then
				count = count + 1
			end
		end
		
		local bool = true;
		
		if JOB[ply:GetJOB()].Max then
			if count >= JOB[ply:GetJOB()].Max then
				send_chat(ply, "이미 그 직업은 꽉 차 있습니다.", Color(255, 0, 0, 255))
				bool = false;
			end
		end	
	
		if bool then
		for k, v in pairs(ply:GetWeapons()) do
			if JOB[ply:GetJOB()].Weapons then
				if table.HasValue(JOB[ply:GetJOB()].Weapons, v:GetClass()) then
					ply:StripWeapon(v:GetClass())
				end
			end
		end

		ply:SetJOB(job)
		
		if JOB[ply:GetJOB()].GiveWeapon then
			if JOB[ply:GetJOB()].Weapons then
				for k, v in pairs(JOB[ply:GetJOB()].Weapons) do
					ply:Give(v)
				end	
			end
		end
		end
	end
	
	hook.Call("OnPlayerChangedJob", GAMEMODE, ply)
end)