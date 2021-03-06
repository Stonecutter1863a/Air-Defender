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


function MenuButton:new (o, a, b, g)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	local pauseScene = a
	local targetScene = b
	
	--local g = display.newRect(0, 0, 50, 20)
	--g:setFillColor(1,1,1)
	o.interface = g
	--o.interface = widget.newButton(opt)
	o.params = {}
	
	function o.ToScene()
		if not (isPaused == true)then
			local composer = require("composer")
			if (pauseScene == 0) then
				composer.gotoScene(targetScene, {params = o.params})
			elseif (pauseScene == 1) then
				composer.showOverlay(targetScene, {params = o.params})
				o.isPaused = true
			elseif (pauseScene == 2) then
				composer.hideOverlay()
			end
		end
	end

	o.pauseScene = a
	o.isPaused = false

	o.interface:addEventListener("tap", o.ToScene)

	return o
end

function MenuButton:SetPos(x,y)
	self.interface:SetX(x)
	self.interface:SetY(y)
end

function MenuButton:SetParams(p)
	self.params = p
end

function MenuButton:IsPaused()
	if (self.pauseScene == 1) then return self.isPaused
	else return false
	end
end

function MenuButton:Unpause()
	self.isPaused = false
end
function MenuButton:Pause()
	self.isPaused = true
end

function MenuButton:Destroy()
	self.interface:Destroy()
	self=nil
end

return MenuButton