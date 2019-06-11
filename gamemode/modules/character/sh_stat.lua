CHAR_STAT = {
	["jump"] = {
		Name = "다리 힘 증가",
		Desc = "점프력이 증가합니다.",
		hook = {
			["PlayerSpawn"] = function(ply)
				ply:SetJumpPower(150 + ply:GetStat("stat")*10)
			end,
		}
	},
	
	["runspeed"] = {
		Name = "달리는 속도 증가",
		Desc = "달리는 속도가 증가합니다.",
		hook = {
			["PlayerSpawn"] = function(ply)
				ply:SetWalkSpeed(170 + ply:GetStat("runspeed")*10)
				ply:SetRunSpeed(200 + ply:GetStat("runspeed")*10)
			end,
		}
	},
	
	["health"] = {
		Name = "맷집 증가",
		Desc = "최대 체력이 증가합니다.",
		hook = {
			["PlayerSpawn"] = function(ply)
				ply:SetHealth(100 + ply:GetStat("health")*10)
				ply:SetMaxHealth(100 + ply:GetStat("health")*10)
			end,
		}
	},
	
	["look"] = {
		Name = "흔들림 감소",
		Desc = "시야의 흔들림이 감소합니다.",
	},
}

local meta = FindMetaTable("Player")

function meta:GetStat(s)
	return self:GetNWInt(s)
end
