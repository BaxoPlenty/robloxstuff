# UI Libraries

### Blue UI

Created and scripted by BaxoPlenty

Credits:

- NoviHacks | Design inspiration for the UI library ( If you want a takedown, direct message me on discord: BaxoPlenty#0001 )

Features:

- Up to 6 total tabs
- Up to 4 sections per tab

Example on how to make tabs:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BaxoPlenty/robloxstuff/Stable/UILibraries/Blue-UI.lua"))() -- Initialize Library

local Window = Library.NewWindow("Test") -- Create Window

local FirstTab = Window:AddTab("FirstTab", 6832437855) -- Make sure the Icons are white

--[[

There are 2 alignments. L ( Left ) and R ( Right )

--]]

FirstTab:AddButton("L", "Hello", function() print("hello") end)

FirstTab:AddSpacer("L") -- Put some space

FirstTab:AddLabel("L", "New Label") -- Just some text

FirstTab:AddCheckbox("L", "Checkbox", false, function(value) print(value) end) -- false = Default Value

FirstTab:AddTextbox("L", "Something", "Placeholder", "", function(value) print(value) end) -- "" = Default Value

-- Window Functions

Window:Destroy()
Window:Toggle()
```
