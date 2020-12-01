--[[
	ResultsScene.lua
	
	The game over screen for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
local Graphic = require("Graphic")

local creditText
local creditOptions
local creditDisplay

local background

local exiting
local title

local credittimer

function Update()
	if(exiting == false)then
		creditdisplay.y = creditdisplay.y - 2
		credittimer = credittimer + 1
		if(credittimer < 800)then
			timer.performWithDelay(15, Update, 1)
		else
			exiting = true
			timer.cancel("Update")
			composer.gotoScene("TitleScene", {effect = "fade",time = 900,params = {settings = settings}})
		end
	
	end
end
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

		settings = event.params.settings
		
		exiting = false
		credittimer = 0
		
		if(settings.level == 1)then
			background = Graphic:new({},0,0,"game1")
		elseif(settings.level == 2)then
			background = Graphic:new({},0,0,"game2")
		else
			background = Graphic:new({},0,0,"game3")
		end
		background:SetX(750)
		background:SetY(display.contentHeight)

   		title = MenuButton:new(o, 0, "TitleScene", Graphic:new({},0,0,"backbutton"))
   		title:SetPos(display.contentCenterX - 500, display.contentCenterY + 190)
		
   
		
		credittext = "Original Concept: Abigail Roberts\n\nArt Director: Abigail Roberts\n\nSprite Artists: Adigail Roberts, Dalton Johnson\n\nSound Director: Dian Hernandez\n\nProgrammers: Joshua Tirone, Kyra Wharton\n\nLevel Music: AShamaluevMusic\nGame Over Sound Effect: Freak Gamer\nTitle Theme: Eric Matyas\n\nAll other sound effects were designed with BFXR software."
		
		
		
		creditdisplay = display.newText({
			text=credittext,
			x=display.contentCenterX,
			y=display.contentHeight*5/3,
			width = display.contentWidth*2/3,
			align = "center"
		})
		
		timer.performWithDelay(15, Update, 1)
   elseif ( phase == "did" ) then
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
		exiting = true
		timer.cancel("Update")
		
		title:Destroy()
		title=nil
	
		creditdisplay:removeSelf()
		creditdisplay = nil
	
		background:Destroy()
   
   elseif ( phase == "did" ) then
   
	local sceneGroup = self.view
 
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

