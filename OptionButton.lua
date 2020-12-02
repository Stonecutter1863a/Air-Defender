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
	
	local g = display.newRect(0, 0, 112, 31)
	g:setFillColor(1,1,1)
	group = display.newGroup()
	group:insert(g)
	if (i==1) then
		text = display.newText(group, "MUSIC",1,1, native.systemFont)
		text:setFillColor(0,255,0)
	end
	o.interface = g
	--o.interface = widget.newButton(opt)

	function changeSetting()
		if (Settings:Get(i) == false) then
			Settings:Set(i, true)
		else
			Settings:Set(i, false)
		end
		Settings:Update()
	end
	o.interface:addEventListener("tap", changeSetting)

	return o
end

function OptionButton:SetPos(x,y)
	group.x = x
	group.y = y
end

function OptionButton:Destroy()
	self.interface:removeSelf()
	text:removeSelf()
	group:removeSelf()
	self=nil
end

return OptionButton