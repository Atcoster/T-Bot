
function movePlayer()
    
    player:setMovement(true)
    
end

local playerActionTimer = MOAITimer.new()
playerActionTimer:setSpan(0.1)
playerActionTimer:setMode(MOAITimer.NORMAL)
playerActionTimer:setListener(MOAITimer.EVENT_TIMER_END_SPAN, movePlayer)


----------------------------
-- Mouse handlers
----------------------------
if MOAIInputMgr.device.pointer then 
  
  -- For mouse clicks
  MOAIInputMgr.device.mouseLeft:setCallback(
    function(isMouseDown)
      
      local x,y = MOAIInputMgr.device.pointer:getLoc()
      mouseStartX = x
      local touchedProp = partition:propForPoint(layer:wndToWorld(x, y))
      
      if(isMouseDown) then
        
        --------------------
        ---- Mouse down ----
        --------------------
         if gameState == "Menu" then
          
          if(touchedProp == text["mainStart"]:getTextProp()) then
            
            gameView:loadLevel()

          end
          
         end
        
        
        if gameState == "Playfield" then
          --------------------
          ---- Player 
          --------------------
          if(touchedProp == player:getPlayerProp()) then
            
            playerActionTimer:start()

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
          
             playerActionTimer:stop()

          end
         
          if player:getMovement() == true then
            
            player:setMovement(false)
          
          else
            
            if(touchedProp == player:getPlayerProp()) then
            
               table.insert(bullet, Bullet.create(player:getPlayerBody():getPosition()))

            end
          
          end
        
          --------------------
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