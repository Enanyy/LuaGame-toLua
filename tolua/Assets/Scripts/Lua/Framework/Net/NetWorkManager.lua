require("Connection")

NetWorkManager = Class("NetWorkManager").new()

function NetWorkManager:ctor()
    
    self.connections = {}

end

function NetWorkManager:Update()

    for k,v in pairs(self.connections) do
       v:Update()
    end

end

function NetWorkManager:OnReceive(data)

    print(data)


end

function NetWorkManager:Send(id, data)

    if self.connections[id] then

        self.connections[id]:Send(data)

    end

end

function NetWorkManager:CreateConnection(id, ip, port)

    local  con = Connection.new(ip, port)
    local ret = con:Connect()

    if ret then
        con.onReceive = function(data) self:OnReceive(data) end
        
        con:SetTimeout(0)
        if self.connections == nil then
            self.connections = {}
        end
        self.connections[id] = con

    end
    return ret
end