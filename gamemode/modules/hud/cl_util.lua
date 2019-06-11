function util.CreateGUIBlur(panel, density, alpha)
	local blur = Material( "pp/blurscreen" )
	local x, y = panel:LocalToScreen(0, 0)
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )
	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
	end	
end

function util.CreateBlurBackGround(panel, density, alpha)
	local blur = Material( "pp/blurscreen" )
	local x, y = panel:LocalToScreen(0, 0)
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )
	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( -x, -y, ScrW(), ScrH() )
	end	
end

function EyeAngles3D2D()
	local ang = EyeAngles()
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 270)
	return ang
end

function EyePos3D2DScreen(right, up, forward)
	local eyepos = EyePos()
	local eyeang = EyeAngles()
	return eyepos + eyeang:Forward() * (forward or 1024) + eyeang:Right() * right + eyeang:Up() * up
end