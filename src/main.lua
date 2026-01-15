local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [[ SETTINGS ]] --
_G.AutoOpenBasic = false

-- [[ FUNCTION ]] --
local function OpenBasicBox()
    local args = { "BasicBox" }
    local remote = ReplicatedStorage:FindFirstChild("Box") 
        and ReplicatedStorage.Box:FindFirstChild("Remotes") 
        and ReplicatedStorage.Box.Remotes:FindFirstChild("Client") 
        and ReplicatedStorage.Box.Remotes.Client:FindFirstChild("RollBox")
    
    if remote then
        remote:FireServer(unpack(args))
    end
end

-- [[ UI WINDOW ]] --
local Window = WindUI:CreateWindow({
    Title = "BilzzHub - Simple Box",
    Icon = "rbxassetid://124846601689213",
    Author = "Basic Box Only",
    Size = UDim2.fromOffset(400, 300),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 120
})

-- [[ TAB: BOX ]] --
local TabBox = Window:Tab({ Title = "Box", Icon = "package" })

TabBox:Section({ Title = "Box Opener" })

TabBox:Toggle({
    Title = "Auto Open Basic Box",
    Default = false,
    Callback = function(v)
        _G.AutoOpenBasic = v
        task.spawn(function()
            while _G.AutoOpenBasic do
                OpenBasicBox()
                task.wait(0.3) -- Jeda agar tidak spam berlebihan
            end
        end)
    end
})

TabBox:Button({
    Title = "Open Basic Box (1x)",
    Callback = function()
        OpenBasicBox()
        WindUI:Notify({Title = "System", Content = "open 1x box", Duration = 2})
    end
})

-- [[ AUTO AFK (Biar gak disconnect) ]] --
Player.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
