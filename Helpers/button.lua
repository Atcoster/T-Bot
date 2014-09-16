----------------------------
-- Variables
----------------------------
Button = {}
Button.__index = Button

----------------------------
-- Constructor
----------------------------
function Button.create(x, y, imgSource)

  local btn = {}
  setmetatable(btn, Button)
  
  btn._x = x
  btn._y = y
  btn._imgSource = imgSource
  
  btn._sprite = MOAIGfxQuad2D.new()
  btn._prop =  MOAIProp2D.new()
  
  btn:make()
  
  --Return object
  return btn

end

----------------------------
-- Functions
----------------------------
--Create button (Internal function)
function Button:make()
  
  --Texture
  local texture = MOAIImage.new()
  texture:load(self._imgSource)
  local w, h = texture:getSize()
  
  --Sprite
  self._sprite:setTexture(texture)
  self._sprite:setRect(-w, -h, w, h)
  
  --Prop
  self._prop:setDeck(self._sprite)
  self._prop:setLoc(self._x, self._y)
  self._prop:setPriority(1)

  --Insert prop
  layer:insertProp(self._prop)
  partition:insertProp(self._prop)

end

-- Set Texture
function Button:changeTexture(newImg)
  
  self._imgSource = newImg
  layer:removeProp(self._prop)
  self:make()
  
end

-- Get prop
function Button:getProp()

  return self._prop

end