----------------------------
-- Game init
----------------------------
gameView = ViewControl.create()

gameView:loadMainMenu()
--gameView:loadLevelSelectMenu()
--gameView:loadLevel()


--reset_user_data()
--[[
print(user_data.levelData["level1"])
print(user_data.levelData["level2"])
print(user_data.levelData["level3"])
print(user_data.levelData["level4"])
print(user_data.levelData["level5"])
--]]
  
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