--[[
	Bomb.lua
	
	
]]

local Projectile = require("Projectile")
local Explosion = require("Explosion")

--[[
	
]]
local Bomb = {}


function Bomb:new(o,x,y,dy,dx,sfx,s,g)
	o = o or {}
	o = Projectile:new(o, x, y, dy, dx, sfx, s, g)
	o.explosion = nil
	o.isBomb = true
	
	function o.spawnExplosion()
		o.explosion = Explosion:new({},o.graphic:GetX(),o.graphic:GetY())
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
	vx,xy = self.graphic.sprites[1]:getLinearVelocity()
	if(vy >= vx)then
		self.graphic.sprites[1]:play()
	end
	if(self.graphic.GetY() > display.contentHeight*8/10)then
	self:Explode()
	end
end
--[[
function Bomb:GetPosY()
	return self.graphic:GetY()
end]]

function Bomb:Explode()
	o.explosion = Explosion:new({},o.graphic:GetX(),o.graphic:GetY())
	print("EXPLOOOOOOOOOOOSION!")
end

return Bomb