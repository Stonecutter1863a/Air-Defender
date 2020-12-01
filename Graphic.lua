--[[
	Graphic.lua
	
	Manages sprites.
]]



--[[
	Class Graphic
		Public functions:
			Rotate(float angle)	- rotates the graphic to face angle
			Translate(int x, int y) - moves the graphic to position x, y
			GetX() - returns x position
			GetY() - returns y position
			GetRotation() - returns rotation
]]
local Graphic = {}


function Graphic:new (o, x, y, g)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	local g = display.newRect(x, y, 50, 50)
	g:setFillColor(1,1,1)	--##
	o.sprites = {}
	table.insert(o.sprites, g)
	o.angle = 0
	o.x = x
	o.y = y
	
	return o
end

function Graphic:Rotate(angle)	--## Incomplete. Needs to take sprite offsets into account.
	a = self.angle
	for i, j in ipairs(self.sprites) do
		j:rotate(a - angle)
	end
	self.angle = angle
end

function Graphic:Translate(x,y)	--## Incomplete. Needs to take sprite offsets into account.
	self.x = x
	self.y = y
	for i, j in ipairs(self.sprites) do
		j.x = x
		j.y = y
	end
end

function Graphic:Destroy()
		for i=1,#self.sprites,1 do
			local j = self.sprites[#self.sprites]
			table.remove(self.sprites, #self.sprites)
			j:removeSelf()
			j = nil
		end
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
	self = nil
end

function Graphic:GetX()
	return self.x
end
function Graphic:SetX(x)
	self.x = x
	for i, j in ipairs(self.sprites) do
		j.x = x
	end
end
function Graphic:GetY()
	return self.y
end
function Graphic:SetY(y)
	self.y = y
	for i, j in ipairs(self.sprites) do
		j.y = y
	end
end
function Graphic:GetHeight()
	return 50
end
function Graphic:GetWidth()
	return 50
end
function Graphic:GetRotation()
	return self.angle
end

return Graphic
