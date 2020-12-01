--[[
	FireButton.lua
	
	Defines the button by which players fire projectiles.
]]

	local widget = require("widget")
	local buttonWidth = 100
	local buttonHeight = 100
	local opt = {
		x=0,
		y=0,
		width=buttonWidth,
		height=buttonHeight,
	}


--[[
	Class FireButton
		Public functions:
			IsPressed()	- returns true when button is currently pressed
]]
local FireButton = {}

local function touched(event)
	if(
			event.phase == "ended"
			or event.phase == "cancelled"
			or
			(
				event.phase == "moved"
				and
				(
					event.x < event.target.x - (event.target.width/2) + 5
					or event.x > event.target.x + (event.target.width/2) - 5
					or event.y < event.target.y - (event.target.height/2) + 5
					or event.y > event.target.y + (event.target.height/2) - 5
				)
			)
		) then
		event.target.isPressed = false
	else
		event.target.isPressed = true
	end
end

function FireButton:new (o)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	
	local g = display.newRect(0, 0, 100, 100)
	g:setFillColor(1,1,1)
	o.interface = g
	o.interface.isPressed = false
	--o.interface = widget.newButton(opt)
	o.interface:addEventListener("touch", touched)
	
	return o
end

function FireButton:IsPressed()
	return self.interface.isPressed
end

function FireButton:SetPos(x,y)
	self.interface.x = x
	self.interface.y = y
end
--[[
function FireButton:Reset()
	self.isPressed = false
end]]

function FireButton:Destroy()
	self.interface:removeSelf()
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j = nil
		end
	self=nil
end

return FireButton
