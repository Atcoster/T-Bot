----------------------------
-- Core works
----------------------------

--Create button
--test = Button.create(-50, 400, "Assets/img/Blue_brick.png")

--Create text field
--text = TextField.create(0, -100, 100, 50, "Testing")

--Create view
--view = View.create("Assets/img/map.jpg")

block = {}
-- Small Block
--[[
block[4] = Block.create(0+(0),200+(0))
block[5] = Block.create(0+(16*2), 200+(0))
block[6] = Block.create(0+(16*2), 200+(16*2))
block[7] = Block.create(0+(16*4), 200+(16*2))
--]]

--block[4] = Block.create(-280,400)

xCount = 0
yCount = 0
max = 13
amountBlocks = 26*8
blocksize = 24

for i=1, amountBlocks do 
  
  block[i] = Block.create(-285+(blocksize*(xCount*2)),420-(blocksize*(2*yCount)))
  
  if i == max then
   
    max = max + 13
    yCount = yCount + 1
    xCount = 0
  
  else
     xCount = xCount + 1
  end
  
end
