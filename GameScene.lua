--[[
	GameScene.lua
	
	The main gameplay scene for Air Defender
]]

local composer = require( "composer" )
local scene = composer.newScene()

local params

Physics = require("physics")

local framerateControl = 15
local exiting = false
local paused

local groundenemyspeed = 2.2 * display.contentWidth / 1334
local airenemyspeed = 3 * display.contentWidth / 1334

local xScale = display.contentWidth / 1334
local yScale = display.contentHeight / 750

local groundspeed = 1.8 * xScale
local backspeed = 0.8 * xScale

local SteeringSlider = require("SteeringSlider")
local FireButton = require("FireButton")
local MenuButton = require("MenuButton")
local AI = require("AI")
local Combatant = require("Combatant")
local Graphic = require("Graphic")
	local Weapon = require("Weapon")

local steering
local fire
local pause
local playerAvatar
local gameTime
local settings
local spawner
local enemies
local projectiles
local explosions
local ai
local score
local difficulty
local health

local backdrops
local distBackdrops

local enemyspawncenter
local enemyspawnnumber
local enemyspawntypeone
local enemyspawntypetwo
local enemyspawntypethree
local enemyspawntypefour
local enemytypeweightone
local enemytypeweighttwo
local enemytypeweightthree
local enemytypeweightfour
local enemyspawntime

local sounds = {}
--[[
	channel 1 is for background music
	channel 2 is for weapon firing
	channel 3 is for damage sounds
	channel 4 is for explosions
	channel 5 is for enemies making it past the player
]]
local gameOverVolume
local menuVolume
local backgroundVolume
local damageVolume
local enemymissVolume
local explosionVolume
local fireVolume


local timerDefualtText
local timerDefault
local timerActual
local scoreDefualtText
local scoreDefault
local scoreActual
local healthDefualtText
local healthDefault
local healthActual

function GameOver()
	timer.cancel("Update")
						local options = {
							effect = "fade",
							time = 200,
							params = {
							gametime = gameTime,
							score = score,
							settings = settings
							}
						}
						composer.gotoScene("ResultsScene", options)
end

function SpawnEnemy(enemytype)
	if(enemytype == 0)then
		g = Graphic:new({},0,0)
		table.insert(enemies, Combatant:new({},1,false,nil,groundenemyspeed,1,Graphic:new(o,0,0,"grunt")))
		enemies[#enemies]:SetPos(display.contentWidth-(1*xScale), (display.contentHeight-(48*yScale)))
	
		table.insert(ai, AI:new(o,0))
	elseif(enemytype == 1)then
		g = Graphic:new({},0,0)
		table.insert(enemies, Combatant:new({},1,false,nil,airenemyspeed,1,Graphic:new(o,0,0,"drone")))
		enemies[#enemies]:SetPos(display.contentWidth-(1*xScale), enemyspawncenter + (math.random()*(display.contentHeight)/(5*yScale)) - (math.random()*(display.contentHeight)/(5*yScale)))
	
		table.insert(ai, AI:new(o,0))
	elseif(enemytype == 2)then
		g = Graphic:new({},0,0)
		table.insert(enemies, Combatant:new({},1,false,nil,airenemyspeed*2,1,Graphic:new(o,0,0,"fastdrone")))
		enemies[#enemies]:SetPos(display.contentWidth-(1*xScale), enemyspawncenter + (math.random()*(display.contentHeight)/(5*yScale)) - (math.random()*(display.contentHeight)/(5*yScale)))
	
		table.insert(ai, AI:new(o,0))
	elseif(enemytype == 3)then
		g = Graphic:new({},0,0)
		table.insert(enemies, Combatant:new({},1,false,nil,airenemyspeed,1,Graphic:new(o,0,0,"smartdrone")))
		enemies[#enemies]:SetPos(display.contentWidth-(1*xScale), enemyspawncenter + ((math.random()*(display.contentHeight)/(5*yScale)) - (math.random()*(display.contentHeight)/(5*yScale))))
	
		table.insert(ai, AI:new(o,1))
	end
	
	--Physics.addBody(enemies[#enemies], "dynamic")
end

function ChooseEnemyType()
	if(difficulty > 3)then
		return math.random(0,3)
	else
		return math.random(0,difficulty)
	end
end

function SpawnEnemies()
	if(enemyspawnnumber == 0)then
		enemyspawncenter = math.random(96*yScale,display.contentHeight-(96*yScale))
		enemyspawnnumber = math.random(0,difficulty)
		enemyspawntypeone = ChooseEnemyType()
		enemyspawntypetwo = ChooseEnemyType()
		enemyspawntypethree = ChooseEnemyType()
		enemyspawntypefour = ChooseEnemyType()
		enemytypeweightone = math.random() + (10/difficulty)
		enemytypeweighttwo = math.random() + (5/difficulty)
		enemytypeweightthree = math.random() + (2/difficulty)
		enemytypeweightfour = math.random()
		if(difficulty < 4)then
			enemyspawntime = gameTime + math.random(90, (8-difficulty)*30)
		else
			enemyspawntime = gameTime + math.random(30, 120)
		end
	elseif(gameTime - enemyspawntime > 30 * math.random(1, (3/difficulty)+1))then
		local enemyoneweight = enemytypeweightone + math.random()
		local enemytwoweight = enemytypeweighttwo + math.random()
		local enemythreeweight = enemytypeweightthree + math.random()
		local enemyfourweight = enemytypeweightfour + math.random()
		local enemytype = math.max(enemyoneweight, enemytwoweight, enemythreeweight, enemyfourweight)
		if(enemytype == enemyoneweight)then
			SpawnEnemy(enemyspawntypeone)
		elseif(enemytype == enemytwoweight)then
			SpawnEnemy(enemyspawntypetwo)
		elseif(enemytype == enemythreeweight)then
			SpawnEnemy(enemyspawntypethree)
		else
			SpawnEnemy(enemyspawntypefour)
		end
		
		enemyspawntime = gameTime
		enemyspawnnumber = enemyspawnnumber - 1
	end
end

function UpdateGame()
	--print(pause:IsPaused())
	if (pause:IsPaused() == false)then
		audio.resume(1)
		gameTime = gameTime + 1
		
		if(math.floor(gameTime / 3600) < 10)then
			timerActual.text = timerDefualtText .. "0" .. (math.floor(gameTime / 3600) .. ":")
		else
			timerActual.text = timerDefualtText .. (math.floor(gameTime / 3600) .. ":")
		end
		if(math.floor(gameTime % 3600/60) < 10)then
			timerActual.text = timerActual.text .. "0" .. (math.floor(gameTime % 3600/60))
		else
			timerActual.text = timerActual.text .. (math.floor(gameTime % 3600/60))
		end
		
		scoreActual.text = scoreDefualtText .. (score)
		healthActual.text = healthDefualtText .. (health)
		playerAvatar:Steer(steering:GetInput())
		playerAvatar:Update()
		
		if(fire:IsPressed() == true)then
			local projectile = playerAvatar:UseWeapon(1)
			if(projectile ~= nil and settings:IsSFX() == true)then
				audio.play(sounds.fire, {channel = 2, loops = 0})
			end
			if not (projectile == nil) then
				table.insert(projectiles, projectile)
			end
		end
		if(bomb:IsPressed() == true)then
			local projectile = playerAvatar:UseWeapon(2)
			if(projectile ~= nil and settings:IsSFX() == true)then
				audio.play(sounds.explosion, {channel = 2, loops = 0})
			end
			if not (projectile == nil) then
				table.insert(projectiles, projectile)
			end
		end
		
		local n = #projectiles
		for i=1,n,1 do
		--print("updating projectile")
			local j = projectiles[n-(i-1)]
			--local j = projectiles[i]
			if(j~= nil)then
				j:Update()
				--print(j:GetPosX())
				if(j:GetPosX()~=nil)then
					if(j:GetPosX() > display.contentWidth or j:GetPosY() > display.contentHeight)then
						--print("it went too far!")
						table.remove(projectiles, n-(i-1))
						j:Destroy()
					elseif(j:BulletType() ~= "defualt" and j:HasExploded() == true)then
						--print("Exploded!")
						table.remove(projectiles, n-(i-1))
						--print(j:GetExplosion())
						table.insert(explosions, j:GetExplosion())
						j:Destroy()
						--print("cleaned up bombshell")
					elseif(j.isBomb ~= nil and j.GetPosY()~= nil and j.GetPosY() > display.contentHeight*9/10)then
						j:Explode()
					elseif(j.graphics ~= nil
							and
							(j:GetPosX() > display.contentWidth
							or j:GetPosX() < 0
							or j:GetPosY() > display.contentHeight
							or j:GetPosY() < 0)
					)then
						--print("it went too far!")
						table.remove(projectiles, n-(i-1))
						j:Destroy()
					--[[else
						for k,l in ipairs(enemies)do
							if(
								j:GetPosY() <= l:GetPosY()+l:GetHeight()
								and j:GetPosY() >= l:GetPosY()-l:GetHeight()
								and j:GetPosX() <= l:GetPosX()+l:GetWidth()
								and j:GetPosX() >= l:GetPosX()-l:GetWidth()
							)then	-- projectile has collided with the enemy
								if (l:Damage(1) == true)then
									l:Delete()
									table.remove(enemies, k)
									table.remove(ai, k)
									audio.play(sounds.explosion, {channel = 4, loops = 0})
								end
								score = score + 100
							end
						end]]
					end
				end
			end
		end
		
		
		for i, j in ipairs(enemies) do
			if(j == nil)then
				table.remove(enemies, i)
				j:Delete()
				local a = ai[i]
				table.remove(ai, i)
				a:Delete()
			else
				local x = ai[i]:Update()
				if x ~= nil then
					j:Steer(x[2])
				end
				j:Update()
				if(j.graphic.sprites[1].collided == true)then
					if (j:Damage(1) == true)then
						j:Delete()
						table.remove(enemies, i)
						table.remove(ai, i)
						if(settings:IsSFX() == true)then
							audio.play(sounds.damage, {channel = 4, loops = 0})
						end
					end
					score = score + 10
				elseif(
					j:GetPosX() < 0
				)then
					health = health - 1
					table.remove(enemies, i)
					j:Delete()
					local a = ai[i]
					table.remove(ai, i)
					a:Delete()
					if(settings:IsSFX() == true)then
						audio.play(sounds.enemymiss, {channel = 5, loops = 0})
					end
					if(playerAvatar:Damage(1))then	-- player has lost
						audio.stop(1)
						if(settings:IsSFX() == true)then
							audio.play(sounds.gameOver, {channel = 1, loops = 0, onComplete = GameOver()})
						else
							GameOver()
						end
					end
				end
			end
		end
		local n = #explosions
		for i=1,#explosions,1 do
			if(explosions[n-(i-1)] == nil)then
				table.remove(explosions[n-(i-1)])
			end
		end
		
		--[[
		enemy spawning logic goes here
		]]
		difficulty = (gameTime/60)/8
		
		SpawnEnemies()
		
		backdrops[1]:SetX(backdrops[1]:GetX()-(groundspeed))
		backdrops[2]:SetX(backdrops[2]:GetX()-(groundspeed))
		backdrops[3]:SetX(backdrops[3]:GetX()-(groundspeed))
		backdrops[4]:SetX(backdrops[4]:GetX()-(groundspeed))
		backdrops[5]:SetX(backdrops[5]:GetX()-(groundspeed))
		if(backdrops[1]:GetX() < -(600*xScale))then
			backdrops[1]:SetX(4190*xScale)
		elseif(backdrops[2]:GetX() < -(600*xScale))then
			backdrops[2]:SetX(4190*xScale)
		elseif(backdrops[3]:GetX() < -(600*xScale))then
			backdrops[3]:SetX(4190*xScale)
		elseif(backdrops[4]:GetX() < -(600*xScale))then
			backdrops[4]:SetX(4190*xScale)
		elseif(backdrops[5]:GetX() < -(600*xScale))then
			backdrops[5]:SetX(4190*xScale)
		end
		distBackdrops[1]:SetX(distBackdrops[1]:GetX()-(backspeed))
		distBackdrops[2]:SetX(distBackdrops[2]:GetX()-(backspeed))
		distBackdrops[3]:SetX(distBackdrops[3]:GetX()-(backspeed))
		distBackdrops[4]:SetX(distBackdrops[4]:GetX()-(backspeed))
		distBackdrops[5]:SetX(distBackdrops[5]:GetX()-(backspeed))
		if(distBackdrops[1]:GetX() < -(600*xScale))then
			distBackdrops[1]:SetX(4190*xScale)
		elseif(distBackdrops[2]:GetX() < -(600*xScale))then
			distBackdrops[2]:SetX(4190*xScale)
		elseif(distBackdrops[3]:GetX() < -(600*xScale))then
			distBackdrops[3]:SetX(4190*xScale)
		elseif(distBackdrops[4]:GetX() < -(600*xScale))then
			distBackdrops[4]:SetX(4190*xScale)
		elseif(distBackdrops[5]:GetX() < -(600*xScale))then
			distBackdrops[5]:SetX(4190*xScale)
		end
	else
		audio.pause(1)
	end
	if(exiting ~= true)then
		timer.performWithDelay(framerateControl, UpdateGame, 1, "UpdateGame")
	end
end

function scene:Unpause()
		pause:Unpause()
		Physics.start()
		for i=1,#explosions,1 do
			local j = explosions[#explosions]
			if(j.graphics~=nil)then
				j.graphics[1].sprites[1]:play()
				j.graphics[2].sprites[1]:play()
			end
		end
		for i=1,#projectiles,1 do
			local j = projectiles[#projectiles]
			if(j.graphic ~= nil)then j.graphic.sprites[1]:play() end
		end
end

function scene:Pause()
	Physics.pause()
		for i=1,#explosions,1 do
		print("projectile paused")
			local j = explosions[#explosions+1-i]
			if(j.graphics~=nil)then
				j.graphics[1].sprites[1]:pause()
				j.graphics[2].sprites[1]:pause()
			end
		end
		for i=1,#projectiles,1 do
		print("projectile paused")
			local j = projectiles[#projectiles+1-i]
			if(j.graphic ~= nil)then j.graphic.sprites[1]:pause() end
		end
end

--[[function SetDifficulty()
end]]

--[[function Begin()
end]]

 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
   params = event.params
	if(params ~= nil) then
		if(params.settings ~= nil) then
			settings = params.settings
		else
		end
	else
	end
	
	--SetDifficulty(settings)
	
end
 
 --##
 function debugFunc()
 end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
		
		settings = event.params.settings
		
		Physics.start()
		--Physics.setGravity(0,0)
		
		audio.stop()
		backdrops = {}
		distBackdrops = {}
		if(settings:WhatLevel() == 1)then
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			
			table.insert(backdrops, Graphic:new({},0,0,"game1b"))
			table.insert(backdrops, Graphic:new({},0,0,"game1b"))
			table.insert(backdrops, Graphic:new({},0,0,"game1b"))
			table.insert(backdrops, Graphic:new({},0,0,"game1b"))
			table.insert(backdrops, Graphic:new({},0,0,"game1b"))
		elseif(settings:WhatLevel() == 2)then
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			
			table.insert(backdrops, Graphic:new({},0,0,"game2b"))
			table.insert(backdrops, Graphic:new({},0,0,"game2b"))
			table.insert(backdrops, Graphic:new({},0,0,"game2b"))
			table.insert(backdrops, Graphic:new({},0,0,"game2b"))
			table.insert(backdrops, Graphic:new({},0,0,"game2b"))
		else
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			
			table.insert(backdrops, Graphic:new({},0,0,"game3b"))
			table.insert(backdrops, Graphic:new({},0,0,"game3b"))
			table.insert(backdrops, Graphic:new({},0,0,"game3b"))
			table.insert(backdrops, Graphic:new({},0,0,"game3b"))
			table.insert(backdrops, Graphic:new({},0,0,"game3b"))
		end
		backdrops[1]:SetX(0)
		backdrops[1]:SetY(display.contentHeight - (80*yScale))
		backdrops[2]:SetX(1200*xScale)
		backdrops[2]:SetY(display.contentHeight - (80*yScale))
		backdrops[3]:SetX(2399*xScale)
		backdrops[3]:SetY(display.contentHeight - (80*yScale))
		backdrops[4]:SetX(3598*xScale)
		backdrops[4]:SetY(display.contentHeight - (80*yScale))
		backdrops[5]:SetX(4797*xScale)
		backdrops[5]:SetY(display.contentHeight - (80*yScale))
		
		
		distBackdrops[1]:SetX(0)
		distBackdrops[1]:SetY(display.contentHeight - (650*yScale))
		distBackdrops[2]:SetX(1200*xScale)
		distBackdrops[2]:SetY(display.contentHeight - (650*yScale))
		distBackdrops[3]:SetX(2399*xScale)
		distBackdrops[3]:SetY(display.contentHeight - (650*yScale))
		distBackdrops[4]:SetX(3598*xScale)
		distBackdrops[4]:SetY(display.contentHeight - (650*yScale))
		distBackdrops[5]:SetX(4797*xScale)
		distBackdrops[5]:SetY(display.contentHeight - (650*yScale))
		
		
		
		
	enemies = {}
	ai = {}
	projectiles = {}
	explosions = {}
	
	steering = SteeringSlider:new()
	steering.interface.x = display.contentWidth - (steering.interface.width * (2))
	steering.interface.y = (display.contentHeight - (steering.interface.height))/(2)
	local g
	if(settings:WhatShip() == 1)then
		g = Graphic:new({},0,0,"avatar")
	elseif(settings:WhatShip() == 2)then
		g = Graphic:new({},0,0,"avatar2")
	else
		g = Graphic:new({},0,0,"avatar3")
	end
	playerAvatar = Combatant:new({},3,true,{Weapon:new({}, "l","projectile"),Weapon:new({}, "b","bomb")},15*display.contentHeight/(750),1,g)
	playerAvatar:SetPos(display.contentWidth/(6), display.contentHeight/(2))
	
	pause = MenuButton:new({}, 1, "PauseScene", Graphic:new({},0,0,"pausebutton"))
	pause:SetPos((display.contentWidth/(14)), (display.contentHeight*((6/10))) - (pause.interface:GetHeight()/(2)) - (display.contentHeight/(9)))
	
	fire = FireButton:new({},Graphic:new({},0,0,"firebutton"))
	fire:SetPos((display.contentWidth/(14)), (display.contentHeight*((4/10))) - (fire.interface:GetHeight()/(2)) - (display.contentHeight/(9)))
	
	bomb = FireButton:new({}, Graphic:new({},0,0,"bombbutton"))
	bomb:SetPos((display.contentWidth/(14)), (display.contentHeight*((5/10))) - (fire.interface:GetHeight()/(2)) - (display.contentHeight/(9)))
	
	
	exiting = false
	paused = false
	gameTime = 0
	difficulty = 0
	health = 3
	
	enemyspawncenter = 0
	enemyspawnnumber = 0
	enemyspawntype = 0
	enemyspawntime = 0
	
	
	score = 0
	
	sounds = {}
	sounds.gameOver = audio.loadSound("Assets/Sounds/GameOver/GameOver.m4a")
	sounds.background = audio.loadSound("Assets/Sounds/BackgroundMusic/Vip-AShamaluevMusic.mp3")
	sounds.damage = audio.loadSound("Assets/Sounds/SoundFX/Damage.wav")
	sounds.enemymiss = audio.loadSound("Assets/Sounds/SoundFX/EnemyLeaves.wav")
	sounds.explosion = audio.loadSound("Assets/Sounds/SoundFX/Explosion.wav")
	sounds.fire = audio.loadSound("Assets/Sounds/SoundFX/Projectile.wav")
	
	gameOverVolume = 1
	menuVolume = 1
	backgroundVolume = 1
	damageVolume = 1
	enemymissVolume = 1
	explosionVolume = 1
	fireVolume = 1
	
	--[[
	g = Graphic:new({},0,0)
	table.insert(enemies, Combatant:new({},1,false,nil,3,1,g))
	enemies[1]:SetPos(display.contentWidth-1, display.contentHeight/2)
	
	table.insert(ai, AI:new(o,0))]]
	
	math.randomseed(os.time())
	
	
	timerDefualtText = "Time   :  "
	timerDefault =
	{
		text = timerDefualtText,
		x = 160*xScale,
		y = 84*yScale,
		fontSize = 24*xScale,
		width = 200*xScale,
		align = "left"
	}
	timerActual = display.newText(timerDefault)
	
	scoreDefualtText = "Score  :  "
	scoreDefault =
	{
		text = scoreDefualtText,
		x = 160*xScale,
		y = 56*yScale,
		width = 200*xScale,
		fontSize = 24*xScale,
		align = "left"
	}
	scoreActual = display.newText(scoreDefault)
	
	healthDefualtText = "Health :  "
	healthDefault =
	{
		text = healthDefualtText,
		x = 160*xScale,
		y = 112*yScale,
		width = 200*xScale,
		fontSize = 24*xScale,
		align = "left"
	}
	healthActual = display.newText(healthDefault)
	
	timer.performWithDelay(framerateControl, UpdateGame, 1)
   elseif ( phase == "did" ) then
	if(settings:IsMusic() == true)then
		audio.play(sounds.background, {channel = 1, loops = -1})
	else
		audio.pause(1)
	end
	
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
	exiting = true
	timer.cancel("UpdateGame")
	audio.stop()
   elseif ( phase == "did" ) then
	timer.cancel("UpdateGame")
		fire:Destroy()
		bomb:Destroy()
		pause:Destroy()
		for i=1,#enemies,1 do
			local j = enemies[#enemies]
			table.remove(enemies, #enemies)
			j:Delete()
		end
		for i=1,#ai,1 do
			local j = ai[#ai]
			table.remove(ai, #ai)
			j:Delete()
		end
		for i=1,#projectiles,1 do
			local j = projectiles[#projectiles]
			table.remove(projectiles, #projectiles)
			j:Destroy()
		end
		for i=1,#explosions,1 do
			local j = explosions[#explosions]
			table.remove(explosions, #explosions)
			if(j.graphics~=nil and j.Destroy ~= nil)then
				j:Destroy()
				j = nil
			else
				j = nil
			end
		end
		for i=1,#backdrops,1 do
			local j = backdrops[#backdrops]
			table.remove(backdrops, #backdrops)
			j:Destroy()
		end
		for i=1,#distBackdrops,1 do
			local j = distBackdrops[#distBackdrops]
			table.remove(distBackdrops, #distBackdrops)
			j:Destroy()
		end
		if(playerAvatar ~= nil and playerAvatar.Delete ~= nil)then
			playerAvatar:Delete()
		end
		steering:Destroy()
		
		timerActual.text = ""
		timerActual:removeSelf()
		timerActual = nil
		scoreActual.text = ""
		scoreActual:removeSelf()
		scoreActual = nil
		healthActual.text = ""
		healthActual:removeSelf()
		healthActual = nil
		
		Physics.stop()
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene
