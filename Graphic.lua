--[[
	Graphic.lua
	
	Manages sprites.
]]

local Physics = require("physics")

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


function Graphic:new (o, x, y, g, p)    --constructor
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	
	--local g = display.newRect(x, y, 50, 50)
	--g:setFillColor(1,1,1)	--##
	o.sprites = {}
	o.angle = 0
	o.x = x
	o.y = y
	o:SetX(x)
	o:SetY(y)
	o.simulate = false
	o.proj = p
	
	if(g == "grunt")then
		o.simulate = true
		o.width = 52
		o.height = 96
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
		--Physics.addBody(sprite,"dynamic",{outline=graphics.newOutline(4,spriteSheet,1)})
		Physics.addBody(sprite,"kinematic")
		sprite.isSensor = true
		sprite.tag = "enemy"
		sprite.gravityScale = 0
		sprite:scale(display.contentWidth/1334,display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "drone")then
		o.simulate = true
		o.width = 108
		o.height = 56
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
		--Physics.addBody(sprite,"dynamic",{outline=graphics.newOutline(4,spriteSheet,1)})
		Physics.addBody(sprite,"kinematic")
		sprite.isSensor = true
		sprite.tag = "enemy"
		sprite.gravityScale = 0
		sprite:scale(display.contentWidth/1334,display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "fastdrone")then
		o.simulate = true
		o.width = 60
		o.height = 88
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
		--Physics.addBody(alien3,"dynamic",{outline=graphics.newOutline(4,alien3Sheet,1)})
		Physics.addBody(alien3,"kinematic")
		alien3.tag = "enemy"
		alien3.isSensor = true
		alien3.gravityScale = 0
		alien3:scale(display.contentWidth/1334,display.contentHeight/750)
		table.insert(o.sprites, alien3)
	elseif(g == "smartdrone")then
		o.simulate = true
		o.width = 88
		o.height = 52
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
		--Physics.addBody(alien1,"dynamic",{outline=graphics.newOutline(4,alien1Sheet,1)})
		Physics.addBody(alien1,"kinematic")
		alien1.tag = "enemy"
		alien1.gravityScale = 0
		alien1.isSensor = true
		alien1:scale(display.contentWidth/1334,display.contentHeight/750)
		table.insert(o.sprites, alien1)
	elseif(g == "projectile")then
		o.simulate = true
		o.width = 8*2
		o.height = 4*2
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
			count = 2,
			time = 15*15,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		sprite.tag = "projectile"
		sprite.parent = o
		Physics.addBody(sprite,"dynamic")
		sprite.isSensor = true
		sprite.isBullet = true
		sprite.gravityScale = 0
		sprite:play()
		table.insert(o.sprites, sprite)
	elseif(g == "bomb")then
		o.simulate = true
		o.width = 8*2
		o.height = 4*2
		local spriteoptions = {
			frames = {
				{x = 54, y = 36, width = 28, height = 12},
				{x = 40, y = 36, width = 12, height = 28}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/bomb.png", spriteoptions)
		local spriteSequence = {
			name = "bomb",
			start = 1,
			count = 2,
			loopCount = 1
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(1*display.contentWidth/1334,1*display.contentHeight/750)
		--sprite.tag = "projectile"
		sprite.parent = o
		Physics.addBody(sprite,"dynamic")
		sprite.gravityScale = 8*display.contentHeight/750
		sprite.isSensor = true
		sprite.isBullet = true
		sprite.tag = "projectile"
		--sprite:play()
		table.insert(o.sprites, sprite)
	elseif(g == "explosion")then
		o.simulate = true
		o.width = 8*2
		o.height = 4*2
		local spriteoptions = {
			frames = {
				{x = 20, y = 32, width = 28, height = 4},
				{x = 72, y = 24, width = 28, height = 12},
				{x = 8, y = 64, width = 32, height = 32},
				{x = 8, y = 64, width = 32, height = 32},
				{x = 72, y = 24, width = 28, height = 12},
				{x = 20, y = 32, width = 28, height = 4},
				{x = 72, y = 64, width = 32, height = 30},
				{x = 72, y = 64, width = 32, height = 30}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/explosion.png", spriteoptions)
		local spriteSequence = {
			name = "explosion",
			start = 1,
			count = 8,
			time = 180*15,
			loopCount = 1
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(3*display.contentWidth/1334,3*display.contentHeight/750)
		sprite.tag = "projectile"
		sprite.parent = o
		Physics.addBody(sprite,"dynamic",{shape = 0,0, 100*display.contentWidth/1334,0, 100*display.contentWidth/1334,120*display.contentHeight/750, 0,120*display.contentHeight/750})
		sprite:play()
		sprite.gravityScale = 0.2*display.contentHeight/750
		sprite.isSensor = true
		sprite.isBullet = true
		table.insert(o.sprites, sprite)
	elseif(g == "avatar")then
		o.width = 96
		o.height = 40
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
		--Physics.addBody(sprite,"dynamic",{outline=graphics.newOutline(4,spriteSheet,1)})
		Physics.addBody(sprite,"dynamic")
		sprite.isSensor = true
		sprite.gravityScale = 0
		sprite:scale(display.contentWidth/1334,display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "title")then
		o.width = 1500
		o.height = 1500
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 500, height = 500}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/title_screen.png", spriteoptions)
		local spriteSequence = {
			name = "title",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2.7*display.contentWidth/1334,2.7*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "titlebutton")then
	elseif(g == "results")then
	elseif(g == "game1")then
		o.width = 1500
		o.height = 1500
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
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game2")then
		o.width = 1500
		o.height = 1500
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
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game3")then
		o.width = 1500
		o.height = 1500
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
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game3t")then
		o.width = 1500
		o.height = 195
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 1305}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_deserttop.png", spriteoptions)
		local spriteSequence = {
			name = "deserttop",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game3b")then
		o.width = 1500
		o.height = 195
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 195}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_desertbottom.png", spriteoptions)
		local spriteSequence = {
			name = "desertbottom",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game1t")then
		o.width = 1500
		o.height = 195
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 1305}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_citytop.png", spriteoptions)
		local spriteSequence = {
			name = "citytop",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game1b")then
		o.width = 1500
		o.height = 195
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 195}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_citybottom.png", spriteoptions)
		local spriteSequence = {
			name = "citybottom",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game2t")then
		o.width = 1500
		o.height = 195
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 1305}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_mountainstop.png", spriteoptions)
		local spriteSequence = {
			name = "mountainstop",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "game2b")then
		o.width = 1500
		o.height = 195
		local spriteoptions = {
			frames = {
				{x = 0, y = 0, width = 1500, height = 195}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/backdrop_mountainsbottom.png", spriteoptions)
		local spriteSequence = {
			name = "mountainsbottom",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(0.8*display.contentWidth/1334,0.8*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "playbutton")then
		o.width = 60*2
		o.height = 20*2
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
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "backbutton")then
		o.width = 46*2
		o.height = 20*2
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
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "resumebutton")then
		o.width = 66*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 2, y = 68, width = 66, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "resume",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "quitbutton")then
		o.width = 44*2
		o.height = 20*2
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
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "settings")then
	elseif(g == "settingsbutton")then
		o.width = 72*2
		o.height = 20*2
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
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "firebutton")then
		o.width = 46*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 2, y = 158, width = 46, height = 22}
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
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "bombbutton")then
		o.width = 46*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 50, y = 158, width = 46, height = 22}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "bombbutton",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "pausebutton")then
		o.width = 20*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 98, y = 158, width = 20, height = 22}
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
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "creditbutton")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 76, y = 23, width = 72, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "creditbutton",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "musicbutton1")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 69, y = 67, width = 50, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "musicbutton1",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "musicbutton2")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 122, y = 67, width = 50, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "musicbutton2",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "sfxbutton1")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 47, y = 89, width = 36, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "sfxbutton1",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "sfxbutton2")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 85, y = 89, width = 36, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "sfxbutton2",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "lvlbutton1")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 71, y = 111, width = 64, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "lvlbutton1",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "lvlbutton2")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 2, y = 133, width = 64, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "lvlbutton2",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
		table.insert(o.sprites, sprite)
	elseif(g == "lvlbutton3")then
		o.width = 72*2
		o.height = 20*2
		local spriteoptions = {
			frames = {
				{x = 69, y = 133, width = 64, height = 20}
			}
		}
		local spriteSheet = graphics.newImageSheet("Assets/Sprites/buttons.png", spriteoptions)
		local spriteSequence = {
			name = "lvlbutton3",
			start = 1,
			count = 1,
			loopCount = 0
		}
		local sprite = display.newSprite(spriteSheet,spriteSequence)
		sprite:scale(2*display.contentWidth/1334,2*display.contentHeight/750)
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
			if(j.simulated == true)then
				Physics.removeBody(j)
			end
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
	return self.sprites[1].x
end
function Graphic:SetX(x)
	if(self~=nil)then
		self.x = x
		for i, j in ipairs(self.sprites) do
			j.x = x
		end
	end
end
function Graphic:GetY()
	return self.sprites[1].y
end
function Graphic:SetY(y)
	self.y = y
	for i, j in ipairs(self.sprites) do
		j.y = y
	end
end
function Graphic:GetHeight()
	return self.width
end
function Graphic:GetWidth()
	return self.height
end
function Graphic:GetRotation()
	return self.angle
end

function Graphic:addEventListener(eventname, listener)
	--print(#self.sprites)
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
