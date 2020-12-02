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

Settings = require("Settings")

local OptionButton = {}

function OptionButton:new(o, i)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	local g = display.newRect(0, 0, 80, 30)
	g:setFillColor(1,1,1)
	o.interface = g
	--o.interface = widget.newButton(opt)

	function changeSetting()
		value = Settings:Get(i)
		if (i == 1) or (i == 2) then
			if (value == false) then
				Settings:Set(i, true)
			else
				Settings:Set(i, false)
			end
		elseif (i == 3) then
			if (value == 1) or (value == 2) then
				Settings:Set(3, value + 1)
			else
				Settings:Set(3, 1)
			end
		end
		Settings:Update()
	end
	o.interface:addEventListener("tap", changeSetting)

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