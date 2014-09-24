----------------------------
-- Core works
----------------------------
view["gamescreen"] = View.create(resourceManager:getTexture("background"))

player = Player.create()
blockGenerator = Blockinator.create()

local offset = 45
button["left"] = Button.create(-264, -deviceScreenHeight+offset, resourceManager:getTexture("leftBtn"))
button["jump"] = Button.create(-132, -deviceScreenHeight+offset, resourceManager:getTexture("jumpBtn"))
button["powerup"] = Button.create(0, -deviceScreenHeight+offset, resourceManager:getTexture("powerUpBtn"))
button["shoot"] = Button.create(132, -deviceScreenHeight+offset, resourceManager:getTexture("shootBtn"))
button["right"] = Button.create(264, -deviceScreenHeight+offset, resourceManager:getTexture("rightBtn"))

 --blockGenerator:make()

----------------------------
-- Spawn Wall
----------------------------
function spawnBlock()
  
  blockGenerator:make()
  
  for key,value in pairs(blocks) do
    
    if blocks[key]:getDestructionState() == true then
    
      table.remove(blocks, key)
      
    end
  
  end
  
  if blockGenerator:getMovement() == true then
  
    blockGenerator:drop()
    
  end


end

timer = MOAITimer.new()
timer:setSpan(5)
timer:setMode(MOAITimer.LOOP)
timer:setListener(MOAITimer.EVENT_TIMER_END_SPAN, spawnBlock)
timer:start()

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
  
  -- Bullets
  for key,value in pairs(bullet) do
    
    if bullet[key]:getDestructionState() == false then
     
      bullet[key]:move()
    
    end
  
  end
  
  -- Blocks
  for key,value in pairs(blocks) do
    
    if blocks[key]:getDestructionState() == false then
    
      blocks[key]:getBlockBody():setAwake(false)
      
    end
    
  end
  
  -- Player
  if player:getMovement() == true then player:move() end
  if player:getJumpState() == true then player:jump() end
 
end


--Floor testing()
bodies[0] = world:addBody( MOAIBox2DBody.STATIC )
bodies[0]:setTransform( 0, -330 )  
fixtures[0] = bodies[0]:addRect( -320, -10, 320, 10 )

-- Right Wall
bodies[1] = world:addBody( MOAIBox2DBody.STATIC )
bodies[1]:setTransform( 330, 75 )  
fixtures[1] = bodies[1]:addRect( -10, -390, 10, 390 )

-- Left Wall
bodies[2] = world:addBody( MOAIBox2DBody.STATIC )
bodies[2]:setTransform( -330, 75 )  
fixtures[2] = bodies[2]:addRect( -10, -390, 10, 390 )
