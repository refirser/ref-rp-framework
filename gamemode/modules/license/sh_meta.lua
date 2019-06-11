local meta = FindMetaTable("Player")

function meta:SetLicense(bool)
	self:SetNWBool("license", bool)
end

function meta:GetLicense()
	return self:GetNWBool("license")
end

function meta:HasLicense()
	if self:GetLicense() then
		return true
	else
		return false
	end
end