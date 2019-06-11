JOBMENU = JOBMENU or {}

JOBMENU = {
	[1] = {
		Name = "직업",
		Func = function(parent)
			for k, v in pairs(parent:GetChildren()) do
				v:Remove()
			end

			local function GetJOBCount(class)
				local count = 0;
				
				for k, v in pairs(player.GetAll()) do
					if v:GetJOB() == class then
						count = count + 1
					end
				end
				return count
			end
			
			for k, v in pairs(JOB) do
				if (!v.Default or (v.Default && LocalPlayer():GetJOB() ~= k)) && !v.Hide && !v.WhiteList then
					local button = parent:Add("DButton")
						button:SetText("")
						button:SetSize(parent:GetWide()/2-2.5, 50)
						button:SetPos(0,0)
					function button:OnCursorEntered()
						self.cursor = true
					end
					function button:OnCursorExited()
						self.cursor = false
					end
					function button:Paint(w,h)
						if self.cursor then
							draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 135, 150))
						else
							draw.RoundedBox(0, 0, 0, w, h, Color(127, 255, 195, 150))
						end
						
						draw.SimpleText(v.Name, "Gothic_32_Bold", 10, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
						
						local count = GetJOBCount(k);
						
						draw.RoundedBox(0, w - 75, h/2 - 15, 70, 30, Color(0, 0, 0, 255))
						if v.Max then
							draw.SimpleText(count.."/"..v.Max, "Gothic_24", w - 40, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						else
							draw.SimpleText(count.."/∞", "Gothic_24", w - 40, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
					end
					function button:DoClick()
						local count = GetJOBCount(k);
						
						if v.Max then
							if count <= v.Max then
								net.Start("select_class")
									net.WriteString("job")
									net.WriteInt(k, 32)
								net.SendToServer()
							end
						else
							net.Start("select_class")
								net.WriteString("job")
								net.WriteInt(k, 32)
							net.SendToServer()						
						end
					end
				end
			end
		end,
		UnFunc = function(parent)
			for k, v in pairs(parent:GetChildren()) do
				v:Remove()
			end
		end,
	},
	
	[2] = {
		Name = "화이트 리스트",
		Func = function(parent)
			for k, v in pairs(parent:GetChildren()) do
				v:Remove()
			end

			local function GetJOBCount(class)
				local count = 0;
				
				for k, v in pairs(player.GetAll()) do
					if v:GetJOB() == class then
						count = count + 1
					end
				end
				return count
			end
			
			
			
			for k, v in pairs(JOB) do
				if LocalPlayer():IsSuperAdmin() or (v.Leader && LocalPlayer():GetJOB() == v.Leader)  then
					if !v.Hide && v.WhiteList then
						local button = parent:Add("DButton")
							button:SetText("")
							button:SetSize(parent:GetWide()/2-2.5, 50)
							button:SetPos(0,0)
						function button:OnCursorEntered()
							self.cursor = true
						end
						function button:OnCursorExited()
							self.cursor = false
						end
						function button:Paint(w,h)
							if self.cursor then
								draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 135, 150))
							else
								draw.RoundedBox(0, 0, 0, w, h, Color(127, 255, 195, 150))
							end
							
							draw.SimpleText(v.Name, "Gothic_32_Bold", 10, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
						end
						function button:DoClick()
							local main = vgui.Create("DFrame")
								main:SetSize(700, 100)
								main:SetTitle("")
								main:SetDraggable(false)
								main:ShowCloseButton(false)
								main:MakePopup()
								main:Center()
							function main:Paint(w,h)	
								util.CreateGUIBlur(self, 3, 230)
								
								draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
								
								draw.SimpleText("RF FrameWork", "Gothic_24", 5, 5, Color(255, 255, 255, 255))
								draw.SimpleText("화리 지급", "Gothic_32_Bold", 5, 30, Color(255, 255, 255, 255))
							end
							
							surface.SetFont("Gothic_32_Bold")
							local tw, th = surface.GetTextSize("RF FrameWork")
							
							local scroll = vgui.Create("DScrollPanel", main) 
								scroll:SetSize(main:GetWide() - (64 + tw), 90)
								scroll:SetPos(34 + tw, 5)
							function scroll:Paint(w,h)
							
							end
							local bar = scroll:GetVBar()
							bar:SetWide(2)
							function bar:Paint(w,h)
								--draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							function bar.btnGrip:Paint(w,h)
								draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							function bar.btnUp:Paint(w,h)
								draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							function bar.btnDown:Paint(w,h)
								draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							
							local list = vgui.Create("DIconLayout", scroll)
								list:SetSize(scroll:GetWide(), scroll:GetTall())
								list:SetPos(0,0)
								list:SetSpaceX(5)
								list:SetSpaceY(5)
							function list:Paint(w,h)
							
							end
							
							for k2, v2 in pairs(player.GetAll()) do
								local button = list:Add("DButton")
									button:SetText("")
									button:SetSize(list:GetWide()/2-2.5, 42.5)
									button:SetPos(0,0)
								function button:OnCursorEntered()
									self.cursor = true
								end
								function button:OnCursorExited()
									self.cursor = false
								end
								function button:Paint(w,h)
									if self.cursor then
										draw.RoundedBox(0, 0, 0, w, h, Color(74, 71, 255, 150))
									else
										draw.RoundedBox(0, 0, 0, w, h, Color(66, 63, 255, 150))
									end
									
									draw.SimpleText(v2:Nick(), "Gothic_32_Bold", 10, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
								end
								function button:DoClick()
									net.Start("select_class")
										net.WriteString("whitelist")
										net.WriteInt(k, 32)
										net.WriteEntity(v2)
									net.SendToServer()
								end							
							end

							local close = vgui.Create("DButton", main)
								close:SetText("")
								close:SetSize(30, 30)
								close:SetPos(main:GetWide() - 30, 0)
							function close:OnCursorEntered()
								self.cursor = true
							end
							function close:OnCursorExited()
								self.cursor = false
							end
							function close:Paint(w,h)
								if !self.cursor then
									draw.RoundedBox(0, 0, 0, w, h, Color(255, 50, 50, 255))
								else
									draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 255))
								end
								
								draw.SimpleText("X", "Gothic_24", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
							function close:DoClick()
								main:Remove()
							end							
						end
					end
				else
					LocalPlayer():Notify("어드민 또는 리더가 아니면 접근이 불가능합니다.", 5)
					break
				end
			end
		end,
		UnFunc = function(parent)
			for k, v in pairs(parent:GetChildren()) do
				v:Remove()
			end
		end,
	},
	
	[3] = {
		Name = "계급",
		Func = function(parent)
			for k, v in pairs(parent:GetChildren()) do
				v:Remove()
			end
			
			if JOB[LocalPlayer():GetJOB()].Level && (JOB[LocalPlayer():GetJOB()] && (LocalPlayer():IsSuperAdmin() or LocalPlayer():GetLevel() == #JOB[LocalPlayer():GetJOB()].Level)) then
				for k, v in pairs(JOB[LocalPlayer():GetJOB()].Level) do
						local button = parent:Add("DButton")
							button:SetText("")
							button:SetSize(parent:GetWide()/2-2.5, 50)
							button:SetPos(0,0)
						function button:OnCursorEntered()
							self.cursor = true
						end
						function button:OnCursorExited()
							self.cursor = false
						end
						function button:Paint(w,h)
							if self.cursor then
								draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 135, 150))
							else
								draw.RoundedBox(0, 0, 0, w, h, Color(127, 255, 195, 150))
							end
							
							draw.SimpleText(v.Name, "Gothic_32_Bold", 10, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
						end
						function button:DoClick()
							local main = vgui.Create("DFrame")
								main:SetSize(700, 100)
								main:SetTitle("")
								main:SetDraggable(false)
								main:ShowCloseButton(false)
								main:MakePopup()
								main:Center()
							function main:Paint(w,h)	
								util.CreateGUIBlur(self, 3, 230)
								
								draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
								
								draw.SimpleText("RF FrameWork", "Gothic_24", 5, 5, Color(255, 255, 255, 255))
								draw.SimpleText("계급 지급", "Gothic_32_Bold", 5, 30, Color(255, 255, 255, 255))
							end
							
							surface.SetFont("Gothic_32_Bold")
							local tw, th = surface.GetTextSize("RF FrameWork")
							
							local scroll = vgui.Create("DScrollPanel", main) 
								scroll:SetSize(main:GetWide() - (64 + tw), 90)
								scroll:SetPos(34 + tw, 5)
							function scroll:Paint(w,h)
							
							end
							local bar = scroll:GetVBar()
							bar:SetWide(2)
							function bar:Paint(w,h)
								--draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							function bar.btnGrip:Paint(w,h)
								draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							function bar.btnUp:Paint(w,h)
								draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							function bar.btnDown:Paint(w,h)
								draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))
							end
							
							local list = vgui.Create("DIconLayout", scroll)
								list:SetSize(scroll:GetWide(), scroll:GetTall())
								list:SetPos(0,0)
								list:SetSpaceX(5)
								list:SetSpaceY(5)
							function list:Paint(w,h)
							
							end
							
							for k2, v2 in pairs(player.GetAll()) do
								local button = list:Add("DButton")
									button:SetText("")
									button:SetSize(list:GetWide()/2-2.5, 42.5)
									button:SetPos(0,0)
								function button:OnCursorEntered()
									self.cursor = true
								end
								function button:OnCursorExited()
									self.cursor = false
								end
								function button:Paint(w,h)
									if self.cursor then
										draw.RoundedBox(0, 0, 0, w, h, Color(74, 71, 255, 150))
									else
										draw.RoundedBox(0, 0, 0, w, h, Color(66, 63, 255, 150))
									end
									
									draw.SimpleText(v2:Nick(), "Gothic_32_Bold", 10, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
								end
								function button:DoClick()
									net.Start("select_level")
										net.WriteInt(k, 32)
										net.WriteEntity(v2)
									net.SendToServer()
								end							
							end

							local close = vgui.Create("DButton", main)
								close:SetText("")
								close:SetSize(30, 30)
								close:SetPos(main:GetWide() - 30, 0)
							function close:OnCursorEntered()
								self.cursor = true
							end
							function close:OnCursorExited()
								self.cursor = false
							end
							function close:Paint(w,h)
								if !self.cursor then
									draw.RoundedBox(0, 0, 0, w, h, Color(255, 50, 50, 255))
								else
									draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0, 255))
								end
								
								draw.SimpleText("X", "Gothic_24", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
							function close:DoClick()
								main:Remove()
							end							
						end
				end
			end
		end,
		UnFunc = function(parent)
			for k, v in pairs(parent:GetChildren()) do
				v:Remove()
			end
		end,
	},
}