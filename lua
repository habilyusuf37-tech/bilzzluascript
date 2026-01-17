--[[
    MODIFIED MACLIB (FULL SOURCE)
    - Forced Vertical Layout (Single Column)
    - Premium Dark Theme (15, 15, 15)
    - Auto-Grouping for Elements
    - Optimized for GitHub Upload
]]

local MacLib = { 
	Options = {}, 
	Folder = "Maclib", 
	GetService = function(service)
		return cloneref and cloneref(game:GetService(service)) or game:GetService(service)
	end
}

--// Services
local TweenService = MacLib.GetService("TweenService")
local RunService = MacLib.GetService("RunService")
local HttpService = MacLib.GetService("HttpService")
local UserInputService = MacLib.GetService("UserInputService")
local Players = MacLib.GetService("Players")

--// Variables
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

--// Utility Functions
local function MakeDraggable(obj)
	local dragging, dragInput, dragStart, startPos
	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = obj.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

function MacLib:Window(Settings)
	local WindowFunctions = {Tabs = {}}
	
	local macLib = Instance.new("ScreenGui")
	macLib.Name = "MacLib_Modified"
	macLib.ResetOnSpawn = false
	macLib.DisplayOrder = 100
	macLib.Parent = (gethui and gethui()) or game:GetService("CoreGui")

	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Hitam Pekat
	mainFrame.Size = Settings.Size or UDim2.fromOffset(550, 600)
	mainFrame.Position = UDim2.fromScale(0.5, 0.5)
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Parent = macLib
	MakeDraggable(mainFrame)

	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 12)
	mainCorner.Parent = mainFrame

	-- Container Tab (Area di mana semua Group akan muncul)
	local contentArea = Instance.new("ScrollingFrame")
	contentArea.Name = "ContentArea"
	contentArea.Size = UDim2.new(1, -20, 1, -60)
	contentArea.Position = UDim2.new(0, 10, 0, 50)
	contentArea.BackgroundTransparency = 1
	contentArea.ScrollBarThickness = 2
	contentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
	contentArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
	contentArea.Parent = mainFrame

	local mainLayout = Instance.new("UIListLayout")
	mainLayout.Padding = UDim.new(0, 15) -- Jarak antar GROUP
	mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
	mainLayout.Parent = contentArea

	function WindowFunctions:Tab(Name)
		local TabFunctions = {}
		
		-- Dalam modifikasi ini, Tab akan langsung berfungsi sebagai pembuat Section/Group
		function TabFunctions:Section(Title)
			local SectionFunctions = {}
			
			local groupFrame = Instance.new("Frame")
			groupFrame.Name = Title .. "_Group"
			groupFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22) -- Warna Kotak Group
			groupFrame.Size = UDim2.new(1, 0, 0, 0) -- Lebar Penuh
			groupFrame.AutomaticSize = Enum.AutomaticSize.Y
			groupFrame.Parent = contentArea

			local groupCorner = Instance.new("UICorner")
			groupCorner.CornerRadius = UDim.new(0, 8)
			groupCorner.Parent = groupFrame

			local groupLayout = Instance.new("UIListLayout")
			groupLayout.Padding = UDim.new(0, 4) -- Jarak rapat antar elemen dalam group
			groupLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			groupLayout.SortOrder = Enum.SortOrder.LayoutOrder
			groupLayout.Parent = groupFrame

			local groupPadding = Instance.new("UIPadding")
			groupPadding.PaddingTop = UDim.new(0, 10)
			groupPadding.PaddingBottom = UDim.new(0, 10)
			groupPadding.Parent = groupFrame

			-- Title Group
			local headerLabel = Instance.new("TextLabel")
			headerLabel.Text = Title:upper()
			headerLabel.Size = UDim2.new(0.9, 0, 0, 20)
			headerLabel.BackgroundTransparency = 1
			headerLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
			headerLabel.TextXAlignment = Enum.TextXAlignment.Left
			headerLabel.Font = Enum.Font.GothamBold
			headerLabel.TextSize = 11
			headerLabel.Parent = groupFrame

			-- MODIFIKASI: Button dalam Group
			function SectionFunctions:Button(Args)
				local button = Instance.new("TextButton")
				button.Name = Args.Name
				button.Size = UDim2.new(0.95, 0, 0, 38)
				button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				button.Text = "  " .. Args.Name
				button.TextColor3 = Color3.fromRGB(255, 255, 255)
				button.TextXAlignment = Enum.TextXAlignment.Left
				button.Font = Enum.Font.Gotham
				button.TextSize = 13
				button.Parent = groupFrame

				local btnCorner = Instance.new("UICorner")
				btnCorner.CornerRadius = UDim.new(0, 6)
				btnCorner.Parent = button

				button.MouseButton1Click:Connect(Args.Callback)
				return button
			end

			-- MODIFIKASI: Toggle dalam Group
			function SectionFunctions:Toggle(Args)
				local toggleFrame = Instance.new("TextButton")
				toggleFrame.Size = UDim2.new(0.95, 0, 0, 38)
				toggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				toggleFrame.Text = ""
				toggleFrame.Parent = groupFrame

				local tglCorner = Instance.new("UICorner")
				tglCorner.CornerRadius = UDim.new(0, 6)
				tglCorner.Parent = toggleFrame

				local label = Instance.new("TextLabel")
				label.Text = "  " .. Args.Name
				label.Size = UDim2.new(1, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.TextColor3 = Color3.fromRGB(200, 200, 200)
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Font = Enum.Font.Gotham
				label.TextSize = 13
				label.Parent = toggleFrame

				local state = Args.Default or false
				toggleFrame.MouseButton1Click:Connect(function()
					state = not state
					label.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
					Args.Callback(state)
				end)
			end

			return SectionFunctions
		end
		return TabFunctions
	end
	
	return WindowFunctions
end

return MacLib

