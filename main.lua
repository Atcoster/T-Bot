----------------------------
-- MOAI Setup
----------------------------
local gameName = "T-Bot"
local screenWidth = 320
local screenHeight = 480

-- Device Screen setup
-- FOR PC USE!!!
deviceScreenWidth  = MOAIEnvironment.horizontalResolution or screenWidth
deviceScreenHeight = MOAIEnvironment.verticalResolution or screenHeight

-- FOR MOBILE USE!!!
--deviceScreenWidth  = MOAIEnvironment.horizontalResolution or 1024
--deviceScreenHeight = MOAIEnvironment.verticalResolution or 9/16*deviceScreenWidth

-- Open a window for testing, used on pc, skipped when on mobile
MOAISim.openWindow(gameName, deviceScreenWidth, deviceScreenHeight)

-- Making the viewport
viewport = MOAIViewport.new()
viewport:setSize(deviceScreenWidth, deviceScreenHeight)
viewport:setScale(deviceScreenWidth*2, deviceScreenHeight*2)
--viewport:setOffset(-100, -100)
--viewport:setScale(deviceScreenWidth*2, deviceScreenHeight*2)

--[[
gameWidth = 480
gameHeight = 320
screenXOffset = 0
screenYOffset = 0

MOAISim.openWindow( gameName, gameWidth, gameHeight )
 
deviceWidth, deviceHeight = MOAIGfxDevice.getViewSize()
 
 
local gameAspect = gameHeight / gameWidth
local realAspect = deviceHeight / deviceWidth
 
 if realAspect > gameAspect then
    screenWidth = deviceWidth
    screenHeight = deviceHeight * gameAspect
 else
    screenWidth = deviceHeight / gameAspect
    screenHeight = deviceHeight
 end

 if screenWidth < deviceWidth then
    screenXOffset = ( deviceWidth - screenWidth ) * 0.5
 end

 if screenHeight < deviceHeight then
    screenYOffset = ( deviceHeight - screenHeight ) * 0.5
 end

viewport = MOAIViewport.new()
viewport:setSize ( screenXOffset, screenYOffset, screenXOffset + screenWidth, screenYOffset + screenHeight )
viewport:setScale ( gameWidth, gameHeight )
--]]

-- Adding layers
layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAIRenderMgr.pushRenderPass(layer)
MOAIGfxDevice.getFrameBuffer():setClearColor(0, 0, 0, 1);

-- Creating the world
gravityX = 0;
gravityY = -5; 
world = MOAIBox2DWorld.new();
world:setGravity(gravityX, gravityY);
world:setUnitsToMeters(1/30);
world:start();
--layer:setBox2DWorld(world);

-- Create partition
partition = MOAIPartition.new()
layer:setPartition(partition)

----------------------------
-- Global vars
----------------------------
button = {}
text = {}
view = {}
player = {}
bullet = {}

blocks = {}
blockGenerator = {}

resourceManager = {}

mouseStartX = 0

gameView = {}
gameState = {}


-- Invisable walls
bodies = {}
fixtures = {}
images = {}
props = {}

require("Helpers/resourceManager")
resourceManager = ResourceManager.create()

require("Helpers/progressbar")
progressBar = Progressbar.create()

-- Helpers
require("Helpers/view")
require("Helpers/button")
require("Helpers/view")
require("Helpers/textfield")

-- Mechanics
require("Mechanics/block")
require("Mechanics/blockinator")
require("Mechanics/player")
require("Mechanics/bullet")
require("Mechanics/touchHandlers")
require("Mechanics/viewControl")
require("game")
