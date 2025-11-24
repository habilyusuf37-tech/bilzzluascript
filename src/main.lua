-- GROK ATOMIC CDID w/ KEY "ph2025" + FLOATING CIRCLE TOGGLE (FULL VERSION - Nov 2025)
-- Paste langsung ke executor → Redeem key → Circle muncul → Klik circle buka menu!

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local rs = game:GetService("ReplicatedStorage")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local run = game:GetService("RunService")
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

local keyValid = false
local money = 0

-- KEY SYSTEM UI (Awal execute)
local keyGui = Instance.new("ScreenGui", pgui)
keyGui.Name = "KeyAuth"
keyGui.ResetOnSpawn = false

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0, 350, 0, 200)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
keyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
keyFrame.BorderSizePixel = 0
local kCorner = Instance.new("UICorner", keyFrame) kCorner.CornerRadius = UDim.new(0,15)
local kStroke = Instance.new("UIStroke", keyFrame) kStroke.Color = Color3.fromRGB(0,255,0) kStroke.Thickness = 3

local kTitle = Instance.new("TextLabel", keyFrame)
kTitle.Size = UDim2.new(1,0,0,60)
kTitle.BackgroundColor3 = Color3.fromRGB(0,170,0)
kTitle.Text = "🔑 KEY AUTH - GROK ATOMIC CDID"
kTitle.TextColor3 = Color3.new(1,1,1)
kTitle.Font = Enum.Font.GothamBold
kTitle.TextSize = 20
local ktCorner = Instance.new("UICorner", kTitle) ktCorner.CornerRadius = UDim.new(0,15)

local kInput = Instance.new("TextBox", keyFrame)
kInput.Size = UDim2.new(1,-40,0,50)
kInput.Position = UDim2.new(0,20,0,80)
kInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
kInput.PlaceholderText = "Masukkan key: ph2025"
kInput.Text = ""
kInput.TextColor3 = Color3.new(1,1,1)
kInput.Font = Enum.Font.Gotham
kInput.TextSize = 18
local kiCorner = Instance.new("UICorner", kInput) kiCorner.CornerRadius = UDim.new(0,10)

local redeemBtn = Instance.new("TextButton", keyFrame)
redeemBtn.Size = UDim2.new(0,100,0,40)
redeemBtn.Position = UDim2.new(0.5,-50,0,140)
redeemBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
redeemBtn.Text = "REDEEM"
redeemBtn.TextColor3 = Color3.new(1,1,1)
redeemBtn.Font = Enum.Font.GothamBold
redeemBtn.TextSize = 18
local rbCorner = Instance.new("UICorner", redeemBtn) rbCorner.CornerRadius = UDim.new(0,10)

redeemBtn.MouseButton1Click:Connect(function()
    if kInput.Text == "ph2025" then
        keyValid = true
        keyGui:Destroy()
        loadMainScript()  -- Auto execute main script
        game.StarterGui:SetCore("SendNotification", {Title="KEY VALID!", Text="Floating circle muncul! Klik buat menu.", Duration=5})
    else
        kInput.Text = ""
        kInput.PlaceholderText = "Key salah! Coba lagi: ph2025"
    end
end)

function loadMainScript()
    -- FLOATING CIRCLE TOGGLE (Bulatan hijau pojok kanan bawah - Draggable)
    local circleGui = Instance.new("ScreenGui", pgui)
    circleGui.Name = "CircleToggle"
    circleGui.ResetOnSpawn = false

    local circle = Instance.new("Frame", circleGui)
    circle.Size = UDim2.new(0, 80, 0, 80)
    circle.Position = UDim2.new(1, -100, 1, -100)
    circle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    circle.BorderSizePixel = 0
    local cCorner = Instance.new("UICorner", circle) cCorner.CornerRadius = UDim.new(0.5, 0)
    local cStroke = Instance.new("UIStroke", circle) cStroke.Color = Color3.new(1,1,1) cStroke.Thickness = 2

    local cIcon = Instance.new("TextLabel", circle)
    cIcon.Size = UDim2.new(1,0,1,0)
    cIcon.BackgroundTransparency = 1
    cIcon.Text = "🟢"
    cIcon.TextColor3 = Color3.new(1,1,1)
    cIcon.Font = Enum.Font.GothamBold
    cIcon.TextSize = 40

    -- Draggable Circle (Mobile friendly)
    local dragging = false
    circle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    circle.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            circle.Position = UDim2.new(0, input.Position.X - 40, 0, input.Position.Y - 40)
        end
    end)
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    -- MAIN MENU (Hidden awal, toggle via circle)
    local mainGui = Instance.new("ScreenGui", pgui)
    mainGui.Name = "GrokAtomic"
    mainGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame", mainGui)
    mainFrame.Size = UDim2.new(0, 450, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = false
    local mCorner = Instance.new("UICorner", mainFrame) mCorner.CornerRadius = UDim.new(0,12)
    local mStroke = Instance.new("UIStroke", mainFrame) mStroke.Color = Color3.fromRGB(0,255,0) mStroke.Thickness = 2

    local mTitle = Instance.new("TextLabel", mainFrame)
    mTitle.Size = UDim2.new(1,0,0,60)
    mTitle.BackgroundColor3 = Color3.fromRGB(0,170,0)
    mTitle.Text = "🟢 GROK ATOMIC HUB | CDID JABAR 🟢"
    mTitle.TextColor3 = Color3.new(1,1,1)
    mTitle.Font = Enum.Font.GothamBold
    mTitle.TextSize = 22
    local mtCorner = Instance.new("UICorner", mTitle) mtCorner.CornerRadius = UDim.new(0,12)

    local mClose = Instance.new("TextButton", mTitle)
    mClose.Size = UDim2.new(0,40,0,40)
    mClose.Position = UDim2.new(1,-50,0,10)
    mClose.Text = "✕"
    mClose.BackgroundTransparency = 1
    mClose.TextColor3 = Color3.new(1,1,1)
    mClose.Font = Enum.Font.GothamBold
    mClose.TextSize = 24
    mClose.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

    -- Tabs sederhana (Autofarm | Dealer | Misc) - Ringan
    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = UDim2.new(1,0,0,40)
    tabFrame.Position = UDim2.new(0,0,0,60)
    tabFrame.BackgroundTransparency = 1

    local tabs = {"Autofarm", "Dealer", "Misc"}
    local pages = {}
    for i, t in ipairs(tabs) do
        local tabBtn = Instance.new("TextButton", tabFrame)
        tabBtn.Size = UDim2.new(1/#tabs,0,1,0)
        tabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
        tabBtn.Text = t
        tabBtn.TextColor3 = Color3.new(1,1,1)
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 16
        local tabC = Instance.new("UICorner", tabBtn) tabC.CornerRadius = UDim.new(0,8)

        pages[i] = Instance.new("ScrollingFrame", mainFrame)
        pages[i].Size = UDim2.new(1,-20,1,-120)
        pages[i].Position = UDim2.new(0,10,0,105)
        pages[i].BackgroundTransparency = 1
        pages[i].ScrollBarThickness = 6
        pages[i].Visible = i==1
        local pLayout = Instance.new("UIListLayout", pages[i]) pLayout.Padding = UDim.new(0,5)
    end

    -- Dealers (exact CDID)
    local Dealers = {Premium="PremiumDealer", Tokoma="TokomaDealer", SLM="SLMDealer", BMR="BMRDealer", Hyunson="HyunsonDealer", Mizada="MizadaDealer", Otnas="OtnasDealer", Retro="RetroDealer"}

    for dName, rName in pairs(Dealers) do
        local dBtn = Instance.new("TextButton", pages[2])
        dBtn.Size = UDim2.new(1,-10,0,45)
        dBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        dBtn.Text = "🏪 BUY ALL "..dName:upper()
        dBtn.TextColor3 = Color3.new(1,1,1)
        dBtn.Font = Enum.Font.GothamBold
        dBtn.TextSize = 15
        dBtn.MouseButton1Click:Connect(function()
            spawn(function()
                local remote = rs.DealerSystem:FindFirstChild(rName)
                if remote then
                    local oldPos = root.CFrame
                    root.CFrame = CFrame.new(351.16, 8.19, -286.64)
                    remote:FireServer("Open", dName)
                    wait(1.5)
                    local bought = 0
                    for _, obj in pairs(pgui:GetDescendants()) do
                        if obj:IsA("TextButton") and obj.Text:find("Buy") then
                            local car = obj.Text:match("(.-)Rp") or obj.Text
                            rs.DealerSystem.PurchaseCar:FireServer(car)
                            rs.NetworkContainer.RemoteEvents.BuyVehicle:FireServer(car)
                            bought += 1
                            wait(0.6)
                        end
                    end
                    root.CFrame = oldPos
                    game.StarterGui:SetCore("SendNotification", {Title=dName.." DONE", Text=bought.." cars!", Duration=4})
                end
            end)
        end)
    end

    -- Autofarm Toggles (Truck + Mini)
    local truckToggle = Instance.new("TextButton", pages[1])
    truckToggle.Size = UDim2.new(1,-10,0,50)
    truckToggle.Text = "🚚 TRUCK FARM [OFF]"
    truckToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
    truckToggle.TextColor3 = Color3.new(1,1,1)
    truckToggle.Font = Enum.Font.GothamBold
    truckToggle.TextSize = 16
    local truckOn = false
    truckToggle.MouseButton1Click:Connect(function()
        truckOn = not truckOn
        truckToggle.Text = truckOn and "🚚 TRUCK FARM [ON]" or "🚚 TRUCK FARM [OFF]"
        truckToggle.BackgroundColor3 = truckOn and Color3.fromRGB(0,170,0) or Color3.fromRGB(40,40,40)
    end)

    -- Counter Live
    local counter = Instance.new("TextLabel", mainFrame)
    counter.Size = UDim2.new(1,0,0,25)
    counter.Position = UDim2.new(0,0,1,-30)
    counter.BackgroundTransparency = 1
    counter.Text = "💰 Rp 0"
    counter.TextColor3 = Color3.fromRGB(0,255,0)
    counter.Font = Enum.Font.GothamBold
    counter.TextSize = 18

    -- Main Loop (Farm + Counter)
    spawn(function()
        while wait(0.1) do
            if truckOn then
                local tRemote = rs:FindFirstChild("TruckDelivery") or rs.NetworkContainer.RemoteEvents:FindFirstChild("CompleteDelivery")
                if tRemote then tRemote:FireServer() end
                money += 500000000
            end
            counter.Text = "💰 Rp " .. money
        end
    end)

    -- Tab Switch (Simple)
    for i=1,3 do
        local tabBtn = tabFrame:FindFirstChildOfClass("TextButton", i) or tabFrame:GetChildren()[i+1]
        if tabBtn then
            tabBtn.MouseButton1Click:Connect(function()
                for j,p in pairs(pages) do p.Visible = (j==i) end
            end)
        end
    end

    -- TOGGLE MAIN MENU VIA CIRCLE
    circle.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        ts:Create(circle, TweenInfo.new(0.2), {Size = UDim2.new(0, mainFrame.Visible and 90 or 80, 0, mainFrame.Visible and 90 or 80)}):Play()
    end)
end

print("^2[GROK ATOMIC] ^7Key system loaded! Input ph2025")
