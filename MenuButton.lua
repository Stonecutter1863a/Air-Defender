--[[
	MenuButton.lua
	
	Defines the button by which players open the menu.
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

local MenuButton = {}

function MenuButton:new (o, a, b)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	local pauseScene = a
	local targetScene = b
	
	local g = display.newRect(0, 0, 50, 20)
	g:setFillColor(1,1,1)
	o.interface = g
	--o.interface = widget.newButton(opt)
	
	function o.ToScene()
		local composer = require("composer")
		if (pauseScene == 0) then
			composer.gotoScene(targetScene)
		elseif (pauseScene == 1) then
			composer.showOverlay(targetScene)
		elseif (pauseScene == 2) then
			composer.hideOverlay()
		end
	end

	o.interface:addEventListener("tap", o.ToScene)

	return o
end

function MenuButton:SetPos(x,y)
	self.interface.x = x
	self.interface.y = y
end

function MenuButton:IsPaused()
	if (pauseScene == 1) then return true
	else return false
	end
end

function MenuButton:Destroy()
	self.interface:removeSelf()
	self=nil
end

return MenuButton