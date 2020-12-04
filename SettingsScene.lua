--[[
	SettingsScene.lua
	
	The options menu for Air Defender.
]]





local composer = require( "composer" )
local scene = composer.newScene()
local MenuButton = require("MenuButton")
local OptionButton = require("OptionButton")
local Graphic = require("Graphic")
local json = require("json")
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
end
 
 
 function scene:ChangeButton(id, value, button)
	if(id == 1)then
		if(value == true)then
			button:ChangeGraphic(Graphic:new({},0,0,"musicbutton1"), id, self)
		else
			button:ChangeGraphic(Graphic:new({},0,0,"musicbutton2"), id, self)
		end
	elseif(id == 2)then
		if(value == true)then
			button:ChangeGraphic(Graphic:new({},0,0,"sfxbutton1"), id, self)
		else
			button:ChangeGraphic(Graphic:new({},0,0,"sfxbutton2"), id, self)
		end
	elseif(id == 3)then
		if(value == 1)then
			button:ChangeGraphic(Graphic:new({},0,0,"lvlbutton1"), id, self)
		elseif(value == 2)then
			button:ChangeGraphic(Graphic:new({},0,0,"lvlbutton2"), id, self)
		else
			button:ChangeGraphic(Graphic:new({},0,0,"lvlbutton3"), id, self)
		end
	elseif(id == 4)then
		if(value == 1)then
			button:ChangeGraphic(Graphic:new({},0,0,"shipbutton1"), id, self)
		elseif(value == 2)then
			button:ChangeGraphic(Graphic:new({},0,0,"shipbutton2"), id, self)
		else
			button:ChangeGraphic(Graphic:new({},0,0,"shipbutton3"), id, self)
		end
	end
 end
 
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then

	local Settings = Settings
	

		background = Graphic:new({},0,0,"title")
		background:SetX(display.contentWidth/2)
		background:SetY(display.contentHeight/2 - (80 * display.contentHeight/750))
		
   		title = MenuButton:new(o, 0, "TitleScene", Graphic:new({},0,0,"backbutton"),self)
   		title:SetPos(display.contentCenterX + (500*display.contentWidth/1334), display.contentCenterY + (250*display.contentHeight/750))
		
		if(Settings:Get(1)==true)then
			musicsetting = OptionButton:new(o, 1, Graphic:new({},0,0,"musicbutton1"),self)
		else
			musicsetting = OptionButton:new(o, 1, Graphic:new({},0,0,"musicbutton2"),self)
		end
   		musicsetting:SetPos(display.contentCenterX - (500*display.contentWidth/1334), display.contentCenterY + (250*display.contentHeight/750))


		if(Settings:Get(2)==true)then
			sfxsetting = OptionButton:new(o, 2, Graphic:new({},0,0,"sfxbutton1"),self)
		else
			sfxsetting = OptionButton:new(o, 2, Graphic:new({},0,0,"sfxbutton2"),self)
		end
   		sfxsetting:SetPos(display.contentCenterX - (250*display.contentWidth/1334), display.contentCenterY + (250*display.contentHeight/750))

		if(Settings:Get(3)==1)then
			levelsetting = OptionButton:new(o, 3, Graphic:new({},0,0,"lvlbutton1"),self)
		elseif(Settings:Get(3)==2)then
			levelsetting = OptionButton:new(o, 3, Graphic:new({},0,0,"lvlbutton2"),self)
		else
			levelsetting = OptionButton:new(o, 3, Graphic:new({},0,0,"lvlbutton3"),self)
		end
   		levelsetting:SetPos(display.contentCenterX + (0*display.contentWidth/1334), display.contentCenterY + (250*display.contentHeight/750))
   
		
		if(Settings:Get(4)==1)then
			shipsetting = OptionButton:new(o, 4, Graphic:new({},0,0,"shipbutton1"),self)
		elseif(Settings:Get(4)==2)then
			shipsetting = OptionButton:new(o, 4, Graphic:new({},0,0,"shipbutton2"),self)
		else
			shipsetting = OptionButton:new(o, 4, Graphic:new({},0,0,"shipbutton3"),self)
		end
   		shipsetting:SetPos(display.contentCenterX + (250*display.contentWidth/1334), display.contentCenterY + (250*display.contentHeight/750))
   
   
   elseif ( phase == "did" ) then
   
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   
   elseif ( phase == "did" ) then
   
		local outpath = system.pathForFile("AirDefender.settings.json", system.DocumentsDirectory)
		local outfile, errorString = io.open(outpath, "w")
		
		if (not outfile) then
			print("File error: " .. errorString)
		else
			outfile:write(json.encode({ Settings:Get(1),Settings:Get(2),Settings:Get(3),Settings:Get(4) }))
			--outfile:write("")
			--print("Wrote to file")
			io.close(outfile)
		end
   
	local sceneGroup = self.view
	title:Destroy()
	title=nil
	musicsetting:Destroy()
	musicsetting=nil
	sfxsetting:Destroy()
	sfxsetting=nil
	levelsetting:Destroy()
	levelsetting=nil
	shipsetting:Destroy()
	shipsetting=nil
	background:Destroy()
 
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

