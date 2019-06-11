AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function AddCSLuaFolder(folder)
	local files = file.Find(GM.Folder .. "/gamemode/" .. folder .. "/*.lua", "GAME")
	
	for k, v in pairs(files) do
		--if string.find(v, "sv_") or string.find(v, "sh_") then
			AddCSLuaFile(folder .. "/" .. v)
		--end
	end
end

function includeFolder(folder)
	local files = file.Find(GM.Folder .. "/gamemode/" .. folder .. "/*.lua", "GAME")
	for k, v in pairs(files) do
		if SERVER then
			if string.find(v, "sv_") or string.find(v, "sh_") then
				include(folder .. "/" .. v)
			end
		end
	end	
end

function resource.AddFolder(folder)
	local files = file.Find(GM.Folder .. "/contents/" .. folder .. "/*", "GAME")
	
	for k, v in pairs(files) do
		resource.AddFile(folder .. "/" .. v)
	end
end

resource.AddFile("resource/fonts/gothic.ttf")
resource.AddFile("resource/fonts/gothic_bold.ttf")

resource.AddFolder("materials/rfframe")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

AddCSLuaFolder("modules/command")
AddCSLuaFolder("modules/house")
AddCSLuaFolder("modules/data")
AddCSLuaFolder("modules/message")
AddCSLuaFolder("modules/class")
AddCSLuaFolder("modules/money")
AddCSLuaFolder("modules/hud")
AddCSLuaFolder("modules/license")
AddCSLuaFolder("modules/shop")
AddCSLuaFolder("modules/food")
--AddCSLuaFolder("modules/stun")
AddCSLuaFolder("modules/teleport")
AddCSLuaFolder("modules/phone")
AddCSLuaFolder("modules/chat")
AddCSLuaFolder("modules/police")
AddCSLuaFolder("modules/admin")
AddCSLuaFolder("modules/position")
AddCSLuaFolder("modules/bank")
AddCSLuaFolder("modules/player")
AddCSLuaFolder("modules/drug")
AddCSLuaFolder("modules/armory")
AddCSLuaFolder("modules/mechanic")
AddCSLuaFolder("modules/scoreboard")
AddCSLuaFolder("modules/tutorial")
AddCSLuaFolder("modules/report")
AddCSLuaFolder("modules/tex")
AddCSLuaFolder("modules/stamina")
AddCSLuaFolder("modules/level")
AddCSLuaFolder("modules/character")
AddCSLuaFolder("modules/screen")


includeFolder("modules/command")
includeFolder("modules/house")
includeFolder("modules/data")
includeFolder("modules/message")
includeFolder("modules/class")
includeFolder("modules/money")
includeFolder("modules/hud")
includeFolder("modules/license")
includeFolder("modules/shop")
includeFolder("modules/food")
--includeFolder("modules/stun")
includeFolder("modules/teleport")
includeFolder("modules/phone")
includeFolder("modules/chat")
includeFolder("modules/police")
includeFolder("modules/admin")
includeFolder("modules/position")
includeFolder("modules/bank")
includeFolder("modules/player")
includeFolder("modules/drug")
includeFolder("modules/armory")
includeFolder("modules/mechanic")
includeFolder("modules/tutorial")
includeFolder("modules/report")
includeFolder("modules/tex")
includeFolder("modules/stamina")
includeFolder("modules/level")
includeFolder("modules/character")
includeFolder("modules/move")