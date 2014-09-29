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
      
      if b.userdata[1] ~= nil then
        b.userdata[3] = a.userdata[3]
        b.userdata[2] = "danger"
      end
      
    end
    
    if phase == MOAIBox2DArbiter.BEGIN then
      
      if b.userdata == "Bullet" and b ~= nil then
        
        if a.userdata[1] == "wood" or a.userdata[1] == "bomb" then
          
          blk:destruction()
          
        end
        
        if a.userdata[1] == "bomb" then
          
           for key,value in pairs(blocks) do
    
            if blocks[key]:getUserdata(2) == "danger" and blocks[key]:getUserdata(3) == a.userdata[3] then
              
              blocks[key]:destruction()
            
            end
             
          end
          
        end
        
        for key,value in pairs(bullet) do
          
          if bullet[key]:getBulletBody() == b:getBody() then
            
            bullet[key]:destruction()
          
          end
           
        end
       
      end
      
    elseif phase == MOAIBox2DArbiter.END then
      
      
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

function Block:getBlockBody() return self._body end

function Block:getBlockProp() return self._prop end

function Block:getUserdata(index) return self._fixture.userdata[index] end

function Block:getDestructionState() return self._destruction end
function Block:setDestruction(state) self._destruction = state end

function Block:getMovement() return self._movement end
function Block:setMovement(state) self._movement = state end