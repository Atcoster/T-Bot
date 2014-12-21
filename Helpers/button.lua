----------------------------
-- Variables
----------------------------
Button = {}
Button.__index = Button

----------------------------
-- Constructor
----------------------------
function Button.create(x, y, texture,rows,cols)

  local btn = {}
  setmetatable(btn, Button)
  
  btn._rows = rows or 1
  btn._cols = cols or 1
  btn._x = x
  btn._y = y
  btn._texture = texture
  
  btn._sprite = MOAITileDeck2D.new()
  btn._prop =  MOAIProp2D.new()
  
  -- Powerups logic
  btn._missileActive = false
  btn._missileActivated = false
  
  btn:make()
  
  --Return object
  return btn

end

----------------------------
-- Functions
----------------------------
--Create button (Internal function)
function Button:make()
  
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

end


-- Set Texture
function Button:changeTexture(texture)
  
  self._texture = texture
  layer:removeProp(self._prop)
  self:make()
  
end

function Button:setmissileActivation(state) self._missileActivated = state end
function Button:getmissileActivation() return self._missileActivated end

function Button:setMissileState(state) self._missileActive = state end
function Button:getMissleState() return self._missileActive end

function Button:getProp() return self._prop end