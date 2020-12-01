--[[
	Graphic.lua
	
	Manages sprites.
]]



--[[
	Class Graphic
		Public functions:
			Rotate(float angle)	- rotates the graphic to face angle
			Translate(int x, int y) - moves the graphic to position x, y
			GetX() - returns x position
			GetY() - returns y position
			GetRotation() - returns rotation
]]
local Graphic = {}


function Graphic:new (o, x, y, g)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	--local g = display.newRect(x, y, 50, 50)
	--g:setFillColor(1,1,1)	--##
	o.sprites = {}
	o.angle = 0
	o.x = x
	o.y = y
	
	
	
	if(g == "grunt")then
		local spriteoptions = {
			frames = {
				{x = 24, y = 16, width = 52, height = 96}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/soldier.png", spriteoptions)
		local spriteSequence = {
			name = "grunt",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "drone")then
		local spriteoptions = {
			frames = {
				{x = 12, y = 20, width = 108, height = 56}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/enemy2.png", spriteoptions)
		local spriteSequence = {
			name = "drone",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "fastdrone")then
		local alien3options = {
			frames = {
				{x = 36, y = 20, width = 60, height = 88}
			}
		}
		local alien3Sheet = graphics.newImageSheet("Assets/Sprites/enemy3.png", alien3options)
		local alien3Sequence = {
			name = "fastdrone",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local alien3 = display.newSprite(alien3Sheet,alien3Sequence)
		table.insert(o.sprites, alien3)
	elseif(g == "smartdrone")then
		local alien1options = {
			frames = {
				{x = 16, y = 16, width = 88, height = 52}
			}
		}
		local alien1Sheet = graphics.newImageSheet("Assets/Sprites/alien1.png", alien1options)
		local alien1Sequence = {
			name = "smartdrone",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local alien1 = display.newSprite(alien1Sheet,alien1Sequence)
		table.insert(o.sprites, alien1)
	elseif(g == "projectile")then
		local spriteoptions = {
			frames = {
				{x = 0, y = 4, width = 8, height = 4},
				{x = 12, y = 12, width = 8, height = 4}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/bulletlaser.png", spriteoptions)
		local spriteSequence = {
			name = "projectile",
			start = 1,
			count = 1,
			time = 15,
			loopCount = 1
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2,2)
		table.insert(o.sprites, sprite)
	elseif(g == "bomb")then
	elseif(g == "avatar")then
		local spriteoptions = {
			frames = {
				{x = 0, y = 24, width = 96, height = 40}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/friendly1.png", spriteoptions)
		local spriteSequence = {
			name = "avatar",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "title")then
	elseif(g == "titlebutton")then
	elseif(g == "results")then
	elseif(g == "game1")then
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 1500}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_city.png", spriteoptions)
		local spriteSequence = {
			name = "city",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(1, 1)
		table.insert(o.sprites, sprite)
	elseif(g == "game2")then
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 1500}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_mountains.png", spriteoptions)
		local spriteSequence = {
			name = "mountains",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(1, 1)
		table.insert(o.sprites, sprite)
	elseif(g == "game3")then
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 1500}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_desert.png", spriteoptions)
		local spriteSequence = {
			name = "desert",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(1, 1)
		table.insert(o.sprites, sprite)
	elseif(g == "playbutton")then
		local spriteoptions = {
			frames = {
				{x = 2, y = 2, width = 60, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "play",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "backbutton")then
		local spriteoptions = {
			frames = {
				{x = 2, y = 46, width = 46, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "back",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "resumebutton")then
		local spriteoptions = {
			frames = {
				{x = 2, y = 68, width = 66, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "pause",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "quitbutton")then
		local spriteoptions = {
			frames = {
				{x = 2, y = 90, width = 44, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "quit",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "settings")then
	elseif(g == "settingsbutton")then
		local spriteoptions = {
			frames = {
				{x = 2, y = 24, width = 72, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "settingsbutton",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "firebutton")then
		local spriteoptions = {
			frames = {
				{x = 2, y = 158, width = 46, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "fire",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	elseif(g == "pausebutton")then
		local spriteoptions = {
			frames = {
				{x = 98, y = 158, width = 20, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "pause",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		table.insert(o.sprites, sprite)
	end
	
	
	return o
end

function Graphic:Rotate(angle)	--## Incomplete. Needs to take sprite offsets into account.
	a = self.angle
	for i, j in ipairs(self.sprites) do
		j:rotate(a - angle)
	end
	self.angle = angle
end

function Graphic:Translate(x,y)	--## Incomplete. Needs to take sprite offsets into account.
	self.x = x
	self.y = y
	for i, j in ipairs(self.sprites) do
		j.x = x
		j.y = y
	end
end

function Graphic:Destroy()
		for i=1,#self.sprites,1 do
			local j = self.sprites[#self.sprites]
			table.remove(self.sprites, #self.sprites)
			j:removeSelf()
			j = nil
		end
		for i=1,#self,1 do
			local j = self[#self]
			table.remove(self, #self)
			j=nil
		end
	self = nil
end

function Graphic:GetX()
	return self.x
end
function Graphic:SetX(x)
	self.x = x
	for i, j in ipairs(self.sprites) do
		j.x = x
	end
end
function Graphic:GetY()
	return self.y
end
function Graphic:SetY(y)
	self.y = y
	for i, j in ipairs(self.sprites) do
		j.y = y
	end
end
function Graphic:GetHeight()
	return 50
end
function Graphic:GetWidth()
	return 50
end
function Graphic:GetRotation()
	return self.angle
end

function Graphic:addEventListener(eventname, listener)
	for i=1,#self.sprites,1 do
		self.sprites[i]:addEventListener(eventname, listener)
	end
end
function Graphic:removeEventListener(eventname, listener)
	for i=1,#self.sprites,1 do
		self.sprites[i]:removeEventListener(eventname, listener)
	end
end

return Graphic
