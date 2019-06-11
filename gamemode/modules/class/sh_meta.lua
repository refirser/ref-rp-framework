local meta = FindMetaTable("Player")

function meta:SetJOB(a)
	self:SetNWInt("job", tonumber(a))
	
	self:SaveData()
end

function meta:GetJOB()
	return tonumber(self:GetNWInt("job", 1))
end