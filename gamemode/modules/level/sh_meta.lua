local meta = FindMetaTable("Player")

function meta:SetLevel(lvl)
	self:SetNWInt("level", lvl)
	
	self:SaveLevel()
end

function meta:AddLevel(lvl)
	self:SetLevel(self:GetLevel() + lvl)
end

function meta:TakeLevel(lvl)
	self:SetLevel(self:GetLevel() - lvl)
end

function meta:GetLevel()
	return self:GetNWInt("level", 1)
end

function meta:SetEXP(a)
	self:SetNWInt("exp", a)
	
	self:SaveLevel()
end

function meta:AddEXP(a)
	self:SetEXP(self:GetEXP() + a)
end

function meta:TakeEXP(a)
	self:SetEXP(self:GetEXP() - a)
end

function meta:GetEXP()
	return self:GetNWInt("exp")
end