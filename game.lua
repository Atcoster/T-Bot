----------------------------
-- Game init
----------------------------
gameView = ViewControl.create()

gameView:loadMainMenu()
--gameView:loadLevelSelectMenu()
--gameView:loadLevel()


--reset_user_data()


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
      if tiltControl == false then
        local playerX, playerY = player:getPlayerBody():getPosition()
        if mouseStartX > (playerX+24) then
          
         player:move(1)
          
        end
        
        if mouseStartX < (playerX-24) then
        
        player:move(-1)
        
      end
    
    
    else
        player:move(acceloSpeed)
      end
    end
  end

end


