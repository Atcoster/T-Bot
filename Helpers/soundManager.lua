----------------------------
-- Variables
----------------------------
SoundManager = {}
SoundManager.__index = SoundManager

local sounds = {}

----------------------------
-- Constructor
----------------------------
function SoundManager.create()
  
  local sm = {}
  setmetatable(sm, SoundManager)
  
  sm._currentSound = ""
  
  sm:loadResources()
  
  return sm
  
end

----------------------------
-- Functions
----------------------------
function SoundManager:loadResources()
  
  --music
  sounds["mainTheme"] = MOAIUntzSound.new()
  sounds["mainTheme"]:load("Assets/sounds/music/Theme.ogg")
  sounds["mainTheme"]:setLooping(true)
  
  
  sounds["gameTheme"] = MOAIUntzSound.new()
  sounds["gameTheme"]:load("Assets/sounds/music/InGameMusic.ogg")
  sounds["gameTheme"]:setLooping(true)
  
  sounds["loseTheme"] = MOAIUntzSound.new()
  sounds["loseTheme"]:load("Assets/sounds/music/Lose.ogg")
  
  sounds["winTheme"] = MOAIUntzSound.new()
  sounds["winTheme"]:load("Assets/sounds/music/Win.ogg")
  
  --sound effects
  sounds["arrowSwitch"] = MOAIUntzSound.new()
  sounds["arrowSwitch"]:load("Assets/sounds/effects/ArrowSwitch.wav")
  
  sounds["bombFreeze"] = MOAIUntzSound.new()
  sounds["bombFreeze"]:load("Assets/sounds/effects/BombFreezing.wav")
  
  sounds["breakIce"] = MOAIUntzSound.new()
  sounds["breakIce"]:load("Assets/sounds/effects/BreakingIce.wav")
  
  sounds["Explosion"] = MOAIUntzSound.new()
  sounds["Explosion"]:load("Assets/sounds/effects/Explosion.wav")
  
  sounds["meltMetal"] = MOAIUntzSound.new()
  sounds["meltMetal"]:load("Assets/sounds/effects/MeltMetal.wav")
  
  sounds["impactMetal"] = MOAIUntzSound.new()
  sounds["impactMetal"]:load("Assets/sounds/effects/ImpactMetal.wav")
  
  sounds["MissileShoot"] = MOAIUntzSound.new()
  sounds["MissileShoot"]:load("Assets/sounds/effects/MissileShoot.ogg")
 sounds["MissileShoot"]:setVolume(0.2)
  
  sounds["PartPicked"] = MOAIUntzSound.new()
  sounds["PartPicked"]:load("Assets/sounds/effects/PartPicked.wav")
  
  sounds["PowerupShoot"] = MOAIUntzSound.new()
  sounds["PowerupShoot"]:load("Assets/sounds/effects/PowerupShoot.wav")
  
end

function SoundManager:playMusic(index)
  
  if self._currentSound ~= index then
  
    if index == "mainTheme" then
      
      sounds["gameTheme"]:stop()
      
    elseif index == "gameTheme" then
      
      sounds["mainTheme"]:stop()
      
    end
    
    sounds[index]:play()
    self._currentSound = index
  
  end
  
end

function SoundManager:getSound(index)
  return sounds[index]
 end
