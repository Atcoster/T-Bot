----------------------------
-- Variables
----------------------------
TextField = {}
TextField.__index = TextField

----------------------------
-- Constructor
----------------------------
function TextField.create(x, y, w, h, value, size)
  
  local txt = {}
  setmetatable(txt, TextField)
  
  txt._x = x
  txt._y = y
  txt._width = w
  txt._height = h
  txt._value = value
  txt._size = size
  
  txt._prop = MOAITextBox.new()
  txt._style = MOAITextStyle.new()
  
  txt:make()
  
  return txt
  
end

----------------------------
-- Functions
----------------------------
--Create button (Internal function)
function TextField:make()
  
  local x = self._x
  local y = self._y
  local w = self._width
  local h = self._height
  
  self._prop:setStyle(newStyle(font, self._size))
  self._prop:setString(self._value)
  self._prop:setRect(x,y,x+w,y+h)
  self._prop:setYFlip(true)
  
  layer:insertProp(self._prop)
  
  return self._prop
  
end

function TextField:setText(string)
  
  self._prop:setString(string)
  
end

function newStyle(font, size)
 
 local charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
 font = MOAIFont.new ()
 font:loadFromTTF ( 'Assets/fonts/arialbd.ttf', charcodes, 16, 163 )
 
 local style = MOAITextStyle.new()
 style:setFont(font)
 style:setSize(size) 
 style:setColor(1, 1, 1, 1) 
 
 return style
  
end

function TextField:getTextProp() return self._prop end