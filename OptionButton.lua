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

function OptionButton:new(o, i, g, p)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.interface = g
	o.pos = {0,0}
	--o.interface = widget.newButton(opt)

	function changeSetting()
		value = Settings:Get(i)
		if (i == 1) or (i == 2) then
			if (value == false) then
				Settings:Set(i, true)
				value = Settings:Get(i)
			else
				Settings:Set(i, false)
				value = Settings:Get(i)
			end
		elseif (i == 3) then
			if (value == 1) or (value == 2) then
				Settings:Set(3, value + 1)
				value = Settings:Get(i)
			else
				Settings:Set(3, 1)
				value = Settings:Get(i)
			end
		elseif (i == 4) then
			if (value == 1) or (value == 2) then
				Settings:Set(4, value + 1)
				value = Settings:Get(i)
			else
				Settings:Set(4, 1)
				value = Settings:Get(i)
			end
		end
		Settings:Update()
		p:ChangeButton(i,value,o)
	--print(o.i)
	end
	o.interface:addEventListener("tap", changeSetting)

	return o
end

function OptionButton:ChangeGraphic(g, i, p)
	self.interface:Destroy()
	self.interface = nil
	self.interface = g
	
	self.interface:SetX(self.pos[1])
	self.interface:SetY(self.pos[2])
	function changeSetting()
		value = Settings:Get(i)
		if (i == 1) or (i == 2) then
			if (value == false) then
				Settings:Set(i, true)
				value = Settings:Get(i)
			else
				Settings:Set(i, false)
				value = Settings:Get(i)
			end
		elseif (i == 3) then
			if (value == 1) or (value == 2) then
				Settings:Set(3, value + 1)
				value = Settings:Get(i)
			else
				Settings:Set(3, 1)
				value = Settings:Get(i)
			end
		elseif (i == 4) then
			if (value == 1) or (value == 2) then
				Settings:Set(4, value + 1)
				value = Settings:Get(i)
			else
				Settings:Set(4, 1)
				value = Settings:Get(i)
			end
		end
		Settings:Update()
		p:ChangeButton(i,value,self)
	--print(o.i)
	end
	self.interface:addEventListener("tap", changeSetting)
end

function OptionButton:SetPos(x,y)
	self.pos = {x,y}
	self.interface:SetX(x)
	self.interface:SetY(y)
end

function OptionButton:Destroy()
	self.interface:Destroy()
	self=nil
end

return OptionButton