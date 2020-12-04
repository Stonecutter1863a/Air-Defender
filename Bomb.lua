--[[
	Bomb.lua
	
	
]]

local Projectile = require("Projectile")
local Explosion = require("Explosion")

--[[
	
]]
local Bomb = {}
setmetatable(Bomb, Projectile)
self_index = Projectile


function Bomb:new(o,x,y,dy,dx,sfx,s,g)
	o = o or {}
	o = Projectile:new(o, x, y, dy, dx, sfx, s, g)
	setmetatable(o, self)
	self.__index = self
	
	
	o.explosion = false
	o.spent = false
	
	function o.spawnExplosion()
		--o.explosion = Explosion:new({},o.graphic:GetX(),o.graphic:GetY())
		o:Explode()
	end
	
	function o.Collide(event)
		if(o.explosion == nil and event.other.tag == "enemy")then
			timer.performWithDelay(1,o.spawnExplosion)
			o.graphic.sprites[1]:removeEventListener("collision",o.Collide)
		end
	end
	
	o.graphic.sprites[1]:addEventListener("collision",o.Collide)
	return o
end

function Bomb:Update()
--print("bomb update")
	--[[vx,xy = self.graphic.sprites[1]:getLinearVelocity()
	if(vy >= vx)then
		self.graphic.sprites[1]:play()
	end]]
	if(self ~= nil and self.graphic ~= nil and self.graphic.sprites~=nil and self.graphic.sprites[1] ~=nil and self.graphic.sprites[1].y > display.contentHeight)then
		--self:Destroy()
	elseif(self ~= nil and self.graphic ~= nil and self.graphic.sprites~=nil and self.graphic.sprites[1] ~=nil and self.graphic.sprites[1].y > display.contentHeight*8/10)then
		self:Explode()
	end
end
--[[
function Bomb:GetPosY()
	return self.graphic:GetY()
end]]

function Bomb:BulletType()
	return "bomb"
end

function Bomb:HasExploded()
	return self.spent
end

function Bomb:GetExplosion()
	return self.explosion
end

function Bomb:Explode()
	if(self.spent ~= true)then
		self.explosion = Explosion:new({},self.graphic:GetX(),self.graphic:GetY())
		--print("EXPLOOOOOOOOOOOSION!")
		self.spent = true
	end
end

return Bomb