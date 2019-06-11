net.Receive("send_chat", function()
	local text = net.ReadString();
	local col = net.ReadColor();
	
	if LocalPlayer():GetNWBool("tutorial") then
		chat.AddText(col, text)
	end
end)