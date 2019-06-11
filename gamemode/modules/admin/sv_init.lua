AddCommand("관리", function(ply, args)
	if #args > 0 then
		if args[1] == "업무" then
			if ply:IsSuperAdmin() or ply:IsAdmin() then
				if !ply:GetNWBool("admin") then
					for k, v in pairs(player.GetAll()) do
						if ply:GetNWString("adminnick") ~= "" then
							send_chat(v, ply:GetNWString("adminnick") .. " 님이 관리 업무를 시작하였습니다.", Color(255, 255, 255, 255))
						else
							send_chat(v, ply:Nick() .. " 님이 관리 업무를 시작하였습니다.", Color(255, 255, 255, 255))
						end
					end
					ply:SetNWBool("admin", true)
					
					ply:Give("weapon_physgun")
					ply:Give("gmod_tool")
					ply:ConCommand("gmod_toolmode remover")
				else
					for k, v in pairs(player.GetAll()) do
						if ply:GetNWString("adminnick") ~= "" then
							send_chat(v, ply:GetNWString("adminnick") .. " 님이 관리 업무를 종료하였습니다.", Color(255, 255, 255, 255))
						else
							send_chat(v, ply:Nick() .. " 님이 관리 업무를 종료하였습니다.", Color(255, 255, 255, 255))
						end
					end			
					ply:SetNWBool("admin", false)
					ply:StripWeapon("weapon_physgun")
					ply:StripWeapon("gmod_tool")
				end
			end
		elseif args[1] == "가명" then
			local text = ""
			for k, v in pairs(args) do
				if k ~= 1 then
					text = text .. v
				end
			end
			
			if ply:IsSuperAdmin() or ply:IsAdmin() then	
				ply:SetNWString("adminnick", "[GM]" .. text)
				
				ply:SaveAdminNick()
				
				send_chat(ply, "어드민 가명을 " .. text .. " 로 설정하였습니다.", Color(255, 255, 255, 255))
			end	
		end
	end
end)

AddCommand("숨기", function(ply, args)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if !ply:GetNWBool("hide") then
			ply:SetNWBool("hide", true)
			ply:SetNoDraw(true)
			ply:StripWeapons()
			send_chat(ply, "숨기 모드 활성화", Color(255, 0, 0, 255))
		else
			ply:SetNWBool("hide", false)
			for k, v in pairs(JOB[ply:GetJOB()].Weapons) do
				ply:Give(v)
			end
			ply:SetNoDraw(false)
			send_chat(ply, "숨기 모드 비활성화", Color(255, 0, 0, 255))
		end
	end
end)

AddCommand("공지", function(ply, args, text)
	if ply:IsAdmin() then
		if #args > 0 then
			local text = string.Replace(text, "/공지 ", "")
			
			for k, v in pairs(player.GetAll()) do
				send_chat(v, "[공지]" .. text, Color(255, 255, 255, 255))
			end
		end
	end
end)

AddCommand("이름변경", function(ply, args, text)
	if ply:IsAdmin() then
		if #args > 0 then
			if args[1] then
				local target;
					
				for k, v in pairs(player.GetAll()) do
					if string.find(string.upper(v:Nick()), string.upper(args[1])) or (v:GetNWString("name") ~= "" && string.find(string.upper(v:GetNWString("name")), string.upper(args[1]))) then
						target = v;
					end
				end	

				local text = string.Replace(text, "/이름변경 " .. args[1], "")
				if IsValid(target) then
					local args = string.Explode(" ", text)
					CLOTHESMOD.PlayerInfos[target:SteamID64()].name = args[2]
					CLOTHESMOD.PlayerInfos[target:SteamID64()].surname = args[3]
					
					target:SetNWString("name", args[2] .. " " .. args[3])
					
					target:CM_SavePlayerInfos()
					target:CM_NetworkTableInfos()
				end
			end
		end
	end
end)

AddCommand("강제튜토", function(ply, args, text)
	if ply:IsAdmin() then
		if #args > 0 then
			if args[1] then
				local target;
					
				for k, v in pairs(player.GetAll()) do
					if string.find(string.upper(v:Nick()), string.upper(args[1])) or string.find(string.upper(v:GetNWString("name")), string.upper(args[1])) then
						target = v;
					end
				end	

				if IsValid(target) then
					target:SendLua("OpenForceTutorial()")
				end
			end
		end
	end
end)

AddCommand("돈", function(ply, args, text)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		if #args > 0 then
			local target;
			
			for k, v in pairs(player.GetAll()) do
				if string.find(string.upper(v:Nick()), string.upper(args[2])) or string.find(string.upper(v:GetNWString("name")), string.upper(args[2])) then
					target = v;
					break;
				end
			end
		
			if IsValid(target) then
				if args[1] == "주기" then
					if args[3] then
						if isnumber(tonumber(args[3])) then
							target:AddMoney(tonumber(args[3]))
							
							send_chat(ply, target:GetNWString("name") .. " 님에게 돈을 지급하였습니다.", Color(120, 50, 255, 255))
							send_chat(target, ply:GetNWString("name") .. " 님이 돈을 지급하였습니다.", Color(120, 50, 255, 255))
						end
					end
				elseif args[1] == "탈취" then
					if args[3] then
						if isnumber(tonumber(args[3])) then
							target:TakeMoney(tonumber(args[3]))
							send_chat(ply, target:GetNWString("name") .. " 님에게 돈을 빼앗았습니다.", Color(120, 50, 255, 255))
							send_chat(target, ply:GetNWString("name") .. " 님이 돈을 빼앗았습니다.", Color(120, 50, 255, 255))
						end
					end			
				end
			end
		end
	end
end)

AddCommand("캐릭터", function(ply, args, text)
	if ply:IsAdmin() then
		if #args > 0 then
			if args[1] then
				local target;
					
				for k, v in pairs(player.GetAll()) do
					if string.find(string.upper(v:Nick()), string.upper(args[1])) or (v:GetNWString("name") ~= "" && string.find(string.upper(v:GetNWString("name")), string.upper(args[1]))) then
						target = v;
					end
				end	

				if IsValid(target) then
					target:SetNWBool("char", false)
					target:SendLua([[open_char()]])
				end
			end
		end
	end
end)

function admin_noclip(ply)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		return true
	else
		return false
	end
end
hook.Add("PlayerNoClip", "admin_noclip", admin_noclip)