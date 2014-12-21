----------------------------
-- Game init
----------------------------
gameView = ViewControl.create()

gameView:loadMainMenu()
--gameView:loadLevelSelectMenu()
--gameView:loadLevel()




print(user_data.levelData["level1"]["status"])
print(user_data.levelData["level2"]["status"])
print(user_data.levelData["level3"]["status"])
print(user_data.levelData["level4"]["status"])
print(user_data.levelData["level5"]["status"])
  
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
    
    if gameState == "Playfield" then
      --------------
      --motionsensor
      --------------
      
      ---------------
      -- Bullets
      ---------------
      for key,value in pairs(bullet) do
        
        if bullet[key]:getDestructionState() == false then
         
          bullet[key]:move()
        
        end
      
      end
    
      ---------------
      -- Blocks
      ---------------
      for key,value in pairs(blocks) do
        
        if blocks[key]:getDestructionState() == false then
          
          blocks[key]:getBlockBody():setAwake(false)
          
        end
        
      end
    
    ---------------
    -- Player
    ---------------
    mouseStartX = mouseStartX+acceloSpeed
    
    if player:getMovement() == true then 
      
      local playerX, playerY = player:getPlayerBody():getPosition()
      
      if playerX < mouseStartX then
        
        if playerX > mouseStartX and playerX < (mouseStartX + 24) then
          
          player:move(0)
          
          
        else
        
          player:move(8)
        
        end
        
      end
      
      if playerX > mouseStartX then
        
        if playerX > mouseStartX and playerX < (mouseStartX + 24) then
          
          player:move(0)
          
        else
        
          player:move(-8)
        
        end
        
      end
    
    end

  end

end
