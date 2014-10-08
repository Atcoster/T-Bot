----------------------------
-- Variables
----------------------------
Block = {}
Block.__index = Block

local bombCount = 1
local blockVictim = {}
local victimCount = 1

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
  
  blk._animProp = MOAIProp2D.new()  
  blk._animation = MOAIAnim:new()
  blk._curve = MOAIAnimCurve.new()
  
  --Body
  blk._body = world:addBody( MOAIBox2DBody.DYNAMIC )
  blk._body:setTransform( x, y )
  
  --Fixture
  blk._fixture = blk._body:addRect( -blk._size, -blk._size, blk._size, blk._size )
  blk._fixture:setSensor(true)
  
  if blockType == "bomb" then 
    
    blk._fixture.userdata = {blockType, "danger", {}, bombCount}
    bombCount = bombCount + 1
    
  else
  
    blk._fixture.userdata = {blockType, "safe", {}, 0}
  
  end
  
  -- Texture
  blk._image = MOAIGfxQuad2D.new()
  blk._prop = MOAIProp2D.new()
  
  --Collision
  function handleCollision(phase, a, b, arbiter)
    
    -- Set all boxes around surrounding the bomb to bombable
    if a.userdata[1] == "bomb" then
      
      if b.userdata[1] ~= nil and b.userdata[1] ~= "wall" and b.userdata[1] ~= "arrow" and b.userdata[1] ~= "Bullet" then
        
        table.insert(b.userdata[3], a.userdata[4])
        
        b.userdata[2] = "danger"
      
      end
      
    end
    
    if phase == MOAIBox2DArbiter.BEGIN then
      
      --------------------------
      -- General
      --------------------------
      if b.userdata[1] == "Bullet" and b ~= nil then
        
        ----------------------------------------------------
        -- Ignore destruction at certain blocks
        ----------------------------------------------------
        if a.userdata[1] ~= "wall" and a.userdata[1] ~= "metal" and a.userdata[1] ~= "bomb" and a.userdata[1] ~= "arrow" then
          
          if a.userdata[1] == "fire" then 
            
            button["firePowerupButton"]:changeTexture(resourceManager:getTexture("inactiveFireButton"))
            button["firePowerupButton"]:setmissileActivation(true)
          
          end
        
          if a.userdata[1] == "freeze" then 
            
            button["freezePowerupButton"]:changeTexture(resourceManager:getTexture("inactiveFreezeButton"))
            button["freezePowerupButton"]:setmissileActivation(true)
          
          end
          
          if a.userdata[1] == "wood" then
            
            blk:woodDestroy(a:getBody():getPosition())
          
          elseif a.userdata[1] == "part" then
            
            progressBar:moveProgressbarImage()
            blk:destruction()
            
            if progressBar:getRemainingParts() == 0 then
            
              gameView:gamePopupWin()
            
            end
            
          else
            
            blk:destruction()
          
          end
 
        end
        
        --------------------------
        -- Powerup effects
        --------------------------
        if b.userdata[2] == "freeze" then
          
          if a.userdata[1] == "bomb" then
            
            blk:freeze(a:getBody():getPosition())
            
          end
        
        elseif b.userdata[2] == "fire" then
          
          if a.userdata[1] == "metal" then
            
            blk:melt(a:getBody():getPosition())
            
          end
          
        end
        
        --------------------------
        -- Bomb mecahnics
        --------------------------
        if a.userdata[1] == "bomb" and b.userdata[2] ~= "freeze" then
          
          blk:explosion(a:getBody():getPosition())
          
        end
        
        --------------------------
        -- Bullet rotation
        --------------------------
        if b.userdata[1] == "Bullet" and b ~= nil then
        
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
  
  if self._fixture.userdata[1] == "part" then
    
    local part = self._fixture.userdata[1]..tostring(math.random(1, 10))
    
    self._image:setTexture(resourceManager:getTexture(part))
  
  else
  
    self._image:setTexture(resourceManager:getTexture(self._fixture.userdata[1]))
  
  end
  
  self._image:setRect(-24, -24, 24, 24)

  self._prop:setDeck(self._image)
  
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
end

function Block:destruction()
  
  if self:getUserdata(1) ~= "bomb" and self._destruction == false then
    
    self._destruction = true
    layer:removeProp(self._prop)
    self._body:destroy()
  
  end
  
end

function Block:moveBlock(direction)
    
    local x,y = self._body:getPosition()
    self._body:setTransform(x + direction,y)
    
end

function Block:freeze(x,y)
  
  self:animate(7, 0.05,"freezeBomb", x, y)
  
end

function Block:melt(x,y)
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  
  self:animate(7, 0.05,"meltMetal", x, y)
  
end

function Block:woodDestroy(x,y)
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  
  self:animate(7, 0.02,"destroyWood", x, y)
  
end

function Block:explosion(x,y)
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  
 for key,value in pairs(blocks) do

    if blocks[key]:getUserdata(2) == "danger" then
      
      for key2,value2 in pairs(blocks[key]:getUserdata(3)) do
        
        if value2 == self:getUserdata(4) then
          
          if blocks[key]:getUserdata(1) == "bomb" then
        
            if blocks[key]:getDestructionState() == false then
                            
              blocks[key]:explosion(blocks[key]:getBlockBody():getPosition())
              
            end
            
          else
          
           blocks[key]:destruction()
          
          end
            
        end
        
      end
      
    end
     
  end
  
  self:animate(9, 0.05,"explosion", x, y)
    
end

function Block:animate(tl, sp, dck, x, y)
  
  local tiles = tl
  local speed = sp
  
  self._animProp:setDeck(ResourceManager:getTexture(dck))
  self._animProp:setLoc(x,y)
  
  layer:insertProp(self._animProp)

  self._curve:reserveKeys(tiles)

  for i=1,tiles,1 do
    
    self._curve:setKey(i, speed * i, i)
    
  end

  self._animation:reserveLinks(1)
  self._animation:setLink(1, self._curve, self._animProp, MOAIProp2D.ATTR_INDEX)
  self._animation:setMode(MOAITimer.LOOP)
  self._animation:setSpan(tiles * speed)
  self._animation:start()
  
  self._animation:setListener(MOAIAnim.EVENT_TIMER_END_SPAN, 
  function()
    self._animation:stop()
    layer:removeProp(self._animProp)
    
    if dck == "freezeBomb" then
      
      
      self._fixture.userdata[1] = "frozenBomb"
      self:changeTexture()
      
    end
    
  end)
  
end

-- Set Texture
function Block:changeTexture(texture)
  
  layer:removeProp(self._prop)
  self:make()
  
end

function Block:getBlockBody() return self._body end

function Block:getBlockProp() return self._prop end

function Block:getUserdata(index) return self._fixture.userdata[index] end

function Block:getDestructionState() return self._destruction end
function Block:setDestruction(state) self._destruction = state end

function Block:getMovement() return self._movement end
function Block:setMovement(state) self._movement = state end