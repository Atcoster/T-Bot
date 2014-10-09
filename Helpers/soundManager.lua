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
  
  sounds["mainTheme"] = MOAIUntzSound.new()
  sounds["mainTheme"]:load("Assets/sounds/music/Theme.wav")
  sounds["mainTheme"]:setLooping(true)
  sounds["mainTheme"]:play()
  
  sounds["gameTheme"] = MOAIUntzSound.new()
  sounds["gameTheme"]:load("Assets/sounds/music/InGameMusic.wav")
  sounds["gameTheme"]:setLooping(true)
  
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
