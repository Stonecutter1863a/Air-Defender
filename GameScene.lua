--[[
	GameScene.lua
	
	The main gameplay scene for Air Defender
]]

local composer = require( "composer" )
local scene = composer.newScene()

local params

local Physics = require("physics")

local framerateControl = 15
local exiting = false
local paused

local SteeringSlider = require("SteeringSlider")
local FireButton = require("FireButton")
local MenuButton = require("MenuButton")
--local Spawner = require("CombatantSpawner")
--local Player = require("Player")
local AI = require("AI")
local Combatant = require("Combatant")
local Graphic = require("Graphic")

local steering
local fire
local pause
local playerAvatar
local gameTime
local settings
local spawner
local player
local enemies
local projectiles
local ai

function Update()
	--print(pause:IsPaused())
	if (pause:IsPaused() == false)then
		gameTime = gameTime + 1
		playerAvatar:Steer(steering:GetInput())
		playerAvatar:Update()
		
		if(fire:IsPressed() == true)then
			local projectile = playerAvatar:UseWeapon()
			if not (projectile == nil) then
				table.insert(projectiles, projectile)
			end
		end
		
		for i, j in ipairs(projectiles) do
			j:Update()
			if(
				j:GetPosX() > display.contentWidth
				or j:GetPosX() < 0
				or j:GetPosY() > display.contentHeight
				or j:GetPosY() < 0
			)then
				table.remove(projectiles, i)
				j:Delete()
			else
				for k,l in ipairs(enemies)do
					if(
						j:GetPosY() <= l:GetPosY()+l:GetHeight()
						and j:GetPosY() >= l:GetPosY()-l:GetHeight()
						and j:GetPosX() <= l:GetPosX()+l:GetWidth()
						and j:GetPosX() >= l:GetPosX()-l:GetWidth()
					)then
						table.remove(projectiles, i)
						j:Delete()
						if (l:Damage(1) == true)then
							table.remove(enemies, k)
							table.remove(ai, k)
						end
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
				j:Update()
				if(
					j:GetPosX() < 0
					or j:GetPosY() > display.contentHeight
					or j:GetPosY() < 0
				)then
					table.remove(enemies, i)
					j:Delete()
					local a = ai[i]
					table.remove(ai, i)
					a:Delete()
				end
			end
		end
		
	end
	if(exiting ~= true)then
		timer.performWithDelay(framerateControl, Update, 1, "update")
	end
end

function scene:Unpause()
		pause:Unpause()
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
		
	enemies = {}
	ai = {}
	projectiles = {}
	gameTime = 0
	steering = SteeringSlider:new()
	steering.interface.x = display.contentWidth - (steering.interface.width * 2)
	steering.interface.y = (display.contentHeight - steering.interface.height)/2
	--local g = display.newRect(0, 0, 100, 100)
	--g:setFillColor(1,1,1)
	local g = Graphic:new({},0,0)
	playerAvatar = Combatant:new({},3,true,0,15,1,g)
	playerAvatar:SetPos(display.contentWidth/5, display.contentHeight/2)
	spawner = "NOT IMPLEMENTED"
	pause = MenuButton:new({}, 1, "PauseScene")
	pause:SetPos(pause.interface.width, (display.contentHeight*4/5) - (pause.interface.height/2))
	fire = FireButton:new()
	fire:SetPos(fire.interface.width, (display.contentHeight*2/5) - (fire.interface.height/2))
	
	exiting = false
	paused = false
	gameTime = 0
	timer.performWithDelay(framerateControl, Update, 1)
	
	g = Graphic:new({},0,0)
	table.insert(enemies, Combatant:new({},1,false,nil,3,1,g))
	enemies[1]:SetPos(display.contentWidth-1, display.contentHeight/2)
	
	table.insert(ai, AI:new(o,0))
   elseif ( phase == "did" ) then
   
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
	exiting = true
	timer.cancel("update")
   elseif ( phase == "did" ) then
		fire:Destroy()
		pause:Destroy()
		for i,j in ipairs(projectiles) do
			table.remove(projectiles, i)
			j:Delete()
		end
		for i,j in ipairs(enemies) do
			table.remove(enemies, i)
			j:Delete()
		end
		for i,j in ipairs(ai) do
			table.remove(ai, i)
			j:Delete()
		end
		playerAvatar:Delete()
		steering:Destroy()
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
