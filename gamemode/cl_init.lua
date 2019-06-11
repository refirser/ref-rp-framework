function includeFolder(folder)
	local files = file.Find("rfframe/gamemode/" .. folder .. "/*.lua", "LUA")
	
	for k, v in pairs(files) do
		if CLIENT then
			print(v)
			if string.find(v, "cl_") or string.find(v, "sh_") then
				include(folder .. "/" .. v)
			end
		end
	end	
end

include("shared.lua")

includeFolder("modules/house")
includeFolder("modules/class")
includeFolder("modules/data")
includeFolder("modules/hud")
includeFolder("modules/message")
includeFolder("modules/money")
includeFolder("modules/license")
includeFolder("modules/command")
includeFolder("modules/shop")
includeFolder("modules/food")
--includeFolder("modules/stun")
includeFolder("modules/teleport")
includeFolder("modules/phone")
includeFolder("modules/chat")
includeFolder("modules/police")
includeFolder("modules/admin")
includeFolder("modules/scoreboard")
includeFolder("modules/tutorial")
includeFolder("modules/report")
includeFolder("modules/tex")
includeFolder("modules/level")
includeFolder("modules/character")
includeFolder("modules/screen")