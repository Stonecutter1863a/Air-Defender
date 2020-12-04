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

local Graphic = require("Graphic")

--[[
	Class FireButton
		Public functions:
			IsPressed()	- returns true when button is currently pressed
]]
local FireButton = {}

function FireButton.touched(event)
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

function FireButton:new (o, g)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	
		
	o.interface = g
	--o.interface.height = 30
	--o.interface.width = 69
	o.interface.sprites[1].isPressed = false
	--o.interface = widget.newButton(opt)
	o.interface:addEventListener("touch", FireButton.touched)
	
	return o
end

function FireButton:IsPressed()
	return self.interface.sprites[1].isPressed
end

function FireButton:SetPos(x,y)
	--self.interface:SetX(x)
	--self.interface:SetY(y)
	self.interface:SetX(x)
	self.interface:SetY(y)
end
--[[
function FireButton:Reset()
	self.isPressed = false
end]]

function FireButton:Destroy()
	self.interface:removeEventListener("touch", FireButton.touched)
	self.interface:Destroy()
	--self.interface:removeSelf()
	self.interface = nil
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j = nil
		end
	self=nil
end

return FireButton
