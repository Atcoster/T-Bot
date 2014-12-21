---------------------------
-- Mouse handlers
----------------------------
canpress = true
function onBackButtonPressed ()
  if canpress == true then
    if gameState == "LevelSelection" then gameView:loadMainMenu() 
  elseif gameState == "LevelSelectionPopup" then gameView:loadLevelSelectMenu()
    elseif gameState == "Playfield" then gameView:gamePopup()
    elseif gameState == "paused" then 
      resumeGame()
    end
   -- if gameState == "LevelSelection" then gameView:loadMainMenu() end
    --if gameState == "LevelSelection" then gameView:loadMainMenu() end
    canpress = false
  end
   local timerback = MOAITimer.new()
    timerback:setSpan(0.9)
    timerback:setMode(MOAITimer.NORMAL)
    timerback:setListener(MOAITimer.EVENT_TIMER_END_SPAN,resetBB)
    timerback:start()
    return true
end

function resetBB() canpress = true end

MOAIApp.setListener ( MOAIApp.BACK_BUTTON_PRESSED, onBackButtonPressed )

if MOAIInputMgr.device.pointer then 
  
  -- For mouse clicks
  MOAIInputMgr.device.mouseLeft:setCallback(
    function(isMouseDown)
      
      local x,y = MOAIInputMgr.device.pointer:getLoc()
      local touchedProp = partition:propForPoint(layer:wndToWorld(x, y))
      
     
      x,y = layer:wndToWorld(x, y)
      
      if(isMouseDown) then
        
        downAction(x,y,touchedProp)
        
      else
       
        releaseAction(x,y,touchedProp)
        
      end
      
    end
  )

else


-- For touch devices
  MOAIInputMgr.device.touch:setTapTime(0)
  MOAIInputMgr.device.touch:setCallback (

    function ( eventType, idx, x, y, tapCount )
        
        local touchedProp = partition:propForPoint(layer:wndToWorld(x, y))
        
        x,y = layer:wndToWorld(x, y)
        
        --[[
        if y < -300 and y > -400 and player:getMovement() == true then
           
           mouseStartX = x
           
        end
        --]]
        
        if (tapCount > 1) then
        
        elseif eventType == MOAITouchSensor.TOUCH_MOVE then
        
        moveAction(x,y,touchedprop)
        
        elseif eventType == MOAITouchSensor.TOUCH_DOWN then
        
          downAction(x,y,touchedProp)
        
        elseif eventType == MOAITouchSensor.TOUCH_UP then
        
          releaseAction(x,y,touchedProp)
        
        end
    end
  )

end

----------------------------------------
----------- Mouse Move -----------------
----------------------------------------
function moveAction(x,y,touchedProp)
if gameState == "Playfield" then
   if y < -200 and y > -400 and player:getMovement() == true then
           
         mouseStartX = x
         
      end
  
  end
end
----------------------------------------
----------- Touch down -----------------
----------------------------------------
function downAction(x,y,touchedProp)
  
  if gameState == "Menu" then
          
   if(touchedProp == button["settingsBtn"]:getProp()) then
       button["settingsBtn"]:getProp():setIndex(2) 
   elseif(touchedProp == button["aboutBtn"]:getProp()) then
       button["aboutBtn"]:getProp():setIndex(2) 
    elseif(touchedProp == button["startBtn"]:getProp()) then
       button["startBtn"]:getProp():setIndex(2) 
    elseif(touchedProp == button["removeadsBtn"]:getProp()) then
    button["removeadsBtn"]:getProp():setIndex(2) 
    end
    
  end
   
  if gameState == "LevelSelection" then
    
    if(touchedProp == text["lvlNum"][1]:getTextProp()) then currentLevel=1 gameView:levelSelectionPopup("Lvl 1")  end
    
    for i=2,levelAmount do
    if user_data.levelData[i-1]["status"] == "complete" then 
      
      if(touchedProp == text["lvlNum"][i]:getTextProp()) then currentLevel=i gameView:levelSelectionPopup("Lvl "..i)   end
    
    end
  end

    if(touchedProp == button["levelBackButton"]:getProp()) then gameView:loadMainMenu() end
    
  end

  if gameState == "LevelSelectionPopup" then
  
    if(touchedProp == button["popupLevelPlay"]:getProp()) then gameView:loadLevel() end
    
    if(touchedProp == button["popupLevelSelect"]:getProp()) then
      
      layer:removeProp(button["popupBackground"]:getProp())
      layer:removeProp(button["popupLevelSelect"]:getProp())
      layer:removeProp(button["popupLevelPlay"]:getProp())
      
      layer:removeProp(button["goldPrize"]:getProp())
      layer:removeProp(button["silverPrize"]:getProp())
      layer:removeProp(button["bronzePrize"]:getProp())
      
      layer:removeProp(text["currentLevel"]:getTextProp())
      layer:removeProp(text["levelTimeTitle"]:getTextProp())
      layer:removeProp(text["levelTime"]:getTextProp())
      
       gameState = "LevelSelection"
 
    end
  
  end
  
  
  --------------------
  ---- Pause mode 
  --------------------
  if gameState == "paused" then
    
    if touchedProp == button["popupGamePlay"]:getProp() then
      
    resumeGame()
    
    end
  
    if touchedProp == button["popupGameRestart"]:getProp() then
      
      gameView:loadLevel()
      
    end
    
    if touchedProp == button["popupGameStop"]:getProp() then
      
      player:setMovement(false)
      gameView:loadLevelSelectMenu()
      
    end
    
  end
  
  --------------------
  ---- Win mode 
  --------------------
  if gameState == "gameWon" then 
    
    if(touchedProp == button["popupLevelPlay"]:getProp()) then 
      if currentLevel ~= levelAmount then
      currentLevel = currentLevel + 1
      gameView:loadLevel()
      else gameView:loadLevelSelectMenu()
    end
       end
    
    if touchedProp == button["popupGameRestart"]:getProp() then
      
      gameView:loadLevel()
      
    end
    
    if(touchedProp == button["popupLevelSelect"]:getProp()) then
      
      gameView:loadLevelSelectMenu()
 
    end
    
  end
  
  --------------------
  ---- Lose mode 
  --------------------
  if gameState == "gameLost" then 
    
    if touchedProp == button["popupGameStop"]:getProp() then
      
      gameView:loadLevelSelectMenu()
      
    end
    
    if touchedProp == button["popupGameRestart"]:getProp() then
      
      gameView:loadLevel()
      
    end
    
  end
  
  --------------------
  ---- Game mode 
  --------------------
  if gameState == "Playfield" then        
    
    if touchedProp == button["pauseButton"]:getProp() then
      
      gameView:gamePopup()
      
    end
    
    if touchedProp == player:getPlayerProp() and player:getMovement() == true then
    
      table.insert(bullet, Bullet.create(player:getPlayerBody():getPosition()))
      
      soundManager:getSound("MissileShoot"):play()

    
    end
    
    --------------------
    ---- Powerups 
    --------------------
    
    if touchedProp == button["firePowerupButton"]:getProp() then
      
      if button["firePowerupButton"]:getmissileActivation() == true then
      
        if button["firePowerupButton"]:getMissleState() == false then
          
          button["firePowerupButton"]:changeTexture(resourceManager:getTexture("activeFireButton"))
          button["firePowerupButton"]:setMissileState(true)
          player:setWeaponType("fire")
          
        else
          
          button["firePowerupButton"]:changeTexture(resourceManager:getTexture("inactiveFireButton"))
          button["firePowerupButton"]:setMissileState(false)
           player:setWeaponType("normal")
          
        end
      
      end
    
      if button["freezePowerupButton"]:getMissleState() == true then
          
        button["freezePowerupButton"]:changeTexture(resourceManager:getTexture("inactiveFreezeButton"))
        button["freezePowerupButton"]:setMissileState(false)
        
      end
      
    end
    
    if touchedProp == button["freezePowerupButton"]:getProp() then
      
      if button["freezePowerupButton"]:getmissileActivation() == true then
          
        if button["freezePowerupButton"]:getMissleState() == false then
          
          button["freezePowerupButton"]:changeTexture(resourceManager:getTexture("activeFreezeButton"))
          button["freezePowerupButton"]:setMissileState(true)
          player:setWeaponType("freeze")
          
        else
          
          button["freezePowerupButton"]:changeTexture(resourceManager:getTexture("inactiveFreezeButton"))
          button["freezePowerupButton"]:setMissileState(false)
          player:setWeaponType("normal")
          
        end
        
        if button["firePowerupButton"]:getMissleState() == true then
          
          button["firePowerupButton"]:changeTexture(resourceManager:getTexture("inactiveFireButton"))
          button["firePowerupButton"]:setMissileState(false)
          
        end
          
      end     
      
    end
  
    --------------------
    ---- Blocks
    --------------------
    for key,value in pairs(blocks) do
      
      if touchedProp == blocks[key]:getBlockProp() then
        
        -- rotating blocks
        if blocks[key]:getUserdata(1) == "arrow" then
            --print(blocks[117]:getPos())
            blocks[key]:getBlockProp():moveRot(-90, 0.5)
           -- soundManager:playMusic("arrowSwitch")
        end
        
        -- Swiping - Under construction
        for key2,value2 in pairs(blocks) do
          
          if blocks[key2]:getUserdata(2) == "moveable" then
            blocks[key2]:setMovement(true)
          end
          
        end
       
      end
      
    end
  
  end
  
end

----------------------------------------
----------- Mouse Up -------------------
----------------------------------------
function releaseAction(x,y,touchedProp)
  
  if gameState == "Menu" then
    if(touchedProp == button["startBtn"]:getProp()) then
       button["startBtn"]:getProp():setIndex(1)
       gameView:loadLevelSelectMenu()
       end
        button["aboutBtn"]:getProp():setIndex(1)
        button["settingsBtn"]:getProp():setIndex(1)
        button["removeadsBtn"]:getProp():setIndex(1)
    
    end
  --------------------
  ---- Player 
  --------------------
  if gameState == "Playfield" then
    
    -------------------
    ---- Swipe 
    --------------------
    for key,value in pairs(blocks) do
      
      if blocks[key]:getUserdata(2) == "moveable" then
        blocks[key]:setMovement(false)
      end
       
    end
    
  end
  
end



function resumeGame()
        gameTime:start()
      player:setMovement(true)
      gameState = "Playfield"
      
      layer:removeProp(button["popupBackground"]:getProp())
      layer:removeProp(button["popupGameStop"]:getProp())
      layer:removeProp(button["popupGameRestart"]:getProp())
      layer:removeProp(button["popupGamePlay"]:getProp())
      
      layer:removeProp(text["gamePauseTitle"]:getTextProp())
      end