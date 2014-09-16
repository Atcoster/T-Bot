----------------------------
-- MOAI Setup
----------------------------
local gameName = "T-Bot"
local screenWidth = 320
local screenHeight = 480

-- Device Screen setup
deviceScreenWidth  = MOAIEnvironment.horizontalResolution or screenWidth
deviceScreenHeight = MOAIEnvironment.verticalResolution or screenHeight

-- Open a window for testing, used on pc, skipped when on mobile
MOAISim.openWindow(gameName, deviceScreenWidth, deviceScreenHeight)

-- Making the viewport
viewport = MOAIViewport.new()
viewport:setSize(deviceScreenWidth, deviceScreenHeight)
viewport:setScale(deviceScreenWidth*2, deviceScreenHeight*2)

-- Adding layers
layer = MOAILayer2D.new()
layer:setViewport(viewport)
MOAIRenderMgr.pushRenderPass(layer)
MOAIGfxDevice.getFrameBuffer():setClearColor(0, 0, 0, 1);

-- Creating the world
gravityX = 0;
gravityY = 0; 
world = MOAIBox2DWorld.new();
world:setGravity(gravityX, gravityY);
world:setUnitsToMeters(1/30);
world:start();
layer:setBox2DWorld(world);

-- Create partition
partition = MOAIPartition.new()
layer:setPartition(partition)

----------------------------
-- Global vars
----------------------------
test = {}
text = {}
view = {}

-- Helpers
require("Helpers/view")
require("Helpers/block")
require("Helpers/button")
require("Helpers/view")

-- Mechanics
require("Mechanics/touchHandlers")
require("game")
