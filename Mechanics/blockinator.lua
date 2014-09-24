----------------------------
-- Variables
----------------------------
Blockinator = {}
Blockinator.__index = Blockinator

local blocksize = 24

----------------------------
-- Constructor
----------------------------
function Blockinator.create()
  
  local blk = {}
  setmetatable(blk, Blockinator)
  
  blk._startY = 480
  
  blk._movement = 1
  
  return blk
  
end
----------------------------
-- Functions
----------------------------
function Blockinator:make()
  
  local y = self._startY
  local x = 0
  
  table.insert(blocks, Block.create(x-(blocksize*12), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x-(blocksize*10), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x-(blocksize*8), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x-(blocksize*6), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x-(blocksize*4), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x-(blocksize*2), y+(blocksize*0), "Block"))
  
  table.insert(blocks, Block.create(x+(blocksize*0), y+(blocksize*0), "Block"))
  
  table.insert(blocks, Block.create(x+(blocksize*2), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x+(blocksize*4), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x+(blocksize*6), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x+(blocksize*8), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x+(blocksize*10), y+(blocksize*0), "Block"))
  table.insert(blocks, Block.create(x+(blocksize*12), y+(blocksize*0), "Block"))

end

function Blockinator:drop()
  
  for key,value in pairs(blocks) do
    
    if blocks[key]:getDestructionState() == false then
      
      blocks[key]:getBlockBody():setTransform(blocks[key]:getBlockPosition("x"),blocks[key]:getBlockPosition("y")-(48))
    
    end
    
  end
  
end

function Blockinator:getMovement()
  
  for key,value in pairs(blocks) do --actualcode
    
    if blocks[key]:getMovement() == false  then
    
      return false
      
    else

      return true
      
    end
  
  end

end
