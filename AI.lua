--[[
	AI.lua
	
	The controllers for the NPC's in Air Defender.
]]


--[[
	Class AI
		Public functions:
			new({}, aitype)
			Update(x1,y1, x2,y2)	-	Generates inputs for the NPC based on its position (x1,y1) and the player's (x2,y2).
]]
local AI = {}

function AI:new (o, aitype, origin)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	o.aitype = aitype
	o.phase = math.round(math.random(0,1))
	if(origin == nil)then
		o.origin = math.random(20,80)
	else
		o.origin = origin
	end
	o.timer = math.random(0,1)*80
	
	return o
end

function AI:Update()
	if(self.aitype == 1)then
		--self.phase = self.phase + (0.25/5)
		--local n = {0,(((math.sin(self.phase * math.pi)/2)+0.5) * 20)+self.origin}
		self.timer = self.timer + 1
		return {0,math.round((self.timer % 160)/160)*160-80+self.origin}
	else
		return nil
	end
end

function AI:Delete()
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
	self = nil
end

return AI