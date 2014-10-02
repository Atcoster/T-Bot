----------------------------
-- Variables
----------------------------
Block = {}
Block.__index = Block

local bombCount = 1

----------------------------
-- Constructor
----------------------------

function Block.create(x, y, blockType)

  local blk = {}
  setmetatable(blk, Block)
  
  blk._size = 24
  blk._x = x
  blk._y = y
  blk._movement = false
  blk._destruction = false
  
  --Body
  blk._body = world:addBody( MOAIBox2DBody.DYNAMIC )
  blk._body:setTransform( x, y )
  
  --Fixture
  blk._fixture = blk._body:addRect( -blk._size, -blk._size, blk._size, blk._size )
  blk._fixture:setSensor(true)
  
  if blockType == "bomb" then 
    
    blk._fixture.userdata = {blockType, "safe", bombCount}
    bombCount = bombCount + 1
    
  elseif blockType == "m_wall" then
  
    blk._fixture.userdata = {"wall", "moveable", 0}
  
  else
  
    blk._fixture.userdata = {blockType, "safe", 0}
  
  end
  
  -- Texture
  blk._image = MOAIGfxQuad2D.new()
  blk._prop = MOAIProp2D.new()
  
  --Collision
  function handleCollision(phase, a, b, arbiter)
    
    -- Set all boxes around surrounding the bomb to bombable
    if a.userdata[1] == "bomb" then
      
      if b.userdata[1] ~= nil and b.userdata[1] ~= "wall" and b.userdata[1] ~= "arrow" then
        b.userdata[3] = a.userdata[3]
        b.userdata[2] = "danger"
      end
      
    end
    
    if phase == MOAIBox2DArbiter.BEGIN then
      
      --------------------------
      -- General
      --------------------------
      if b.userdata == "Bullet" and b ~= nil then
        
        
        ----------------------------------------------------
        -- Ignore destruction at certain blocks
        ----------------------------------------------------
        if a.userdata[1] ~= "wall" and a.userdata[1] ~= "metal" and a.userdata[1] ~= "bomb" and a.userdata[1] ~= "arrow" then
          
          blk:destruction()
          
        end
        
        --------------------------
        -- Bomb Mechanics
        --------------------------
        if a.userdata[1] == "bomb" then
          
          blk:explosion(a:getBody():getPosition())
          blk:destruction()
          
           for key,value in pairs(blocks) do
    
            if blocks[key]:getUserdata(2) == "danger" and blocks[key]:getUserdata(3) == a.userdata[3] then
              
              blocks[key]:destruction()
            
            end
             
          end
          
        end
        
        --------------------------
        -- Bullet rotation
        --------------------------
        if b.userdata == "Bullet" and b ~= nil then
        
          if a.userdata[1] == "arrow" then
            
            local arrowprop = blk:getBlockProp()
            local rotation = arrowprop:getRot()
            
            function changeDirection()
    
              for key,value in pairs(bullet) do
            
                if bullet[key]:getBulletBody() == b:getBody() then
                
                  if rotation > -10 and rotation < 10 then
                     
                    bullet[key]:setDirection("up", a:getBody():getPosition())

                  elseif rotation > 260 and rotation < 280 then
                  
                    bullet[key]:setDirection("right", a:getBody():getPosition())
                  
                  elseif rotation > 170 and rotation < 190 then
                  
                    bullet[key]:setDirection("down", a:getBody():getPosition())
                
                  elseif rotation > 80 and rotation < 100 then
                    
                    bullet[key]:setDirection("left", a:getBody():getPosition())
                    
                  end
              
                end
            
              end
                
            end

            local timer = MOAITimer.new()
            timer:setSpan(0.1)
            timer:setMode(MOAITimer.NORMAL)
            timer:setListener(MOAITimer.EVENT_TIMER_END_SPAN, changeDirection)
            timer:start()
            
          end
          
        end
        
        ----------------------------
        -- Bullet destruction
        ----------------------------
        if a.userdata[1] ~= "arrow" then
        
          for key,value in pairs(bullet) do
            
            if bullet[key]:getBulletBody() == b:getBody() then
              
              bullet[key]:destruction()
            
            end
             
          end
        
        end
       
      end
      
    end

  end
  
  blk._fixture:setCollisionHandler(handleCollision, MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END)
  
  blk:make()
  
  return blk

end

----------------------------
-- Functions
----------------------------
function Block:make()
  
  self._image:setTexture(resourceManager:getTexture(self._fixture.userdata[1]))
  
  self._image:setRect(-24, -24, 24, 24)

  self._prop:setDeck(self._image)
  
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
end

function Block:destruction()
  
  if self._body ~= nil then
    self._destruction = true
    layer:removeProp(self._prop)
    self._body:destroy()
  end
  
end

function Block:moveBlock(direction)
    
    local x,y = self._body:getPosition()
    self._body:setTransform(x + direction,y)
    
end

function Block:explosion(x,y)
    
  local explodeProp = MOAIProp2D.new()  
    
  local tiles = 9
  local speed = 0.05
  
  explodeProp:setDeck(ResourceManager:getTexture("explosion"))
  explodeProp:setLoc(x,y)
  
  layer:insertProp(explodeProp)

  curve = MOAIAnimCurve.new()
  curve:reserveKeys(tiles)

  for i=1,tiles,1 do
    
    curve:setKey(i, speed * i, i)
    
  end

  anim = MOAIAnim:new()
  anim:reserveLinks(1)
  anim:setLink(1, curve, explodeProp, MOAIProp2D.ATTR_INDEX)
  anim:setMode(MOAITimer.LOOP)
  anim:setSpan(tiles * speed)
  anim:start()
  
  anim:setListener(MOAIAnim.EVENT_TIMER_END_SPAN, 
  function()
    anim:stop()
    layer:removeProp(explodeProp)
  end
)
    
end

function Block:getBlockBody() return self._body end

function Block:getBlockProp() return self._prop end

function Block:getUserdata(index) return self._fixture.userdata[index] end

function Block:getDestructionState() return self._destruction end
function Block:setDestruction(state) self._destruction = state end

function Block:getMovement() return self._movement end
function Block:setMovement(state) self._movement = state end