--[[
	Weapon.lua
	
	Defines the default weapon equippable by combatants.
	Other weapons should inherit from this class.
]]

		local Projectile = require("Projectile")
		local Bomb = require("Bomb")
		local Graphic = require("Graphic")
		local Physics

--[[
	Class Weapon
		Public functions:
			new({}, speed, graphic, sfx)
			FireProjectile(x,y,direction)	-	Launches a projectile. It is assumed that the projectile comes from the player.
]]
local Weapon = {}

function Weapon:new (o, weapontype, g)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.weapontype = weapontype
	o.graphic = g
	o.sfx = "sfx"
	if(weapontype == "l") then
		o.endlag = 15
		o.speed = 30
	else
		o.endlag = 60
		o.speed = 2
	end
	o.lagtime = 0
	
	return o
end

function Weapon:Update()
	local int = self.lagtime - 1
	if(int > 0)then
		self.lagtime = int
	else
		self.lagtime = 0
	end
end

function Weapon:FireProjectile(x,y,directionX,directionY)
	if(self.lagtime == 0)then
		local projectile
		if(self.weapontype == "l" or self.weapontype == nil)then
			projectile = Projectile:new(o, x, y, directionX,directionY, self.sfx, self.speed, Graphic:new({},x,y,self.graphic))
		else
			projectile = Bomb:new(o, x, y, directionX,directionY, self.sfx, self.speed, Graphic:new({},x,y,self.graphic))
		end
		self.lagtime = self.endlag
		--print("fired projectile")
		return projectile
	else
		--print("endlag")
		return nil
	end
end

function Weapon:Delete()
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
	self = nil
end

return Weapon