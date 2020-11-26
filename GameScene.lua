--[[
	GameScene.lua
	
	The main gameplay scene for Air Defender
]]

local composer = require( "composer" )
local scene = composer.newScene()

local params

local Physics = require("physics")

local framerateControl = 15

local SteeringSlider = require("SteeringSlider")
local FireButton = require("FireButton")
local MenuButton = require("MenuButton")
--local PauseButton = require("PauseButton")
--local Avatar = require("PlayerAvatar")
--local Spawner = require("CombatantSpawner")
--local Player = require("Player")
--local Enemies = require("Enemies")
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

function Update()
	if not(pause:IsPaused())then
		playerAvatar:Steer(steering:GetInput())
		playerAvatar:Update()
		
		if(fire:IsPressed() == true)then
			local projectile = playerAvatar:UseWeapon()
			if not (projectile == nil) then
				print("Fired projectile!")
				--projectiles[tostring(#projectiles + 1)] = projectile
				
				print(#projectiles)
				for i, j in ipairs(projectiles) do
					print(j.graphic)
				end
				table.insert(projectiles, projectile)
				print(#projectiles)
				for i, j in ipairs(projectiles) do
					print(j.graphic)
				end
			end
		end
		
		for i, j in ipairs(projectiles) do
			j:Update()
			--print("Updated projectile!")
			if(false)then
				j:Delete()
			elseif(false) then
				j:Delete()
			end
		end
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
	
	enemies = {}
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
	fire = FireButton:new()
	fire:SetPos(fire.interface.width, (display.contentHeight*2/5) - (fire.interface.height/2))
	
end
 
 --##
 function debugFunc()
 end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
		
   elseif ( phase == "did" ) then
   
		timer.performWithDelay(framerateControl, Update, 0)
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
   elseif ( phase == "did" ) then
   
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
