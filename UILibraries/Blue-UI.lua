--// Setup \\--

local Library = {}
Library.__index = Library

local Window = {}
Wab.__index = Wab

local Theme = {
  ["MainBackground"] = Color3.fromRGB(25, 26, 32)
}

--// Utilities \\--

-- OffsetRoundElement | ORoundElement(<Instance> Element, <int> Radius)

local function ORoundElement(Element, Radius)
  local Rounder = Instance.new("UICorner")
  
  Rounder.CornerRadius = UDim.new(0, Radius);
  Rounder.Parent = Element
end

-- SizeRoundElement | SRoundElement(<Instance> Element, <int> Radius)

local function SRoundElement(Element, Radius)
  local Rounder = Instance.new("UICorner")
  
  Rounder.CornerRadius = UDim.new(Radius, 0);
  Rounder.Parent = Element
end

--// UI Library \\--

-- Window.Test() // Testing

function Window.Test()
    print("WORK!")
end

-- <Window> Libary.NewWindow(<string> Name)

function Library.NewWindow(Name)
  local ScreenGui = Instance.new("ScreenGui", game.CoreGui) -- Use CoreGui so it doesn't overlap with existing stuff.
  ScreenGui.ResetOnSpawn = false
  ScreenGui.Name = "BlueUI_" .. Name
  
  local Background = Instance.new("Frame", ScreenGui)
  Background.BackgroundColor3 = Theme["MainBackground"]
  Background.Size = UDim2.new(0.415, 0, 0.450, 0)
  Background.Position = UDim2.new(0, 50, 0, 50)
  Background.BorderSizePixel = 0

  ORoundElement(Background, 3)

  return setmetatable({ WindowName = Name, WindowUIObject = ScreenGui }, Window)
end

--// Finish up \\--

return Library
