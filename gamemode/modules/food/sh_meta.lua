local meta = FindMetaTable("Player")

function meta:SetHunger(a)
	self:SetNWInt("hunger", math.Clamp(a, 0, 100))
end

function meta:GetHunger()
	return self:GetNWInt("hunger")
end

function meta:AddHunger(a)
	self:SetHunger(self:GetHunger() + a)
end

function meta:TakeHunger(a)
	self:SetHunger(self:GetHunger() - a)
end

function meta:SetThirst(a)
	self:SetNWInt("thirst", math.Clamp(a, 0, 100))
end

function meta:GetThirst()
	return self:GetNWInt("thirst")
end

function meta:AddThirst(a)
	self:SetThirst(self:GetThirst() + a)
end

function meta:TakeThirst(a)
	self:SetThirst(self:GetThirst() - a)
end