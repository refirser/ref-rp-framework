local meta = FindMetaTable("Player")

bankmoney = 0

function meta:SetAccountMoney(a)
	self:SetNWInt("accountmoney", a)
	
	self:SaveBank()
end

function meta:GetAccountMoney()
	return self:GetNWInt("accountmoney")
end

function meta:AddAccountMoney(a)
	self:SetAccountMoney(self:GetAccountMoney() + a)
	
	bankmoney = bankmoney + a
end

function meta:TakeAccountMoney(a)
	self:SetAccountMoney(self:GetAccountMoney() - a)
end

function meta:HasAccountMoney(a)
	if self:GetAccountMoney() >= a then
		return true
	else
		return false
	end
end