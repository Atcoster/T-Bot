----------------------------
-- Variables
----------------------------
ViewControl = {}
ViewControl.__index = ViewControl

----------------------------
-- Constructor
----------------------------
function ViewControl.create()
  
  local vc = {}
  setmetatable(vc, ViewControl)
  
  return vc
  
end

----------------------------
-- Functions
----------------------------

----------------------------
-- Clear view
----------------------------
function clearView()
  
  -- Clear all blocks
  for key, value in pairs(blocks) do
    if blocks[key] ~= nil then
      blocks[key]:destroy();
      blocks[key] = nil;
    end
  end
  
  --Remove all props
  layer:clear()
  
  -- Reset arrays
  button = {}
  text = {}
  view = {}
  player = {}
  bullet = {}

  blocks = {}
  blockGenerator = {}
  
end

----------------------------
-- Main Menu
----------------------------
function ViewControl:loadMainMenu()
  
  clearView()
  gameState = "Menu"
  
  view["mainMenu"] = View.create(resourceManager:getTexture("Mainbackground"))
  
  button["mainMenuStartButton"] = Button.create(0, 165, resourceManager:getTexture("mainMenuButton"))
  button["mainMenuSettingsButton"] = Button.create(0, 5, resourceManager:getTexture("mainMenuButton"))
  button["mainMenuAboutButton"] = Button.create(0, -165, resourceManager:getTexture("mainMenuButton"))
  
  text["mainStart"] = TextField.create(-100, 130, 220, 75, "START", 65)
  text["mainSettings"] = TextField.create(-160, -30, 340, 75, "SETTINGS", 65)
  text["mainAbout"] = TextField.create(-120, -200, 240, 75, "ABOUT", 65)
  
end

----------------------------
-- Level Selection Menu
----------------------------
function ViewControl:loadLevelSelectMenu()
  
  clearView()
  gameState = "LevelSelection"
  
  view["selectView"] = View.create(resourceManager:getTexture("selectbackground"))
  
  button["levelDownButton"] = Button.create(0, -440, resourceManager:getTexture("levelSelectButton"))
  
end

----------------------------
-- Load level
----------------------------
function ViewControl:loadLevel()
  
  clearView()
  gameState = "Playfield"
  
  view["gamescreen"] = View.create(resourceManager:getTexture("GameBackground"))

  button["powerupButtonOne"] = Button.create(-180, -440, resourceManager:getTexture("inactivePowerup"))
  button["powerupButtonTwo"] = Button.create(0, -440, resourceManager:getTexture("inactivePowerup"))

  player = Player.create()
  blockGenerator = Blockinator.create()

  blockGenerator:make()
  
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
  
    local mouseX, mouseY = layer:wndToWorld(MOAIInputMgr.device.pointer:getLoc())
    
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
      
      if blocks[key]:getUserdata(2) == "moveable" then
        
        if blocks[key]:getMovement() == true then
          
          local blockx, blocky = blocks[key]:getBlockBody():getPosition()
          
          -- Swipe movement
          if mouseStartX < mouseX then
            
            if blockx > mouseX and blockx < (mouseX + 24) then
              
              blocks[key]:moveBlock(0)
              mouseStartX = mouseX
              
            else
              
              blocks[key]:moveBlock(8)
            
            end
          
          else
            
            if blockx < mouseX and blockx > (mouseX - 24) then
              
              blocks[key]:moveBlock(0)
              mouseStartX = mouseX
              
            else
              
              blocks[key]:moveBlock(-8)
            
            end
            
          end
        
        end
        
      end

      if blocks[key]:getDestructionState() == false then
        
        blocks[key]:getBlockBody():setAwake(false)
        
      end
      
    end
    
    ---------------
    -- Player
    ---------------
    if player:getMovement() == true then
      
      local playerX, playerY = player:getPlayerBody():getPosition()
      
      -- Swipe movement
      if mouseStartX < mouseX then
        
        if playerX > mouseX and playerX < (mouseX + 24) then
          
          player:move(0)
          mouseStartX = mouseX
          
        else
          
          player:move(10)
        
        end
      
      else
        
        if playerX < mouseX and playerX > (mouseX - 24) then
          
          player:move(0)
          mouseStartX = mouseX
          
        else
          
          player:move(-10)
        
        end
        
      end
    
    end
   
  end
  
  ------------------------------
 -- Invisable walls
 ------------------------------
  --Floor
  bodies[0] = world:addBody( MOAIBox2DBody.STATIC )
  bodies[0]:setTransform( 0, -400 )  
  fixtures[0] = bodies[0]:addRect( -320, -10, 320, 10 )

  -- Right Wall
  bodies[1] = world:addBody( MOAIBox2DBody.STATIC )
  bodies[1]:setTransform( 330, 55 )  
  fixtures[1] = bodies[1]:addRect( -10, -420, 10, 420 )

  -- Left Wall
  bodies[2] = world:addBody( MOAIBox2DBody.STATIC )
  bodies[2]:setTransform( -330, 55 )  
  fixtures[2] = bodies[2]:addRect( -10, -420, 10, 420 )

end