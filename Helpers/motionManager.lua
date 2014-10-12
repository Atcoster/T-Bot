----------------------------
-- Variables
----------------------------
MotionManager = {}
MotionManager.__index = MotionManager

local position = {}
position["pos"] = 0
----------------------------
-- Constructor
----------------------------
function MotionManager.create()
  
  local mm = {}
  setmetatable(mm, MotionManager)
  
  return mm
  
end

----------------------------
-- Functions
----------------------------
function MotionManager:getPos()
  return position["pos"]
end

 
 if MOAIInputMgr.device.level then
   if tiltControl == true then
  MOAIInputMgr.device.level:setCallback(
    function(x,y,z)
      
          if acceloSpeed > 0 and y < 0 then
            acceloSpeed = acceloSpeed+(y*10)
          elseif acceloSpeed < 0 and y > 0 then
            acceloSpeed = acceloSpeed+(y*10)
          else
            acceloSpeed = acceloSpeed+y
          end
    
          if acceloSpeed > 10 then
            acceloSpeed =10
          end
    
          if acceloSpeed < -10 then
            acceloSpeed = -10
          end
      
    end
  )
  end
end


