----------------------------
-- Variables
----------------------------
Block = {}
Block.__index = Block

----------------------------
-- Constructor
----------------------------

function Block.create(x, y)

  local blk = {}
  setmetatable(blk, Block)
  
  blk._size = 24
  blk._x = x
  blk._y = y
  blk._movement = true
  blk._destruction = false
  
  --Body
  blk._body = world:addBody( MOAIBox2DBody.DYNAMIC )
  blk._body:setTransform( x, y )
  
  --Fixture
  blk._fixture = blk._body:addRect( -blk._size, -blk._size, blk._size, blk._size )
  blk._fixture:setSensor(true)
  blk._fixture.userdata = "Block"
  
  -- Texture
  blk._image = MOAIGfxQuad2D.new()
  blk._prop = MOAIProp2D.new()
  
  --Collision
  function handleCollision(phase, a, b, arbiter)
  
    if phase == MOAIBox2DArbiter.BEGIN then
      
      if b.userdata == "Bullet" and b ~= nil then
        
        blk:destruction()
        
        for key,value in pairs(bullet) do --actualcode
    
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

  self._image:setTexture(resourceManager:getTexture("box"))
  self._image:setRect(-24, -24, 24, 24)

  self._prop:setDeck(self._image)
  
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
end

function Block:getBlockBody()
  
  return self._body
  
end

function Block:getMovement()
  
  return self._movement
  
end

function Block:getBlockPosition(pos)
    
    
    local x,y = self._body:getPosition()
    
    if pos == "x" then return x end
    if pos == "y" then return y end
    if pos == nil then return self._body:getPosition() end
    
end

function Block:getId()
  
  return self._id
  
end

function Block:getDestructionState()
  
  return self._destruction
  
end

function Block:destruction()
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  
end


