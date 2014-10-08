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
  
  blt._speed = 4
  blt._destruction = false
  blt._direction = "up"
  
  -- Body
  blt._body = world:addBody(MOAIBox2DBody.KINEMATIC)
  blt._body:setTransform(x,y+50)  
  
  -- Fixture
  blt._fixture = blt._body:addRect(-12,-12,12,12)
  blt._fixture.userdata = {"Bullet", "normal"}
  
 
  
   -- Texture
  blt._animation = MOAIAnim:new()
  blt._curve = MOAIAnimCurve.new()
  blt._prop = MOAIProp2D.new()
  
  blt:make()
  
  return blt
  
end

----------------------------
-- Functions
----------------------------
function Bullet:make()
  
   if  player:getWeaponType() == "normal" then
    
    self._prop:setDeck(resourceManager:getTexture("normalMissileSheet"))
    self._fixture.userdata[2] = "normal"
    
  elseif player:getWeaponType() == "fire" then
    
    self._prop:setDeck(resourceManager:getTexture("fireMissileSheet"))
    self._fixture.userdata[2] = "fire"
    
  elseif player:getWeaponType() == "freeze" then
    
    self._prop:setDeck(resourceManager:getTexture("freezeMissileSheet"))
    self._fixture.userdata[2] = "freeze"
    
  end
  
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
  local tiles = 3
  local speed = 0.1

  self._curve:reserveKeys(tiles)

  for i=1,tiles,1 do
    
    self._curve:setKey(i, speed * i, i)
    
  end

  self._animation:reserveLinks(1)
  self._animation:setLink(1, self._curve, self._prop, MOAIProp2D.ATTR_INDEX)
  self._animation:setMode(MOAITimer.LOOP)
  self._animation:setSpan(tiles * speed)
  self._animation:start()
  
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

function Bullet:getBulletType() return self._type end





