# UI Libraries

These UI Libraries can be used for free. However, you need to credit me.

### Blue UI

Created and scripted by BaxoPlenty

Credits:

- NoviHacks | Design inspiration for the UI library ( If you want a takedown, direct message me on discord: BaxoPlenty#1337 )

Features:

- Up to 6 total tabs
- Up to 4 sections per tab

Example on how to make stuff:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BaxoPlenty/robloxstuff/Stable/UILibraries/Blue-UI.lua"))() -- Initialize Library

local Window = Library.NewWindow("Test") -- Create Window

local FirstTab = Window:AddTab("FirstTab", 6832437855) -- Make sure the Icons are white

local Section = FirstTab:AddSection("Hello") -- Add the section

--[[

There are 2 alignments. L ( Left ) and R ( Right )

--]]

Section:AddButton("L", "Hello", function() print("hello") end)

Section:AddSpacer("L") -- Put some space

Section:AddLabel("L", "New Label") -- Just some text

Section:AddCheckbox("L", "Checkbox", false, function(value) print(value) end) -- false = Default Value

Section:AddTextbox("L", "Something", "Placeholder", "", function(value) print(value) end) -- "" = Default Value

-- Window Functions

Window:Destroy()
Window:Toggle()
```
