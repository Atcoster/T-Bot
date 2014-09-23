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
  
  images["button"] = MOAIImageTexture.new()
  images["button"]:load("Assets/img/blocks/Wall-Box.png")
  images["button"]:invalidate()
  
  images["floor"] = MOAIImageTexture.new()
  images["floor"]:load("Assets/img/blocks/Metal-Box.png")
  images["floor"]:invalidate()
  
  images["box"] = MOAIImageTexture.new()
  images["box"]:load("Assets/img/blocks/Box.png")
  images["box"]:invalidate()
  
  images["player"] = MOAIImageTexture.new()
  images["player"]:load("Assets/img/t-bot/T-Bot-48.png")
  images["player"]:invalidate()
  
  images["missile"] = MOAIImageTexture.new()
  images["missile"]:load("Assets/img/t-bot/missile.png")
  images["missile"]:invalidate()
  
end

function ResourceManager:getTexture(name)
  
  return images[name]
  
end