----------------------------
-- Variables
----------------------------
Bullet = {}
Bullet.__index = Bullet

----------------------------
-- Constructor
----------------------------
function Bullet.create(x,y,z)
  local blt = {}
  setmetatable(blt, Bullet)
  
  blt._speed = 5
  blt._destruction = false
  blt._direction = z or "up"
  blt._teleportable = false
  -- Body
  blt._body = world:addBody(MOAIBox2DBody.KINEMATIC)
  blt._body:setTransform(x,y+50)  
  
  -- Fixture
  blt._fixture = blt._body:addRect(-12,-12,12,12)
  blt._fixture.userdata = {"Bullet", "normal"}
  
  -- teleport coordinates

   -- Texture
  blt._animation = MOAIAnim:new()
  blt._curve = MOAIAnimCurve.new()
  blt._prop = MOAIProp2D.new()
  
  blt:make()
  blt:makeTeleportable()
  return blt
  
end

----------------------------
-- Functions
----------------------------
function Bullet:make()
  
   if  player:getWeaponType() == "normal" then
    
    self._prop:setDeck(resourceManager:getTexture("normalMissileSheet"))
    self._fixture.userdata[2] = "normal"
    soundManager:playMusic("MissileShoot")
    
  elseif player:getWeaponType() == "fire" then
    
    self._prop:setDeck(resourceManager:getTexture("fireMissileSheet"))
    self._fixture.userdata[2] = "fire"
    --soundManager:playMusic("PowerupShoot")
    
  elseif player:getWeaponType() == "freeze" then
    
    self._prop:setDeck(resourceManager:getTexture("freezeMissileSheet"))
    self._fixture.userdata[2] = "freeze"
    --soundManager:playMusic("PowerupShoot")
    
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
  
  local x,y = self:getPosition()
  
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

  --reset teleport
  self._teleportX = nil
  self._teleportY = nil
end

function Bullet:destruction()
  
  self._destruction = true
  layer:removeProp(self._prop)
  self._body:destroy()
  for key,value in pairs(bullet) do
    if bullet[key] == self then
      table.remove(bullet,key)
    end
    end
end

function Bullet:setDirection(state)
  
  self._direction = state

end
function Bullet:makeTeleportable()
  if self._teleportable == false then
  function resetTel() self._teleportable = true end
    local timer3 = MOAITimer.new()
    timer3:setSpan(0.15)
    timer3:setMode(MOAITimer.NORMAL)
    timer3:setListener(MOAITimer.EVENT_TIMER_END_SPAN,resetTel)
    timer3:start()
    end
end

function Bullet:getPosition()
  
 
    return self._body:getPosition()
  
 end
function Bullet:getBulletBody() return self._body end

function Bullet:getDestructionState() return self._destruction end

function Bullet:getBulletType() return self._type end

function Bullet:getDirection() return self._direction end

function Bullet:getTeleportable() return self._teleportable end


