--[[
	Projectile.lua
	
	Projectiles in Air Defender. They should fly straight in their given direction and damage enemies on impact.
]]

--[[
	
]]
local Projectile = {}

function Projectile:new(o)
	local Graphic = require("Graphic")
	local g = Graphic:new({},0,0,"projectile")
	g:setFillColor(1,1,1)
	
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.aimY = 0
	o.aimX = 1
	local s = 2
	local x = 0
	local y = 0
	
	o.graphic = g
	o.sfx = sfx
	o.topspeed = 2
	o.graphic:SetY(y)
	o.graphic:SetX(x)
	

	--[[function o.Reset()
		o.graphic.sprites[1]:setLinearVelocity(0,0)
		o.graphic.sprites[1]:applyForce((dx * s*display.contentWidth/1334),(dy * s*display.contentHeight/750),o.graphic:GetX(),o.graphic:GetY())
	end]]
	
	function o.collide(event)
		--if(event.phase == "end")then
			--timer.performWithDelay(30,o.Reset,1)
		--end
		if(--[[o.graphic.sprites[1]:getAngularVelocity() < 1 and]] event.other.tag == "enemy")then
			o.graphic.sprites[1]:applyAngularImpulse(1)
		end
	end
	o.graphic.sprites[1]:applyForce((dx * s*display.contentWidth/1334),(dy * s*display.contentHeight/750), x,y)
	
	o.graphic:addEventListener("collision", o.collide)
	--timer.performWithDelay(2, o.regAncestry)
	return o
	
end

function Projectile:new(o,x,y,dy,dx,sfx,s,g)	--## needs to play sfx
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.aimY = dy
	o.aimX = dx
	
	o.graphic = g
	o.sfx = sfx
	o.topspeed = s
	o.graphic:SetY(y)
	o.graphic:SetX(x)
	

	--[[function o.Reset()
		o.graphic.sprites[1]:setLinearVelocity(0,0)
		o.graphic.sprites[1]:applyForce((dx * s*display.contentWidth/1334),(dy * s*display.contentHeight/750),o.graphic:GetX(),o.graphic:GetY())
	end]]
	
	function o.collide(event)
		--if(event.phase == "end")then
			--timer.performWithDelay(30,o.Reset,1)
		--end
		if(--[[o.graphic.sprites[1]:getAngularVelocity() < 1 and]] event.other.tag == "enemy")then
			o.graphic.sprites[1]:applyAngularImpulse(1)
			if(o:BulletType() == "bomb")then
				o:Explode()
			end
		end
	end
	o.graphic.sprites[1]:applyForce((dx * s*display.contentWidth/1334),(dy * s*display.contentHeight/750), x,y)
	
	o.graphic:addEventListener("collision", o.collide)
	--timer.performWithDelay(2, o.regAncestry)
	return o
end


function Projectile:Update()
		--self.graphic:SetY(self.graphic:GetY() - (self.aimY * self.topspeed*display.contentHeight/750))
		--self.graphic:SetX(self.graphic:GetX() + (self.aimX * self.topspeed*display.contentWidth/1334))
		--self:Reset()
end

function Projectile:BulletType()
	return "defualt"
end

function Projectile:GetPosX()
	if(self.graphic.sprites[1] ~= nil)then
		return self.graphic.sprites[1].x
	else
		return nil
	end
end
function Projectile:GetPosY()
	if(self ~= nil)then
		return self.graphic.sprites[1].y
	else
		return nil
	end
end

function Projectile:Reset()
	self:setLinearVelocity((self.aimX * self.topspeed*display.contentWidth/1334),(self.aimY * self.topspeed*display.contentHeight/750))

	--self.graphic.sprites[1]:setLinearVelocity(0,0)
	--self:applyForce((self.aimX * self.topspeed*display.contentWidth/1334),(self.aimY * self.topspeed*display.contentHeight/750),self.graphic:GetX(),self.graphic:GetY())
end

function Projectile:Destroy()
	self.graphic:Destroy()
	
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
		
	self = nil
end

return Projectile