----------------------------
-- Variables
----------------------------
Player = {}
Player.__index = Player

----------------------------
-- Constructor
----------------------------
function Player.create()
  
  local pl = {}
  setmetatable(pl, Player)
  
  pl._movement = false
  pl._direction = 0
  pl._jumpHeight = 10
  pl._jumpState = false
  
  pl._body = world:addBody(MOAIBox2DBody.DYNAMIC)
  pl._body:setTransform(0, -275)
  pl._fixture = pl._body:addRect(-48, -42, 48, 42)
  
  -- Texture
  pl._spritesheet = MOAITileDeck2D.new()
  pl._prop = MOAIProp2D.new()  
  
  pl:make()
  
  return pl
  
end

----------------------------
-- Functions
----------------------------
function Player:make()
  
  self._spritesheet:setTexture("Assets/img/t-bot/Tbot_Sprite.png")
  self._spritesheet:setSize(4,1)
  self._spritesheet:setRect(-48, -42, 48, 42)
  
  self._prop:setDeck(self._spritesheet)
  self._prop:setParent(self._body)
  
  layer:insertProp(self._prop)
  
end

function Player:getMovement()
    
    return self._movement
    
end

function Player:getJumpState()
  
  return self._jumpState
  
end

function Player:setMovement(state)
    
    self._movement = state 
    
end

function Player:setJumpState(state)
  
  self._jumpState = state
  self._body:setAwake(true)
  
end

function Player:setDirection(dir)
    
    self._direction = dir
    
end

function Player:move()
  
  local x,y = self._body:getPosition()
  self._body:setAwake(true)
  self._body:setTransform(x + (self._direction), y)
  
end

function Player:jump()
    
  local x,y = self._body:getPosition()
  self._body:setTransform(x, y + self._jumpHeight)
    
end

function Player:getPlayerBody()
  
  return self._body
  
end

function Player:getPlayerProp()
  
  return self._prop
  
end