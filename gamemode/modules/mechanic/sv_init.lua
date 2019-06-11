AddCommand("정비공", function(ply, args, text)
	if ply:GetJOB() == 2 then
		if #args > 0 then
			if args[1] ~= "" then
				local text = string.Replace(text, "/정비공 ", "");
			
				for k, v in pairs(player.GetAll()) do
					send_chat(v, "정비공 작업을 시작하였습니다. ☎ - " .. ply:GetPhone(), Color(238, 255, 0, 255))
				end
			end
		end
	else
		send_chat(ply, "정비공만 사용할 수 있습니다.", Color(255, 0, 0, 255))
	end
end)