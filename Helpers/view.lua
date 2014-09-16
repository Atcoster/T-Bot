----------------------------
-- Variables
----------------------------
View = {}
View.__index = View

----------------------------
-- Constructor
----------------------------
function View.create(imgSource)
  
  local vw = {}
  setmetatable(vw, View)
  
  vw._x = 640
  vw._y = 0
  vw._imgSource = imgSource
  vw._sprite = MOAIGfxQuad2D.new()
  vw._prop =  MOAIProp2D.new()
  vw._state = false
  
  vw:make()
  
  -- Return object
  return vw
  
end

----------------------------
-- Functions
----------------------------
--Create view (Internal function)
function View:make()
  
  --Texture
  local texture = MOAIImage.new()
  texture:load(self._imgSource)
  local w, h = texture:getSize()
  
  --Sprite
  self._sprite:setTexture(texture)
  self._sprite:setRect(-w, -h, w, h)
  
  --Prop
  self._prop:setDeck(self._sprite)
  self._prop:setLoc(self._x, self_y)

  --Insert prop
  layer:insertProp(self._prop)
  partition:insertProp(self._prop)
  
end

--Slide animation
function View:slide()
    
  if self._state then 
    self._prop:moveLoc(640,0, 0.5)
    self._state = false
  else 
    self._prop:moveLoc(-640,0, 0.5)
    self._state = true
  end
    
end
