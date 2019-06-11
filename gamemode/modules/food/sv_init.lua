function FoodSystem(ply)
	if !ply.nextht or ply.nextht <= CurTime() then
		if ply:GetHunger() > 0 then
			ply:TakeHunger(1);
		end
		
		if ply:GetThirst() > 0 then
			ply:TakeThirst(1);
		end
		
		if ply:GetHunger() <= 10 or ply:GetThirst() <= 10 then
			send_chat(ply, "당신은 현재 배고프거나 목마른 상태입니다.", Color(255, 0, 0, 255))
		end
		
		if ply:GetHunger() <= 0 or ply:GetThirst() <= 10 then
			ply:Kill()
		end
		
		ply.nextht = CurTime() + FOOD_CONFIG.ReduceTime
	end
end
hook.Add("PlayerPostThink", "FoodSystem", FoodSystem)

function SetInitFood(ply)
	ply:SetHunger(100)
	ply:SetThirst(100)
end
hook.Add("PlayerSpawn", "SetInitFood", SetInitFood)