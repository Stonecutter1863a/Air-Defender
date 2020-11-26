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
	
	self = Combatant:new(o,1,false,0,1,1,g)
	
	return o
end

function Combatant:new(o,h,p,w,t,a,g)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	local Weapon = require("Weapon")
	
	o.health = h
	o.aim = 0
	o.isPlayer = p
	o.weapon = Weapon:new({}, "w")	--##
	o.topspeed = t
	o.speed = 0
	o.acceleration = a
	
	o.graphic = g
	
	return o
end

function Combatant:Steer(dir)
	self.aim = dir*math.pi/200
end

function Combatant:SetPos(x,y)
	self.graphic:SetX(x)
	self.graphic:SetY(y)
end

function Combatant:Update()	--## needs to account for graphic heights
	if(self.isPlayer == true) then
		--self.graphic.y = self.graphic.y - (math.sin(self.aim) * self.topspeed)
		self.graphic:SetY(self.graphic:GetY() - (math.sin(self.aim) * self.topspeed))
		if(self.graphic:GetY() > display.contentHeight) then
			--self.graphic.y = display.contentHeight
			self.graphic:SetY(display.contentHeight)
		elseif(self.graphic:GetY() < 0) then
			--self.graphic.y = 0
			self.graphic:SetY(0)
		end
		self.weapon:Update()
	else	--## needs to delete enemies onece they reach the left side of the screen
		--self.graphic.y = self.graphic.y - (math.sin(self.aim) * self.topspeed)
		--self.graphic.x = self.graphic.x - (math.cos(self.aim) * self.topspeed)
		self.graphic:SetY(self.graphic:GetY() - (math.sin(self.aim) * self.topspeed))
		self.graphic:SetX(self.graphic:GetX() - (math.cos(self.aim) * self.topspeed))
	end
end

function Combatant:UseWeapon()
	return self.weapon:FireProjectile(self.graphic.x,self.graphic.y,self.aim,self.isPlayer)
end

function Combatant:Damage(amount)
	self.health = self.health - amount
	if(self.health <= 0) then
		self:Instakill()
	end
end

function Combatant:Instakill()
	self:Delete()
end

function Combatant:Delete()
	self.graphic:Destroy()
	self.graphic=nil
	for k,l in ipairs(self) do
		l = nil
	end
	self = nil
end

return Combatant