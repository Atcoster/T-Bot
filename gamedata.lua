--MOAI
serializer = ... or MOAIDeserializer.new ()

local function init ( objects )

  --Initializing Tables
  local table

  table = objects [ 0x029A08E0 ]

  table [ "levelData" ] = {
    
    ["level1"] = {["time"] = "05:00", ["status"] = "incomplete"},
    ["level2"] = {["time"] = "05:00", ["status"] = "incomplete"},
    ["level3"] = {["time"] = "05:00", ["status"] = "incomplete"},
    ["level4"] = {["time"] = "05:00", ["status"] = "incomplete"},
    ["level5"] = {["time"] = "05:00", ["status"] = "incomplete"}
    
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

 
