---------------------------
-- Mouse handlers
----------------------------
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
  
  MOAIInputMgr.device.touch:setCallback (

    function ( eventType, idx, x, y, tapCount )
        
        local touchedProp = partition:propForPoint(layer:wndToWorld(x, y))
        
        x,y = layer:wndToWorld(x, y)
        
        if y < -300 and y > -400 and player:getMovement() == true then
           
           mouseStartX = x
           
        end

        
        if (tapCount > 1) then
        
        
        elseif eventType == MOAITouchSensor.TOUCH_DOWN then
        
          downAction(x,y,touchedProp)
        
        elseif eventType == MOAITouchSensor.TOUCH_UP then
        
          releaseAction(x,y,touchedProp)
        
        end
    end
  )

end


----------------------------------------
----------- Mouse down -----------------
----------------------------------------
function downAction(x,y,touchedProp)
  
  if gameState == "Menu" then
          
    if(touchedProp == text["mainStart"]:getTextProp()) then
      
      gameView:loadLevelSelectMenu()

    end
    
  end
   
  if gameState == "LevelSelection" then
    
    if(touchedProp == text["levelOne"]:getTextProp()) then gameView:levelSelectionPopup("1-1") end
    --if(touchedProp == text["levelTwo"]:getTextProp()) then gameView:levelSelectionPopup("1-2") end
    --if(touchedProp == text["levelThree"]:getTextProp()) then gameView:levelSelectionPopup("1-3") end
    --if(touchedProp == text["levelFour"]:getTextProp()) then gameView:levelSelectionPopup("1-4") end
    --if(touchedProp == text["levelFive"]:getTextProp()) then gameView:levelSelectionPopup("1-5") end
    
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
      
      gameTime:start()
      player:setMovement(true)
      gameState = "Playfield"
      
      layer:removeProp(button["popupBackground"]:getProp())
      layer:removeProp(button["popupGameStop"]:getProp())
      layer:removeProp(button["popupGameRestart"]:getProp())
      layer:removeProp(button["popupGamePlay"]:getProp())
      
      layer:removeProp(text["gamePauseTitle"]:getTextProp())
    
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
    
    if(touchedProp == button["popupLevelPlay"]:getProp()) then gameView:loadLevel() end
    
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

    else
    
      if y < -300 and y > -400 and player:getMovement() == true then
           
         mouseStartX = x
         
      end
    
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
            
            blocks[key]:getBlockProp():moveRot(-90, 0.5)
            
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