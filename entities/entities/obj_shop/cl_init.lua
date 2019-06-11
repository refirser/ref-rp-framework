include("shared.lua")

function ENT:Initialize()
	self:SetRenderBounds(Vector(-128, -128, -128), Vector(128, 128, 128))
end

function ENT:Draw()
	self:RenderDraw()
end

function ENT:RenderDraw()
	render.SetMaterial(Material("rfframe/circle.png"))
    render.DrawQuadEasy( self:GetPos(), Vector(0, 0, 1), 100, 100, Color(255,255,255,255))
end

function ENT:Think()

end

function ENT:OnRemove()

end