--[[
	Explosion.lua
	
	
]]

local Graphic = require("Graphic")

local Explosion = {}

function Explosion:new(o, x,y)
	o = o or {}
	setmetatable(o, self)
	self_index = self
	
	o.graphics = {Graphic:new({},0,0,"explosion"),Graphic:new({},0,0,"explosion")}
	o.graphics[1]:SetX(x)
	o.graphics[1]:SetY(y)
	o.graphics[2]:SetX(x)
	o.graphics[2]:SetY(y)
	
	o.graphics[1].sprites[1].x = o.graphics[1].sprites[1].x + 12*display.contentHeight/750
	o.graphics[2].sprites[1].x = o.graphics[1].sprites[1].x - 12*display.contentHeight/750
	o.graphics[2].sprites[1]:rotate(180)
	
	
	function Kill(event)
		if(event.phase == "ended")then
			o.graphics[1]:Destroy()
			o.graphics[2]:Destroy()
			o.graphics = nil
		end
	end
	
	
	o.graphics[1].sprites[1]:addEventListener("sprite", Kill)
	
	return o
end

function Explosion:Update()

end

function Explosion:Destroy()
			o.graphics[1]:Destroy()
			o.graphics[2]:Destroy()
end

return Explosion