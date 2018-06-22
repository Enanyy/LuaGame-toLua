require("NetWorkManager")
require("common_pb")
require("person_pb")

-------------------------------------------Test Start-----------------------------------------

Test = {}

--测试static函数
function Test.TestStatic(self, go)

	self:Test1()
	print(go.name)
end


---测试 C# string[] 数组 array 是C#中传入的数组
function Test:Test1(array)

	print("array length =" .. array.Length)
	for i = 0, array.Length - 1 do
		print("array[".. i .."] =" .. array:GetValue(i))
	end
	
	

	print(self)
	
end
--测试创建GameObject
function Test:TestGameObject()

   

end


----测试C#导出栈类
function Test.TestStack()
    
    local stack = Stack.New()
    stack:Push(1)
    stack:Push(2)
    stack:Push(3)

    print("top:"..stack:Peek())

end

--测试继承和重写
A = Class("A")
function A:print()
	print("A:print")
end
function A:init(a)
	print("Class A a =" ..a)
end

B = Class("B",A)

function B:ctor()
	--self.base = A.new()
end

function B:init(b)

	self.base:init(b)
	print("Class B b =" ..b)

end

C = Class("C",B)
function C:ctor()

end

function C:init(c)

	self.base:init(c)
	print("Class C c =" ..c)

end

--[[
function B:print()
	print("B:print")

	self.base:print()
end
--]]
function Test:TestOverWrite()

	local a = A.new()
	a:print()

	--没有重写 调用A的print
	local b = B.new()
	b:init(111)

	local c = C.new()
	c:init(222)

end

--测试Socket,以 socket 的方式访问获取百度首页数据
function Test:TestSocketClient()

	local socket = require("socket")
 
	local host = "127.0.0.1"
	local port = 7000
	local sock = socket.connect(host, port)

	if sock then	
	
		sock:settimeout(0)
	  
		local input = "Hello LuaSocket!"
		local recvt, sendt, status
		while true do
	
			assert(sock:send(input .. "\n"))
		
		    print("aaaaaaa")
			recvt, sendt, status = socket.select({sock}, nil, 1)
			while #recvt > 0 do
				local response, receive_status = sock:receive()
				if receive_status ~= "closed" then
					if response then
						print(response)
						recvt, sendt, status = socket.select({sock}, nil, 1)
					end
				else
					break
				end
			end
		end
	else
		print("connect "..host ..":"..port.." fail.")
	end
end

function Test:TestSocketServer()

	local socket = require("socket")
 
	local host = "127.0.0.1"
	local port = "12345"
	local server = assert(socket.bind(host, port, 1024))
	server:settimeout(0)
	local client_tab = {}
	local conn_count = 0
 
	print("Server Start " .. host .. ":" .. port) 
 
	while true do
    	local conn = server:accept()
    	if conn then
        	conn_count = conn_count + 1
        	client_tab[conn_count] = conn
        	print("A client successfully connect!") 
    	end
  
    	for conn_count, client in pairs(client_tab) do
        	local recvt, sendt, status = socket.select({client}, nil, 1)
        	if #recvt > 0 then
            	local receive, receive_status = client:receive()
            	if receive_status ~= "closed" then
                	if receive then
                    	assert(client:send("Client " .. conn_count .. " Send : "))
                    	assert(client:send(receive .. "\n"))
                    	print("Receive Client " .. conn_count .. " : ", receive)   
                	end
            	else
                	table.remove(client_tab, conn_count) 
                	client:close() 
                	print("Client " .. conn_count .. " disconnect!") 
            	end
        	end
         
    	end
	end

end

function Test:TestSetPosition()

	local go = GameObject('TestSetPosition')

	local time = os.clock()

	for i = 1, 1000000 do
		SetPosition(go, Vector3.zero)
	end

	print(os.clock() - time)

end

function Test:TestSetPosition1()

	local go = GameObject('TestSetPosition1')

	local time = os.clock()

	for i = 1, 1000000 do
		go.transform.position = Vector3.zero
	end

	print(os.clock() - time)

end

function Test:TestSetPosition2()


	local index = TestLua.TestCreateGameObject(1000)
	local TestSetPosition = TestLua.TestSetPosition
	local time = os.clock()

	for i = 1, 1000000 do
		TestSetPosition(index, 0,0,0)
	end


	

	print(os.clock() - time)

end


function Test:TestAssetManager()
	local plane = "assets/r/Plane.prefab";
    AssetManager:Load(plane, plane, function (varGo)

        if varGo then
            
            self.go0 = AssetManager:Instantiate(plane, plane, varGo) 
			
		end
    end)


    local cube = "assets/r/Cube.prefab";
    AssetManager:Load(cube, cube, function (varGo)

        if varGo then
            
            self.go1 = AssetManager:Instantiate(cube, cube, varGo) 
			
		end
	end)
	
end

function Test:TestAssetManagerUpdate()
	if  Input.GetKeyDown (KeyCode.Keypad0) then 
		Destroy(self.go0)
	end
	if  Input.GetKeyDown (KeyCode.Keypad1) then 
		Destroy(self.go1)
	end

	if  Input.GetKeyDown (KeyCode.Keypad2) then 
		if self.mList  then
			for i,v in ipairs(self.mList) do
				Destroy(v)
			end
		end
	end

	if  Input.GetKeyDown (KeyCode.Keypad3) then 
		local plane = "assets/r/Plane.prefab";
    	AssetManager:Load(plane, plane, function (varGo)

        	if varGo then
            
				local go = AssetManager:Instantiate(plane, plane, varGo) 
				if self.mList == nil then
					self.mList =  {}
				end
				table.insert( self.mList, go )

			end
    	end)
	end
end


function Test:TestProtobuf()
	
	local person_pb = require "Protol.person_pb" 
	local msg = person_pb.Person()

	msg.id = 10
	msg.age = 30
	msg.name = "aaaaa"
	msg.email = "bbbbbb"

	msg.header.cmd = 11
	msg.header.seq = 1000

	msg.array:append(1)                              
	msg.array:append(2)   

	local pb_data = msg:SerializeToString()   


	--local msg = person_pb.Person()
	--msg:ParseFromString(pb_data)
	--tostring 不会打印默认值
	--print('person_pb decoder: '..tostring(msg)..'age: '..msg.age..'\nemail: '..msg.email)
	local buf = ByteBuffer.New()
	local length = string.len(pb_data)
	print(length)
	local str =""
	local bytes = {}
	for i = 1, length do
		local b = string.byte(pb_data,i)
		buf:Add(b)
		table.insert(bytes, b)
		str = str .. b .. " "
	end
	print(str)
	buf:Print()
	buf:Print(pb_data)
	
	LuaGame.TestProtobuf(buf)

	
end

function Test:TestParseProtobuf(buffer)

	local buf = buffer:GetBuffer()
	local bytes = {}
	for i = 0, buf.Length - 1 do
		table.insert(bytes, buf:GetValue(i))
	end
	local pb_data = string.char(unpack(bytes))
	local person_pb = require "Protol.person_pb" 
	local msg = person_pb.Person()
	msg:ParseFromString(pb_data)
	--tostring 不会打印默认值
	print('person_pb decoder: '..tostring(msg)..'age: '..msg.age..'\nemail: '..msg.email)
end

-------------------------------------------Test End-----------------------------------------
