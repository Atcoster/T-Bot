----------------------------
-- Variables
----------------------------
ResourceManager = {}
ResourceManager.__index = ResourceManager

local images = {}
local sounds = {}
local strings={}
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
  
  -----------------------
  --MainMenu
  -----------------------
  images["Mainbackground"] = MOAIImageTexture.new()
  images["Mainbackground"]:load("Assets/img/Views/Main/Main.png")
  images["Mainbackground"]:invalidate()
  

  
  -----------------------
  --Level selection
  -----------------------
  images["selectbackground"] = MOAIImageTexture.new()
  images["selectbackground"]:load("Assets/img/Views/Levels/background.png")
  images["selectbackground"]:invalidate()
  
  images["selectTopBar"] = MOAIImageTexture.new()
  images["selectTopBar"]:load("Assets/img/Views/Levels/levelTopBar.png")
  images["selectTopBar"]:invalidate()
  
  images["selectBottomBar"] = MOAIImageTexture.new()
  images["selectBottomBar"]:load("Assets/img/Views/Levels/levelBottom.png")
  images["selectBottomBar"]:invalidate()
  
  -----------------------
  --PopUps
  -----------------------
  images["popupBackground"] = MOAITexture.new()
  images["popupBackground"]:load("Assets/img/Views/Popups/popupBG.png")
  
  images["pausePopupBackground"] = MOAITexture.new()
  images["pausePopupBackground"]:load("Assets/img/Views/Popups/pauseBG.png")
  
  
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
  
  
  images["air"] = MOAITexture.new()
  images["air"]:load("Assets/img/blocks/air.png")
  
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
  -- Buttons
  ------------------------
  
  
  -- Main menu buttons / logo
 images["settingsimg"] = MOAITexture.new()
  images["settingsimg"]:load("Assets/img/Views/Main/settingsBtn.png")
  
   images["aboutimg"] = MOAITexture.new()
  images["aboutimg"]:load("Assets/img/Views/Main/aboutBtn.png")
  
   images["startimg"] = MOAITexture.new()
  images["startimg"]:load("Assets/img/Views/Main/startBtn.png")

   images["logoAnim"] = MOAITexture.new()
  images["logoAnim"]:load("Assets/img/Views/Main/ding.png")
  
  images["removeadsimg"] = MOAITexture.new()
  images["removeadsimg"]:load("Assets/img/Views/Main/removeadsBtn.png")
  
  --images["settingsBtn"]:setSize(100,100)
  --images["settingsBtn"]:setRect(-100, -100, 100, 100)
  
  -- Level Select buttons
  images["levelActiveButton"] = MOAITexture.new()
  images["levelActiveButton"]:load("Assets/img/Views/Levels/activeInactiveSprite.png")
  
  images["levelInactiveButton"] = MOAITexture.new()
  images["levelInactiveButton"]:load("Assets/img/Views/Levels/stage-inactive.png")
  
  images["levelSelectForward"] = MOAITexture.new()
  images["levelSelectForward"]:load("Assets/img/Views/Levels/rightArrow.png")
  
   images["levelSelectBack"] = MOAITexture.new()
  images["levelSelectBack"]:load("Assets/img/Views/Levels/leftArrow.png")
  
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
  
  -- popup prizes
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
  images["backButton"]:load("Assets/img/Views/Levels/backButton.png")
  
  images["pauseButton"] = MOAITexture.new()
  images["pauseButton"]:load("Assets/img/Views/pauze.png")
  
  ------------------------
  -- Spritesheets
  ------------------------
  images["tbot"] = MOAITileDeck2D.new()
  images["tbot"]:setTexture("Assets/img/t-bot/Tbot_Sprite.png")
  images["tbot"]:setSize(4,1)
  images["tbot"]:setRect(-48, -42, 48, 42)
  
  images["normalMissileSheet"] = MOAITileDeck2D.new()
  images["normalMissileSheet"]:setTexture("Assets/img/t-bot/NormalMisSprite.png")
  images["normalMissileSheet"]:setSize(3,1)
  images["normalMissileSheet"]:setRect(-24, -24, 24, 24)
  
  images["fireMissileSheet"] = MOAITileDeck2D.new()
  images["fireMissileSheet"]:setTexture("Assets/img/t-bot/FireMisSprite.png")
  images["fireMissileSheet"]:setSize(3,1)
  images["fireMissileSheet"]:setRect(-24, -24, 24, 24)
  
  images["freezeMissileSheet"] = MOAITileDeck2D.new()
  images["freezeMissileSheet"]:setTexture("Assets/img/t-bot/FreezeMisSprite.png")
  images["freezeMissileSheet"]:setSize(3,1)
  images["freezeMissileSheet"]:setRect(-24, -24, 24, 24)
  
  images["explosion"] = MOAITileDeck2D.new()
  images["explosion"]:setTexture("Assets/img/Animations/explosion-sprite.png")
  images["explosion"]:setSize(9,1)
  images["explosion"]:setRect(-72, -72, 72, 72)
  
    images["portal"] = MOAITileDeck2D.new()
  images["portal"]:setTexture("Assets/img/blocks/portal-block.png")
  images["portal"]:setSize(7,1)
  images["portal"]:setRect(-24, -24, 24, 24)
  
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

function ResourceManager:loadStringResources()
  strings["tutorial"][1][0]="Hello and welcome to the T-factory."
  strings["tutorial"][1][2]="Hello and welcome to the T-factory."
  strings["tutorial"][1][3]="Hello and welcome to the T-factory."
  strings["tutorial"][1][4]="Hello and welcome to the T-factory."
  end

function ResourceManager:getTexture(name)
  
  return images[name]
  
end
function ResourceManager:getString(name)
  
  return  strings[name]
  
end