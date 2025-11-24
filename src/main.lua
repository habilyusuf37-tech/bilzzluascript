--===== LOAD RAYFIELD =====--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

--===== SERVICES =====--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local task = task

local lp = Players.LocalPlayer
local character = lp.Character or lp.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

--===== VEHICLE =====--
local vehicle = workspace:WaitForChild("Vehicle") -- ganti sesuai vehicle
local vehicleRoot = vehicle:WaitForChild("PrimaryPart") or vehicle:WaitForChild("HumanoidRootPart")

--===== WAYPOINTS =====--
local waypoints = {
    {pos = Vector3.new(-13007.67, 1051.88, -16369.39), radius = 15},
    {pos = Vector3.new(-38723.95, 1013.15, -62498.38), radius = 20},
    {pos = Vector3.new(-50885.80, 1012.89, -86516.27), radius = 25},
    {pos = Vector3.new(-25909.67, 1050.33, -43893.98), radius = 10},
}

local jobTruck = Vector3.new(-21795.81, 1052.03, -26799.80)
local flySpeed = 250
local delayTime = 45
local pingLimit = 180
local currentWP = 1
local running = false
local earnings = 0
local noclipConn, flyConn, bv

--===== RAYFIELD UI =====--
local Window = Rayfield:CreateWindow({
    Name = "Premium by Bill",
    LoadingTitle = "Bill Hub",
    LoadingSubtitle = "by Bill",
    Theme = "Dark",
    ConfigurationSaving = { Enabled = true, FolderName = "PremiumByBillConfigs", FileName = "Config1" },
    KeySystem = true,
    KeySettings = {
        Title = "Masukkan Key",
        Subtitle = "Masukkan key untuk mengakses UI",
        Note = "Key: premiumhub",
        FileName = "KeyConfig",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "premiumhub"
    }
})

local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateSlider({
    Name = "Delay Timer (detik)",
    Range = {5, 120},
    Increment = 1,
    Suffix = "s",
    CurrentValue = delayTime,
    Callback = function(value)
        delayTime = value
    end,
})
MainTab:CreateSlider({
    Name = "Speed",
    Range = {50, 500},
    Increment = 10,
    Suffix = "stud/s",
    CurrentValue = flySpeed,
    Callback = function(value)
        flySpeed = value
    end,
})
MainTab:CreateButton({
    Name = "Teleport Job Truck",
    Callback = function()
        if vehicleRoot then
            vehicleRoot.CFrame = CFrame.new(jobTruck + Vector3.new(0,5,0))
            Rayfield:Notify({Title="Teleport", Content="Berhasil teleport ke Job Truck", Duration=3})
        end
    end,
})
MainTab:CreateToggle({
    Name = "AutoFarm ON/OFF",
    CurrentValue = false,
    Callback = function(value)
        running = value
        if value then
            Rayfield:Notify({Title="AutoFarm", Content="AutoFarm Truck dijalankan!", Duration=3})
            startAutoFarm()
        else
            Rayfield:Notify({Title="AutoFarm", Content="AutoFarm Truck dihentikan!", Duration=3})
            stopAutoFarm()
        end
    end,
})

--===== AUTO FARM FUNCTION =====--
function startAutoFarm()
    if noclipConn then noclipConn:Disconnect() end
    if flyConn then flyConn:Disconnect() end
    if bv then bv:Destroy() end

    noclipConn = RunService.Stepped:Connect(function()
        if not running or not vehicle then return end
        for _, part in pairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e5,1e5,1e5)
    bv.Velocity = Vector3.new(0,0,0)
    bv.Parent = vehicleRoot

    flyConn = RunService.Heartbeat:Connect(function()
        if not running or not vehicleRoot then return end

        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        if ping > pingLimit then
            bv.Velocity = Vector3.new(0,0,0)
            task.wait(delayTime)
            return
        end

        local target = waypoints[currentWP].pos
        local dir = (target - vehicleRoot.Position).Unit
        bv.Velocity = dir * flySpeed + Vector3.new(0,10,0)

        if (vehicleRoot.Position - target).Magnitude < waypoints[currentWP].radius then
            earnings += math.random(100,500)
            Rayfield:Notify({Title="Waypoint Reached", Content="Earnings: Rp "..earnings, Duration=2})

            running = false
            bv.Velocity = Vector3.new(0,0,0)
            task.spawn(function()
                for i = delayTime,0,-1 do
                    Rayfield:Notify({Title="Delay AutoFarm", Content="AutoFarm lanjut dalam "..i.." detik", Duration=1})
                    task.wait(1)
                end
                currentWP = currentWP % #waypoints + 1
                running = true
            end)
        end
    end)
end

function stopAutoFarm()
    if noclipConn then noclipConn:Disconnect() end
    if flyConn then flyConn:Disconnect() end
    if bv then bv:Destroy() end
end

--===== NOTIFIKASI WELCOME =====--
Rayfield:Notify({
    Title = "Welcome!",
    Content = "Menu Premium by Bill siap digunakan",
    Duration = 5,
})
