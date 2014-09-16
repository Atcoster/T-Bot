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
  
  blk._body = world:addBody( MOAIBox2DBody.STATIC )
  blk._body:setTransform( x, y )
  
  blk._fixture = blk._body:addRect( -blk._size, -blk._size, blk._size, blk._size )
  
  -- Return obj
  return blk

end

----------------------------
-- Functions
----------------------------