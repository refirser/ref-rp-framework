util.AddNetworkString("send_bank");

AddCommand("add_bank", function(ply, args)
	banktable = banktable or {}
	banktable[#banktable + 1] = tostring(ply:GetPos())
	local ent = ents.Create("obj_bank")
		ent:SetPos(ply:GetPos())
		ent:Spawn()
	save_bank()
end)

AddCommand("계좌", function(ply, args)
	if banktable then
		local bool = false;
		
		for k, v in pairs(banktable) do
			local pos = util.StringToType(v, "Vector")
			if pos:Distance(ply:GetPos()) <= 200 then
				bool = true;
				break
			end
		end
		
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
			if v:GetClass() == "obj_bank" then
				bool = true;
				break
			end
		end
		
		if bool then
			if #args > 0 then
				if args[1] == "확인" then
					send_chat(ply, "현재 남은 잔액 : " .. ply:GetAccountMoney(), Color(65, 255, 58, 255))
				elseif args[1] == "입금" then
					if args[2] && isnumber(tonumber(args[2])) then
						if ply:HasMoney(tonumber(args[2])) then
							ply:TakeMoney(tonumber(args[2]))
							ply:AddAccountMoney(tonumber(args[2]))
						end			
					end
				elseif args[1] == "출금" then
					if args[2] && isnumber(tonumber(args[2])) then
						if bankmoney >= tonumber(args[2]) then
							if ply:HasAccountMoney(tonumber(args[2])) then
								ply:TakeAccountMoney(tonumber(args[2]))
								ply:AddMoney(tonumber(args[2]))
								bankmoney = bankmoney - tonumber(args[2])
							end		
						end
					end		
				end
			end
		else
			send_chat(ply, "근처에 은행이 존재하지 않습니다.", Color(255, 0, 0, 255))
		end
	else
		send_chat(ply, "근처에 은행이 존재하지 않습니다.", Color(255, 0, 0, 255))
	end
end)


function save_bank()
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	if !file.IsDir("rf_data/" .. game.GetMap(), "DATA") then
		file.CreateDir("rf_data/" .. game.GetMap())
	end
	
	banktable = banktable or {}
	file.Write("rf_data/" .. game.GetMap() .. "/bank.txt", util.TableToKeyValues(banktable))
end

function load_bank()
	if !file.Exists("rf_data/" .. game.GetMap() .. "/bank.txt", "DATA") then
		save_bank()
	else
		local data = util.KeyValuesToTable(file.Read("rf_data/" .. game.GetMap() .. "/bank.txt", "DATA"))
		
		for k, v in pairs(data) do
			v = util.StringToType(v, "Vector")
			
			local ent = ents.Create("obj_bank")
				ent:SetPos(v)
				ent:Spawn()			
		end
		
		banktable = data
	end
end
hook.Add("InitPostEntity", "load_bank", load_bank)

function save_account()
	if !file.IsDir("rf_data", "DATA") then
		file.CreateDir("rf_data")
	end
	
	file.Write("rf_data/account.txt", bankmoney or 0)
end

function load_account()
	if !file.Exists("rf_data/account.txt", "DATA") then
		save_account()
	else
		bankmoney = tonumber(file.Read("rf_data/account.txt", "DATA"))
	end
end
hook.Add("InitPostEntity", "load_account", load_account)

function load_bank_ply(ply)
	ply:LoadBank()
end
hook.Add("PlayerInitialSpawn", "load_bank_ply", load_bank_ply)