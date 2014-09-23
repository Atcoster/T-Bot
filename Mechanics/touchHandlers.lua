----------------------------
-- Mouse handlers
----------------------------
if MOAIInputMgr.device.pointer then 
  
  -- For mouse clicks
  MOAIInputMgr.device.mouseLeft:setCallback(
    function(isMouseDown)
        
      if(isMouseDown) then
        
        -- Mouse down 
        touch(MOAIInputMgr.device.pointer:getLoc())
        
      else
        -- Mouse Up
        if player:getMovement() == true then player:setMovement(false) end
        
        if player:getJumpState() == true then player:setJumpState(false) end

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

function touch(x, y) 
    
    local touchedProp = partition:propForPoint(layer:wndToWorld(x, y))
    
    
    if(touchedProp == button["right"]:getProp()) then
      
      player:setMovement(true)
      player:setDirection(5)
      
    end
    
    if(touchedProp == button["left"]:getProp()) then
      
      player:setMovement(true)
      player:setDirection(-5)
     
    end
    
    if(touchedProp == button["jump"]:getProp()) then
      
      player:setJumpState(true)
      
    end
    
    if(touchedProp == button["shoot"]:getProp()) then
      
      table.insert(bullet, Bullet.create(player:getPlayerBody():getPosition()))
      
    end
    
    
end