require("Class")
Stack = Class("Stack")

function Stack:ctor(...)
    self.items = {...}
end

function Stack:Peek()
    return self.items[1]
end

function Stack:Push(item)
    table.insert(self.items, 1, item)
end

function Stack:Pop()
    local item = self:Peek()
	table.remove(self.items, 1)
	return item
end

function Stack:Count()
    return #self.items
end

function Stack:Clear()
    self.items = {}
end