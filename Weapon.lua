--[[
	Weapon.lua
	
	Defines the default weapon equippable by combatants.
	Other weapons should inherit from this class.
]]

		local Projectile = require("Projectile")

--[[
	Class Weapon
		Public functions:
			new({}, speed, graphic, sfx)
			FireProjectile(x,y,direction)	-	Launches a projectile. It is assumed that the projectile comes from the player.
]]
local Weapon = {}

function Weapon:new (o, weapontype)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.speed = 15
	o.graphic = "graphic"
	o.sfx = "sfx"
	o.endlag = 15
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

function Weapon:FireProjectile(x,y,direction)
	if(self.lagtime == 0)then
		local projectile = Projectile:new(o, x, y, direction, self.sfx, self.speed, self.graphic)
		self.lagtime = self.endlag
		--print("fired projectile")
		return projectile
	else
		--print("endlag")
		return nil
	end
end

function Weapon:Delete()
	for i, j in pairs(self) do
		table.remove(self, i)
		j = nil
	end
	self = nil
end

return Weapon