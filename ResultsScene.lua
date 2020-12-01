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

local bestscore
local besttime

 
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
			print("found file")
			local instring
			local filedata
			for line in infile:lines() do
				instring = line
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
			outfile:write("{ time : " .. besttime .. " , score : " .. bestscore .. " }")
			--print("Wrote to file")
			io.close(outfile)
		end
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

