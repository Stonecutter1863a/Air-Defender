--[[
	Combatant.lua
	
	Combative units in Air Defender, such as the player avatar and enemy sprites.
]]


--[[
	
]]
local Combatant = {}

function Combatant:new(o)
	
	local g = display.newRect(0, 0, 100, 100)
	g:setFillColor(1,1,1)
	
	o = Combatant:new(o,1,false,0,1,1,g)
	
	return o
end

function Collide(event)
	if(event.other.tag ~= nil and event.other.tag == "projectile")then
		--print("collision!")
		event.target.collided = true
	end
end

function Combatant:new(o,h,p,w,t,a,g)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	local Weapon = require("Weapon")
	
	o.health = h
	o.aimY = 0
	o.aimX = 1
	o.isPlayer = p
	o.weapon = Weapon:new({}, "w")	--##
	o.topspeed = t
	o.speed = 0
	o.acceleration = a
	
	o.graphic = g
	
	if(p == false)then
		g.sprites[1]:addEventListener("collision", Collide)
		o.collided = false
	end
	return o
end


function Combatant:Steer(dir)
	
	local targetHeight = display.contentHeight - (dir * display.contentHeight / 100)
	
	local opposite = self.graphic:GetY() - targetHeight
	local adjacent = display.contentWidth - self.graphic:GetX()
	local hypot = math.sqrt((opposite^2) + (adjacent^2))
	self.aimY = (opposite/hypot)
	if(self.isPlayer == true and self.aimY > 0.01)then
		self.aimY = 1
	elseif(self.isPlayer == true and self.aimY < -0.01)then
		self.aimY = -1
	elseif(self.isPlayer == true)then
		self.aimY = 0
	end
end

function Combatant:SetPos(x,y)
	self.graphic:SetX(x)
	self.graphic:SetY(y)
end
function Combatant:GetPosX()
	return self.graphic:GetX()
end
function Combatant:GetPosY()
	return self.graphic:GetY()
end
function Combatant:GetHeight()
	return self.graphic:GetHeight()
end
function Combatant:GetWidth()
	return self.graphic:GetWidth()
end

function Combatant:Update()	--## needs to account for graphic heights
	if(self.isPlayer == true) then
		self.graphic:SetY(self.graphic:GetY() - (self.aimY * self.topspeed))
		if(self.graphic:GetY() > display.contentHeight) then
			self.graphic:SetY(display.contentHeight)
		elseif(self.graphic:GetY() < 0) then
			self.graphic:SetY(0)
		end
		self.weapon:Update()
	else
		self.graphic:SetY(self.graphic:GetY() - (self.aimY * self.topspeed))
		self.graphic:SetX(self.graphic:GetX() - (self.aimX * self.topspeed))
	end
end

function Combatant:UseWeapon()
	return self.weapon:FireProjectile(self.graphic.x,self.graphic.y,0,1,self.isPlayer)
end

function Combatant:Damage(amount)
	self.health = self.health - amount
	self.collided = false
	if(self.health <= 0) then
		--self:Instakill()
		return true
	else
		return false
	end
end

function Combatant:Instakill()
	self:Delete()
end

function Combatant:Delete()
	self.graphic:Destroy()
	self.graphic=nil
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
	self = nil
end

return Combatant