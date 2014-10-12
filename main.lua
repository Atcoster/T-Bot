----------------------------
-- MOAI Setup
----------------------------

----------------------------
-- FOR PC TESTING
----------------------------
local gameName = "T-Bot"
local screenWidth = 320
local screenHeight = 480

deviceScreenWidth  = MOAIEnvironment.horizontalResolution or screenWidth
deviceScreenHeight = MOAIEnvironment.verticalResolution or screenHeight

-- Open a window for testing, used on pc, skipped when on mobile
MOAISim.openWindow(gameName, deviceScreenWidth, deviceScreenHeight)

-- Making the viewport
viewport = MOAIViewport.new()
viewport:setSize(deviceScreenWidth, deviceScreenHeight)
viewport:setScale(deviceScreenWidth*2, deviceScreenHeight*2)

----------------------------
-- FOR MOBILE TESTING
----------------------------
--[[
local gameName = "T-Bot"
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
viewport:setSize ( screenXOffset, 0, screenXOffset + screenWidth,  screenHeight*1.5 )
viewport:setScale ( gameWidth*1.33, gameHeight*3.33 )
--]]

----------------------------
-- Adding layers
----------------------------
layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAIRenderMgr.pushRenderPass(layer)
MOAIGfxDevice.getFrameBuffer():setClearColor(0, 0, 0, 1);

----------------------------
-- Creating the world
----------------------------
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
MOAIUntzSystem.initialize()
MOAIUntzSystem.setVolume(1)

button = {}
text = {}
view = {}
bullet = {}
blocks = {}
blockGenerator = {}

currentLevel = ""

mouseStartX = 0
acceloSpeed = 0
tiltControl = false

gameView = {}
gameState = {}
gameTime = MOAITimer.new()

winTime = "00:00"

-- Invisable walls
bodies = {}
fixtures = {}
images = {}
props = {}

require("Helpers/resourceManager")
resourceManager = ResourceManager.create()

require("Helpers/soundManager")
soundManager = SoundManager.create()

require("Helpers/motionManager")
motionManager = MotionManager.create()

require("Helpers/progressbar")
progressBar = Progressbar.create()

require("Mechanics/player")
player = Player.create()

-- Helpers
require("Helpers/view")
require("Helpers/dataPersistence")
require("Helpers/button")
require("Helpers/view")
require("Helpers/textfield")

-- Mechanics
require("Mechanics/block")
require("Mechanics/blockinator")
require("Mechanics/bullet")
require("Mechanics/touchHandlers")
require("Mechanics/viewControl")
require("game")
