----------------------------
-- Core works
----------------------------
view["gamescreen"] = View.create(resourceManager:getTexture("background"))

player = Player.create()
blockGenerator = Blockinator.create()

blockGenerator:make()


----------------------------------
-- Animations
----------------------------------
local tiles = 4
local speed = 0.1

curve = MOAIAnimCurve.new()
curve:reserveKeys(tiles)

for i=1,tiles,1 do
  
  curve:setKey(i, speed * i, i)
  
end

anim = MOAIAnim:new()
anim:reserveLinks(1)
anim:setLink(1, curve, player:getPlayerProp(), MOAIProp2D.ATTR_INDEX)
anim:setMode(MOAITimer.LOOP)
anim:setSpan(tiles * speed)
anim:start()

----------------------------------
-- Game loop
----------------------------------

thread = MOAIThread.new()
thread:run(function() 
    
    while true do
    
      update()
      -- Start next thread
      coroutine.yield()
    
    end
    
end)

function update() 
  
  local mouseX, mouseY = MOAIInputMgr.device.pointer:getLoc()
  
  
  -- Bullets
  for key,value in pairs(bullet) do
    
    if bullet[key]:getDestructionState() == false then
     
      bullet[key]:move()
    
    end
  
  end
  
  -- Blocks
  for key,value in pairs(blocks) do
    
    if blocks[key]:getUserdata(2) == "moveable" then
      
      if blocks[key]:getMovement() == true then
        
        -- Swipe movement
        if mouseStartX < mouseX then
          print("Moving LEFT")
          blocks[key]:moveBlock(-1)
        else
          print("Moving RIGHT")
          blocks[key]:moveBlock(1)
        end
      
      end
      
    end

    if blocks[key]:getDestructionState() == false then
      
      blocks[key]:getBlockBody():setAwake(false)
      
    end
    
  end
  
  -- Player
  if player:getMovement() == true then player:move(layer:wndToWorld(mouseX, mouseY)) end
 
end


--Floor testing()
bodies[0] = world:addBody( MOAIBox2DBody.STATIC )
bodies[0]:setTransform( 0, -400 )  
fixtures[0] = bodies[0]:addRect( -320, -10, 320, 10 )

-- Right Wall
bodies[1] = world:addBody( MOAIBox2DBody.STATIC )
bodies[1]:setTransform( 330, 75 )  
fixtures[1] = bodies[1]:addRect( -10, -390, 10, 390 )

-- Left Wall
bodies[2] = world:addBody( MOAIBox2DBody.STATIC )
bodies[2]:setTransform( -330, 75 )  
fixtures[2] = bodies[2]:addRect( -10, -390, 10, 390 )
