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
      
      if y < -300 and y > -400 then
         mouseStartX = x
      end
      
     
      
      if(isMouseDown) then
        
        --------------------
        ---- Mouse down ----
        --------------------
         if gameState == "Menu" then
          
          if(touchedProp == text["mainStart"]:getTextProp()) then
            
            gameView:loadLevelSelectMenu()

          end
          
         end
         
         if gameState == "LevelSelection" then
          
          if(touchedProp == text["levelOne"]:getTextProp()) then gameView:loadLevel() print("level selected") end
          if(touchedProp == button["levelBackButton"]:getProp()) then gameView:loadMainMenu() end
        
         end
        
        
        if gameState == "Playfield" then        
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
        
      else
        
        --------------------
        ---- Mouse up ----
        --------------------
        
        --------------------
        ---- Player 
        --------------------
        if gameState == "Playfield" then
       
          if(touchedProp == player:getPlayerProp()) then
          
            table.insert(bullet, Bullet.create(player:getPlayerBody():getPosition()))

          end
          
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
      
    end
  )
  
  -- For touch devices
  --[[
  MOAIInputMgr.device.touch:setCallback (

    function ( eventType, idx, x, y, tapCount )
        if (tapCount > 1) then
            MOAIGfxDevice.setClearColor(math.random(0,1),math.random(0,1),math.random(0,1),1)
        elseif eventType == MOAITouchSensor.TOUCH_DOWN then
            handleClickOrTouch(x,y)
        end
    end
  )
  --]]
  
end