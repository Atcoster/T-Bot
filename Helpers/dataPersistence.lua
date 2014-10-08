----------------------------
-- Load user data
----------------------------

-- Persistent data: user-based data that must be recorded
user_data_path = (MOAIEnvironment.documentDirectory or "./") .. "/gamedata.lua"
user_data_f = loadfile(user_data_path) or nil
user_data = {}

-- Reset the user_data table, in case the user needs it (application-persistent data reset)
function reset_user_data()

  user_data.levelData = {
    ["level1"] = "05:00",
    ["level2"] = "05:00",
    ["level3"] = "05:00",
    ["level4"] = "05:00",
    ["level5"] = "05:00"
  } 

  -- every time you use this method in your code somewhere, user_data will persist.
  save_user_data()

end

 

-- Save the contents of the user_data, for eternity ..

function save_user_data()

  serializer = MOAISerializer.new ()

  serializer:serialize ( user_data )

  user_data_Str = serializer:exportToString ()

 

  --compiled = string.dump ( loadstring ( user_data_Str, '' ))

  --print("Writing User Data: ", user_data_path)

  user_data_file = io.open (user_data_path, 'wb' )

  -- attempt to save the file ..

  if (user_data_file ~= nil) then

    user_data_file:write ( user_data_Str )

    user_data_file:close ()

  end

end

 

-- At the beginning of your application, get the persisted data:

if (user_data_f ~= nil) then

  user_data = user_data_f() -- we de-serialize our loads

  --print ("Reading User Data: ", user_data)

else

  reset_user_data() -- or, we begin anew ..

end

 
-- .. and in the the rest of the code of your application:
--[[
user_data.high_score = 9999
user_data.level_gained = 20 -- &etc.
save_user_data()
--]]
