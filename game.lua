----------------------------
-- Core works
----------------------------

--Create button
--test = Button.create(-50, 400, "Assets/img/Blue_brick.png")

--Create text field
--text = TextField.create(0, -100, 100, 50, "Testing")

--Create view
--view = View.create("Assets/img/map.jpg")

-- Small Block
block = Blockinator.create(0,200)
block2 = Blockinator.create(-200,200)

position = 200
position2 = 200
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
  
  position = position - 2
  position2 = position2 - 0.5
  
  block:move(0,position)
  block2:move(-200,position2)
  
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