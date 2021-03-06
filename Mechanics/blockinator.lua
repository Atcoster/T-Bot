----------------------------
-- Variables
----------------------------
Blockinator = {}
Blockinator.__index = Blockinator

local blocksize = 24

local boxType = {"wood", "metal", "bomb", "wall", "freeze", "fire", "arrow", "part","portal","air"}

--[[
  
  1 = wood
  2 = metal
  3 = bomb
  4 = wall
  5 = freeze
  6 = fire
  7 = arrow
  
  8 = parts
  9= portal
  10=air
  
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"
  
]]--

local grid = {
  
  [1] = {
  "1", "1", "1", "1", "1", "1", "8", "1", "1", "1", "1", "1", "4",
  "7", "7", "7", "1", "1", "1", "7", "1", "1", "1", "3", "8", "4",
  "2", "2", "2", "4", "1", "1", "1", "1", "1", "1", "1", "1", "4",
  "3", "3", "3", "4", "1", "1", "1", "1", "1", "1", "4", "4", "4",
  "3", "8", "3", "4", "1", "1", "1", "1", "1", "1", "4", "4", "4",
  "3", "3", "3", "4", "1", "1", "7", "1", "1", "1", "2", "5", "4",
  "4", "4", "4", "4", "1", "1", "1", "1", "1", "1", "4", "4", "4",
  "2", "2", "2", "2", "2", "2", "2", "2", "2", "2", "4", "4", "4",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "4", "6", "4",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "4", "2", "4",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "3", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"
  },
  
  [2] = {
  "2", "2", "2", "1", "1", "1", "1", "1", "1", "1", "2", "2", "2",
  "2", "8", "2", "5", "1", "1", "1", "1", "1", "1", "2", "6", "2",
  "2", "2", "2", "1", "1", "1", "1", "1", "1", "1", "2", "2", "2",
  "4", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "3", "4",
  "4", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "4",
  "4", "1", "1", "7", "1", "3", "8", "3", "1", "7", "1", "1", "4",
  "4", "1", "1", "1", "1", "4", "4", "4", "1", "1", "1", "1", "4",
  "4", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "4",
  "4", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "4",
  "4", "1", "1", "7", "1", "1", "1", "1", "1", "7", "1", "1", "4",
  "4", "1", "1", "3", "3", "3", "3", "3", "3", "3", "1", "1", "4",
  "4", "8", "1", "1", "1", "1", "8", "1", "1", "1", "1", "8", "4"
  },

  [3] = {
  "8", "1", "1", "1", "1", "1", "1", "7", "7", "1", "1", "1", "1",
  "1", "7", "1", "5", "1", "1", "1", "1", "1", "1", "1", "1", "1",
  "2", "1", "1", "1", "1", "1", "1", "1", "8", "1", "1", "1", "1",
  "1", "7", "1", "1", "1", "1", "1", "1", "3", "1", "1", "1", "1",
  "1", "1", "4", "3", "2", "1", "1", "1", "1", "1", "1", "7", "1",
  "1", "1", "4", "8", "2", "1", "2", "1", "1", "1", "1", "1", "7",
  "1", "1", "4", "4", "4", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "2", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "3", "1", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "3", "6", "3", "1", "1", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "3", "1", "1", "1", "1", "8", "1", "1", "1",
  "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"
},

[4] = {
  "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3",
  "3", "8", "7", "1", "3", "3", "3", "3", "3", "3", "3", "3", "3",
  "3", "1", "7", "7", "1", "1", "1", "1", "1", "1", "1", "7", "3",
  "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "1", "3",
  "3", "7", "1", "1", "1", "1", "1", "1", "1", "1", "1", "7", "3",
  "3", "1", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3",
  "3", "1", "3", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
  "3", "1", "3", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
  "3", "1", "3", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
  "3", "1", "3", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
  "3", "1", "3", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4",
  "3", "1", "3", "4", "4", "4", "4", "4", "4", "4", "4", "4", "4"
},

[5] = {
  "6", "4", "4", "4", "8", "1", "1", "1", "1", "1", "1", "1", "1",
  "3", "3", "8", "3", "3", "1", "7", "1", "1", "1", "1", "1", "7",
  "1", "1", "2", "2", "2", "4", "1", "4", "1", "3", "1", "3", "1",
  "1", "1", "2", "3", "1", "1", "1", "1", "1", "8", "1", "1", "7",
  "1", "1", "2", "2", "2", "4", "1", "4", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "4", "7", "1", "1", "1", "1", "7", "1",
  "7", "1", "7", "1", "7", "4", "1", "4", "1", "1", "1", "1", "1",
  "1", "1", "1", "1", "1", "4", "1", "4", "1", "1", "1", "3", "1",
  "1", "1", "1", "1", "1", "4", "1", "4", "1", "1", "1", "1", "1",
  "1", "1", "7", "1", "1", "1", "1", "1", "1", "1", "1", "7", "1",
  "1", "1", "1", "1", "1", "4", "1", "4", "1", "1", "2", "5", "2",
  "4", "4", "4", "4", "4", "4", "1", "4", "4", "4", "4", "4", "4"
},

[6] = { "7","5","2","1","7","1","1","1","7","4","1","1","8",
"1","4","4","1","1","1","1","1","1","4","1","1","3",
"1","4","1","1","1","1","1","1","1","4","8","3","9",
"1","4","1","1","1","1","1","1","1","4","1","1","3",
"2","4","1","1","1","1","1","1","1","4","1","1","8",
"9","2","1","1","1","7","1","1","7","4","4","4","4",
"2","4","1","1","1","1","1","1","4","4","1","1","1",
"1","1","1","1","1","1","1","1","1","1","4","4","4",
"1","1","1","1","1","7","1","1","1","1","3","2","6",
"1","1","1","1","1","1","1","1","1","1","4","4","4",
"1","1","1","1","1","1","1","1","1","1","1","1","1",
"1","1","1","1","1","1","1","1","1","1","1","1","1" },

[7]= { "7","1","1","1","7","1","1","1","7","1","1","1","7",
"1","1","1","1","1","1","1","1","1","1","1","1","1",
"1","1","1","1","1","1","1","1","1","1","1","1","1",
"7","1","9","3","8","1","1","1","8","3","9","1","7",
"4","4","4","1","9","4","4","4","9","1","4","4","4",
"3","3","7","1","1","1","9","1","1","1","7","3","3",
"3","8","7","3","3","3","3","3","3","3","7","8","3",
"3","3","7","1","1","1","9","1","1","1","7","3","3",
"4","4","4","4","4","4","1","4","4","4","4","4","4",
"1","9","1","1","1","1","1","1","1","1","1","9","1",
"1","1","1","1","1","1","1","1","1","1","1","1","1",
"1","1","1","1","1","1","1","1","1","1","1","1","1" }

}
-----------------
-- used for saving portal locations dont delete
-----------------
local portalId ={
}

------------------
-- portal connections MANDATORY
--------------------------------
local portalCon ={
  [6] = {[1]=2,[2]=1},
  [7] = {[1]=5,[2]=6,[3]=8,[4]=7,[5]=6,[6]=5,[7]=3,[8]=4}
}

----------------------------
-- Constructor
----------------------------
function Blockinator.create(level)
  
  local blk = {}
  setmetatable(blk, Blockinator)
  
  blk._startY = 480
  blk._amountParts = 0
  blk._level = level
 --blk._portalConect = portalCon
  blk._movement = 1
  
  return blk
  
end
----------------------------
-- Functions
----------------------------
function Blockinator:make()
  
  -- Ceiling
  for i=0, 12 do
    table.insert(blocks, Block.create(-288+(blocksize*(i*2)), 398, "wall"))
  end
  
  local y = 350
  local x = -288
  
  local yCount = 0
  local maxy = 13
  local portalCount =0
  local xcount = 0
  
  for i=1, 156 do
    
    local c = tonumber(grid[self._level][i])
    
    if boxType[c] == "portal" then
     portalCount = portalCount+1
    table.insert(blocks, Block.create(x+(blocksize*(xcount*2)), y-(blocksize*(yCount*2)), boxType[c],portalCon[currentLevel][portalCount]))
    portalId[portalCount]=i+13
  else
     table.insert(blocks, Block.create(x+(blocksize*(xcount*2)), y-(blocksize*(yCount*2)), boxType[c]))
     end
    if boxType[c] == "part" then
    
      self._amountParts = self._amountParts + 1
    
    end
    
    xcount = xcount + 1
    
    if i == maxy then
      
      xcount = 0
      yCount = yCount + 1
      maxy = maxy + 13
    
    end
  
  end


end

function Blockinator:getAmountParts()
  
  return self._amountParts
  
end

function Blockinator:getPortal(p)
  
  return blocks[portalId[p]]:getBlockBody():getPosition() 
  --blocks[portalCon[currentLevel][p]]:getBlockBody():getPosition()
  
end

function Blockinator:getLevelAmount() return table.getn(grid) end
