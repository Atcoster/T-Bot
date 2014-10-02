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
  pl._starty = -350
  
  pl._body = world:addBody(MOAIBox2DBody.DYNAMIC)
  pl._body:setTransform(0, pl._starty)
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
  
  ----------------------------------
  -- Animations
  ----------------------------------
  local tiles = 4
  local speed = 0.1

  curve = MOAIAnimCurve.new()
  curve:reserveKeys(tiles)

  for i=1,tiles,1 do
    
    curve:setKey(i, speed * i, i)
    
  end

  anim = MOAIAnim:new()
  anim:reserveLinks(1)
  anim:setLink(1, curve, self._prop, MOAIProp2D.ATTR_INDEX)
  anim:setMode(MOAITimer.LOOP)
  anim:setSpan(tiles * speed)
  anim:start()
  
end

function Player:move(direction)
  
  local x,y = self._body:getPosition()
  self._body:setAwake(true)
  self._body:setTransform(x + direction,y)
  
end

function Player:getMovement() return self._movement end
function Player:setMovement(state) self._movement = state  end

function Player:setDirection(dir) self._direction = dir end

function Player:getPlayerBody() return self._body end

function Player:getPlayerProp() return self._prop end