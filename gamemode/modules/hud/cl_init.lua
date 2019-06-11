local hide = {
	["CHudAmmo"] = true,
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudCrosshair"] = true,
	["CHudDeathNotice"] = true,
}

hook.Add("HUDShouldDraw", "Disable HUD", function(name)
	if hide[name] then
		return false
	end
end)

function automaticLineFeed(inputText)
	local resultText = {""}

	while(string.len(inputText) > 0) do
		local b = string.byte(inputText)
		if b >= 32 and b <= 126 then
			resultText[#resultText] = resultText[#resultText]..inputText[1]
			inputText = string.sub(inputText, 2)
		else
			resultText[#resultText] = resultText[#resultText]..inputText[1]..inputText[2]..inputText[3]
			inputText = string.sub(inputText, 4)
		end

		surface.SetFont("Gothic_40")
		if surface.GetTextSize(resultText[#resultText]) > 300 then
			resultText[#resultText] = resultText[#resultText].."\n"
			resultText[#resultText+1] = ""
		end
	end

	return resultText
end

function CustomHUD()
	if GetConVarNumber("hud_deathnotice_time") ~= 0 then
		RunConsoleCommand('hud_deathnotice_time', '0')
	end

	
	
	local maxhp = LocalPlayer():GetMaxHealth()
	local hp = LocalPlayer():Health()
	
	local job = "";
	local salary = 0;
	
	local money = LocalPlayer():GetMoney();
	
	local haslicense = LocalPlayer():HasLicense();

	draw.RoundedBox(0, 5, ScrH() - 35, 450, 30, Color(30, 30, 30, 255))
	draw.RoundedBox(0, 5, ScrH() - 35, math.Clamp(hp/maxhp, 0, 1)*450, 30, Color(255, 255, 255, 255))
	
	draw.RoundedBox(0, 5, ScrH() - 90, 222.5, 50, Color(0, 0, 0, 230))
	draw.RoundedBox(0, 232.5, ScrH() - 90, 222.5, 50, Color(0, 0, 0, 230))
	
	
	//Information
	draw.SimpleText("체력 " .. hp, "Gothic_32", 10, ScrH() - 20, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	if LocalPlayer():GetNWString("name") == "" then
		draw.SimpleText(LocalPlayer():Nick(), "Gothic_24_Bold", 7, ScrH() - 87, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
	else
		draw.SimpleText(LocalPlayer():GetNWString("name"), "Gothic_24_Bold", 7, ScrH() - 87, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
	end
	
	draw.RoundedBox(0, 5, ScrH() - 125, 222.5, 30, Color(0, 0, 0, 230))
	if LocalPlayer():GetPhonePower() then
		draw.SimpleText("폰 번호 : " .. LocalPlayer():GetPhone(), "Gothic_24_Bold", 116.25, ScrH() - 110, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText("폰 번호 : " .. LocalPlayer():GetPhone(), "Gothic_24_Bold", 116.25, ScrH() - 110, Color(130, 130, 130, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	draw.RoundedBox(0, 232.5, ScrH() - 125, 222.5, 30, Color(0, 0, 0, 230))
	if JOB[LocalPlayer():GetJOB()] && JOB[LocalPlayer():GetJOB()].Level then
		if JOB[LocalPlayer():GetJOB()].Level[LocalPlayer():GetLevel()] then
			draw.SimpleText(JOB[LocalPlayer():GetJOB()].Level[LocalPlayer():GetLevel()].Name, "Gothic_24_Bold", 232.25 + 111.25, ScrH() - 110, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("계급이 존재하지 않습니다.", "Gothic_24_Bold", 232.25 + 111.25, ScrH() - 110, Color(130, 130, 130, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	else
		draw.SimpleText("계급이 존재하지 않습니다.", "Gothic_24_Bold", 232.25 + 111.25, ScrH() - 110, Color(130, 130, 130, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	draw.RoundedBox(0, 5, ScrH() - 160, 222.5, 30, Color(0, 0, 0, 230))
	draw.RoundedBox(0, 232.5, ScrH() - 160, 222.5, 30, Color(0, 0, 0, 230))
	
	draw.SimpleText("배고픔 " .. LocalPlayer():GetHunger(), "Gothic_24_Bold", 116.25, ScrH() - 145, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("목마름 " .. LocalPlayer():GetThirst(), "Gothic_24_Bold", 232.25 + 111.25, ScrH() - 145, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	//JOB
	if JOB && JOB[LocalPlayer():GetJOB()] then
		job = JOB[LocalPlayer():GetJOB()].Name
		salary = JOB[LocalPlayer():GetJOB()].Salary
	end
	
	if LocalPlayer():GetNWString("name") == "" then
		surface.SetFont("Gothic_24_Bold")
		local tw, th = surface.GetTextSize(LocalPlayer():Nick())
		draw.SimpleText(job, "Gothic_24_Bold", 7 + tw + 5, ScrH() - 87, Color(120, 120, 120, 255), TEXT_ALIGN_LEFT)
	else
		surface.SetFont("Gothic_24_Bold")
		local tw, th = surface.GetTextSize(LocalPlayer():GetNWString("name"))
		draw.SimpleText(job, "Gothic_24_Bold", 7 + tw + 5, ScrH() - 87, Color(120, 120, 120, 255), TEXT_ALIGN_LEFT)	
	end
	
	//Money
	if money >= 999999 then
		money = 999999
	end
	draw.SimpleText("$" .. string.Comma(money) .. " [" .. salary .. "/min]", "Gothic_24_Bold", 7, ScrH() - 67, Color(220, 220, 220, 255), TEXT_ALIGN_LEFT)

	//License
	if haslicense then
		draw.SimpleText("총기 라이센스 소지", "Gothic_24_Bold", 232.25 + 111.25, ScrH() - 65, Color(63, 255, 92, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText("총기 라이센스 미소지", "Gothic_24_Bold", 232.25 + 111.25, ScrH() - 65, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	// Time Stamp
	surface.SetFont("Gothic_24")
	local tw, th = surface.GetTextSize(os.date( "%H:%M:%S" , os.time()))
	draw.RoundedBox(0, 5, 5, tw+10, th+10, Color(0, 0, 0, 230))
	draw.SimpleText(os.date( "%H:%M:%S" , os.time()), "Gothic_24", 10, 10, Color(230, 230, 230, 255), TEXT_ALIGN_LEFT)
	
	//Player Count
	surface.SetFont("Gothic_32_Bold")
	local tw, th = surface.GetTextSize(#player.GetAll() .. " / " .. game.MaxPlayers())
	draw.RoundedBox(0, 5, 44, tw+10, th+10, Color(0, 0, 0, 230))
	draw.SimpleText(#player.GetAll() .. " / " .. game.MaxPlayers(), "Gothic_32_Bold", 10, 49, Color(230, 230, 230, 255), TEXT_ALIGN_LEFT)	
end
hook.Add("HUDPaint", "CustomHUD", CustomHUD)

function GM:HUDDrawTargetID()

end

function CustomTarget()
	local trace = LocalPlayer():GetEyeTrace();
	
	if trace.Entity:IsPlayer() then
		if !trace.Entity:GetNWBool("admin") then
			if trace.Entity:GetNWString("name") == "" then
				draw.SimpleText("이름 미정", "Gothic_24_Bold", ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(trace.Entity:GetNWString("name"), "Gothic_24_Bold", ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		else
			if trace.Entity:GetNWString("adminnick") ~= "" then
				draw.SimpleText("[관리 업무]" .. trace.Entity:GetNWString("adminnick"), "Gothic_24_Bold", ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("관리 업무 중", "Gothic_24_Bold", ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end
hook.Add("HUDDrawTargetID", "CustomTarget", CustomTarget)

function DrawDesc()
	local pos;
	
	for k, ply in pairs(player.GetAll()) do
		local pos = ply:GetPos() + Vector( 0, 0, 90 )
		local ang = LocalPlayer():EyeAngles()
		
		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )
		
		local dist = LocalPlayer():GetPos():Distance( ply:GetPos() )
		
		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.15 )		
			render.OverrideDepthEnable(false, true)
				local tw, th =  surface.GetTextSize(ply:GetNWString("desc"))
				for l, txt in pairs(automaticLineFeed(ply:GetNWString("desc"))) do
					draw.DrawText(txt, "Gothic_40", 0, l*35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
				end
				--draw.DrawText(ply:GetNWString("desc"), "Gothic_40", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)		
			render.OverrideDepthEnable(false, false)
		cam.End3D2D()
	end
end
hook.Add("PostDrawTranslucentRenderables", "DrawDesc", DrawDesc)