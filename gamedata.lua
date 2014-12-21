--MOAI
serializer = ... or MOAIDeserializer.new ()

local function init ( objects )

  --Initializing Tables
  local table

  table = objects [ 0x029A08E0 ]

  table [ "levelData" ] = {}
  for i=1,9999 do
     table [ "levelData" ][i] = {["time"] = "05:00", ["status"] = "incomplete"}
     end
    
    

end

 

--Declaring Objects

local objects = {

  --Declaring Tables

  [ 0x029A08E0 ] = {}

}

 

init ( objects )

--Returning Tables
return objects [ 0x029A08E0 ]

 
