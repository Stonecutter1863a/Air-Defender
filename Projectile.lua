--[[
	Projectile.lua
	
	Projectiles in Air Defender. They should fly straight in their given direction and damage enemies on impact.
]]

--[[
	
]]
local Projectile = {}

--[[function Projectile:new(o)
	
	local g = display.newRect(0, 0, 100, 100)
	g:setFillColor(1,1,1)
	
	self = Combatant:new(o,1,false,0,1,1,g)
	
	return o
end]]

function Projectile:new(o,x,y,dy,dx,sfx,s,g)	--## needs to play sfx
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.aimY = dy
	o.aimX = dx
	
	local Graphic = require("Graphic")
	
	o.graphic = Graphic:new({},x,y,"projectile", o)
	o.sfx = sfx
	o.topspeed = s
	o.graphic:SetY(y)
	o.graphic:SetX(x)
	

	function o.Reset()
		o.graphic.sprites[1]:setLinearVelocity(0,0)
		o.graphic.sprites[1]:applyForce((dx * s*display.contentWidth/1334),(dy * s*display.contentHeight/750),o.graphic:GetX(),o.graphic:GetY())
	end
	
	function o.collide(event)
		--if(event.phase == "end")then
			timer.performWithDelay(30,o.Reset,1)
		--end
	end
	
	o.graphic.sprites[1]:applyForce((dx * s*display.contentWidth/1334),(dy * s*display.contentHeight/750), x,y)
	
	o.graphic:addEventListener("collide", o.collide)
	return o
end

function Projectile:Update()
		--self.graphic:SetY(self.graphic:GetY() - (self.aimY * self.topspeed*display.contentHeight/750))
		--self.graphic:SetX(self.graphic:GetX() + (self.aimX * self.topspeed*display.contentWidth/1334))
		self:Reset()
end

function Projectile:GetPosX()
	return self.graphic:GetX()
end
function Projectile:GetPosY()
	return self.graphic:GetY()
end

function Projectile:Reset()
	self:setLinearVelocity((self.aimX * self.topspeed*display.contentWidth/1334),(self.aimY * self.topspeed*display.contentHeight/750))
end

function Projectile:Delete()
	self.graphic:Destroy()
	
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
		
	self = nil
end

return Projectile