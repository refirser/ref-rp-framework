util.AddNetworkString("messages")

function Notify(ply, msg, time)
	net.Start("messages")
		net.WriteString(msg)
		net.WriteInt(time, 32)
	net.Send(ply)
end

function NotifyAll(msg, time)
	net.Start("messages")
		net.WriteString(msg)
		net.WriteInt(time, 32)
	net.Broadcast()
end