require("Class")
Connection = Class("Connection")

function Connection:ctor(ip, port)
    self.ip = ip
    self.port = port
    self.isConnected = false
    self.onReceive = nil
end

function Connection:Connect()

    self.socket = require("socket")
    self.sock = self.socket.connect(self.ip, self.port)
    if self.sock then

        self.isConnected = true
        
        return true
    else
        self.isConnected = false
    
        return false
    end

end


function Connection:SetTimeout(time)

    if self.isConnected then
        self.sock:settimeout(time)
    end
end

function Connection:Send(data)

    if self.isConnected then

        self.sock:send(data)

    end
end

function Connection:Update()

    if self.isConnected == false then
        return
    end

    self.recvt, self.sendt, self.status = self.socket.select({self.sock}, nil, 0.00001)
  
    print(#self.recvt,self.status)
	if #self.recvt > 0 then
        local response, receive_status = self.sock:receive()
        print(response, receive_status)
		if receive_status ~= "closed" then
            if response then
                print(response)		
                if self.onReceive then
                    self.onReceive(response)
                end
                --self.recvt, self.sendt, self.status = self.socket.select({self.sock}, nil, 0)
            end
        else
            self.isConnected = false
           -- break
		end
	end
end