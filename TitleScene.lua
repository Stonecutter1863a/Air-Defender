--[[
	TitleScene.lua
	
	The title screen for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
local Settings = require("Settings")
local Graphic = require("Graphic")

local music
local settings
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
		if(event.params ~= nil and event.params.settings ~= nil)then
			settings = event.params.settings
		else
			settings = Settings:new()
			settings.level = 1
			settings.sfx = true
			settings.music = true
		end

   		play = MenuButton:new(o, 0, "GameScene", Graphic:new({},0,0,"playbutton"))
   		play:SetPos(display.contentCenterX, display.contentCenterY - 30)
		play:SetParams({settings = settings})
   
   		options = MenuButton:new(o, 0, "SettingsScene",Graphic:new({},0,0,"settingsbutton"))
   		options:SetPos(display.contentCenterX, display.contentCenterY + 30)
		options:SetParams({settings = settings})
		
   elseif ( phase == "did" ) then
	music = audio.loadSound("Assets/Sounds/MenuSong/Sector-Off-Limits_Looping.mp3")
	audio.play(music, {channel = 1, loops = -1})
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
   elseif ( phase == "did" ) then
   
	local sceneGroup = self.view
	play:Destroy()
	play=nil
	options:Destroy()
	options=nil
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
	local sceneGroup = self.view
	
	--play:Destroy()
	--play=nil
	--options:Destroy()
	--options=nil
	
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene

