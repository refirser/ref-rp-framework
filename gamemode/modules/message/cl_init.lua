local meta = FindMetaTable("Player")

local function ParseMessageDuration(str)
	local mapmess = string.lower(str)
	local seconds = {"seconds", "second", "secs", "sec", "s"}
	local minutes = {"minutes", "minute", "mins", "min", "m"}
	local parsed = nil

	for k,v in pairs(seconds) do
		if string.find(mapmess, '%d+%s' .. v) != nil then
			parsed = string.sub(mapmess, string.find(mapmess, '%d+%s*' .. v))
		end
	end

	if !parsed then
		for k,v in pairs(minutes) do
			if string.find(mapmess, '%d+%s' .. v) != nil then
				parsed = string.sub(mapmess, string.find(mapmess, '%d+%s*' .. v))
			end
		end
	end

	return parsed and string.sub(parsed, string.find(parsed, '%d+')) or 10 
end

function meta:Notify(msg, time)
	MSG = MSG or {}
	
	MSG[#MSG + 1] = {
		["msg"] = msg,
		["len"] = ParseMessageDuration(msg),
		["time"] = time,
		["timer"] = CurTime() + time,
	}	
end

net.Receive("messages", function()
	MSG = MSG or {}
	
	local msg = net.ReadString();
	local time = net.ReadInt(32);
	
	MSG[#MSG + 1] = {
		["msg"] = msg,
		["len"] = ParseMessageDuration(msg),
		["time"] = time,
		["timer"] = CurTime() + time,
	}
end)

function MSG_HUD()
	--print(FrameTime())
	if MSG then
		for i=1, #MSG do
			if i > 4 then
				table.remove(MSG, 1)
				break
			end
		
			local t = MSG[i]; 
			
			surface.SetFont("Gothic_24")
			local tw,th = surface.GetTextSize(t.msg)
			local timeleft = t.len - (SysTime() - t.time)
			
			draw.RoundedBox(0, ScrW()/2 - (tw + 10)/2, 5 + (i-1)*35, tw + 10, 30, Color(0, 0, 0, 200))
			
			draw.RoundedBox(0, ScrW()/2 - (tw+10)/2, 5 + (i-1)*35, math.Clamp((t.timer - CurTime())/t.time , 0, 1)*(tw+10), 30, Color(100, 100, 100, 200))
			
			draw.SimpleText(t.msg, "Gothic_24_Bold", ScrW()/2, 5 + ((i-1)*35) + 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			if t.timer <= CurTime() then
				table.remove(MSG, i)
				break
			end
		end
	end
end
hook.Add("HUDPaint", "MSG_Draw", MSG_HUD)