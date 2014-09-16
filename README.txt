--------------------------------------------------------
-- Void Walkers Developer Documentation
--------------------------------------------------------

*** Quick Note: WIll update this document slowly and painfully untill everyone suffffers!! MUAHAHAAH ***

--------------------------------------------------------
-- Helpers
--------------------------------------------------------
The purpose of helpers is to simplify the use of certain MOAI functions. Minimizing the use of codes
and incorporating Object Orienting to make developing this game fast and effiecient. You can find all
the helpers in the helpers folder and below detailed information on how to use them. If you want to add a
functionality to a helper, feel free to do so, just make sure to add it to the documentation and make sure it
works!

--------------------------------------------------------
--- List of Helpers ---
--------------------------------------------------------

--------------------------------------------------------
--------------------[[ button ]]------------------------
--------------------------------------------------------

path: ../helper/button.lua

functions:

---------------------------------
---- create(x, y, imgSource) ----
---------------------------------

@Note: Public Constructor

@param: x         = x cord for the button
@param: y         = y cord for the button
@param: imgSource = Image path for the button texture

@returns: Button object

@Details: Fills the necesary variables given by the parameters for further use and calls the internal function make() to create the actual button. Also returns a button object.

----------------
---- make() ----
----------------

@Note: Private function

@Details: This is where the button is actually made. Based on the parameters given, the button will get a texture based on the given iimgSource and placed on the view based on the given x and y cords. The button will also be added to the partition for user interaction.

-------------------------------
---- changeTexture(newImg) ----
-------------------------------

@Note: Public function

@param: newImg = Image path for the button texture

@Details: This function changes the buttons image source,
removes the current button from the view and makes a new one by calling the make() function.

-------------------
---- getProp() ----
-------------------

@Note: Public function

@returns: Button prop object

@Details: Returns the button prop object

--------------------------------------------------------
-------------------[[ textfield ]]----------------------
--------------------------------------------------------

path: ../helper/textfield.lua

functions:

-----------------------------------
---- create(x, y, w, h, value) ----
-----------------------------------

@Note: Public Constructor

@param: x         = x cord for the textbox
@param: y         = y cord for the textbox
@param: w         = width for the textbox
@param: h         = height for the textbox
@param: value     = String value to show on the textbox

@returns: Textbox object

@Details: Fills the necesary variables given by the parameters for further use and calls the internal function make() to create the actual textbox. Also returns a textbox object.

----------------
---- make() ----
----------------

@Note: Private function

@Details: This is where the button is actually made. Based on the parameters given, the textbox rectangle will be set based on the  and placed on the view based on the given x and y cords.



