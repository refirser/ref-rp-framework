char_menu = char_menu or {}

function open_char_menu()
	local alpha = 0
	local click;
	
	if !char_menu.menu or !char_menu.menu:IsValid() then
		char_menu.menu = vgui.Create("DFrame")
			char_menu.menu:SetSize(ScrW(), ScrH())
			char_menu.menu:SetTitle("")
			char_menu.menu:SetDraggable(false)
			char_menu.menu:ShowCloseButton(false)
			char_menu.menu:MakePopup()
			char_menu.menu:Center()
			char_menu.menu:SetMouseInputEnabled( true )
		function char_menu.menu:Paint(w,h)	
			alpha = math.Clamp(alpha + SysTime(), 0, 255)
		
			util.CreateGUIBlur(self, 3, 230)
			
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
			
			draw.SimpleText("RF FrameWork", "Gothic_32", w/2, 100, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER)			
		end
		function char_menu.menu:OnMousePressed(key)
			if key == MOUSE_LEFT then
				self:Remove()
			end
		end
		function char_menu.menu:Think()	
			if self:GetPos() >= ScrW() then
				click:RemoveFunc()
				self:Remove()
			end
		end
		
		local create = vgui.Create("DButton", char_menu.menu)
			create:SetText("")
			create:SetPos(200, 250)
			create:SetSize(150, 40)
		function create:OnCursorEntered()
			self.cursor = true
		end
		function create:OnCursorExited()
			self.cursor = false
		end
		function create:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("생성", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("생성", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function create:DoClick()
			char_menu.menu:LerpPositions(8)
			char_menu.menu:SetPos(ScrW(), char_menu.menu:GetPos())
			
			click = self
		end
		function create:RemoveFunc()
			if !LocalPlayer():GetNWBool("char") then
				init_char()
			else
				LocalPlayer():Notify("캐릭터가 이미 존재합니다.", 5)
			end
		end
		
		local edit = vgui.Create("DButton", char_menu.menu)
			edit:SetText("")
			edit:SetPos(200, 310)
			edit:SetSize(150, 40)
		function edit:OnCursorEntered()
			self.cursor = true
		end
		function edit:OnCursorExited()
			self.cursor = false
		end
		function edit:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("수정", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("수정", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function edit:DoClick()
			char_menu.menu:LerpPositions(8)
			char_menu.menu:SetPos(ScrW(), char_menu.menu:GetPos())
			
			click = self
		end
		function edit:RemoveFunc()
			if LocalPlayer():GetNWBool("char") then
				open_char()
			else
				LocalPlayer():Notify("캐릭터가 존재하지 않습니다.", 5)
			end
		end

		local remove = vgui.Create("DButton", char_menu.menu)
			remove:SetText("")
			remove:SetPos(200, 370)
			remove:SetSize(150, 40)
		function remove:OnCursorEntered()
			self.cursor = true
		end
		function remove:OnCursorExited()
			self.cursor = false
		end
		function remove:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("제거", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("제거", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function remove:DoClick()
			click = self
		
			char_menu.menu:LerpPositions(8)
			char_menu.menu:SetPos(ScrW(), char_menu.menu:GetPos())
		end
		function remove:RemoveFunc()
			local main = vgui.Create("DFrame")
				main:SetTitle("")
				main:SetSize(500, 110)
				main:Center()
				main:MakePopup()
				main:SetDraggable(false)
				main:ShowCloseButton(false)
			function main:Paint(w,h)
				util.CreateGUIBlur(self, 3, 230)
				
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
				
				draw.SimpleText("캐릭터 제거", "Gothic_32_Bold", w/2, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
				
				draw.SimpleText("정말로 캐릭터를 제거하시겠습니까?", "Gothic_24", w/2, 42, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			end
			
			local accept = vgui.Create("DButton", main)
				accept:SetText("")
				accept:SetPos(main:GetWide()/2 - 105, 71)
				accept:SetSize(100, 30)
			function accept:OnCursorEntered()
				self.cursor = true
			end
			function accept:OnCursorExited()
				self.cursor = false
			end
			function accept:Paint(w,h)
				if self.cursor then
					draw.SimpleText("예", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("예", "Gothic_24_Bold", w/2, h/2, Color(180, 180, 180, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			function accept:DoClick()
				LocalPlayer():Notify("캐릭터를 성공적으로 제거하였습니다.", 5)
				main:Remove()
				
				net.Start("character_remove")
				net.SendToServer()
			end
			
			local denine = vgui.Create("DButton", main)
				denine:SetText("")
				denine:SetPos(main:GetWide()/2 - 5, 71)
				denine:SetSize(100, 30)
			function denine:OnCursorEntered()
				self.cursor = true
			end
			function denine:OnCursorExited()
				self.cursor = false
			end
			function denine:Paint(w,h)
				if self.cursor then
					draw.SimpleText("아니요", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("아니요", "Gothic_24_Bold", w/2, h/2, Color(180, 180, 180, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			function denine:DoClick()
				main:Remove()
			end
		end
		
		local cancle = vgui.Create("DButton", char_menu.menu)
			cancle:SetText("")
			cancle:SetPos(200, 430)
			cancle:SetSize(150, 40)
		function cancle:OnCursorEntered()
			self.cursor = true
		end
		function cancle:OnCursorExited()
			self.cursor = false
		end
		function cancle:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("취소", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("취소", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function cancle:DoClick()
			char_menu.menu:LerpPositions(8)
			char_menu.menu:SetPos(ScrW(), char_menu.menu:GetPos())
			
			if !LocalPlayer():GetNWBool("char") then
				LocalPlayer():ConCommand("disconnect")
			end
		end
	end
end


function init_char()
	local point = LocalPlayer():GetNWInt("stat_point");
	local count = 0;
	
	if !char_menu.main or !char_menu.main:IsValid() then
		char_menu.main = vgui.Create("DFrame")
			char_menu.main:SetSize(ScrW(), ScrH())
			char_menu.main:SetTitle("")
			char_menu.main:SetDraggable(false)
			char_menu.main:ShowCloseButton(false)
			char_menu.main:MakePopup()
			char_menu.main:Center()
			char_menu.main:SetMouseInputEnabled( true )
		function char_menu.main:Paint(w,h)	
			util.CreateGUIBlur(self, 3, 230)
			
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
			
			draw.SimpleText("RF FrameWork", "Gothic_18_R_Bold", 15, 5, Color(255, 255, 255, 255))
			
			draw.SimpleText("캐릭터 생성", "Gothic_32_Bold", w/2, 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			
			surface.SetFont("Gothic_32_Bold")
			local tw, th = surface.GetTextSize("캐릭터 생성")
			
			draw.SimpleText("소모 가능한 포인트 : " .. point, "Gothic_24_Bold", w/2 - (tw + 30), 95, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
			
		end
		
		local scroll = vgui.Create("DScrollPanel", char_menu.main)
			scroll:SetSize(380, ScrH()/2)
			scroll:SetPos(200, 124)
		function scroll:Paint(w,h)
		end
		
		local sbar = scroll:GetVBar()
		sbar:SetWide(2)
		function sbar:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		function sbar.btnUp:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		function sbar.btnDown:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		function sbar.btnGrip:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		
		local list = vgui.Create("DIconLayout", scroll)
			list:SetSize(scroll:GetWide(), scroll:GetTall())
			list:SetPos(0,0)
			list:SetSpaceY(5)
		function list:Paint(w,h)
		
		end
		
		local select;
		
		for k, v in pairs(CHAR_STAT) do
			count = count + 1
			local background = list:Add("DPanel")
				background:SetPos(0,0)
				background:SetSize(list:GetWide(), 40)
			function background:Paint(w,h)
				draw.RoundedBox(0,0,h-2,w,2,Color(70, 70, 70, 255))
				
				draw.SimpleText(LocalPlayer():GetStat(k), "Gothic_20", w - 55, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			local label = vgui.Create("DLabel", background)
				label:SetPos(0,0)
				label:SetSize(background:GetWide()-150, 40)
				label:SetText("")
				label:SetMouseInputEnabled(true)
				function label:Paint(w,h)
					if select == k then
						draw.SimpleText(v.Name, "Gothic_20_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else	
						draw.SimpleText(v.Name, "Gothic_20_Bold", w/2, h/2, Color(180, 180, 180, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
				function label:DoClick()
					select = k;
				end
				
			local up = vgui.Create("DButton", background)
				up:SetSize(40, 38)
				up:SetPos(background:GetWide() - 40, 0)
				up:SetText("")
			function up:Paint(w,h)
				draw.SimpleText("+", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			function up:DoClick()
				if point > 0 then
					point = point - 1
					
					net.Start("stat")
						net.WriteBool(true)
						net.WriteString(k)
					net.SendToServer()
				end
			end

			local down = vgui.Create("DButton", background)
				down:SetSize(40, 38)
				down:SetPos(background:GetWide() - 110, 0)
				down:SetText("")
			function down:Paint(w,h)
				draw.SimpleText("-", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			function down:DoClick()
				if LocalPlayer():GetStat(k) > 0 then
					point = point + 1
					net.Start("stat")
						net.WriteBool(false)
						net.WriteString(k)
					net.SendToServer()	
				end
			end			
		end
		
		local x, y = scroll:GetPos();
		local desc = vgui.Create("DLabel", char_menu.main)
			desc:SetText("")
			desc:SetPos(200, y + count*40 + 20)
			desc:SetSize(scroll:GetWide(), 30)
		function desc:Paint(w,h)
			if CHAR_STAT[select] then
				draw.SimpleText(CHAR_STAT[select].Desc, "Gothic_20", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
		
		local page = 1;
		
		local model = vgui.Create("DModelPanel", char_menu.main)
			model:SetModel(JOB[LocalPlayer():GetJOB()].Model[1])
			model:SetSize(200,ScrH()-200)
			model:SetPos(scroll:GetPos() + scroll:GetWide() + 170, 100) 
		function model:LayoutEntity( Entity ) return end	-- Disable cam rotatio
		
		model:SetLookAt( model.Entity:GetPos() + Vector(0,0,30) )

		model:SetCamPos( model.Entity:GetPos()-Vector( -70, -40, -30   ) ) 
		 
		model:SetFOV(25) 
 
		local prev = vgui.Create("DButton", char_menu.main)
			prev:SetText("")
			prev:SetSize(30, 30)
			prev:SetPos(model:GetPos() + 50, char_menu.main:GetTall() - 150)
		function prev:Paint(w,h)
			draw.SimpleText("<", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function prev:DoClick()
			if page > #JOB[LocalPlayer():GetJOB()].Model then
				page = page - 1
			else
				page = #JOB[LocalPlayer():GetJOB()].Model
			end
			model:SetModel(JOB[LocalPlayer():GetJOB()].Model[page])
		end
		
		local next = vgui.Create("DButton", char_menu.main)
			next:SetText("")
			next:SetSize(30, 30)
			next:SetPos(prev:GetPos() + 80, char_menu.main:GetTall() - 150)
		function next:Paint(w,h)
			draw.SimpleText(">", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function next:DoClick()
			if page < #JOB[LocalPlayer():GetJOB()].Model then
				page = page + 1
			else
				page = 1
			end
			model:SetModel(JOB[LocalPlayer():GetJOB()].Model[page])		
		end		
		
		local mdlindex = vgui.Create("DLabel", char_menu.main)
			mdlindex:SetText("")
			mdlindex:SetSize(30, 30)
			mdlindex:SetPos(prev:GetPos() + (next:GetPos() - prev:GetPos())/2, char_menu.main:GetTall() - 150)
		function mdlindex:Paint(w,h)
			draw.SimpleText(page, "Gothic_24", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		local name_label = vgui.Create("DLabel", char_menu.main)
			name_label:SetText("")
			name_label:SetPos(char_menu.main:GetWide() - 300, 150)
			name_label:SetSize(40, 30)
		function name_label:Paint(w,h)
			draw.SimpleText("이름", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		  
		local change = vgui.Create("DLabel", char_menu.main)
			change:SetText("")
			change:SetPos(name_label:GetPos() + 45, 150)
			change:SetSize(200, 30)
		function change:Paint(w,h)
			draw.SimpleText("[클릭하여 변경]", "Gothic_24", 0, h/2, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end
		function change:DoClick()
		
		end
		
		local name_enter = vgui.Create("DTextEntry", char_menu.main)
			name_enter:SetText("Jonson Kim")
			name_enter:SetFont("Gothic_24_Bold")
			name_enter:SetSize(290, 30)
			name_enter:SetPos(name_label:GetPos(), 185)
			name_enter:SetTextColor(Color(255, 255, 255, 255))
		function name_enter:Paint(w,h)
			--draw.SimpleText("dd", "Gothic_24_Bold", 0, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), Color(255, 255, 255, 255))
			--draw.SimpleText(name_enter:GetValue(), "Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end
		
		local desc_label = vgui.Create("DLabel", char_menu.main)
			desc_label:SetText("")
			desc_label:SetPos(char_menu.main:GetWide() - 300, 250)
			desc_label:SetSize(40, 30)
		function desc_label:Paint(w,h)
			draw.SimpleText("설명", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		  
		local change = vgui.Create("DLabel", char_menu.main)
			change:SetText("")
			change:SetPos(desc_label:GetPos() + 45, 250)
			change:SetSize(200, 30)
		function change:Paint(w,h)
			draw.SimpleText("[클릭하여 변경]", "Gothic_24", 0, h/2, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end
		function change:DoClick()
		
		end
		
		local desc_enter = vgui.Create("DTextEntry", char_menu.main)
			desc_enter:SetText("설명을 적어주세요.")
			desc_enter:SetFont("Gothic_24_Bold")
			desc_enter:SetSize(290, 30)
			desc_enter:SetPos(name_label:GetPos(), 285)
			desc_enter:SetTextColor(Color(255, 255, 255, 255))
		function desc_enter:Paint(w,h)
			--draw.SimpleText("dd", "Gothic_24_Bold", 0, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), Color(255, 255, 255, 255))
			--draw.SimpleText(name_enter:GetValue(), "	Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end		
		
		local rank_label = vgui.Create("DLabel", char_menu.main)
			rank_label:SetText("")
			rank_label:SetPos(char_menu.main:GetWide() - 300, 345)
			rank_label:SetSize(40, 30)
		function rank_label:Paint(w,h)
			draw.SimpleText("계급", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		local rank = vgui.Create("DLabel", char_menu.main)
			rank:SetText("")
			rank:SetPos(char_menu.main:GetWide() - 300, 380)
			rank:SetSize(290, 30)
		function rank:Paint(w,h)
			if JOB[LocalPlayer():GetJOB()] && JOB[LocalPlayer():GetJOB()].Level then
				if JOB[LocalPlayer():GetJOB()].Level[LocalPlayer():GetLevel()] then
					draw.SimpleText(JOB[LocalPlayer():GetJOB()].Level[LocalPlayer():GetLevel()].Name, "Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("계급 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			else
				draw.SimpleText("계급 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end	

		local job_label = vgui.Create("DLabel", char_menu.main)
			job_label:SetText("")
			job_label:SetPos(char_menu.main:GetWide() - 300, 445)
			job_label:SetSize(40, 30)
		function job_label:Paint(w,h)
			draw.SimpleText("직업", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		local job = vgui.Create("DLabel", char_menu.main)
			job:SetText("")
			job:SetPos(char_menu.main:GetWide() - 300, 480)
			job:SetSize(290, 30)
		function job:Paint(w,h)
			if JOB[LocalPlayer():GetJOB()] then
				if JOB[LocalPlayer():GetJOB()].Name then
					draw.SimpleText(JOB[LocalPlayer():GetJOB()].Name, "Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("직업 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			else
				draw.SimpleText("직업 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end				
		
		local cancle = vgui.Create("DButton", char_menu.main)
			cancle:SetText("")
			cancle:SetPos(200, char_menu.main:GetTall() - 150)
			cancle:SetSize(150, 40)
		function cancle:OnCursorEntered()
			self.cursor = true
		end
		function cancle:OnCursorExited()
			self.cursor = false
		end
		function cancle:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("취소", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("취소", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function cancle:DoClick()
			char_menu.main:Remove()
		
			net.Start("character")
				net.WriteBool(false)
				net.WriteString(name_enter:GetValue())
				net.WriteString(desc_enter:GetValue())
				net.WriteString(model:GetModel())
			net.SendToServer()		
		end
		
		local confirm = vgui.Create("DButton", char_menu.main)
			confirm:SetText("")
			confirm:SetPos(430, char_menu.main:GetTall() - 150)
			confirm:SetSize(150, 40)
		function confirm:OnCursorEntered()
			self.cursor = true
		end
		function confirm:OnCursorExited()
			self.cursor = false
		end
		function confirm:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("생성", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("생성", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function confirm:DoClick()
			char_menu.main:Remove()
		
			net.Start("character")
				net.WriteBool(true)
				net.WriteString(name_enter:GetValue())
				net.WriteString(desc_enter:GetValue())
				net.WriteString(model:GetModel())
			net.SendToServer()
		end
	end
end

function open_char()
	local point = LocalPlayer():GetNWInt("stat_point");
	local count = 0;
	
	if !char_menu.main or !char_menu.main:IsValid() then
		char_menu.main = vgui.Create("DFrame")
			char_menu.main:SetSize(ScrW(), ScrH())
			char_menu.main:SetTitle("")
			char_menu.main:SetDraggable(false)
			char_menu.main:ShowCloseButton(false)
			char_menu.main:MakePopup()
			char_menu.main:Center()
			char_menu.main:SetMouseInputEnabled( true )
		function char_menu.main:Paint(w,h)	
			util.CreateGUIBlur(self, 3, 230)
			
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
			
			draw.SimpleText("RF FrameWork", "Gothic_18_R_Bold", 15, 5, Color(255, 255, 255, 255))
			
			draw.SimpleText("캐릭터 커스텀", "Gothic_32_Bold", w/2, 50, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
			
			surface.SetFont("Gothic_32_Bold")
			local tw, th = surface.GetTextSize("캐릭터 커스텀")
			
			draw.SimpleText("소모 가능한 포인트 : " .. point, "Gothic_24_Bold", w/2 - (tw + 30), 95, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
			
		end 
		
		local scroll = vgui.Create("DScrollPanel", char_menu.main)
			scroll:SetSize(380, ScrH()/2)
			scroll:SetPos(200, 124)
		function scroll:Paint(w,h)
		end
		
		local sbar = scroll:GetVBar()
		sbar:SetWide(2)
		function sbar:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		function sbar.btnUp:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		function sbar.btnDown:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		function sbar.btnGrip:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255, 255, 255, 255))
		end
		
		local list = vgui.Create("DIconLayout", scroll)
			list:SetSize(scroll:GetWide(), scroll:GetTall())
			list:SetPos(0,0)
			list:SetSpaceY(5)
		function list:Paint(w,h)
		
		end
		
		local select;
		
		for k, v in pairs(CHAR_STAT) do
			count = count + 1
			local background = list:Add("DPanel")
				background:SetPos(0,0)
				background:SetSize(list:GetWide(), 40)
			function background:Paint(w,h)
				draw.RoundedBox(0,0,h-2,w,2,Color(70, 70, 70, 255))
				
				draw.SimpleText(LocalPlayer():GetStat(k), "Gothic_20", w - 55, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			local label = vgui.Create("DLabel", background)
				label:SetPos(0,0)
				label:SetSize(background:GetWide()-150, 40)
				label:SetText("")
				label:SetMouseInputEnabled(true)
				function label:Paint(w,h)
					if select == k then
						draw.SimpleText(v.Name, "Gothic_20_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else	
						draw.SimpleText(v.Name, "Gothic_20_Bold", w/2, h/2, Color(180, 180, 180, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
				function label:DoClick()
					select = k;
				end
				
			local up = vgui.Create("DButton", background)
				up:SetSize(40, 38)
				up:SetPos(background:GetWide() - 40, 0)
				up:SetText("")
			function up:Paint(w,h)
				draw.SimpleText("+", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			function up:DoClick()
				if point > 0 then
					point = point - 1
					
					net.Start("stat")
						net.WriteBool(true)
						net.WriteString(k)
					net.SendToServer()
				end
			end

			local down = vgui.Create("DButton", background)
				down:SetSize(40, 38)
				down:SetPos(background:GetWide() - 110, 0)
				down:SetText("")
			function down:Paint(w,h)
				draw.SimpleText("-", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			function down:DoClick()
				if LocalPlayer():GetStat(k) > 0 then
					point = point + 1
					net.Start("stat")
						net.WriteBool(false)
						net.WriteString(k)
					net.SendToServer()	
				end
			end			
		end
		
		local x, y = scroll:GetPos();
		local desc = vgui.Create("DLabel", char_menu.main)
			desc:SetText("")
			desc:SetPos(200, y + count*40 + 20)
			desc:SetSize(scroll:GetWide(), 30)
		function desc:Paint(w,h)
			if CHAR_STAT[select] then
				draw.SimpleText(CHAR_STAT[select].Desc, "Gothic_20", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
		
		local page = 1;
		
		local model = vgui.Create("DModelPanel", char_menu.main)
			model:SetModel(JOB[LocalPlayer():GetJOB()].Model[1])
			model:SetSize(200,ScrH()-200)
			model:SetPos(scroll:GetPos() + scroll:GetWide() + 170, 100) 
		function model:LayoutEntity( Entity ) return end	-- Disable cam rotatio
		
		model:SetLookAt( model.Entity:GetPos() + Vector(0,0,30) )

		model:SetCamPos( model.Entity:GetPos()-Vector( -70, -40, -30   ) ) 
		 
		model:SetFOV(25) 
 
		local prev = vgui.Create("DButton", char_menu.main)
			prev:SetText("")
			prev:SetSize(30, 30)
			prev:SetPos(model:GetPos() + 50, char_menu.main:GetTall() - 150)
		function prev:Paint(w,h)
			draw.SimpleText("<", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function prev:DoClick()
			if page > #JOB[LocalPlayer():GetJOB()].Model then
				page = page - 1
			else
				page = #JOB[LocalPlayer():GetJOB()].Model
			end
			model:SetModel(JOB[LocalPlayer():GetJOB()].Model[page])
		end
		
		local next = vgui.Create("DButton", char_menu.main)
			next:SetText("")
			next:SetSize(30, 30)
			next:SetPos(prev:GetPos() + 80, char_menu.main:GetTall() - 150)
		function next:Paint(w,h)
			draw.SimpleText(">", "Gothic_24_Bold", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function next:DoClick()
			if page < #JOB[LocalPlayer():GetJOB()].Model then
				page = page + 1
			else
				page = 1
			end
			model:SetModel(JOB[LocalPlayer():GetJOB()].Model[page])		
		end		
		
		local mdlindex = vgui.Create("DLabel", char_menu.main)
			mdlindex:SetText("")
			mdlindex:SetSize(30, 30)
			mdlindex:SetPos(prev:GetPos() + (next:GetPos() - prev:GetPos())/2, char_menu.main:GetTall() - 150)
		function mdlindex:Paint(w,h)
			draw.SimpleText(page, "Gothic_24", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		local name_label = vgui.Create("DLabel", char_menu.main)
			name_label:SetText("")
			name_label:SetPos(char_menu.main:GetWide() - 300, 150)
			name_label:SetSize(40, 30)
		function name_label:Paint(w,h)
			draw.SimpleText("이름", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		  
		local change = vgui.Create("DLabel", char_menu.main)
			change:SetText("")
			change:SetPos(name_label:GetPos() + 45, 150)
			change:SetSize(200, 30)
		function change:Paint(w,h)
			draw.SimpleText("[클릭하여 변경]", "Gothic_24", 0, h/2, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end
		function change:DoClick()
		
		end
		
		local name_enter = vgui.Create("DTextEntry", char_menu.main)
			name_enter:SetText(LocalPlayer():GetNWString("name"))
			name_enter:SetFont("Gothic_24_Bold")
			name_enter:SetSize(290, 30)
			name_enter:SetPos(name_label:GetPos(), 185)
			name_enter:SetTextColor(Color(255, 255, 255, 255))
		function name_enter:Paint(w,h)
			--draw.SimpleText("dd", "Gothic_24_Bold", 0, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), Color(255, 255, 255, 255))
			--draw.SimpleText(name_enter:GetValue(), "Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end
		
		local desc_label = vgui.Create("DLabel", char_menu.main)
			desc_label:SetText("")
			desc_label:SetPos(char_menu.main:GetWide() - 300, 250)
			desc_label:SetSize(40, 30)
		function desc_label:Paint(w,h)
			draw.SimpleText("설명", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		  
		local change = vgui.Create("DLabel", char_menu.main)
			change:SetText("")
			change:SetPos(desc_label:GetPos() + 45, 250)
			change:SetSize(200, 30)
		function change:Paint(w,h)
			draw.SimpleText("[클릭하여 변경]", "Gothic_24", 0, h/2, Color(150, 150, 150, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end
		function change:DoClick()
		
		end
		
		local desc_enter = vgui.Create("DTextEntry", char_menu.main)
			desc_enter:SetText(LocalPlayer():GetNWString("desc"))
			desc_enter:SetFont("Gothic_24_Bold")
			desc_enter:SetSize(290, 30)
			desc_enter:SetPos(name_label:GetPos(), 285)
			desc_enter:SetTextColor(Color(255, 255, 255, 255))
		function desc_enter:Paint(w,h)
			--draw.SimpleText("dd", "Gothic_24_Bold", 0, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			self:DrawTextEntryText(self:GetTextColor(), self:GetHighlightColor(), Color(255, 255, 255, 255))
			--draw.SimpleText(name_enter:GetValue(), "	Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
		end		
		function desc_enter:OnChange()
			surface.SetFont("Gothic_50")
			local tw, th = surface.GetTextSize(self:GetValue())
			
			print(tw)
			if tw >= 800 then
				self:SetValue("설명의 길이가 너무 깁니다.")
			end
		end
		
		local rank_label = vgui.Create("DLabel", char_menu.main)
			rank_label:SetText("")
			rank_label:SetPos(char_menu.main:GetWide() - 300, 345)
			rank_label:SetSize(40, 30)
		function rank_label:Paint(w,h)
			draw.SimpleText("계급", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		local rank = vgui.Create("DLabel", char_menu.main)
			rank:SetText("")
			rank:SetPos(char_menu.main:GetWide() - 300, 380)
			rank:SetSize(290, 30)
		function rank:Paint(w,h)
			if JOB[LocalPlayer():GetJOB()] && JOB[LocalPlayer():GetJOB()].Level then
				if JOB[LocalPlayer():GetJOB()].Level[LocalPlayer():GetLevel()] then
					draw.SimpleText(JOB[LocalPlayer():GetJOB()].Level[LocalPlayer():GetLevel()].Name, "Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("계급 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			else
				draw.SimpleText("계급 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end	

		local job_label = vgui.Create("DLabel", char_menu.main)
			job_label:SetText("")
			job_label:SetPos(char_menu.main:GetWide() - 300, 445)
			job_label:SetSize(40, 30)
		function job_label:Paint(w,h)
			draw.SimpleText("직업", "Gothic_24", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		local job = vgui.Create("DLabel", char_menu.main)
			job:SetText("")
			job:SetPos(char_menu.main:GetWide() - 300, 480)
			job:SetSize(290, 30)
		function job:Paint(w,h)
			if JOB[LocalPlayer():GetJOB()] then
				if JOB[LocalPlayer():GetJOB()].Name then
					draw.SimpleText(JOB[LocalPlayer():GetJOB()].Name, "Gothic_24_Bold", 5, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("직업 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			else
				draw.SimpleText("직업 불명", "Gothic_24_Bold", 5, h/2, Color(130, 130, 130, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end				
		
		local cancle = vgui.Create("DButton", char_menu.main)
			cancle:SetText("")
			cancle:SetPos(200, char_menu.main:GetTall() - 150)
			cancle:SetSize(150, 40)
		function cancle:OnCursorEntered()
			self.cursor = true
		end
		function cancle:OnCursorExited()
			self.cursor = false
		end
		function cancle:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("취소", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("취소", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function cancle:DoClick()
			char_menu.main:Remove()
		
			net.Start("character")
				net.WriteBool(false)
				net.WriteString(name_enter:GetValue())
				net.WriteString(desc_enter:GetValue())
				net.WriteString(model:GetModel())
			net.SendToServer()		
		end
		
		local confirm = vgui.Create("DButton", char_menu.main)
			confirm:SetText("")
			confirm:SetPos(430, char_menu.main:GetTall() - 150)
			confirm:SetSize(150, 40)
		function confirm:OnCursorEntered()
			self.cursor = true
		end
		function confirm:OnCursorExited()
			self.cursor = false
		end
		function confirm:Paint(w,h)
			if !self.cursor then
				draw.SimpleText("적용", "Gothic_32", w/2, h/2, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText("적용", "Gothic_32", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		function confirm:DoClick()	
			char_menu.main:Remove()
		
			net.Start("character")
				net.WriteBool(true)
				net.WriteString(name_enter:GetValue())
				net.WriteString(desc_enter:GetValue())
				net.WriteString(model:GetModel())
			net.SendToServer()
		end
	end
end
--open_char()