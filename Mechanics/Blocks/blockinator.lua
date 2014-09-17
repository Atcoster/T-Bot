----------------------------
-- Variables
----------------------------
Blockinator = {}
Blockinator.__index = Blockinator

local blocksize = 24
local shapes = {"ZR", "ZL", "O", "LR", "LL", "I", "T"}

----------------------------
-- Constructor
----------------------------
function Blockinator.create(x,y)
  
  local blk = {}
  setmetatable(blk, Blockinator)
  
  blk._x = x
  blk._y = y
  blk._block = {}
  
  blk._movement = y
  
  blk:make(shapes[math.random(1,7)])
  
  return blk
  
end
----------------------------
-- Functions
----------------------------
function Blockinator:make(shape)
  
  local x = self._x
  local y = self._y
  local id = blockAmount
  
  print(shape)
  
  if shape == "ZR" then
    
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x+(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*2), y+(blocksize*2), id)
    self._block[4] = Block.create(x+(blocksize*4), y+(blocksize*2), id)
  
  elseif shape == "ZL" then
    
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x+(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*0), y+(blocksize*2), id)
    self._block[4] = Block.create(x-(blocksize*2), y+(blocksize*2), id)
  
  elseif shape == "O" then
  
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x+(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*0), y+(blocksize*2), id)
    self._block[4] = Block.create(x+(blocksize*2), y+(blocksize*2), id)
  
  elseif shape == "LR" then
    
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x+(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*0), y+(blocksize*2), id)
    self._block[4] = Block.create(x+(blocksize*0), y+(blocksize*4), id)
    
  elseif shape == "LL" then
    
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x-(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*0), y+(blocksize*2), id)
    self._block[4] = Block.create(x+(blocksize*0), y+(blocksize*4), id)
    
  elseif shape == "I" then
  
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x+(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*4), y+(blocksize*0), id)
    self._block[4] = Block.create(x-(blocksize*2), y+(blocksize*0), id)
    
  elseif shape == "T" then
    
    self._block[1] = Block.create(x+(blocksize*0), y+(blocksize*0), id)
    self._block[2] = Block.create(x-(blocksize*2), y+(blocksize*0), id)
    self._block[3] = Block.create(x+(blocksize*2), y+(blocksize*0), id)
    self._block[4] = Block.create(x+(blocksize*0), y+(blocksize*2), id)
    
  end
  
  blockAmount = blockAmount + 1

end

function Blockinator:drop()
  
  self._movement = self._movement - 3
  
  --FIX THIS ISSUE!!!!
  self._block[1]:getBlockBody():setTransform(self._block[1]:getBlockPosition("x"), self._movement)
  self._block[2]:getBlockBody():setTransform(self._block[2]:getBlockPosition("x"), self._movement)
  self._block[3]:getBlockBody():setTransform(self._block[3]:getBlockPosition("x"), self._movement+(blocksize*2))
  self._block[4]:getBlockBody():setTransform(self._block[4]:getBlockPosition("x"), self._movement+(blocksize*2))
  
end

function Blockinator:getMovement()
  
  if self._block[1]:getMovement() == false or self._block[2]:getMovement() == false
  or self._block[3]:getMovement() == false or self._block[4]:getMovement() == false then
    
    return false
    
  else
  
    return true
    
  end
  
end
