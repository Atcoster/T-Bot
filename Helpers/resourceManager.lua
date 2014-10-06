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
  images["GameBackground"] = MOAIImageTexture.new()
  images["GameBackground"]:load("Assets/img/BlueBG.png")
  images["GameBackground"]:invalidate()
  
  images["Mainbackground"] = MOAIImageTexture.new()
  images["Mainbackground"]:load("Assets/img/Views/Main/Main.png")
  images["Mainbackground"]:invalidate()
  
  images["selectbackground"] = MOAIImageTexture.new()
  images["selectbackground"]:load("Assets/img/Views/Levels/level-background.png")
  images["selectbackground"]:invalidate()
  
  images["popupBackground"] = MOAITexture.new()
  images["popupBackground"]:load("Assets/img/Views/Popups/popupBG.png")
  
  
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
  
  images["arrow"] = MOAITexture.new()
  images["arrow"]:load("Assets/img/blocks/arrow-block.png")
  
  images["frozenBomb"] = MOAITexture.new()
  images["frozenBomb"]:load("Assets/img/blocks/bomb-frozen.png")
  
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
  
  images["fireMissile"] = MOAITexture.new()
  images["fireMissile"]:load("Assets/img/t-bot/Fire-missile.png")
  
  images["freezeMissile"] = MOAITexture.new()
  images["freezeMissile"]:load("Assets/img/t-bot/Freeze-missile.png")
  
  ------------------------
  -- Buttons
  ------------------------
  
  -- Main menu buttons
  images["mainMenuButton"] = MOAITexture.new()
  images["mainMenuButton"]:load("Assets/img/Views/Main/clean.png")
  
  images["mainMenuButtonHover"] = MOAITexture.new()
  images["mainMenuButtonHover"]:load("Assets/img/Views/Main/tbotjes.png")
  
  -- Level Select buttons
  images["levelActiveButton"] = MOAITexture.new()
  images["levelActiveButton"]:load("Assets/img/Views/Levels/stage-active.png")
  
  images["levelInactiveButton"] = MOAITexture.new()
  images["levelInactiveButton"]:load("Assets/img/Views/Levels/stage-inactive.png")
  
  images["levelSelectButton"] = MOAITexture.new()
  images["levelSelectButton"]:load("Assets/img/Views/Levels/level-arrow.png")
  
  -- In game menu
  images["gameTopMenu"] = MOAITexture.new()
  images["gameTopMenu"]:load("Assets/img/elements/top-bar-bg.png")
  
  images["gameTopMenuBar"] = MOAITexture.new()
  images["gameTopMenuBar"]:load("Assets/img/elements/progress-bar-bg.png")
  
  
  -- popup buttons
  images["poplevelSelectButton"] = MOAITexture.new()
  images["poplevelSelectButton"]:load("Assets/img/Views/Popups/level-select.png")
  
  images["popPlayButton"] = MOAITexture.new()
  images["popPlayButton"]:load("Assets/img/Views/Popups/play.png")
  
  images["popReplayButton"] = MOAITexture.new()
  images["popReplayButton"]:load("Assets/img/Views/Popups/restart.png")
  
  -- popup prozes
  images["emptyPrizeBig"] = MOAITexture.new()
  images["emptyPrizeBig"]:load("Assets/img/Views/Popups/empty-big.png")
  
  images["emptyPrizeSmall"] = MOAITexture.new()
  images["emptyPrizeSmall"]:load("Assets/img/Views/Popups/empty-small.png")
  
  images["bronzePrize"] = MOAITexture.new()
  images["bronzePrize"]:load("Assets/img/Views/Popups/bronze.png")
  
  images["silverPrize"] = MOAITexture.new()
  images["silverPrize"]:load("Assets/img/Views/Popups/silver.png")
  
  images["goldPrize"] = MOAITexture.new()
  images["goldPrize"]:load("Assets/img/Views/Popups/gold.png")
  
  -- In game buttons
  images["activeFreezeButton"] = MOAITexture.new()
  images["activeFreezeButton"]:load("Assets/img/buttons/Freeze-active.png")
  
  images["inactiveFreezeButton"] = MOAITexture.new()
  images["inactiveFreezeButton"]:load("Assets/img/buttons/Freeze-inactive.png")
  
  images["activeFireButton"] = MOAITexture.new()
  images["activeFireButton"]:load("Assets/img/buttons/Fire-active.png")
  
  images["inactiveFireButton"] = MOAITexture.new()
  images["inactiveFireButton"]:load("Assets/img/buttons/Fire-inactive.png")
  
  images["inactivePowerup"] = MOAITexture.new()
  images["inactivePowerup"]:load("Assets/img/buttons/inactive.png")
  
  -- Overall Game buttons
  images["backButton"] = MOAITexture.new()
  images["backButton"]:load("Assets/img/Views/backBtn.png")
  
  ------------------------
  -- Spritesheets
  ------------------------
  images["explosion"] = MOAITileDeck2D.new()
  images["explosion"]:setTexture("Assets/img/Animations/explosion-sprite.png")
  images["explosion"]:setSize(9,1)
  images["explosion"]:setRect(-72, -72, 72, 72)
  
  images["meltMetal"] = MOAITileDeck2D.new()
  images["meltMetal"]:setTexture("Assets/img/Animations/metal-melt.png")
  images["meltMetal"]:setSize(7,1)
  images["meltMetal"]:setRect(-24, -24, 24, 24)
  
  images["destroyWood"] = MOAITileDeck2D.new()
  images["destroyWood"]:setTexture("Assets/img/Animations/wood-destroy.png")
  images["destroyWood"]:setSize(7,1)
  images["destroyWood"]:setRect(-24, -24, 24, 24)
  
  images["freezeBomb"] = MOAITileDeck2D.new()
  images["freezeBomb"]:setTexture("Assets/img/Animations/bomb-freeze.png")
  images["freezeBomb"]:setSize(7,1)
  images["freezeBomb"]:setRect(-24, -24, 24, 24)
  
end

function ResourceManager:getTexture(name)
  
  return images[name]
  
end