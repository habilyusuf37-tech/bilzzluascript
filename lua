--// MicLib - Single Column Fluent Style UI
--// Full Width Sections | 1 File | Loadstring Ready

local MicLib = {}
MicLib.__index = MicLib

-- SERVICES
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- CLEAN OLD
pcall(function()
    CoreGui.MicLib:Destroy()
end)

-- MAIN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MicLib"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- WINDOW
local Window = Instance.new("Frame")
Window.Size = UDim2.fromOffset(640, 420)
Window.Position = UDim2.fromScale(0.5, 0.5)
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
Window.BorderSizePixel = 0
Window.Parent = ScreenGui
Window.Active = true
Window.Draggable = true
Window.Name = "Window"

local Corner = Instance.new("UICorner", Window)
Corner.CornerRadius = UDim.new(0, 12)

-- SIDEBAR
local Sidebar = Instance.new("Frame", Window)
Sidebar.Size = UDim2.fromOffset(170, 420)
Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,20)
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner", Sidebar)
SidebarCorner.CornerRadius = UDim.new(0, 12)

-- TITLE
local Title = Instance.new("TextLabel", Sidebar)
Title.Text = "MicLib"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,50)

-- TAB HOLDER
local TabsHolder = Instance.new("UIListLayout", Sidebar)
TabsHolder.Padding = UDim.new(0,6)
TabsHolder.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsHolder.VerticalAlignment = Enum.VerticalAlignment.Top
TabsHolder.Parent = Sidebar

-- CONTENT
local Content = Instance.new("Frame", Window)
Content.Position = UDim2.fromOffset(170, 0)
Content.Size = UDim2.new(1, -170, 1, 0)
Content.BackgroundTransparency = 1

-- SCROLL
local Scroll = Instance.new("ScrollingFrame", Content)
Scroll.Size = UDim2.fromScale(1,1)
Scroll.CanvasSize = UDim2.fromOffset(0,0)
Scroll.ScrollBarImageTransparency = 1
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.BackgroundTransparency = 1

local ContentLayout = Instance.new("UIListLayout", Scroll)
ContentLayout.Padding = UDim.new(0,14)

-- TAB SYSTEM
function MicLib:Tab(name)
    local TabBtn = Instance.new("TextButton", Sidebar)
    TabBtn.Size = UDim2.fromOffset(140, 36)
    TabBtn.Text = name
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 14
    TabBtn.TextColor3 = Color3.fromRGB(200,200,200)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30,30,34)
    TabBtn.BorderSizePixel = 0

    local TCorner = Instance.new("UICorner", TabBtn)
    TCorner.CornerRadius = UDim.new(0,8)

    TabBtn.MouseButton1Click:Connect(function()
        for _,v in pairs(Scroll:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end
        TabFrame.Visible = true
    end)

    local TabFrame = Instance.new("Frame", Scroll)
    TabFrame.Size = UDim2.new(1, -10, 0, 0)
    TabFrame.AutomaticSize = Enum.AutomaticSize.Y
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false

    local TabLayout = Instance.new("UIListLayout", TabFrame)
    TabLayout.Padding = UDim.new(0,12)

    local TabAPI = {}

    -- SECTION (FULL WIDTH)
    function TabAPI:Section(title)
        local Section = Instance.new("Frame", TabFrame)
        Section.Size = UDim2.new(1, 0, 0, 0)
        Section.AutomaticSize = Enum.AutomaticSize.Y
        Section.BackgroundColor3 = Color3.fromRGB(28,28,32)
        Section.BorderSizePixel = 0

        local SC = Instance.new("UICorner", Section)
        SC.CornerRadius = UDim.new(0,10)

        local Padding = Instance.new("UIPadding", Section)
        Padding.PaddingAll = UDim.new(0,14)

        local Layout = Instance.new("UIListLayout", Section)
        Layout.Padding = UDim.new(0,10)

        local Label = Instance.new("TextLabel", Section)
        Label.Text = title
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 14
        Label.TextColor3 = Color3.fromRGB(255,255,255)
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.new(1,0,0,20)
        Label.TextXAlignment = Left

        local SectionAPI = {}

        function SectionAPI:Button(text, callback)
            local Btn = Instance.new("TextButton", Section)
            Btn.Size = UDim2.new(1,0,0,36)
            Btn.Text = text
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.BackgroundColor3 = Color3.fromRGB(38,38,44)
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.BorderSizePixel = 0
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)

            Btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end

        function SectionAPI:Toggle(text, default, callback)
            local Toggle = Instance.new("TextButton", Section)
            Toggle.Size = UDim2.new(1,0,0,36)
            Toggle.Text = text.." : "..(default and "ON" or "OFF")
            Toggle.Font = Enum.Font.Gotham
            Toggle.TextSize = 14
            Toggle.BackgroundColor3 = Color3.fromRGB(38,38,44)
            Toggle.TextColor3 = Color3.new(1,1,1)
            Toggle.BorderSizePixel = 0
            Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,8)

            local state = default
            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Toggle.Text = text.." : "..(state and "ON" or "OFF")
                pcall(callback, state)
            end)
        end

        return SectionAPI
    end

    return TabAPI
end

-- WINDOW INIT
function MicLib:Window(cfg)
    Title.Text = cfg.Title or "MicLib"
    return self
end

return setmetatable({}, MicLib)
