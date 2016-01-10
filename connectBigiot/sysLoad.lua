-----------------------------------------------------------------------------
-- TCP sample: Little program to send text lines to a given host/port
-- LuaSocket sample files
-- Author: Diego Nehab
-- RCS ID: $Id: talker.lua,v 1.9 2005/01/02 22:44:00 diego Exp $
-----------------------------------------------------------------------------
local socket = require("socket")
local json = require("json")
local util = require "luci.util"
host = host or "www.bigiot.net"
port = port or 8181
lastTime = 0
lastUpdateTime = 0
if arg then
	host = arg[1] or host
	port = arg[2] or port
end
print("Attempting connection to host '" ..host.. "' and port " ..port.. "...")
c = assert(socket.connect(host, port))
c:settimeout(0)
print("Connected! Please type stuff (empty line to stop):")
while true do
	if ((os.time() - lastTime) > 40) then
		print( os.time() )
		s = json.encode({M='checkin',ID='2',K='2353d24ce'})
		assert(c:send( s.."\n" ))
		lastTime=os.time()
	end
	if ((os.time() - lastUpdateTime) > 5) then
	    local sysinfo = luci.util.ubus("system", "info") or { }
	    local load = sysinfo.load or { 0, 0, 0 }
	    local v = {['1']=load[1],['2']=load[2]}
	    local update = json.encode({['M']='update', ['ID']='2', ['V']=v})
	    assert(c:send( update.."\n" ))
	    lastUpdateTime = os.time()
	end
	recvt, sendt, status = socket.select({c}, nil, 1)
	--#获取table长度，即元素数
	while #recvt > 0 do
		local response, receive_status = c:receive()
		if receive_status ~= "closed" then
			if response then
				print(response)
				r = json.decode(response)
				table.foreach(r, print)
				if r.client_list then
				    table.foreach(r.client_list, print)
				end
				recvt, sendt, status = socket.select({c}, nil, 1)
			end
		else
			break
		end
	end
end
