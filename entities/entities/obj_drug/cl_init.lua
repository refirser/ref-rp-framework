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
	
	local ang = LocalPlayer():EyeAngles()
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
	cam.Start3D2D(self:GetPos() + Vector(0, 0, 50), ang, 0.5)
		surface.SetMaterial(Material("rfframe/drug.png"))
		surface.SetDrawColor(255, 255, 255, 200)
		surface.DrawTexturedRect(-25, -25, 50, 50)
	cam.End3D2D()
end

function ENT:Think()

end

function ENT:OnRemove()

end