function AddCommand(cmd, func)
	COMMANDS = COMMANDS or {}
	
	COMMANDS[cmd] = func
end

function SayCommand(ply, text)

end
hook.Add("PlayerSay", "SayCommand", SayCommand)