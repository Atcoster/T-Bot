----------------------------
-- Variables
----------------------------
Bullet = {}
Bullet.__index = Bullet

----------------------------
-- Constructor
----------------------------
function Bullet.create(x,y)
  
  local blt = {}
  setmetatable(blt, Bullet)
  
  blt._speed = 5
  blt._destruction = false
  blt._direction = "up"
  
  -- Body
  blt._body = world:addBody(MOAIBox2DBody.KINEMATIC)
  blt._body:setTransform(x,y+50)  
  
  -- Fixture
  blt._fixture = blt._body:addRect(-12,-12,12,12)
  blt._fixture.userdata = "Bullet"
  
   -- Texture
  blt._image = MOAIGfxQuad2D.new()
  blt._prop = MOAIProp2D.new()
  
  blt:make()
  
  return blt
  
end

----------------------------
-- Functions
----------------------------
function Bullet:make()

  self._image:setTexture(resourceManager:getTexture("missile"))
  self._image:setRect(-24, -24, 24, 24)

  self._prop:setDeck(self._image)
  
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
end

function Bullet:move()
  
  local x,y = self._body:getPosition()
  
  if self._direction == "up" then
    
    self._prop:setRot(0)
    self._body:setTransform(x, y + self._speed)
    
  elseif self._direction == "right" then
    
    self._prop:setRot(270)
    self._body:setTransform(x + self._speed, y)
    
  elseif self._direction == "down" then
    
    self._prop:setRot(180)
    self._body:setTransform(x, y  - self._speed)
  
  elseif self._direction == "left" then
    
    self._prop:setRot(90)
    self._body:setTransform(x - self._speed, y)
  
  end
  
end

function Bullet:destruction()
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  
end

function Bullet:setDirection(state)
  
  self._direction = state

end

function Bullet:getBulletBody() return self._body end

function Bullet:getDestructionState() return self._destruction end




