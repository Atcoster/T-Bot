----------------------------
-- Variables
----------------------------
Block = {}
Block.__index = Block

----------------------------
-- Constructor
----------------------------

function Block.create(x, y, blockType)

  local blk = {}
  setmetatable(blk, Block)
  
  blk._size = 24
  blk._x = x
  blk._y = y
  blk._movement = true
  blk._destruction = false
  
  --Body
  blk._body = world:addBody( MOAIBox2DBody.DYNAMIC )
  blk._body:setTransform( x, y )
  
  --Fixture
  blk._fixture = blk._body:addRect( -blk._size, -blk._size, blk._size, blk._size )
  blk._fixture:setSensor(true)
  
  blk._fixture.userdata = {blockType, "safe"}
  
  -- Texture
  blk._image = MOAIGfxQuad2D.new()
  blk._prop = MOAIProp2D.new()
  
  --Collision
  function handleCollision(phase, a, b, arbiter)
    
    if a.userdata[1] == "bomb" then
      --b.userdata[2] = "bombable"
      
      
      
      --print("Box: "..b.userdata[1].." state: "..b.userdata[2])
      
    end
    
    if phase == MOAIBox2DArbiter.BEGIN then
      
      if b.userdata == "Bullet" and b ~= nil then
        
        local x,y = b:getBody():getPosition()
        
        if a.userdata[1] == "wood" then
          blk:destruction()
        end
        
        for key,value in pairs(bullet) do
    
          if bullet[key]:getBulletBody() == b:getBody() then
            
            bullet[key]:destruction()
          
          end
           
        end
       
      end
      
    elseif phase == MOAIBox2DArbiter.END then
      
      
    end

  end
  
  blk._fixture:setCollisionHandler(handleCollision, MOAIBox2DArbiter.BEGIN + MOAIBox2DArbiter.END)
  
  blk:make()
  
  return blk

end

----------------------------
-- Functions
----------------------------
function Block:make()
  
  self._image:setTexture(resourceManager:getTexture(self._fixture.userdata[1]))
  
  self._image:setRect(-24, -24, 24, 24)

  self._prop:setDeck(self._image)
  
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
end

function Block:getBlockBody()
  
  return self._body
  
end

function Block:getUserdata()
  
  return self._fixture.userdata
  
end

function Block:setDestruction(state)
  
  self._destruction = state
  
end

function Block:getMovement()
  
  return self._movement
  
end

function Block:getDestructionState()
  
  return self._destruction
  
end

function Block:destruction()
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  
end


