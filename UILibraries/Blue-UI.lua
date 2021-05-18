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
  ["SidebarColor"] = Color3.fromRGB(27, 26, 32),
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

-- Window.Destroy()

function Window.Destroy()
 print(self)
 self.WindowUIObject:Destroy()
  print(self)
  
  setmetatable(self, nil)
end

-- Window.Toggle()

function Window.Toggle()
  self.WindowUIObject.Enabled = not self.Toggled
  self.Toggled = not self.Toggled
end

-- <Window> Libary.NewWindow(<string> Name)

function Library.NewWindow(Name)
  --// Gui Creation \\--

  local ScreenGui = Instance.new("ScreenGui", game.CoreGui) -- Use CoreGui so it doesn't overlap with existing stuff.
  ScreenGui.ResetOnSpawn = false
  ScreenGui.Name = "BlueUI_" .. Name

  --// UI Holder Creation \\--

  local UIHolder = Instance.new("Frame", ScreenGui)
  UIHolder.Name = "UIHolder"
  UIHolder.BackgroundTransparency = 1
  UIHolder.BorderSizePixel = 0
  UIHolder.Size = UDim2.new(0.415, 0, 0.475, 0)
  UIHolder.Position = UDim2.new(0, 50, 0, 50)

  --// Background Creation \\--

  local Background = Instance.new("Frame", UIHolder)
  Background.BackgroundColor3 = Theme["MainBackground"]
  Background.Size = UDim2.new(1, 0, 1, 0)
  Background.BorderSizePixel = 0
  Background.ZIndex = 2
  Background.Name = "Background"

  ORoundElement(Background, 3)

  --// TopGradient Creation \\--

  local TopGradient = Instance.new("Frame", UIHolder)
  TopGradient.Size = UDim2.new(1, 0, 0.02, 0)
  TopGradient.Position = UDim2.new(0, 0, -0.01, 0)
  TopGradient.BorderSizePixel = 0
  TopGradient.Name = "TopGradient"

  SRoundElement(TopGradient, 1)
  Gradient(TopGradient, Theme["TopGradient"].From, Theme["TopGradient"].To, 0)

  --// TopUnround Creation \\--

  local TopUnround = Instance.new("Frame", Background)
  TopUnround.Size = UDim2.new(1, 0, 0.06, 0)
  TopUnround.BorderSizePixel = 0
  TopUnround.BackgroundColor3 = Theme["MainBackground"]
  TopUnround.Name = "TopUnround"

  --// Background content Creation \\--

  local BackgroundContent = Instance.new("Frame", Background)
  BackgroundContent.Name = "Content"
  BackgroundContent.BackgroundTransparency = 1
  BackgroundContent.BorderSizePixel = 0
  BackgroundContent.Size = UDim2.new(1, 0, 1,0)

  --// Sidebar Creation \\--

  local Sidebar = Instance.new("Frame", BackgroundContent)
  Sidebar.Name = "Sidebar"
  Sidebar.BackgroundColor3 = Theme["SidebarColor"]
  Sidebar.BorderSizePixel = 0
  Sidebar.Size = UDim2.new(0.095, 0, 1,0)

  ORoundElement(Sidebar, 3)
  
  local STabs = Instance.new("Frame", Sidebar)
  STabs.Name = "Tabs"
  STabs.BackgroundTransparency = 1
  STabs.BorderSizePixel = 0
  STabs.Size = UDim2.new(1, 0, 1,0)

  local SidebarUnround1 = Instance.new("Frame", Sidebar)
  SidebarUnround1.Size = UDim2.new(-0.06, 0, 0.06, 0)
  SidebarUnround1.Position = UDim2.new(1, 0, 0, 0)
  SidebarUnround1.BorderSizePixel = 0
  SidebarUnround1.BackgroundColor3 = Theme["SidebarColor"]
  SidebarUnround1.Name = "Unround"

  local SidebarUnround2 = Instance.new("Frame", Sidebar)
  SidebarUnround2.Position = UDim2.new(1, 0, 1, 0)
  SidebarUnround2.Size = UDim2.new(-0.06, 0, -0.06)
  SidebarUnround2.BorderSizePixel = 0
  SidebarUnround2.BackgroundColor3 = Theme["SidebarColor"]
  SidebarUnround2.Name = "Unround"

  --// TabContent Creation \\--

  local TabContent = Instance.new("Frame", BackgroundContent)
  TabContent.Name = "TabContent"
  TabContent.BackgroundTransparency = 1
  TabContent.BorderSizePixel = 0
  TabContent.Size = UDim2.new(0.905, 0, 1, 0)
  TabContent.Position = UDim2.new(0.095, 0, 0, 0)

  --// Return the window \\--

  return setmetatable( {WindowName = Name, WindowUIObject = ScreenGui, WindowCurrentTab = nil, Toggled = true }, Window)
end

--// Finish up \\--

return Library
