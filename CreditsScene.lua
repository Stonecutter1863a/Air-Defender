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

local backgrounds
local distBackdrops

local exiting
local title

local credittimer
local yScale = display.contentHeight/750
local xScale = display.contentWidth/1334

function Update()
	if(exiting == false)then
		creditdisplay.y = creditdisplay.y - (2*yScale)
		credittimer = credittimer + 1
		if(credittimer < 1100)then
			timer.performWithDelay(15, Update, 1)
		else
			exiting = true
			timer.cancel("Update")
			composer.gotoScene("TitleScene", {effect = "fade",time = 900,params = {settings = settings}})
		end
		
		for i=1,#backgrounds,1 do
			backgrounds[i]:SetX(backgrounds[i]:GetX()-(1.8 * display.contentWidth / 1334))
			if(backgrounds[i]:GetX() < -(600 * display.contentWidth / 1334))then
				backgrounds[i]:SetX((4190 * display.contentWidth / 1334))
			end
		end
		for i=1,#distBackdrops,1 do
			distBackdrops[i]:SetX(distBackdrops[i]:GetX()-(0.8 * display.contentWidth / 1334))
			if(distBackdrops[i]:GetX() < -(600 * display.contentWidth / 1334))then
				distBackdrops[i]:SetX((4190 * display.contentWidth / 1334))
			end
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
		timer.cancel("UpdateGame")

		settings = event.params.settings
		
		exiting = false
		credittimer = 0
		
		backgrounds = {}
		distBackdrops = {}
		
		if(settings:WhatLevel() == 1)then
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game1t"))
			
			table.insert(backgrounds, Graphic:new({},0,0,"game1b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game1b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game1b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game1b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game1b"))
		elseif(settings:WhatLevel() == 2)then
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game2t"))
			
			table.insert(backgrounds, Graphic:new({},0,0,"game2b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game2b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game2b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game2b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game2b"))
		else
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			table.insert(distBackdrops, Graphic:new({},0,0,"game3t"))
			
			table.insert(backgrounds, Graphic:new({},0,0,"game3b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game3b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game3b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game3b"))
			table.insert(backgrounds, Graphic:new({},0,0,"game3b"))
		end
		backgrounds[1]:SetX(0)
		backgrounds[1]:SetY(display.contentHeight - (80*yScale))
		backgrounds[2]:SetX(1200*xScale)
		backgrounds[2]:SetY(display.contentHeight - (80*yScale))
		backgrounds[3]:SetX(2399*xScale)
		backgrounds[3]:SetY(display.contentHeight - (80*yScale))
		backgrounds[4]:SetX(3598*xScale)
		backgrounds[4]:SetY(display.contentHeight - (80*yScale))
		backgrounds[5]:SetX(4797*xScale)
		backgrounds[5]:SetY(display.contentHeight - (80*yScale))
		
		
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

   		title = MenuButton:new(o, 0, "TitleScene", Graphic:new({},0,0,"backbutton"))
   		title:SetPos(display.contentCenterX/(3*display.contentWidth/1334), display.contentCenterY + (190 * display.contentHeight / 750))
		
   
		
		credittext = "Original Concept: Abigail Roberts\n\nArt Director: Abigail Roberts\n\nSprite Artists: Adigail Roberts, Dalton Johnson\n\nSound Director: Dian Hernandez\n\nProgrammers: Joshua Tirone, Kyra Wharton\n\nLevel Music: AShamaluevMusic\nGame Over Sound Effect: Freak Gamer\nTitle Theme: Eric Matyas\n\nAll other sound effects were designed with BFXR software."
		
		
		
		creditdisplay = display.newText({
			text=credittext,
			x=display.contentCenterX,
			y=(display.contentHeight*5/3),
			width = (display.contentWidth*2/3)*display.contentWidth/1334,
			align = "center"
		})
		
   elseif ( phase == "did" ) then
		timer.performWithDelay(15, Update, 1)
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
	
		for i=1,#backgrounds,1 do
			local j = backgrounds[#backgrounds]
			table.remove(backgrounds, #backgrounds)
			j:Destroy()
		end
		for i=1,#distBackdrops,1 do
			local j = distBackdrops[#distBackdrops]
			table.remove(distBackdrops, #distBackdrops)
			j:Destroy()
		end
   
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

