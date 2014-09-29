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
  images["background"] = MOAIImageTexture.new()
  images["background"]:load("Assets/img/BlueBG.png")
  images["background"]:invalidate()
  --local w,h = images["background"]:getSize()
  --images["background"] = images["background"]:resize(w/5, h/5)
  
  ------------------------
  -- Box Textures
  ------------------------
  images["wood"] = MOAIImageTexture.new()
  images["wood"]:load("Assets/img/blocks/Wood.png")
  images["wood"]:invalidate()
  
  images["metal"] = MOAIImageTexture.new()
  images["metal"]:load("Assets/img/blocks/Metal.png")
  images["metal"]:invalidate()
  
  images["bomb"] = MOAIImageTexture.new()
  images["bomb"]:load("Assets/img/blocks/Bomb.png")
  images["bomb"]:invalidate()
  
  images["wall"] = MOAIImageTexture.new()
  images["wall"]:load("Assets/img/blocks/Wall.png")
  images["wall"]:invalidate()
  
  --Parts
  for i = 1, 10 do
    
    local index = "part"..tostring(i)
    local path = "Assets/img/blocks/Part"..tostring(i)..".png"
    
    images[index] = MOAIImageTexture.new()
    images[index]:load(path)
    images[index]:invalidate()
  
  end
  
  ------------------------
  -- Powerup textures
  ------------------------
  
  images["fire"] = MOAIImageTexture.new()
  images["fire"]:load("Assets/img/blocks/Fire-Missile.png")
  images["fire"]:invalidate()
  
  images["freeze"] = MOAIImageTexture.new()
  images["freeze"]:load("Assets/img/blocks/Freeze-Missile.png")
  images["freeze"]:invalidate()
  
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
  
end

function ResourceManager:getTexture(name)
  
  return images[name]
  
end