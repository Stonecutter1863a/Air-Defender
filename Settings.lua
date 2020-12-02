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
local music = true

function Settings:new (o)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	self.values = {true} --default music on

	return o
end

function Settings:Get(key)
	return self.values[key]
end
function Settings:Set(key, value)
	self.values[key] = value
end

function Settings:Delete()
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
	self = nil
end

function Settings:Update()
	if (self.values[1] == true) then
		music = true
		audio.resume(1)
	elseif (self.values[1] == false) then
		music = false
		audio.pause(1)
	end
end

function Settings:IsMusic()
	return music
end

return Settings