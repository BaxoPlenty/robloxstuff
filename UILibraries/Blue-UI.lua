--[[

 ____  _              _    _ _____ 
|  _ \| |            | |  | |_   _|
| |_) | |_   _  ___  | |  | | | |  
|  _ <| | | | |/ _ \ | |  | | | |  
| |_) | | |_| |  __/ | |__| |_| |_ 
|____/|_|\__,_|\___|  \____/|_____|
                                   
Created and scripted by BaxoPlenty

Credits:

- NoviHacks | Design inspiration for the UI library ( If you want a takedown, direct message me on discord: BaxoPlenty#1337 )

Features:

- Up to 6 total tabs
- Up to 4 sections per tab

--]]
--// Setup \\--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Library = {}
Library.__index = Library

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

local Section = {}
Section.__index = Section

local Theme = {
  ["MainBackground"] = Color3.fromRGB(28, 28, 35),
  ["SidebarColor"] = Color3.fromRGB(27, 26, 32),
  ["TopGradient"] = {
    ["From"] = Color3.fromRGB(14, 116, 164),
    ["To"] = Color3.fromRGB(126, 77, 234)
  },
  ["Tab"] = {
    ["Active"] = Color3.fromRGB(28, 28, 35),
    ["None"] = Color3.fromRGB(27, 26, 32)
  },
  ["Icon"] = {
    ["Hovered"] = Color3.fromRGB(122, 126, 136),
    ["Active"] = Color3.fromRGB(122, 126, 136),
    ["None"] = Color3.fromRGB(60, 59, 67)
  },
  ["Label"] = {
    ["White"] = Color3.fromRGB(218, 220, 226),
    ["Hovered"] = Color3.fromRGB(122, 126, 136),
    ["Active"] = Color3.fromRGB(122, 126, 136),
    ["Placeholder"] = Color3.fromRGB(203, 210, 226),
    ["None"] = Color3.fromRGB(60, 59, 67)
  },
  ["Component"] = {
    ["Hovered"] = Color3.fromRGB(81, 79, 126),
    ["Active"] = Color3.fromRGB(102, 140, 255),
    ["None"] = Color3.fromRGB(40, 41, 54)
  }
}

--// Utilities \\--

-- GetHeadshotAvatar(<Player> Player)

local function GetHeadshotAvatar(Player)
  local UserId = Player.UserId
  local Type = Enum.ThumbnailType.HeadShot
  local Size = Enum.ThumbnailSize.Size100x100

  local Content = Players:GetUserThumbnailAsync(UserId, Type, Size)

  return Content
end

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
  local gradient = Instance.new("UIGradient")

  gradient.Rotation = Rotation
  gradient.Color =
    ColorSequence.new {
    ColorSequenceKeypoint.new(0, From),
    ColorSequenceKeypoint.new(1, To)
  }

  gradient.Parent = Element
end

-- GridLayout(<Instance> Element, <Enum> FillDirection, <int> MaxCells, <UDim2> CellSize, <UDim2> CellPadding)

local function GridLayout(Element, FillDirection, MaxCells, CellSize, CellPadding)
  local gridlayout = Instance.new("UIGridLayout")

  gridlayout.FillDirectionMaxCells = MaxCells
  gridlayout.CellSize = CellSize
  gridlayout.FillDirection = FillDirection
  gridlayout.CellPadding = CellPadding
  gridlayout.SortOrder = Enum.SortOrder.LayoutOrder

  gridlayout.Parent = Element
end

-- FadeIcon(<Instance> Icon, <Color3> Color)

local function FadeIcon(Icon, Color)
  local Information = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

  local Properties = {
    ImageColor3 = Color
  }

  TweenService:Create(Icon, Information, Properties):Play()
end

-- FadeFrame(<Instance> Frame, <Color3> Color)

local function FadeFrame(Frame, Color)
  local Information = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

  local Properties = {
    BackgroundColor3 = Color
  }

  TweenService:Create(Frame, Information, Properties):Play()
end

-- FadeFrameReduced(<Instance> Frame, <Color3> Color)

local function FadeFrameReduced(Frame, Color)
  local Information = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

  local Properties = {
    BackgroundColor3 = Color
  }

  TweenService:Create(Frame, Information, Properties):Play()
end

-- FadeText(<Instance> Text, <Color3> Color)

local function FadeText(Text, Color)
  local Information = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

  local Properties = {
    TextColor3 = Color
  }

  TweenService:Create(Text, Information, Properties):Play()
end

--// UI Library \\--
-- Section:AddSpacer(Alignment)

function Section:AddSpacer(Alignment)
  local AlignFrame = self.ComponentsHolder[Alignment]

  if self.ComponentCount[Alignment] == 16 then
    return
  end

  self.ComponentCount[Alignment] += 1

  local ComponentFrame = Instance.new("Frame", AlignFrame)

  ComponentFrame.BackgroundTransparency = 1
  ComponentFrame.BorderSizePixel = 0
  ComponentFrame.Name = "Spacer"
end

-- Section:AddLabel(Alignment, Name)

function Section:AddLabel(Alignment, Name)
  local AlignFrame = self.ComponentsHolder[Alignment]

  if self.ComponentCount[Alignment] == 16 then
    return
  end

  self.ComponentCount[Alignment] += 1

  local ComponentFrame = Instance.new("Frame", AlignFrame)

  ComponentFrame.BackgroundTransparency = 1
  ComponentFrame.BorderSizePixel = 0
  ComponentFrame.Name = "Component"

  local Label = Instance.new("TextLabel", ComponentFrame)

  Label.BackgroundTransparency = 1
  Label.Font = Enum.Font.SourceSansBold
  Label.TextColor3 = Theme.Label.Active
  Label.TextSize = 14
  Label.Text = Name
  Label.Name = "Label"
  Label.Size = UDim2.new(1, 0, 1, 0)
  Label.ZIndex = 2
end

-- Section:AddTextbox(Alignment, Name, Placeholder, DefaultText, Callback)

function Section:AddTextbox(Alignment, Name, Placeholder, DefaultText, Callback)
  local AlignFrame = self.ComponentsHolder[Alignment]

  if self.ComponentCount[Alignment] == 16 then
    return
  end

  self.ComponentCount[Alignment] += 1

  local ComponentFrame = Instance.new("Frame", AlignFrame)

  ComponentFrame.BackgroundTransparency = 1
  ComponentFrame.BorderSizePixel = 0
  ComponentFrame.Name = "Component"

  local TextboxFrame = Instance.new("Frame", ComponentFrame)

  TextboxFrame.BorderSizePixel = 0
  TextboxFrame.BackgroundColor3 = Theme.Component.None
  TextboxFrame.Size = UDim2.new(0.5, 0, 1, 0)
  TextboxFrame.Position = UDim2.new(1, 0, 0, 0)
  TextboxFrame.AnchorPoint = Vector2.new(1, 0)
  TextboxFrame.Name = "TextboxFrame"

  local TextInput = Instance.new("TextBox", TextboxFrame)

  TextInput.BackgroundTransparency = 1
  TextInput.Text = DefaultText
  TextInput.PlaceholderText = Placeholder
  TextInput.Size = UDim2.new(1, 0, 1, 0)
  TextInput.Name = "TextInput"
  TextInput.TextColor3 = Theme.Label.White
  TextInput.PlaceholderColor3 = Theme.Label.Placeholder
  TextInput.Font = Enum.Font.SourceSansBold
  TextInput.TextSize = 14
  TextInput.TextTruncate = Enum.TextTruncate.AtEnd
  TextInput.ZIndex = 2

  ORoundElement(TextboxFrame, 3)

  local Label = Instance.new("TextLabel", ComponentFrame)

  Label.BackgroundTransparency = 1
  Label.Font = Enum.Font.SourceSansBold
  Label.TextColor3 = Theme.Label.Active
  Label.TextSize = 14
  Label.Text = Name
  Label.Name = "Label"
  Label.Position = UDim2.new(0.05, 0, 0, 0)
  Label.Size = UDim2.new(0.45, 0, 1, 0)
  Label.ZIndex = 2
  Label.TextXAlignment = Enum.TextXAlignment.Left

  TextInput.Focused:Connect(function()
    FadeFrame(TextboxFrame, Theme.Component.Active)
  end)

  TextInput.FocusLost:Connect(function()
    FadeFrame(TextboxFrame, Theme.Component.None)
  end)

  TextInput:GetPropertyChangedSignal("Text"):Connect(function()
    Callback(TextInput.Text)
  end)
end

-- Section:AddButton(Alignment, Name, Callback)

function Section:AddButton(Alignment, Name, Callback)
  local AlignFrame = self.ComponentsHolder[Alignment]

  if self.ComponentCount[Alignment] == 16 then
    return
  end

  self.ComponentCount[Alignment] += 1

  local ComponentFrame = Instance.new("Frame", AlignFrame)

  ComponentFrame.BackgroundTransparency = 1
  ComponentFrame.BorderSizePixel = 0
  ComponentFrame.Name = "Component"

  local ButtonFrame = Instance.new("Frame", ComponentFrame)

  ButtonFrame.BorderSizePixel = 0
  ButtonFrame.BackgroundColor3 = Theme.Component.None
  ButtonFrame.Size = UDim2.new(0.95, 0, 1, 0)
  ButtonFrame.Position = UDim2.new(0.05, 0, 0, 0)
  ButtonFrame.Name = Name

  ORoundElement(ButtonFrame, 3)

  local Label = Instance.new("TextLabel", ButtonFrame)

  Label.BackgroundTransparency = 1
  Label.Font = Enum.Font.SourceSansBold
  Label.TextColor3 = Theme.Label.Active
  Label.TextSize = 14
  Label.Text = Name
  Label.Name = "Label"
  Label.Size = UDim2.new(1, 0, 1, 0)
  Label.ZIndex = 2

  local Click = Instance.new("TextButton", ButtonFrame)

  Click.BackgroundTransparency = 1
  Click.Text = ""
  Click.Size = UDim2.new(1, 0, 1, 0)
  Click.Name = "Click"
  Click.ZIndex = 2

  local Hovered = false

  ButtonFrame.MouseEnter:Connect(function()
    Hovered = true

    FadeFrame(ButtonFrame, Theme.Component.Hovered)
    FadeText(Label, Theme.Label.White)
  end)

  ButtonFrame.MouseLeave:Connect(function()
    Hovered = false

    FadeFrame(ButtonFrame, Theme.Component.None)
    FadeText(Label, Theme.Label.Active)
  end)

  Click.MouseButton1Down:Connect(function()
    FadeFrameReduced(ButtonFrame, Theme.Component.Active)
  end)

  Click.MouseButton1Up:Connect(function()
    if Hovered then
      FadeFrameReduced(ButtonFrame, Theme.Component.Hovered)
    else
      FadeFrame(ButtonFrame, Theme.Component.None)
    end
  end)

  Click.MouseButton1Click:Connect(Callback)
end

-- Section:AddCheckbox(Alignment, Name, DefaultValue, Callback)

function Section:AddCheckbox(Alignment, Name, DefaultValue, Callback)
  local AlignFrame = self.ComponentsHolder[Alignment]

  if self.ComponentCount[Alignment] == 16 then
    return
  end

  self.ComponentCount[Alignment] += 1

  local ComponentFrame = Instance.new("Frame", AlignFrame)

  ComponentFrame.BackgroundTransparency = 1
  ComponentFrame.BorderSizePixel = 0
  ComponentFrame.Name = "Component"

  local ActualCheckbox = Instance.new("Frame", ComponentFrame)

  ActualCheckbox.BorderSizePixel = 0
  ActualCheckbox.BackgroundColor3 = Theme.Component.None
  ActualCheckbox.Size = UDim2.new(1, 0, 1, 0)
  ActualCheckbox.SizeConstraint = Enum.SizeConstraint.RelativeYY
  ActualCheckbox.Position = UDim2.new(1, 0, 0, 0)
  ActualCheckbox.AnchorPoint = Vector2.new(1, 0)
  ActualCheckbox.Name = "Actual Checkbox"

  local Click = Instance.new("TextButton", ActualCheckbox)

  Click.BackgroundTransparency = 1
  Click.Text = ""
  Click.Size = UDim2.new(1, 0, 1, 0)
  Click.Name = "Click"
  Click.ZIndex = 2

  ORoundElement(ActualCheckbox, 3)

  local Label = Instance.new("TextLabel", ComponentFrame)

  Label.BackgroundTransparency = 1
  Label.Font = Enum.Font.SourceSansBold
  Label.TextColor3 = Theme.Label.Active
  Label.TextSize = 14
  Label.Text = Name
  Label.Name = "Label"
  Label.Position = UDim2.new(0.05, 0, 0, 0)
  Label.Size = UDim2.new(0.85, 0, 1, 0)
  Label.ZIndex = 2
  Label.TextXAlignment = Enum.TextXAlignment.Left

  local Hovered = false
  local Toggled = DefaultValue

  if Toggled then
    FadeText(Label, Theme.Label.White)
    FadeFrame(ActualCheckbox, Theme.Component.Active)
  end

  ActualCheckbox.MouseEnter:Connect(function()
    Hovered = true

    if not Toggled then
      FadeFrame(ActualCheckbox, Theme.Component.Hovered)
    end
  end)

  ActualCheckbox.MouseLeave:Connect(function()
    Hovered = false

    if not Toggled then
      FadeFrame(ActualCheckbox, Theme.Component.None)
    end
  end)

  Click.MouseButton1Click:Connect(function()
    if not Toggled then
      Toggled = true

      FadeText(Label, Theme.Label.White)
      FadeFrame(ActualCheckbox, Theme.Component.Active)

      Callback(Toggled)
    else
      Toggled = false

      FadeText(Label, Theme.Label.Active)

      if Hovered then
        FadeFrame(ActualCheckbox, Theme.Component.Hovered)
      else
        FadeFrame(ActualCheckbox, Theme.Component.None)
      end

      Callback(Toggled)
    end
  end)
end

-- Tab:SelectSection(Section)

function Tab:SelectSection(Section)
  FadeText(Section.SectionInstance.Label, Theme.Label.Active)

  Section.ComponentsHolder:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.25, true)

  if self.CurrentSection ~= nil then
    FadeText(self.CurrentSection.SectionInstance.Label, Theme.Label.None)

    local OldTabContent = self.CurrentSection.ComponentsHolder

    self.CurrentSection.ComponentsHolder:TweenPosition(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.25, true, function()
      OldTabContent.Position = UDim2.new(-1, 0, 0, 0)
    end)
  end

  self.CurrentSection = Section
end

-- <Section> Tab:AddSection(Name)

function Tab:AddSection(Name)
  if self.SectionCount == 4 then
    return
  end

  local SectionInstance = Instance.new("Frame", self.SectionsHolder)

  SectionInstance.BackgroundTransparency = 1
  SectionInstance.BorderSizePixel = 0
  SectionInstance.Name = Name
  SectionInstance.Size = UDim2.new(0.25, 0, 1, 0)

  local Label = Instance.new("TextLabel", SectionInstance)

  Label.BackgroundTransparency = 1
  Label.Font = Enum.Font.SourceSansBold
  Label.TextColor3 = Theme.Label.None
  Label.TextSize = 14
  Label.Text = Name
  Label.Name = "Label"
  Label.Size = UDim2.new(1, 0, 1, 0)
  Label.ZIndex = 2

  local Click = Instance.new("TextButton", SectionInstance)

  Click.BackgroundTransparency = 1
  Click.Text = ""
  Click.Size = UDim2.new(1, 0, 1, 0)
  Click.Name = "Click"
  Click.ZIndex = 2

  local Components = Instance.new("Frame", self.ComponentsHolder)

  Components.BackgroundTransparency = 1
  Components.BorderSizePixel = 0
  Components.Name = Name
  Components.Size = UDim2.new(1, 0, 1, 0)
  Components.Position = UDim2.new(-1, 0, 0, 0)

  local Left = Instance.new("Frame", Components)

  Left.BackgroundTransparency = 1
  Left.BorderSizePixel = 0
  Left.Name = "L"
  Left.Size = UDim2.new(0.5, 0, 1, 0)

  GridLayout(Left, Enum.FillDirection.Horizontal, 16, UDim2.new(0.95, 0, 0.05, 0), UDim2.new(0, 0, 0.005, 0))

  local Right = Instance.new("Frame", Components)

  Right.BackgroundTransparency = 1
  Right.BorderSizePixel = 0
  Right.Name = "R"
  Right.Position = UDim2.new(0.5, 0, 0, 0)
  Right.Size = UDim2.new(0.5, 0, 1, 0)

  GridLayout(Right, Enum.FillDirection.Horizontal, 16, UDim2.new(0.95, 0, 0.05, 0), UDim2.new(0, 0, 0.005, 0))

  local NewSection = setmetatable(
    {
      SectionName = Name,
      SectionInstance = SectionInstance,
      ComponentsHolder = Components,
      ComponentCount = {
        ["L"] = 0,
        ["R"] = 0
      }
    },
    Section
  )

  self.Sections[Name] = NewSection
  self.SectionCount += 1

  if self.CurrentSection == nil then
    self:SelectSection(NewSection)
  end

  SectionInstance.MouseEnter:Connect(function()
    if self.CurrentSection ~= NewSection then
      FadeText(Label, Theme.Label.Hovered)
    end
  end)

  SectionInstance.MouseLeave:Connect(function()
    if self.CurrentSection ~= NewSection then
      FadeText(Label, Theme.Label.None)
    end
  end)

  Click.MouseButton1Click:Connect(function()
    if self.CurrentSection ~= NewSection then
      self:SelectSection(NewSection)
    end
  end)

  return NewSection
end

-- Window:Destroy()

function Window:Destroy()
  self.WindowUIObject:Destroy()

  self.__index = nil
  setmetatable(self, nil)
end

-- Window:Toggle()

function Window:Toggle()
  self.WindowUIObject.Enabled = not self.Toggled

  self.Toggled = not self.Toggled
end

-- Window:SelectTab(Tab)

function Window:SelectTab(Tab)
  FadeIcon(Tab.TabInstance.Icon, Theme.Icon.Active)
  FadeFrame(Tab.TabInstance, Theme.Tab.Active)

  Tab.TabContent:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.25, true)

  if self.WindowCurrentTab ~= nil then
    FadeIcon(self.WindowCurrentTab.TabInstance.Icon, Theme.Icon.None)
    FadeFrame(self.WindowCurrentTab.TabInstance, Theme.Tab.None)

    local OldTabContent = self.WindowCurrentTab.TabContent

    self.WindowCurrentTab.TabContent:TweenPosition(UDim2.new(0, 0, -1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.25, true, function()
      OldTabContent.Position = UDim2.new(0, 0, 1, 0)
    end)
  end

  self.WindowCurrentTab = Tab
end

-- <Instance> Window:GetCurrentTab()

function Window:GetCurrentTab()
  return self.WindowCurrentTab
end

-- <Tab> Window:AddTab(TabName, TabIcon)

function Window:AddTab(TabName, TabIcon)
  if self.TabCount == 6 then
    return
  end

  self.TabCount += 1

  local Holder = Instance.new("Frame", self.WindowTabHolder)

  Holder.Name = TabName
  Holder.BorderSizePixel = 0
  Holder.BackgroundColor3 = Theme.Tab.None
  Holder.ZIndex = 2

  local Icon = Instance.new("ImageLabel", Holder)

  Icon.Name = "Icon"
  Icon.Position = UDim2.new(0.25, 0, 0.2, 0)
  Icon.Size = UDim2.new(0.6, 0, 0.6, 0)
  Icon.BackgroundTransparency = 1
  Icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
  Icon.ZIndex = 2

  Icon.Image = "http://www.roblox.com/asset/?id=" .. TabIcon
  Icon.ImageColor3 = Theme.Icon.None

  local Click = Instance.new("TextButton", Holder)

  Click.BackgroundTransparency = 1
  Click.Text = ""
  Click.Size = UDim2.new(1, 0, 1, 0)
  Click.Name = "Click"
  Click.ZIndex = 2

  local Content = Instance.new("Frame", self.WindowTabContent)

  Content.BackgroundTransparency = 1
  Content.BorderSizePixel = 0
  Content.Name = TabName
  Content.Size = UDim2.new(1, 0, 1, 0)
  Content.Position = UDim2.new(0, 0, 1, 0)

  local Sections = Instance.new("Frame", Content)

  Sections.BackgroundTransparency = 1
  Sections.BorderSizePixel = 0
  Sections.Name = "Sections"
  Sections.Size = UDim2.new(1, 0, 0.125, 0)

  local SectionsHolder = Instance.new("Frame", Sections)
  
  SectionsHolder.BackgroundColor3 = Theme.SidebarColor
  SectionsHolder.BorderSizePixel = 0
  SectionsHolder.Name = "Holder"
  SectionsHolder.Position = UDim2.new(0.1, 0, 0.2, 0)
  SectionsHolder.Size = UDim2.new(0.8, 0, 0.6, 0)
  SectionsHolder.ClipsDescendants = true

  ORoundElement(SectionsHolder, 3)

  local ListLayout = Instance.new("UIListLayout", SectionsHolder)
  
  ListLayout.FillDirection = Enum.FillDirection.Horizontal
  ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
  ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

  local Components = Instance.new("Frame", Content)
  Components.BackgroundTransparency = 1
  Components.BorderSizePixel = 0
  Components.Name = "Components"
  Components.Size = UDim2.new(1, 0, 0.875, 0)
  Components.Position = UDim2.new(0, 0, 0.125, 0)

  local NewTab = setmetatable({ Window = self, ActiveSection = nil, TabContent = Content, TabInstance = Holder, ComponentsHolder = Components, SectionsHolder = SectionsHolder, Sections = {}, SectionCount = 0 }, Tab)

  if self:GetCurrentTab() == nil then
    self:SelectTab(NewTab)
  end

  Holder.MouseEnter:Connect(
    function()
      if self:GetCurrentTab() ~= NewTab then
        FadeIcon(Icon, Theme.Icon.Hovered)
      end
    end
  )

  Holder.MouseLeave:Connect(
    function()
      if self:GetCurrentTab() ~= NewTab then
        FadeIcon(Icon, Theme.Icon.None)
      end
    end
  )

  Click.MouseButton1Click:Connect(
    function()
      if self:GetCurrentTab() ~= NewTab then
        self:SelectTab(NewTab)
      end
    end
  )

  self.Tabs[TabName] = NewTab
  
  return NewTab
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
  Background.BackgroundColor3 = Theme.MainBackground
  Background.Size = UDim2.new(1, 0, 1, 0)
  Background.BorderSizePixel = 0
  Background.Name = "Background"

  ORoundElement(Background, 3)

  --// TopGradient Creation \\--

  local TopGradient = Instance.new("Frame", UIHolder)
  TopGradient.Size = UDim2.new(1, 0, 0.02, 0)
  TopGradient.Position = UDim2.new(0, 0, -0.01, 0)
  TopGradient.BorderSizePixel = 0
  TopGradient.Name = "TopGradient"
  TopGradient.ZIndex = 0

  SRoundElement(TopGradient, 1)
  Gradient(TopGradient, Theme.TopGradient.From, Theme.TopGradient.To, 0)

  --// TopUnround Creation \\--

  local TopUnround = Instance.new("Frame", Background)
  TopUnround.Size = UDim2.new(1, 0, 0.06, 0)
  TopUnround.BorderSizePixel = 0
  TopUnround.BackgroundColor3 = Theme.MainBackground
  TopUnround.Name = "TopUnround"

  --// Background content Creation \\--

  local BackgroundContent = Instance.new("Frame", Background)
  BackgroundContent.Name = "Content"
  BackgroundContent.BackgroundTransparency = 1
  BackgroundContent.BorderSizePixel = 0
  BackgroundContent.Size = UDim2.new(1, 0, 1, 0)

  --// Sidebar Creation \\--

  local Sidebar = Instance.new("Frame", BackgroundContent)
  Sidebar.Name = "Sidebar"
  Sidebar.BackgroundColor3 = Theme.SidebarColor
  Sidebar.BorderSizePixel = 0
  Sidebar.Size = UDim2.new(0.095, 0, 1, 0)

  ORoundElement(Sidebar, 3)

  local STabs = Instance.new("Frame", Sidebar)
  STabs.Name = "Tabs"
  STabs.BackgroundTransparency = 1
  STabs.BorderSizePixel = 0
  STabs.Size = UDim2.new(1, 0, 1, 0)

  local BottomContent = Instance.new("Frame", STabs)
  BottomContent.Name = "BottomContent"
  BottomContent.BackgroundTransparency = 1
  BottomContent.BorderSizePixel = 0
  BottomContent.Position = UDim2.new(0, 0, 1, 0)
  BottomContent.Size = UDim2.new(1, 0, -0.15, 0)

  local UserImage = Instance.new("ImageLabel", BottomContent)
  UserImage.Name = "UserImage"
  UserImage.BackgroundTransparency = 1
  UserImage.BorderSizePixel = 0
  UserImage.Position = UDim2.new(0.2, 0, 0.2, 0)
  UserImage.Size = UDim2.new(0.6, 0, 0.6, 0)
  UserImage.Image = GetHeadshotAvatar(Players.LocalPlayer)

  SRoundElement(UserImage, 1)

  local TopContent = Instance.new("Frame", STabs)
  TopContent.Name = "TopContent"
  TopContent.BackgroundTransparency = 1
  TopContent.BorderSizePixel = 0
  TopContent.Size = UDim2.new(1, 0, 0.85, 0)

  GridLayout(TopContent, Enum.FillDirection.Horizontal, 6, UDim2.new(1, 0, 0.15, 0), UDim2.new(0, 0, 0, 0))

  local SidebarUnround1 = Instance.new("Frame", Sidebar)
  SidebarUnround1.Size = UDim2.new(-0.06, 0, 0.06, 0)
  SidebarUnround1.Position = UDim2.new(1, 0, 0, 0)
  SidebarUnround1.BorderSizePixel = 0
  SidebarUnround1.BackgroundColor3 = Theme.SidebarColor
  SidebarUnround1.Name = "Unround"

  local SidebarUnround2 = Instance.new("Frame", Sidebar)
  SidebarUnround2.Position = UDim2.new(1, 0, 1, 0)
  SidebarUnround2.Size = UDim2.new(-0.06, 0, -0.06)
  SidebarUnround2.BorderSizePixel = 0
  SidebarUnround2.BackgroundColor3 = Theme.SidebarColor
  SidebarUnround2.Name = "Unround"

  --// TabContent Creation \\--

  local TabContent = Instance.new("Frame", BackgroundContent)
  TabContent.Name = "TabContent"
  TabContent.BackgroundTransparency = 1
  TabContent.BorderSizePixel = 0
  TabContent.Size = UDim2.new(0.905, 0, 1, 0)
  TabContent.Position = UDim2.new(0.095, 0, 0, 0)
  TabContent.ClipsDescendants = true

  --// Return the window \\--

  return setmetatable(
    {
      WindowName = Name,
      WindowUIObject = ScreenGui,
      WindowTabHolder = TopContent,
      WindowTabContent = TabContent,
      WindowCurrentTab = nil,
      Toggled = true,
      TabCount = 0,
      Tabs = {}
    },
    Window
  )
end

--// Finish up \\--

return Library
