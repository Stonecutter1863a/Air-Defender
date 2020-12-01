--[[
	TitleScene.lua
	
	The title screen for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
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

   		play = MenuButton:new(o, 2, "GameScene", Graphic:new({},0,0,"resumebutton"))
   		play:SetPos(display.contentCenterX, display.contentCenterY - 30)
   
   		title = MenuButton:new(o, 0, "TitleScene",Graphic:new({},0,0,"quitbutton"))
   		title:SetPos(display.contentCenterX, display.contentCenterY + 30)
		
		--event.parent:Pause()
		
   elseif ( phase == "did" ) then
   
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
   elseif ( phase == "did" ) then
   
		event.parent:Unpause()
   
	local sceneGroup = self.view
	play:Destroy()
	play=nil
	title:Destroy()
	title=nil
 
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
	local sceneGroup = self.view
	
	--play:Destroy()
	--play=nil
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

