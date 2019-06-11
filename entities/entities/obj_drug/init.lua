AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

ENT.HitBoxSize = 70
ENT.HitBoxMin = Vector(-ENT.HitBoxSize, -ENT.HitBoxSize, -ENT.HitBoxSize / 2)
ENT.HitBoxMax = Vector(ENT.HitBoxSize, ENT.HitBoxSize, ENT.HitBoxSize / 2)

function ENT:Initialize()
	if SERVER then
		self:PhysicsInitSphere(1)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self:SetCollisionBounds(self.HitBoxMin, self.HitBoxMax)
		self:DrawShadow(false)
		self:SetNotSolid(true)
		self:SetTrigger(true)
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableDrag(false)
			phys:EnableGravity(false)
			phys:EnableCollisions(false)
			phys:Wake()
		end
	end
end

function ENT:Think()

end

function ENT:Touch(ent)

end