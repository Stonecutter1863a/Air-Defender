--[[
	SteeringSlider.lua
	
	Defines the slider control by which players steer the player avatar.
]]
	local widget = require("widget")
	local sliderWidth = 10
	local sliderHeight = 600
	local opt = {
		x=0,
		y=0,
		width=sliderWidth,
		height=sliderHeight,
		orientation="vertical",
		value=50
	}
	
	local deadzone = {45,55}

--[[
	Class SteeringSlider
		Public functions:
			GetInput() - returns player input as an integer between 0 and 100
]]
local SteeringSlider = {}

function SteeringSlider:new (o)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
   
	o.deadzone = deadzone
	o.width = sliderWidth
	o.input = 0
	o.interface = widget.newSlider(opt)
	
	return o
end

function SteeringSlider:Update()
	local input = 0
	if(self.interface.value < self.deadzone[1]) then
		input = (self.interface.value - self.deadzone[1]) * 5 / 2
	elseif(self.interface.value > self.deadzone[2]) then
		input = (self.interface.value - self.deadzone[2]) * 5 / 2
	end
	self.input = input
end

function SteeringSlider:GetInput()
	self:Update()
	return self.input
end

function SteeringSlider:Destroy()
	self.interface:removeSelf()
	for i, j in ipairs(self) do
		table.remove(self, i)
		j = nil
	end
	self=nil
end

return SteeringSlider