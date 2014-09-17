----------------------------
-- Variables
----------------------------
Block = {}
Block.__index = Block

----------------------------
-- Constructor
----------------------------

function Block.create(x, y, id)

  local blk = {}
  setmetatable(blk, Block)
  
  blk._size = 24
  blk._x = x
  blk._y = y
  blk._movement = true
  
  blk._body = world:addBody( MOAIBox2DBody.DYNAMIC )
  
  blk._body:setTransform( x, y )
  
  blk._fixture = blk._body:addRect( -blk._size, -blk._size, blk._size, blk._size )
  blk._fixture:setSensor(true)
  blk._fixture.userdata = id
  
  function handleCollision(phase, a, b, arbiter)
  
    if phase == MOAIBox2DArbiter.BEGIN then
      
      if tostring(b.userdata) ~= tostring(a.userdata) then
        
        blk._movement = false
      
      end
      
    elseif phase == MOAIBox2DArbiter.END then
        
      blk._movement = true
    
    end

  end
  
  blk._fixture:setCollisionHandler(handleCollision, MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END)
  
  -- Return obj
  return blk

end

----------------------------
-- Functions
----------------------------
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


