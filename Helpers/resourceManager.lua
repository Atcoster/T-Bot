----------------------------
-- Variables
----------------------------
ResourceManager = {}
ResourceManager.__index = ResourceManager

local images = {}
local sounds = {}

----------------------------
-- Constructor
----------------------------
function ResourceManager.create()
  
  local mgr = {}
  setmetatable(mgr, ResourceManager)
  
  mgr:loadResources()
  
  return mgr
  
end

----------------------------
-- Functions
----------------------------
function ResourceManager:loadResources()
  
  ------------------------
  -- Views
  ------------------------
  images["background"] = MOAIImage.new()
  images["background"]:load("Assets/img/blueBG.png")
  
  local w,h = images["background"]:getSize()
  images["background"] = images["background"]:resize(w/5, h/5)
  
  ------------------------
  -- Box Textures
  ------------------------
  images["box"] = MOAIImageTexture.new()
  images["box"]:load("Assets/img/blocks/Box.png")
  images["box"]:invalidate()
  
  images["metal"] = MOAIImageTexture.new()
  images["metal"]:load("Assets/img/blocks/Metal-Box.png")
  images["metal"]:invalidate()
  
  ------------------------
  -- Powerup textures
  ------------------------
  images["wallUp"] = MOAIImageTexture.new()
  images["wallUp"]:load("Assets/img/blocks/Wall-Box.png")
  images["wallUp"]:invalidate()
  
  images["lightning"] = MOAIImageTexture.new()
  images["lightning"]:load("Assets/img/blocks/Ligtning-Box.png")
  images["lightning"]:invalidate()
  
  images["laser"] = MOAIImageTexture.new()
  images["laser"]:load("Assets/img/blocks/Laser-Box.png")
  images["laser"]:invalidate()
  
  images["bomb"] = MOAIImageTexture.new()
  images["bomb"]:load("Assets/img/blocks/Bomb-Box.png")
  images["bomb"]:invalidate()
  
  ------------------------
  -- Player Textures
  ------------------------
  images["player"] = MOAIImageTexture.new()
  images["player"]:load("Assets/img/t-bot/T-Bot-48.png")
  images["player"]:invalidate()
  
  images["missile"] = MOAIImageTexture.new()
  images["missile"]:load("Assets/img/t-bot/missile.png")
  images["missile"]:invalidate()
  
  ------------------------
  -- Buttons
  ------------------------
  images["leftBtn"] = MOAIImageTexture.new()
  images["leftBtn"]:load("Assets/img/buttons/left.png")
  images["leftBtn"]:invalidate()
  
  images["rightBtn"] = MOAIImageTexture.new()
  images["rightBtn"]:load("Assets/img/buttons/right.png")
  images["rightBtn"]:invalidate()
  
  images["jumpBtn"] = MOAIImageTexture.new()
  images["jumpBtn"]:load("Assets/img/buttons/up.png")
  images["jumpBtn"]:invalidate()
  
  images["shootBtn"] = MOAIImageTexture.new()
  images["shootBtn"]:load("Assets/img/buttons/shoot.png")
  images["shootBtn"]:invalidate()
  
  images["powerUpBtn"] = MOAIImageTexture.new()
  images["powerUpBtn"]:load("Assets/img/buttons/pu.png")
  images["powerUpBtn"]:invalidate()
  
  
  
end

function ResourceManager:getTexture(name)
  
  return images[name]
  
end