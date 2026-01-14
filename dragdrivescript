local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- [[ UTILS & DETECTIONS ]] --
local function GetDevice()
return (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) and "Mobile 📱" or "PC / Laptop 💻"
end

local function FormatNumber(value)
local str = tostring(math.floor(value))
return str:reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "")
end

local function HideName(name)
if #name <= 2 then return "**" end
return name:sub(1, 1) .. string.rep("*", #name - 2) .. name:sub(-1)
end

-- [[ FIXED BLACK SCREEN LOGIC ]] --
local BlackScreenGui = nil
local function SetBlackScreen(state)
if state then
if not BlackScreenGui then
BlackScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
BlackScreenGui.Name = "BilzzBlackScreen"
BlackScreenGui.IgnoreGuiInset = true
BlackScreenGui.DisplayOrder = -1

local Frame = Instance.new("Frame", BlackScreenGui)  
        Frame.Size = UDim2.new(1, 0, 1, 0)  
        Frame.BackgroundColor3 = Color3.new(0, 0, 0)  
        Frame.BorderSizePixel = 0  
          
        local Label = Instance.new("TextLabel", Frame)  
        Label.Size = UDim2.new(1, 0, 1, 0)  
        Label.BackgroundTransparency = 1  
        -- UPDATE: Teks Black Screen sesuai request  
        Label.Text = "AUTOFARM ON\nSCRIPT BY BILZZ"  
        Label.TextColor3 = Color3.new(1, 1, 1)  
        Label.Font = "GothamBold"  
        Label.TextSize = 22  
    end  
else  
    if BlackScreenGui then BlackScreenGui:Destroy(); BlackScreenGui = nil end  
end

end

-- [[ GLOBAL VARIABLES ]] --
_G.AutoFarmEnabled = false
_G.VehicleSpeed = 295
_G.TargetEarningValue = 0
_G.TargetEnabled = false
_G.AutoRejoin = false
_G.AntiAfk = false
_G.HideNameEnabled = false
_G.HideCharEnabled = false
_G.WebhookURL = ""
_G.WebhookEnabled = false

local targetIndex = 1
local targets = {CFrame.new(-39.24, 12.8, -575.58), CFrame.new(-16704.28, 115.08, 10064.52)}
local RunningSeconds = 0
local RPValue = Player:WaitForChild("PlayerData"):WaitForChild("RPValue")
local StartMoney = RPValue.Value

-- [[ WEBHOOK FUNCTION ]] --
local function SendDiscordLog(isTest)
if _G.WebhookURL == "" or (not _G.WebhookEnabled and not isTest) then return end
local currentRP = RPValue.Value
local totalEarned = currentRP - StartMoney
local timeStr = string.format("%02d:%02d:%02d", math.floor(RunningSeconds/3600), math.floor((RunningSeconds%3600)/60), RunningSeconds%60)

local data = {    
    ["embeds"] = {{    
        ["title"] = "🏍️ Drag Drive Auto Farm Tracker",    
        ["color"] = 16777215,    
        ["fields"] = {    
            {["name"] = "👤 Username", ["value"] = "```" .. HideName(Player.Name) .. "```", ["inline"] = false},    
            {["name"] = "🕒 Running Time", ["value"] = timeStr, ["inline"] = true},    
            {["name"] = "💰 Current Money", ["value"] = "RP. " .. FormatNumber(currentRP), ["inline"] = false},    
            {["name"] = "💵 Total Earning", ["value"] = "RP. " .. FormatNumber(totalEarned), ["inline"] = false}    
        },    
        ["footer"] = {["text"] = "Power By BilzzHub ⚡"}    
    }}    
}    
local requestFunc = syn and syn.request or http and http.request or http_request or request    
if requestFunc then    
    requestFunc({Url = _G.WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(data)})    
end

end

-- [[ UI WINDOW ]] --
local Window = WindUI:CreateWindow({
Title = "BillzzHub ",
Icon = "rbxassetid://124846601689213",
Author = "best script in drag drive simulator",
Size = UDim2.fromOffset(450, 350),
Transparent = true,
Theme = "Dark",
SideBarWidth = 140
})

-- [[ TABS ]] --
local TabInfo = Window:Tab({ Title = "Information", Icon = "info" })
local TabFarming = Window:Tab({ Title = "Farming", Icon = "car" })
local TabStats = Window:Tab({ Title = "Stats", Icon = "trending-up" })
local TabWebhook = Window:Tab({ Title = "Webhook", Icon = "share-2" })
local TabShop = Window:Tab({ Title = "Shop", Icon = "shopping-cart" })
local TabMisc = Window:Tab({ Title = "Misc", Icon = "settings" })

-- [[ TAB: INFORMATION ]] --
TabInfo:Section({ Title = "Script Information" })
TabInfo:Paragraph({ Title = "Status : 🟢 Online", Content = "" })
TabInfo:Paragraph({ Title = "Owner : BilzzHub", Content = "" })

TabInfo:Section({ Title = "Farming Information" })
TabInfo:Paragraph({ Title = "information : Use speed at kmh 280 and use private server", Content = "" })

TabInfo:Section({ Title = "Support (Media)" })
TabInfo:Button({
Title = "Join Discord",
Callback = function()
setclipboard("https://discord.gg/HsNseCuEWZ")
WindUI:Notify({Title = "System", Content = "Link Copied!", Duration = 2})
end
})
TabInfo:Button({
Title = "Follow TikTok",
Callback = function()
setclipboard("https://www.tiktok.com/@infoupdateidcd?_r=1&_t=ZS-933taXsG5FB")
WindUI:Notify({Title = "System", Content = "Link Copied!", Duration = 2})
end
})

-- [[ TAB: FARMING ]] --
TabFarming:Section({ Title = "Main Controls" })
TabFarming:Toggle({
Title = "Auto Farm",
Default = false,
Callback = function(v)
_G.AutoFarmEnabled = v
SetBlackScreen(v)
if not v then
task.wait(0.3)
if Player.Character then Player.Character:BreakJoints() end
end
end
})
TabFarming:Input({ Title = "Vehicle Speed", Default = "295", Callback = function(v) _G.VehicleSpeed = tonumber(v) or 295 end })

TabFarming:Section({ Title = "Target Settings" })
TabFarming:Toggle({ Title = "enable target", Default = false, Callback = function(v) _G.TargetEnabled = v end })
TabFarming:Input({ Title = "Set Target RP", Placeholder = "Enter RP Amount", Callback = function(v) _G.TargetEarningValue = tonumber(v) or 0 end })

-- [[ TAB: STATS ]] --
TabStats:Section({ Title = "Tracker" })
local TargetLabel = TabStats:Button({ Title = "Target : RP.0" })
local TotalLabel = TabStats:Button({ Title = "Earned : RP.0" })
local MoneyLabel = TabStats:Button({ Title = "Balance : RP.0" })
local TimeLabel = TabStats:Button({ Title = "Time : 00:00:00" })

TabStats:Section({ Title = "System" })
local FPSLabel = TabStats:Button({ Title = "FPS : 0" })
TabStats:Button({ Title = "Device : " .. GetDevice() })
TabStats:Button({ Title = "Executor : " .. (identifyexecutor and identifyexecutor() or "Unknown") })

-- [[ TAB: WEBHOOK ]] --
TabWebhook:Section({ Title = "Discord Log" })
TabWebhook:Input({ Title = "URL", Placeholder = "Paste Webhook Here", Callback = function(v) _G.WebhookURL = v end })
TabWebhook:Toggle({ Title = "Enable Webhook", Default = false, Callback = function(v) _G.WebhookEnabled = v end })
TabWebhook:Button({
Title = "Send Test Payload",
Callback = function()
SendDiscordLog(true)
WindUI:Notify({Title = "Webhook", Content = "Test Payload Sent!", Duration = 2})
end
})

-- [[ TAB: SHOP ]] --
TabShop:Section({ Title = "Teleport Dealer" })
TabShop:Button({ Title = "Cars", Callback = function() if Player.Character then Player.Character.HumanoidRootPart.CFrame = CFrame.new(-6605.78, 5.30, -4211.78) end end })
TabShop:Button({ Title = "DragSpec", Callback = function() if Player.Character then Player.Character.HumanoidRootPart.CFrame = CFrame.new(-5005.32, 4.66, -5351.67) end end })
TabShop:Button({ Title = "Hando", Callback = function() if Player.Character then Player.Character.HumanoidRootPart.CFrame = CFrame.new(-5956.16, 5.94, -3898.99) end end })
TabShop:Button({ Title = "Vespero", Callback = function() if Player.Character then Player.Character.HumanoidRootPart.CFrame = CFrame.new(-5753.15, 6.40, -3896.12) end end })

-- [[ TAB: MISC ]] --
TabMisc:Section({ Title = "Character & Name" })
-- UPDATE: Nama toggle sesuai request
TabMisc:Toggle({ Title = "Hide Name by Bilzz", Default = false, Callback = function(v) _G.HideNameEnabled = v end })
TabMisc:Toggle({ Title = "Hide Character", Default = false, Callback = function(v) _G.HideCharEnabled = v end })
TabMisc:Button({ Title = "Reset Character", Callback = function() if Player.Character then Player.Character:BreakJoints() end end })

TabMisc:Section({ Title = "Automation" })
TabMisc:Toggle({ Title = "Anti AFK", Default = false, Callback = function(v) _G.AntiAfk = v end })
TabMisc:Toggle({ Title = "Auto Rejoin", Default = false, Callback = function(v) _G.AutoRejoin = v end })

-- [[ LOGICS ]] --
RunService.RenderStepped:Connect(function()
if _G.HideNameEnabled and Player.Character and Player.Character:FindFirstChild("Head") then
local tag = Player.Character.Head:FindFirstChildOfClass("BillboardGui")
if tag then tag.Enabled = false end
end
if _G.HideCharEnabled and Player.Character then
for _, v in pairs(Player.Character:GetDescendants()) do
if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
end
end
end)

Player.Idled:Connect(function()
if _G.AntiAfk then
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end
end)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
if _G.AutoRejoin and child.Name == "ErrorPrompt" then
TeleportService:Teleport(game.PlaceId, Player)
end
end)

RunService.Heartbeat:Connect(function()
if _G.AutoFarmEnabled then
local char = Player.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
local motor = hum and hum.SeatPart and hum.SeatPart:FindFirstAncestorOfClass("Model")
if motor and motor.PrimaryPart then
for _, v in pairs(motor:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
local targetPos = targets[targetIndex].Position + Vector3.new(0, 50, 0)
motor.PrimaryPart.AssemblyLinearVelocity = (targetPos - motor.PrimaryPart.Position).Unit * _G.VehicleSpeed
motor.PrimaryPart.CFrame = CFrame.new(motor.PrimaryPart.Position, targetPos)
if (motor.PrimaryPart.Position - targetPos).Magnitude < 25 then targetIndex = targetIndex % #targets + 1 end
end
end
end)

task.spawn(function()
local lastWeb = tick()
while task.wait(1) do
pcall(function()
local earned = RPValue.Value - StartMoney
TargetLabel:SetTitle("Target: RP." .. FormatNumber(_G.TargetEarningValue))
TotalLabel:SetTitle("Earned : RP." .. FormatNumber(earned))
MoneyLabel:SetTitle("Balance : RP." .. FormatNumber(RPValue.Value))
FPSLabel:SetTitle("FPS : " .. math.floor(game:GetService("Stats").Workspace.Heartbeat:GetValueString()))

if _G.TargetEnabled and earned >= _G.TargetEarningValue then  
            _G.AutoFarmEnabled = false; SetBlackScreen(false)  
            Player:Kick("\nTarget Reached: RP." .. FormatNumber(earned))  
        end  
          
        if _G.AutoFarmEnabled then   
            RunningSeconds = RunningSeconds + 1   
            if _G.WebhookEnabled and (tick() - lastWeb >= 60) then  
                SendDiscordLog(false)  
                lastWeb = tick()  
            end  
        end  
        local h, m, s = math.floor(RunningSeconds/3600), math.floor((RunningSeconds%3600)/60), RunningSeconds%60  
        TimeLabel:SetTitle(string.format("Time : %02d:%02d:%02d", h, m, s))  
    end)  
end

end)
