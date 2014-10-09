----------------------------
-- Variables
----------------------------
Progressbar = {}
Progressbar.__index = Progressbar

----------------------------
-- Constructor
----------------------------
function Progressbar.create()
  
  local pb = {}
  setmetatable(pb, Progressbar)
  
  pb._deck = MOAIScriptDeck.new ()
  pb._sprite = MOAIGfxQuad2D.new()
  pb._prop = MOAIProp2D.new ()
  
  pb._progressWidth = nil
  pb._startWidth = nil
  
  pb._partAmountMath = 0
  pb._partAmount = 0
  
  pb._width = 0
  pb._height = 0
  pb._x = 0
  pb._y = 0
  
  return pb
  
end

----------------------------
-- Functions
----------------------------
function Progressbar:drawProgressBar(x,y,w,h)
  
  if self._progressWidth == nil then
    self._progressWidth = -w
    self._startWidth = w
  end
  
  print(self._progressWidth)
  
  self._height = h
  self._x = x
  self._y = y
  
  --Drawing logic 
  self._deck:setRect ( -self._startWidth, -h, self._progressWidth, h )
  self._deck:setDrawCallback ( function() 
      
    MOAIGfxDevice.setPenColor ( 0, 1, 0, 1 )
    MOAIDraw.fillRect(-self._startWidth, -h, self._progressWidth, h);
      
  end )

  self._prop:setDeck ( self._deck )
  self._prop:setLoc(x, y);
  layer:insertProp ( self._prop )
  
end

function Progressbar:drawProgressBarImage(amountParts)
  
  self._prop = MOAIProp2D.new ()
  self._sprite = MOAIGfxQuad2D.new()
    
  self._partAmountMath = 290 / amountParts
  self._partAmount = amountParts
  
  --Sprite
  self._sprite:setTexture(resourceManager:getTexture("gameTopMenuBar"))
  self._sprite:setRect(-320, -24, 320, 24)
  
  --Prop
  self._prop:setDeck(self._sprite)
  self._prop:setLoc(-290, 456)

  --Insert prop
  layer:insertProp(self._prop)
  
end

function Progressbar:moveProgressbarImage()
  
  self._prop:moveLoc(self._partAmountMath,0,1)
  
  self._partAmount = self._partAmount - 1
  
end

function Progressbar:addProgress(amount) 
  
  self._progressWidth = self._progressWidth + amount
  
  layer:removeProp( self._prop )
  
  self:drawProgressBar(self._x, self._y, self._progressWidth, self._height)
  
end

function Progressbar:getRemainingParts()
  
  return self._partAmount
  
end