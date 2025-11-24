-- Premium Hub v5 | Loadstring Version 2025 | Anti-Block
-- Upload ini ke Pastebin / Gist / Private Repo
-- Link loader: https://pastebin.com/raw/XxXxXxXx

if not game:IsLoaded() then game.Loaded:Wait() end
repeat wait() until game:GetService("Players").LocalPlayer

local url = "https://raw.githubusercontent.com/YourUser/PremiumHub/main/main.lua" -- ganti tiap update
-- atau pakai mirror: "https://pastebin.com/raw/12345678"

local success, err = pcall(function()
    loadstring(game:HttpGet(url, true))()
end)

if not success then
    warn("Premium Hub gagal load! Coba lagi atau update link.")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Premium Hub Error";
        Text = "Link mati / blocked. Join Discord untuk link baru!";
        Duration = 10;
    })
end
