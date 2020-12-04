--[[
	TitleScene.lua
	
	The title screen for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
local Settings = require("Settings")
local Graphic = require("Graphic")
local json = require("json")

local xScale = display.contentWidth/1334
local yScale = display.contentHeight/750

local music
local settings
local play
local options
local credits
local background
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
		local inpath = system.pathForFile("AirDefender.settings.json", system.DocumentsDirectory)
		local infile, errorstring = io.open(inpath, "r")
		
		if(not infile)then
			print("could not read settings file")
		else
			local instring
			local filedata
			for line in infile:lines() do
				instring = line
				print(instring)
			end
			if(instring ~= nil)then
				filedata = json.decode(instring)
			end
			if(filedata ~= nil)then
				print("settings file was not empty")
				print (filedata)
				for i,j in pairs(filedata) do
					print(i)
					print(j)
					Settings:Set(i, j)
				end
			else
				print("settings file was empty")
			end
			io.close(infile)
		end
		
		timer.cancel("UpdateGame")
		timer.cancel("Update")
		if(settings ~= nil)then
			--settings = event.params.settings
		else
			settings = Settings:new()
			settings.level = 1
			settings.sfx = true
			settings.music = true
		end

		--background = display.newImageRect("Assets/Sprites/title_screen.png", display.contentWidth, display.contentWidth)
		--background.x = display.contentCenterX
		--background.y = display.contentCenterY - (80*yScale)
		background = Graphic:new({},0,0,"title")
		background:SetX(display.contentWidth/2)
		background:SetY(display.contentHeight/2 - (80 * display.contentHeight/750))

   		play = MenuButton:new(o, 0, "GameScene", Graphic:new({},0,0,"playbutton"))
   		play:SetPos(display.contentCenterX - (300*xScale), display.contentCenterY  + (250*yScale))
		play:SetParams({settings = settings})
   
   		options = MenuButton:new(o, 0, "SettingsScene",Graphic:new({},0,0,"settingsbutton"))
   		options:SetPos(display.contentCenterX, display.contentCenterY + (250*yScale))
		options:SetParams({settings = settings})
		
   		credits = MenuButton:new(o, 0, "CreditsScene",Graphic:new({},0,0,"creditbutton"))
   		credits:SetPos(display.contentCenterX + (300*xScale), display.contentCenterY + (250*yScale))
		credits:SetParams({settings = settings})
		
   elseif ( phase == "did" ) then
	music = audio.loadSound("Assets/Sounds/MenuSong/Sector-Off-Limits_Looping.mp3")
	if(settings:IsMusic() == true)then
		audio.play(music, {channel = 1, loops = -1})
	else
		audio.stop(1)
	end
		timer.cancel("Update")
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
		timer.cancel("Update")
   
   elseif ( phase == "did" ) then
   
	local sceneGroup = self.view
	if(play ~= nil)then
		play:Destroy()
		play=nil
	end
	if(options~=nil)then
		options:Destroy()
		options=nil
	end
	background:Destroy()
	if(credits~=nil)then
		credits:Destroy()
		credits=nil
	end
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

