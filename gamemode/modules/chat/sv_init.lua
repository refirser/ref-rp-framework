util.AddNetworkString("send_chat");

function send_chat(ply, text, col)
	net.Start("send_chat")
		net.WriteString(text)
		net.WriteColor(col)
	net.Send(ply)
end

function send_chat_func(ply, text, tc)
	if tc then
		send_chat(ply, "팀챗이 아닌 전체 채팅으로 말해주세요.", Color(255, 0, 0, 255))
		return ""
	end
	local cmd = ""
	local t = string.Explode(" ", text)
	local args = {}
	
	for k, v in pairs(t) do
		if k == 1 then
			if string.find(v, "/") then
				cmd = string.Replace(v, "/", "")
			end
		else
			args[k - 1] = v
 		end
	end
	
	if COMMANDS and COMMANDS[cmd] then
		COMMANDS[cmd](ply, args, text)
		return ""
	end
	
	for k, v in pairs(COMMANDS) do
		if string.upper(k) == string.upper(cmd) then
			COMMANDS[k](ply, args, text)
			return
		end
	end
	
	if ply:GetNWBool("admin") && ply:GetNWString("adminnick") ~= "" then
		for k, v in pairs(player.GetAll()) do
			send_chat(v, ply:GetNWString("adminnick") .. " : " .. text, Color(255, 0, 0, 255))
		end		
		return ""
	end
	
	if ply:GetNWString("name") ~= "" then
		for k, v in pairs(player.GetAll()) do
			if v:GetPos():Distance(ply:GetPos()) <= 500 then
				send_chat(v, ply:GetNWString("name") .. " : " .. text, Color(255, 255, 255, 255))
			end
		end
		return ""
	end
	return text 
end
hook.Add("PlayerSay", "send_chat_func", send_chat_func)

AddCommand("ooc", function(ply, args, text)
	if #args > 0 then
			local text = string.Replace(text, "/ooc ", "")
			
			local nick = ""
			if ply:GetNWString("name") ~= "" then
				nick = ply:GetNWString("name")
			else
				nick = ply:Nick()
			end
			

			for k, v in pairs(player.GetAll()) do
				if v:GetPos():Distance(ply:GetPos()) < 500 then
					send_chat(v, "[OOC]" .. nick .. " : " .. text, Color(255, 255, 255, 255))
				end
			end
	end
end)

AddCommand("광고", function(ply, args, text)
	if #args > 0 then
		if ply:HasMoney(20) then
			ply:TakeMoney(20)
			local text = string.Replace(text, "/광고 ", "")

			for k, v in pairs(player.GetAll()) do
				send_chat(v, "☎ - " .. ply:GetPhone() .. " : " .. text, Color(238, 255, 0, 255))
			end
		elseif (ply:GetJOB() == 28 && total_tex >= 20) then
			total_tex = total_tex - 20
			local text = string.Replace(text, "/광고 ", "")

			for k, v in pairs(player.GetAll()) do
				send_chat(v, "☎ - " .. ply:GetPhone() .. " : " .. text, Color(238, 255, 0, 255))
			end			
		else
			send_chat(ply, "돈이 부족합니다.", Color(255, 0, 0, 255))
		end
	end
end)

AddCommand("질문", function(ply, args, text)
	if #args > 0 then
			local text = string.Replace(text, "/질문 ", "")
			
			local nick = ""
			if ply:GetNWString("name") ~= "" then
				nick = ply:GetNWString("name")
			else
				nick = ply:Nick()
			end
			

			for k, v in pairs(player.GetAll()) do
				send_chat(v, "[질문]" .. nick .. " : " .. text, Color(172, 242, 0, 255))
			end
	end
end)

AddCommand("답변", function(ply, args, text)
	if #args > 0 then
			local target;
			
			for k, v in pairs(player.GetAll()) do
				if v:GetNWString("name") ~= "" then
					if string.find(string.upper(v:GetNWString("name")), string.upper(args[1])) then
						target = v
						break;
					end
				end
			end
	
			local text = string.Replace(text, "/답변 " .. args[1], "")
			
			local nick = ""
			if ply:GetNWString("name") ~= "" then
				nick = ply:GetNWString("name")
			else
				nick = ply:Nick()
			end
			

			for k, v in pairs(player.GetAll()) do
				if IsValid(target) then
					if target:GetNWString("name") ~= "" then
						send_chat(v, target:GetNWString("name") .. "님을 위한 답변 - " .. nick .. " : " .. text, Color(172, 242, 0, 255))
					end
				end
			end
	end
end)

AddCommand("무전", function(ply, args, text)
	if #args > 0 then
		local text = string.Replace(text, "/무전 ", "")
			
		local nick = ""
		if ply:GetNWString("name") ~= "" then
			nick = ply:GetNWString("name")
		else
			nick = ply:Nick()
		end
			

		for k, v in pairs(player.GetAll()) do
			if v:GetJOB() == ply:GetJOB() then
				if nick ~= "" then
					if JOB[ply:GetJOB()].Level && JOB[ply:GetJOB()].Level[ply:GetLevel()]  then
						send_chat(v, "[" .. JOB[ply:GetJOB()].Level[ply:GetLevel()].Name .. "]" .. nick .. " : " .. text, Color(255, 193, 158, 255))
					else
						send_chat(v, "[" .. JOB[ply:GetJOB()].Name .. "]" .. nick .. " : " .. text, Color(255, 193, 158, 255))
					end
				end
			end
		end
	end
end)

AddCommand("경험치", function(ply, args, text)
	send_chat(ply, "경험치 : " .. ply:GetEXP() .. "/" .. (ply:GetLevel()+1)*100, Color(76, 255, 138, 255))
end)

AddCommand("me", function(ply, args, text)
	if #args > 0 then
		local text = string.Replace(text, "/me ", "")
			
		local nick = ""
		if ply:GetNWString("name") ~= "" then
			nick = ply:GetNWString("name")
		else
			nick = ply:Nick()
		end
			

		for k, v in pairs(player.GetAll()) do
			if nick ~= "" then
				if v:GetPos():Distance(ply:GetPos()) < 500 then
					send_chat(v, nick .. "이(가) " .. text, Color(70, 67, 249, 255))
				end
			end
		end
	end
end)

AddCommand("yell", function(ply, args, text)
	if #args > 0 then
		local text = string.Replace(text, "/yell ", "")
			
		local nick = ""
		if ply:GetNWString("name") ~= "" then
			nick = ply:GetNWString("name")
		else
			nick = ply:Nick()
		end
			

		for k, v in pairs(player.GetAll()) do
			if nick ~= "" then
				if v:GetPos():Distance(ply:GetPos()) < 500 then
					send_chat(v, nick .. "이(가) 외침 : " .. text, Color(70, 67, 249, 255))
				end
			end
		end
	end
end)

AddCommand("명령어", function(ply, args, text)
	local t = {
		["/ooc"] = "OOC 채팅을 이용할 수 있습니다.",
		["/질문"] = "플레이어들에게 질문을 할 수 있습니다.",
		["/답변"] = "플레이어들의 질문에 답변할 수 있습니다.",
		["/광고"] = "광고를 낼 수 있습니다.",
		["/지불"] = "근처에 있는 플레이어에게 돈을 지불 할 수 있습니다.",
		["/계좌 입금 비용"] = "은행 장소에 가서 계좌에 비용을 입금할 수 있습니다.",
		["/계좌 출금 비용"] = "은행 장소에 가서 계좌에 있는 비용을 출금할 수 있습니다.",
		["/계좌 확인"] = "은행 장소에 가서 계좌에 있는 비용을 확인할 수 있습니다.",
		["/밀매"] = "밀매 장소에 가서 사용 시 밀매가 가능합니다.",
		["/무장"] = "직업의 지정된 무장 장소에 가서 사용시 무장할 수 있습니다.",
		["/상점"] = "상점 장소에 가서 사용 시 상점을 이용할 수 있습니다.",
		["/수배 시작"] = "지정한 플레이어를 수배합니다.",
		["/수배 해제"] = "지정한 플레이어를 수배 해제 합니다.",
		["/정비공"] = "정비공 업무를 시작하는 메시지를 날립니다.",
		["/무전"] = "같은 직종의 사람들끼리 무전이 가능합니다.",
		["/신고"] = "관리자에게 알피를 방해하거나 규칙을 안지키는 사람을 신고할 수 있습니다.",
		["/문의"] = "관리자에게 문의를 할 수 있습니다.",
		["/세금 확인"] = "미납된 세금을 확인합니다.",
		["/세금 지불 비용"] = "세금을 지불합니다.",
		["/미납리스트"] = "미납자의 리스트를 확인합니다.",
		["/call"] = "상대방의 번호를 통해 멀리에서도 문자를 주고받을 수 있습니다.",
		["/target"] = "경찰만 사용이 가능하며 번호를 통해 상대방의 위치를 추적할 수 있습니다.",
		["/phonenumber"] = "경찰만 사용이 가능하며 상대방의 번호를 알아낼 수 있습니다.",
		["/phone"] = "폰의 전원을 켜고 끌 수 있습니다.",
	}
	
	for k, v in pairs(t) do
		send_chat(ply,  k .. " : " .. v, Color(178, 235, 244, 255))
		send_chat(ply,  "----------------------------------------", Color(100, 100, 100, 255))
	end
end)

function GM:PlayerCanHearPlayersVoice( ply, talker )
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		return true
	end
	
	if talker:GetPos():Distance(talker:GetPos()) <= 500 then
		return true
	else
		return false
	end
end