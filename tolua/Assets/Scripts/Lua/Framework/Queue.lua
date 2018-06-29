
require("Class")
Queue = Class("Queue")

function Queue:ctor(...)
    self.items = {...}
end

function Queue:Peek()
    return self.items[1]
end

function Queue:Enqueue(item)
    table.insert(self.items, self:Count() + 1, item)
end

function Queue:Dequeue()
    local item = self:Peek()
	table.remove(self.items, 1)
	return item
end

function Queue:Count()
    return #self.items
end

function Queue:Clear()
    self.items = {}
end