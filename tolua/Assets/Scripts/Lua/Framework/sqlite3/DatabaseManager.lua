require("sqlite3")

DatabaseManager = {}

function DatabaseManager:Initialize()
     --确保只被初始化一次
     if  self.initialized  == nil or self.initialized == false then
        print(sqlite3.version())
        
        local path ="Assets/R/database/game.db"
        --也可以用sqlite3.open_memory(),参数是数据流
        self.db = sqlite3.open(path)

        if self.db:isopen() ==false then
            error("open db fail:",path)
        else
            print("open db success:",path)
        end
     end
end

function DatabaseManager:Close()

    self.initialized = false
    self.db:close()

end

--
--查询一个tablename的表，回调所有行
--
function DatabaseManager:Execute(tablename, callback)

    if self.db:isopen() == false then
        return
    end

    local sql = string.format( "select * from %s", tablename )

    for row in db:nrows(sql) do 

        if callback ~= nil then
           callback(row) 
        end
	end

end