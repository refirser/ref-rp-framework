util.AddNetworkString("select_level");

net.Receive("select_level", function(len,ply)
	local level = net.ReadInt(32);
	local target = net.ReadEntity();
	
	
	if IsValid(target) then
		local nick = "";
		
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
			
			if target ~= ply then
				Notify(target, nick .. " 님이 당신에게 " .. JOB[target:GetJOB()].Level[level].Name .. " 계급을 지급하였습니다.", 5)
			end
			Notify(ply, target_nick .. " 님에게 " .. JOB[target:GetJOB()].Level[level].Name .. " 계급을 지급하였습니다.", 5)		
	
		target:SetLevel(level)
		target:SetEXP(0)	
	end

end)

function give_exp_think(ply)
	if !ply.giveexp then
		ply.giveexp = CurTime() + 300
	end
	
	if ply.giveexp && ply.giveexp <= CurTime() then
		ply.giveexp = CurTime() + 300
		
		if JOB[ply:GetJOB()] && JOB[ply:GetJOB()].Level then
			local default = 0;
			
			for k, v in pairs(JOB[ply:GetJOB()].Level) do
				if !v.Default then
					default = k
					break;
				end
			end
			
			if ply:GetLevel() + 1 < default then
				if ply:GetEXP() <= (ply:GetLevel()+1)*100 then
					ply:AddEXP(5)
					
					send_chat(ply, "계급 진급을 위한 경험치가 도착하였습니다.", Color(198, 255, 101, 255))
					send_chat(ply, "확인 : /경험치", Color(198, 255, 101, 255))
				else
					send_chat(ply, "진급을 하였습니다.", Color(198, 255, 101, 255))
					
					ply:SetEXP(math.max(0, ply:GetEXP() - (ply:GetLevel()+1)*100))
				
					ply:AddLevel(1)
				end
			else
				send_chat(ply, "더 이상 자동 진급이 불가능합니다.", Color(198, 255, 101, 255))
			end
		end
	end
end
hook.Add("PlayerPostThink", "give_exp_think", give_exp_think)