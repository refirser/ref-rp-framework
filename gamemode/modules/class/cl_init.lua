function OpenClass()
	local main = vgui.Create("DFrame")
		main:SetSize(700, 500)
		main:SetTitle("")
		main:SetDraggable(false)
		main:ShowCloseButton(false)
		main:MakePopup()
		main:Center()
	function main:Paint(w,h)	
		util.CreateGUIBlur(self, 3, 230)
		
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 230))
		
		draw.SimpleText("RF FrameWork", "Gothic_24", 5, 5, Color(255, 255, 255, 255))
		draw.SimpleText("반알피 메뉴", "Gothic_32_Bold", 5, 30, Color(255, 255, 255, 255))
		
		draw.RoundedBox(0, 0, 66, w, 2, Color(255, 255, 255, 255))
		draw.RoundedBox(0, 0, 98, w, 2, Color(255, 255, 255, 255))
	end
	
	local category = vgui.Create("DScrollPanel", main) 
		category:SetSize(main:GetWide(), 30)
		category:SetPos(0, 68)
	function category:Paint(w,h)
	
	end
	local bar = category:GetVBar()
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
	
	local categorylist = vgui.Create("DIconLayout", category)
		categorylist:SetSize(category:GetWide(), category:GetTall())
		categorylist:SetPos(0,0)
	function categorylist:Paint(w,h)
	
	end
	
	local items = vgui.Create("DScrollPanel", main) 
		items:SetSize(main:GetWide(), main:GetTall()-100)
		items:SetPos(0, 100)
	function items:Paint(w,h)
	
	end
	local bar = items:GetVBar()
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
	
	local itemlist = vgui.Create("DIconLayout", items)
		itemlist:SetSize(items:GetWide(), items:GetTall())
		itemlist:SetPos(0,0)
		itemlist:SetSpaceX(5)
		itemlist:SetSpaceY(5)
	function itemlist:Paint(w,h)
	
	end
	
	for k, v in pairs(JOBMENU) do
		surface.SetFont("Gothic_24_Bold")
		local tw, th = surface.GetTextSize(v.Name)
		local button = categorylist:Add("DButton")
			button:SetText("")
			button:SetPos(0,0)
			button:SetSize(tw+20,30)
		function button:OnCursorEntered()
			self.cursor = true
		end
		function button:OnCursorExited()
			self.cursor = false
		end
		function button:Paint(w,h)
			if self.clicked then
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 72, 255, 255))
				
				draw.RoundedBox(0, 0, h-3, w, 2, Color(255, 255, 255, 255))
			end
			draw.SimpleText(v.Name, "Gothic_24_Bold", w/2, h/2 - 1, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function button:DoClick()
			for k, v in pairs(categorylist:GetChildren()) do
				if v.clicked && v ~= self then
					v.clicked = false
				end
			end
			if !self.clicked then
				self.clicked = true
				v.Func(itemlist)
			else
				self.clicked = false
				v.UnFunc(itemlist)
			end
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