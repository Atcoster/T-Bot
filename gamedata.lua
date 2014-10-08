--MOAI
serializer = ... or MOAIDeserializer.new ()

local function init ( objects )

  --Initializing Tables
  local table

  table = objects [ 0x029A08E0 ]

  table [ "levelData" ] = {
    
    ["level1"] = "05:00",
    ["level2"] = "05:00",
    ["level3"] = "05:00",
    ["level4"] = "05:00",
    ["level5"] = "05:00"
    
    }

end

 

--Declaring Objects

local objects = {

  --Declaring Tables

  [ 0x029A08E0 ] = {}

}

 

init ( objects )

--Returning Tables
return objects [ 0x029A08E0 ]

 
