----------------------------
-- Variables
----------------------------
Animator = {}
Animator.__index = Animator

----------------------------
-- Constructor
----------------------------
function Animator.create(x, y, texture,rows,cols)

  local anim = {}
  setmetatable(anim, Animator)
  
  anim._rows = rows or 1
  anim._cols = cols or 1
  anim._x = x
  anim._y = y
  anim._texture = texture
  
  anim._sprite = MOAITileDeck2D.new()
  anim._prop =  MOAIProp2D.new()
  
  anim:make()
  
  --Return object
  return anim

end

----------------------------
-- Functions
----------------------------
--Create button (Internal function)
function Animator:make()
  
  --Texture diminsions
  local w, h = self._texture:getSize()
  
  --Sprite
  self._sprite:setTexture( self._texture)
  self._sprite:setSize(self._rows,self._cols)
  self._sprite:setRect(-w/self._rows, -h/self._cols, w/self._rows, h/self._cols)
  
  --Prop
  self._prop:setDeck(self._sprite) 
  self._prop:setLoc(self._x, self._y)
 
  --Insert prop
  layer:insertProp(self._prop)
  partition:insertProp(self._prop)
self:animate()

end

function Animator:animate()
    local tiles = (self._cols * self._rows)
  local speed = 0.08

  curve = MOAIAnimCurve.new()
  curve:reserveKeys(tiles)

  for i=1,tiles,1 do
    
    curve:setKey(i, speed * i, i)
    
  end
  
  anim = MOAIAnim:new()
  anim:reserveLinks(2)
  anim:setLink(2, curve, self._prop, MOAIProp2D.ATTR_INDEX)
  anim:setMode(MOAITimer.LOOP)
  anim:setSpan(tiles * speed)
  anim:start()
  end

-- Set Texture
function Animator:changeTexture(texture)
  
  self._texture = texture
  layer:removeProp(self._prop)
  self:make()
  
end


function Animator:getProp() return self._prop end