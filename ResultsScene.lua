--[[
	ResultsScene.lua
	
	The game over screen for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
local Graphic = require("Graphic")
local json = require("json")

local score
local gameTime

local backgrounds

local bestscore
local besttime

local besttimetext
local bestscoretext
local timetext
local scoretext

local besttimedisplay
local bestscoredisplay
local timedisplay
local scoredisplay

 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

		gameTime = event.params.gametime
		score = event.params.score
		settings = event.params.settings
		
		backgrounds = {}
		
		if(settings:WhatLevel() == 1)then
			table.insert(backgrounds, Graphic:new({},0,0,"game1"))
			table.insert(backgrounds, Graphic:new({},0,0,"game1"))
			table.insert(backgrounds, Graphic:new({},0,0,"game1"))
		elseif(settings:WhatLevel() == 2)then
			table.insert(backgrounds, Graphic:new({},0,0,"game2"))
			table.insert(backgrounds, Graphic:new({},0,0,"game2"))
			table.insert(backgrounds, Graphic:new({},0,0,"game2"))
		else
			table.insert(backgrounds, Graphic:new({},0,0,"game3"))
			table.insert(backgrounds, Graphic:new({},0,0,"game3"))
			table.insert(backgrounds, Graphic:new({},0,0,"game3"))
		end
		backgrounds[1]:SetX(0)
		backgrounds[1]:SetY(display.contentHeight - 750)
		backgrounds[2]:SetX(1500)
		backgrounds[2]:SetY(display.contentHeight - 750)
		backgrounds[3]:SetX(3000)
		backgrounds[3]:SetY(display.contentHeight - 750)

   		title = MenuButton:new(o, 0, "TitleScene", Graphic:new({},0,0,"quitbutton"))
   		title:SetPos(display.contentCenterX, display.contentCenterY + 190)
		
   
		local inpath = system.pathForFile("AirDefender.personalbests.json", system.DocumentsDirectory)
		local infile, errorstring = io.open(inpath, "r")
		
		if(not infile)then
			besttime = gameTime
			--print(gameTime)
			bestscore = score
			--print(score)
		else
			local instring
			local filedata
			for line in infile:lines() do
				instring = line
				--print(instring)
			end
			if(instring ~= nil)then
				filedata = json.decode(instring)
			end
			if(filedata ~= nil and filedata.time ~= nil)then
				besttime = math.max(filedata.time, gameTime)
				--print(filedata.time)
			else
				besttime = gameTime
				--print(gameTime)
			end
			if(filedata ~= nil and filedata.score ~= nil)then
				bestscore = math.max(filedata.score, score)
				--print(filedata.score)
			else
				bestscore = score
				--print(score)
			end
			io.close(infile)
		end
   
		local outpath = system.pathForFile("AirDefender.personalbests.json", system.DocumentsDirectory)
		local outfile, errorString = io.open(outpath, "w")
		
		if (not outfile) then
			print("File error: " .. errorString)
		else
			outfile:write(json.encode({time=besttime, score=bestscore}))
			--print("Wrote to file")
			io.close(outfile)
		end
		
		besttimetext = "Your best survival time was :  "
		bestscoretext = "Your best score was         :  " .. bestscore
		timetext = "You survived for :  "
		scoretext = "Your score was   :  " .. score
		
		
		if(math.floor(besttime / 7200) < 10)then
			besttimetext = besttimetext .. "0" .. (math.floor(besttime / 7200) .. ":")
		else
			besttimetext = besttimetext .. (math.floor(besttime / 7200) .. ":")
		end
		if(math.floor(besttime % 3600/60) < 10)then
			besttimetext = besttimetext .. "0" .. (math.floor(besttime % 3600/60))
		else
			
			besttimetext = besttimetext .. (math.floor(besttime % 3600/60))
		end
		
		if(math.floor(gameTime / 7200) < 10)then
			timetext = timetext .. "0" .. (math.floor(gameTime / 7200) .. ":")
		else
			timetext = timetext .. (math.floor(gameTime / 7200) .. ":")
		end
		if(math.floor(gameTime % 3600/60) < 10)then
			timetext = timetext .. "0" .. (math.floor(gameTime % 3600/60))
		else
			
			timetext = timetext .. (math.floor(gameTime % 3600/60))
		end
		
		
		besttimedisplay = display.newText({
			text=besttimetext,
			x=display.contentCenterX,
			y=display.contentCenterY - (112 * display.contentHeight / 750),
			width = display.contentWidth*2/3,
			align = "left"
		})
		bestscoredisplay = display.newText({
			text=bestscoretext,
			x=display.contentCenterX,
			y=display.contentCenterY - (150 * display.contentHeight / 750),
			width = display.contentWidth*2/3,
			align = "left"
		})
		timedisplay = display.newText({
			text=timetext,
			x=display.contentCenterX,
			y=display.contentCenterY - (244 * display.contentHeight / 750),
			width = display.contentWidth*2/3,
			align = "left"
		})
		scoredisplay = display.newText({
			text=scoretext,
			x=display.contentCenterX,
			y=display.contentCenterY - (282 * display.contentHeight / 750),
			width = display.contentWidth*2/3,
			align = "left"
		})
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
	
	scoredisplay:removeSelf()
	scoredisplay = nil
	timedisplay:removeSelf()
	timedisplay = nil
	besttimedisplay:removeSelf()
	besttimedisplay = nil
	bestscoredisplay:removeSelf()
	bestscoredisplay = nil
	
	for i=1,#backgrounds,1 do
		j = backgrounds[#backgrounds]
		table.remove(backgrounds, #backgrounds)
		j:Destroy()
	end
 
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

