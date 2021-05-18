--[[

 ____  _              _    _ _____ 
|  _ \| |            | |  | |_   _|
| |_) | |_   _  ___  | |  | | | |  
|  _ <| | | | |/ _ \ | |  | | | |  
| |_) | | |_| |  __/ | |__| |_| |_ 
|____/|_|\__,_|\___|  \____/|_____|
                                   
Created and scripted by BaxoPlenty

Credits:

- NoviHacks | Inspiration for the UI library

Features:

- Up to 5 total tabs
- Up to 3 sections per tab

--]]

--// Setup \\--

local Library = {}
Library.__index = Library

local Window = {}
Window.__index = Window

local Theme = {
  ["MainBackground"] = Color3.fromRGB(28, 28, 35),
  ["TopGradient"] = {
    ["From"] = Color3.fromRGB(14, 116, 164),
    ["To"] = Color3.fromRGB(126, 77, 234)
  }
}

--// Utilities \\--

-- OffsetRoundElement | ORoundElement(<Instance> Element, <int> Radius)

local function ORoundElement(Element, Radius)
  local Rounder = Instance.new("UICorner")

  Rounder.CornerRadius = UDim.new(0, Radius)
  Rounder.Parent = Element
end

-- SizeRoundElement | SRoundElement(<Instance> Element, <int> Radius)

local function SRoundElement(Element, Radius)
  local Rounder = Instance.new("UICorner")

  Rounder.CornerRadius = UDim.new(Radius, 0)
  Rounder.Parent = Element
end

-- Gradient(<Instance> Element, <Color> From, <Color> To, <int> Rotation)

local function Gradient(Element, From, To, Rotation)
  local Gradient = Instance.new("UIGradient")

  Gradient.Rotation = Rotation
  Gradient.Color =
    ColorSequence.new {
    ColorSequenceKeypoint.new(0, From),
    ColorSequenceKeypoint.new(1, To)
  }

  Gradient.Parent = Element
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

  local UIHolder = Instance.new("Frame", ScreenGui)
  UIHolder.Name = "UIHolder"
  UIHolder.BackgroundTransparency = 1
  UIHolder.BorderSizePixel = 0
  UIHolder.Size = UDim2.new(0.415, 0, 0.475, 0)
  UIHolder.Position = UDim2.new(0, 50, 0, 50)

  local Background = Instance.new("Frame", UIHolder)
  Background.BackgroundColor3 = Theme["MainBackground"]
  Background.Size = UDim2.new(1, 0, 1, 0)
  Background.BorderSizePixel = 0
  Background.ZIndex = 2

  ORoundElement(Background, 3)

  local TopGradient = Instance.new("Frame", UIHolder)
  TopGradient.Size = UDim2.new(1, 0, 0.02, 0)
  TopGradient.Position = UDim2.new(0, 0, -0.01, 0)
  TopGradient.BorderSizePixel = 0

  SRoundElement(TopGradient, 1)
  Gradient(TopGradient, Theme["TopGradient"].From, Theme["TopGradient"].To, 0)

  return setmetatable({WindowName = Name, WindowUIObject = ScreenGui, WindowCurrentTab = nil}, Window)
end

--// Finish up \\--

return Library
