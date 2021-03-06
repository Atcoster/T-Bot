----------------------------
-- Variables
----------------------------
ViewControl = {}
tutorialStrings={}
ViewControl.__index = ViewControl

----------------------------
-- Constructor
----------------------------
function ViewControl.create()
  
  local vc = {}
  setmetatable(vc, ViewControl)
  
  return vc
  
end

----------------------------
-- Functions
----------------------------

----------------------------
-- Clear view
----------------------------
function clearView()
  
  --Remove all props
  layer:clear()
  
  -- Clear all blocks
  for key, value in pairs(blocks) do
    if blocks[key]:getBlockBody() ~= nil then
      blocks[key]:getBlockBody():destroy()
    end
  end
  
  -- Clear all blocks
  for key, value in pairs(bullet) do
    if bullet[key]:getBulletBody() ~= nil then
      bullet[key]:getBulletBody():destroy()
    end
  end
  
  -- Clear all text
  --[[
  for key, value in pairs(text) do
    if text[key]:getTextProp() ~= nil then
      layer:removeProp(text[key]:getTextProp())
    end
  end
  ]]--
  
  -- Remove player if exist
  if player:getPlayerBody() ~= nil then
    player:getPlayerBody():destroy()
  end
  
  -- Reset arrays
  button = {}
  button["levels"] = {}
  anim = {}
  text = {}
  text["lvlNum"]={}
  view = {}
  bullet = {}
  blocks = {}
  blockGenerator = {}
  
  
end

----------------------------
-- Main Menu
----------------------------
function ViewControl:loadMainMenu()
  
  clearView()
  gameState = "Menu"
  
  soundManager:playMusic("mainTheme")
  
  view["mainMenu"] = View.create(resourceManager:getTexture("Mainbackground"))
  
  button["startBtn"] = Button.create(0, 170, resourceManager:getTexture("startimg"),1,2)
  button["settingsBtn"] = Button.create(0, 50, resourceManager:getTexture("settingsimg"),1,2)
  button["aboutBtn"] = Button.create(0, -70, resourceManager:getTexture("aboutimg"),1,2)
  
  button["removeadsBtn"] = Button.create(0, -190, resourceManager:getTexture("removeadsimg"),1,2)
  anim["mainLogo"] = Animator.create(0, 350, resourceManager:getTexture("logoAnim"),9,2)
  
  --button["mainMenuStartButton"] Button:makeTest()


 -- button["mainMenuAboutButton"] = Button.create(0, -165, resourceManager:getTexture("mainMenuButton"))
  

 -- text["mainStart"] = TextField.create(-100, 45, 220, 75, "START", 65)
 -- text["mainSettings"] = TextField.create(-160, -30, 340, 75, "SETTINGS", 65)
 -- text["mainAbout"] = TextField.create(-120, -200, 240, 75, "ABOUT", 65)
  
end

----------------------------
-- Level Selection Menu
----------------------------
function ViewControl:loadLevelSelectMenu()
  
  clearView()
  
  soundManager:playMusic("mainTheme")
  
  gameState = "LevelSelection"
  
  view["selectView"] = View.create(resourceManager:getTexture("selectbackground"))
  button["selectTop"] = Button.create(0, -420, resourceManager:getTexture("selectBottomBar"))
  button["selectBottom"] = Button.create(0, 420, resourceManager:getTexture("selectTopBar"))
  

  button["levelDownButton"] = Button.create(265, 420, resourceManager:getTexture("levelSelectForward"),1,2)
  button["levelUpButton"] = Button.create(-261, 420, resourceManager:getTexture("levelSelectBack"),1,2)
  button["levelUpButton"]:getProp():setRot(0)
  button["levelUpButton"]:getProp():setIndex(2); 
  button["levelDownButton"]:getProp():setIndex(2); 
  button["levelBackButton"] = Button.create(0, -410, resourceManager:getTexture("backButton"))
  
  --Levels
  local xb =-200
    local yb = 290
  for i=1,levelAmount do
    
      button["levels"][i] = Button.create(xb, yb, resourceManager:getTexture("levelActiveButton"),2,1)
      text["lvlNum"][i] = TextField.create(xb-15, yb-30, 50, 75, ""..i, 55)
     if xb == 200 then yb = yb-200 end
     if xb ~= 200 then xb = xb+200 else xb = -200 end
     if user_data.levelData[i-1] ~=nil then
      if user_data.levelData[i-1]["status"]=="incomplete" then button["levels"][i]:getProp():setIndex(2) end
     end
  end
  
end

----------------------------
-- Level Selection pop up
----------------------------
function ViewControl:levelSelectionPopup(level)
  
  gameState = "LevelSelectionPopup"
  
  --Background
  button["popupBackground"] = Button.create(0, 0, resourceManager:getTexture("popupBackground"))
  
  --Buttons
  button["popupLevelSelect"] = Button.create(-76, -250, resourceManager:getTexture("poplevelSelectButton"))
  button["popupLevelPlay"] = Button.create(76, -250, resourceManager:getTexture("popPlayButton"))
  
  -- Text
  text["currentLevel"] = TextField.create(-35, 230, 350, 75, level, 55)
  
  print("The level is: "..currentLevel)
  
  text["levelTimeTitle"] = TextField.create(-100, -60, 350, 75, "Best Time", 45)
  text["levelTime"] = TextField.create(-70, -140, 250, 80, tostring(user_data.levelData[currentLevel]["time"]), 55)
  
  --Prizes
  button["goldPrize"] = Button.create(4, 158, resourceManager:getTexture("emptyPrizeBig"))
  button["silverPrize"] = Button.create(140, 110, resourceManager:getTexture("emptyPrizeSmall"))
  button["bronzePrize"] = Button.create(-140, 110, resourceManager:getTexture("emptyPrizeSmall"))
  
  
end

----------------------------
-- In game pop up
----------------------------
function ViewControl:gamePopup()
  
  --Background
  button["popupBackground"] = Button.create(0, 0, resourceManager:getTexture("pausePopupBackground"))
  
  --Buttons
  button["popupGameStop"] = Button.create(-176, -50, resourceManager:getTexture("poplevelSelectButton"))
  button["popupGameRestart"] = Button.create(0, -50, resourceManager:getTexture("popReplayButton"))
  button["popupGamePlay"] = Button.create(176, -50, resourceManager:getTexture("popPlayButton"))
  
  -- Text  
  text["gamePauseTitle"] = TextField.create(-160, 60, 350, 75, "GAME PAUSED", 45)
  
  -- Freeze game
  gameTime:stop()
  player:setMovement(false)
  gameState = "paused"
  
  
end

----------------------------
-- In game pop up LOSE
----------------------------
function ViewControl:gamePopupLose()
  
  --Background
  button["popupBackground"] = Button.create(0, 0, resourceManager:getTexture("pausePopupBackground"))
  
  --Buttons
  button["popupGameStop"] = Button.create(-70, -50, resourceManager:getTexture("poplevelSelectButton"))
  button["popupGameRestart"] = Button.create(80, -50, resourceManager:getTexture("popReplayButton"))
  
  -- Text  
  text["gamePauseTitle"] = TextField.create(-120, 60, 350, 75, "YOU LOSE!", 45)
  
  -- Freeze game
  gameTime:stop()
  player:setMovement(false)
  gameState = "gameLost"
  
   soundManager:playMusic("loseTheme")
end

----------------------------
-- In game pop up WIN
----------------------------
function ViewControl:gamePopupWin()
  
  --Background
  button["popupBackground"] = Button.create(0, 0, resourceManager:getTexture("popupBackground"))
  
  --Buttons
  button["popupLevelSelect"] = Button.create(-176, -250, resourceManager:getTexture("poplevelSelectButton"))
  button["popupGameRestart"] = Button.create(0, -250, resourceManager:getTexture("popReplayButton"))
  button["popupLevelPlay"] = Button.create(176, -250, resourceManager:getTexture("popPlayButton"))
  
  
  -- Score compare
  local winCondition = {}
  for k, v in string.gmatch(winTime, "(%w+):(%w+)") do
    winCondition["minute"] = k
    winCondition["second"] = v
  end
   
  local highscore = {}
  for k, v in string.gmatch(user_data.levelData[currentLevel]["time"], "(%w+):(%w+)") do
    highscore["minute"] = k
    highscore["second"] = v
  end
  
  local totalCondition = (winCondition["minute"] * 100) + winCondition["second"]
  local totalHighscore = (highscore["minute"] * 100) + highscore["second"]
  
  print(totalCondition.." < "..totalHighscore)
  
  if totalCondition < totalHighscore then
    
   user_data.levelData[currentLevel]["time"] = winTime
    --save_user_data()
    
  end
  
  text["levelTime"] = TextField.create(-86, -120, 250, 80, "Time: "..tostring(winTime), 35)
  text["levelBestTime"] = TextField.create(-160, -180, 350, 80, "Best time: "..tostring(user_data.levelData[currentLevel]["time"]), 35)
  
  --Prizes
  text["levelWinTitle"] = TextField.create(-165, 210, 450, 75, "LEVEL COMPLETED!"..currentLevel, 35)
  button["goldPrize"] = Button.create(4, 118, resourceManager:getTexture("emptyPrizeBig"))
  button["silverPrize"] = Button.create(140, 70, resourceManager:getTexture("emptyPrizeSmall"))
  button["bronzePrize"] = Button.create(-140, 70, resourceManager:getTexture("emptyPrizeSmall"))
  
  user_data.levelData[currentLevel]["status"] = "complete"
  
  
  -- Freeze game
  gameTime:stop()
  player:setMovement(false)
  gameState = "gameWon"
  
  soundManager:getSound("winTheme"):play()
  save_user_data()
end


----------------------------
-- Load level
----------------------------
function ViewControl:loadLevel()
  
  clearView()
  
  soundManager:playMusic("gameTheme")
  
  gameState = "Playfield"
 
  view["gamescreen"] = View.create(resourceManager:getTexture("GameBackground"))
  
  button["firePowerupButton"] = Button.create(-180, -440, resourceManager:getTexture("inactivePowerup"))
  button["freezePowerupButton"] = Button.create(0, -440, resourceManager:getTexture("inactivePowerup"))
  
  button["pauseButton"] = Button.create(250, -440, resourceManager:getTexture("pauseButton"))
  
  player = Player.create()
  player:make()
  
  
  blockGenerator = Blockinator.create(currentLevel)
  blockGenerator:make()
  progressBar:drawProgressBarImage(blockGenerator:getAmountParts())
  
  button["topMenu"] = Button.create(0, 456, resourceManager:getTexture("gameTopMenu"))
  
  text["gameTime"] = TextField.create(20, 400, 150, 75, "5:00", 35)
  text["gameCurrentLevel"] = TextField.create(120, 400, 150, 75, "Level "..currentLevel, 35)
  
  -----------
  -- Timer --
  -----------
  seconds = 60
  minutes = 4
  
  winSecs = 0
  winMin =  0
  
  function updateTime()
    
    --count down
    seconds = seconds - 1
    
    if seconds < 10 and seconds >= 0 then
      
       if seconds == 0 and minutes == 0 then
      
        self:gamePopupLose()
      
      end
      
      seconds = "0"..seconds
    
    elseif seconds < 0 then
    
      seconds = 59
      minutes = minutes - 1
    
    end
    
    winSecs = winSecs + 1
    
    if winSecs < 10 then
      
      winSecs = "0"..winSecs
      
    elseif winSecs == 60 then
    
      winSecs = "00"
      winMin =  winMin + 1
    
    end
    
    winTime = "0"..tostring(winMin)..":"..tostring(winSecs)
    
    text["gameTime"]:setText(tostring(minutes)..":"..tostring(seconds))
   -- text["gameTime"]:setText(tostring(motionManager:getPos()))
  end
  
  gameTime:setSpan(1)
  gameTime:setMode(MOAITimer.LOOP)
  gameTime:setListener(MOAITimer.EVENT_TIMER_LOOP, updateTime )
  gameTime:start()
  
  ------------------------------
  -- Invisable walls
  ------------------------------
  --Floor
  bodies[0] = world:addBody( MOAIBox2DBody.STATIC )
  bodies[0]:setTransform( 0, -400 )  
  fixtures[0] = bodies[0]:addRect( -320, -10, 320, 10 )

  -- Right Wall
  bodies[1] = world:addBody( MOAIBox2DBody.STATIC )
  bodies[1]:setTransform( 360, 55 )  
  fixtures[1] = bodies[1]:addRect( -10, -420, 10, 420 )

  -- Left Wall
  bodies[2] = world:addBody( MOAIBox2DBody.STATIC )
  bodies[2]:setTransform( -360, 55 )  
  fixtures[2] = bodies[2]:addRect( -10, -420, 10, 420 )
  
    self:setTutorial(currentLevel)
end

function ViewControl:setTutorial(curlev)
  self.tutorialStrings =  resourceManager:getString("tutorial")
  self.tutorialStrings = tutorialStrings[curlev]
  log(table.getn(tutorialStrings))
  end