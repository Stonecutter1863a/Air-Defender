--[[
	OptionButton.lua

	A button used to change settings in the SettingsScene.
]]

local widget = require ("widget")
local buttonWidth = 100
local buttonHeight = 100
local opt = {
	x=0,
	y=0,
	width=buttonWidth,
	height=buttonHeight,
}

local OptionButton = {}

function OptionButton:new(o)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	local g = display.newRect(0, 0, 50, 20)
	g:setFillColor(255,0,0)
	o.interface = g
	--o.interface = widget.newButton(opt)

	--o.interface:addEventListener("tap", changeSetting)

	return o
end

function OptionButton:SetPos(x,y)
	self.interface.x = x
	self.interface.y = y
end

function OptionButton:Destroy()
	self.interface:removeSelf()
	self=nil
end

return OptionButton