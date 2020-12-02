--[[
	SettingsScene.lua
	
	The options menu for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
local OptionButton = require("OptionButton")
local Graphic = require("Graphic")
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

   		title = MenuButton:new(o, 0, "TitleScene", Graphic:new({},0,0,"backbutton"))
   		title:SetPos(display.contentCenterX, display.contentCenterY + 190)
		
		musicsetting = OptionButton:new(o, 1)
   		musicsetting:SetPos(display.contentCenterX, display.contentCenterY + 40)

   		sfxsetting = OptionButton:new(o, 2)
   		sfxsetting:SetPos(display.contentCenterX, display.contentCenterY + 90)

   		levelsetting = OptionButton:new(o, 3)
   		levelsetting:SetPos(display.contentCenterX, display.contentCenterY + 140)
   
   elseif ( phase == "did" ) then
   
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
   elseif ( phase == "did" ) then
   
	local sceneGroup = self.view
	title:Destroy()
	title=nil
	musicsetting:Destroy()
	musicsetting=nil
	sfxsetting:Destroy()
	sfxsetting=nil
	levelsetting:Destroy()
	levelsetting=nil
 
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
	local sceneGroup = self.view
	
	--title:Destroy()
	--title=nil
	
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene

