----------------------------
-- Core works
----------------------------

----------------------------------
-- Game loop
----------------------------------

thread = MOAIThread.new()
thread:run(function() 
    
    while true do
    
      update()
      -- Start next thread
      coroutine.yield()
    
    end
    
end)

function update() 
  
  for key,value in pairs(blocks) do --actualcode
    
    if blocks[key]:getMovement() == true then
    
      blocks[key]:drop()
    
    end
  
  end
 
end


--Floor
bodies[0] = world:addBody( MOAIBox2DBody.STATIC )
bodies[0]:setTransform( 0, -300 )  
fixtures[0] = bodies[0]:addRect( -300, -10, 300, 10 )

----------------------------------
--Play Field
----------------------------------

--[[
block = {}
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
--]]