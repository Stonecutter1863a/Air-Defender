--[[
	Settings.lua
	
	The various options available to the player for experience customization.
]]


--[[
	Class Settings
		Public functions:
			Get(key)
			Set(key, value)
]]
local Settings = {}

function Settings:new (o)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	self.values = {}
	return o
end

function Settings:Get(key)
	return self.values[key]
end
function Settings:Set(key, value)
	self.values[key] = value
end

function Settings:Delete()
	for i, j in pairs(self) do
		table.remove(self, i)
		j = nil
	end
	self = nil
end

return Settings