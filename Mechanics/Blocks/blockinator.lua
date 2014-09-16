----------------------------
-- Variables
----------------------------
Blockinator = {}
Blockinator.__index = Blockinator

local blocksize = 24

----------------------------
-- Constructor
----------------------------
function Blockinator.create(x,y)
  
  local blk = {}
  setmetatable(blk, Blockinator)
  
  blk._x = x
  blk._y = y
  blk._block = {}
  
  blk:make()
  
  return blk
  
end
----------------------------
-- Functions
----------------------------
function Blockinator:make()
  
  local x = self._x
  local y = self._y
  
  self._block[1] = Block.create(x+(0),y+(0))
  self._block[2] = Block.create(x+(blocksize*2), y+(0))
  self._block[3] = Block.create(x+(blocksize*2), y+(blocksize*2))
  self._block[4] = Block.create(x+(blocksize*4), y+(blocksize*2))

end

function Blockinator:move(x,y)
  
  
  self._block[1]:getBlockBody():setTransform(x+(0),y+(0))
  self._block[2]:getBlockBody():setTransform(x+(blocksize*2), y+(0))
  self._block[3]:getBlockBody():setTransform(x+(blocksize*2), y+(blocksize*2))
  self._block[4]:getBlockBody():setTransform(x+(blocksize*4), y+(blocksize*2))
 
  
end
