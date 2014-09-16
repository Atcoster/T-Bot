----------------------------
-- Variables
----------------------------
Block = {}
Block.__index = Block

----------------------------
-- Constructor
----------------------------

function Block.create(x,y)

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
  
  
  function handleCollision(phase, a, b, arbiter)
  
    if phase == MOAIBox2DArbiter.BEGIN then
      
      if b == fixtures[0] then
        
        
        --blk._body:setTransform(0,0)
        print("HITTT")
      
      end
    
    elseif phase == MOAIBox2DArbiter.END then
        
      print("....")
    
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


