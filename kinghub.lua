-- 👑 KING HUB | SAFE & FULL RGB (ESP + PLATFORM)
repeat task.wait() until game:IsLoaded()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("👑 KING HUB | PREMIUM RGB", "DarkScene")

-- TABS
local Main = Window:NewTab("Əsas Menu")
local Movement = Window:NewTab("Hərəkət")
local Visuals = Window:NewTab("Görünüş (ESP)")

-- --- ANA MENÜ ---
local MainSection = Main:NewSection("Script Yükləyici")
MainSection:NewButton("P8eK5qd2 Scriptini İşə Sal", "Özel scripti aktiv edir", function()
    pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/P8eK5qd2"))()
    end)
end)

-- --- HƏRƏKƏT (SAFE MODE) ---
local MoveSection = Movement:NewSection("Safe Movement")
MoveSection:NewSlider("Sürət (Speed)", "Güvənli limit: 100", 100, 16, function(s)
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)
end)

MoveSection:NewSlider("Tullanış (Jump)", "Güvənli limit: 120", 120, 50, function(s)
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
    end)
end)

-- 🌈 RGB PLATFORM (Havada Blok Yaradır)
local plat_toggle = false
MoveSection:NewToggle("RGB Platform (Fly)", "Tullananda ayaqaltı blok yaradır", function(state)
    plat_toggle = state
    game:GetService("RunService").RenderStepped:Connect(function()
        if plat_toggle and game.Players.LocalPlayer.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(8, 0.5, 8)
            p.Anchored = true
            p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.2, 0)
            p.Transparency = 0.5
            p.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1) -- Rainbow Effekt
            task.wait(0.1)
            p:Destroy()
        end
    end)
end)

-- --- GÖRÜNÜŞ (ESP) ---
local VisualSection = Visuals:NewSection("Oyunçu İzləmə")
VisualSection:NewButton("Aktiv Et: RGB ESP", "Bütün oyunçuları rəngli gör", function()
    for _, v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name and v.Character then
            pcall(function()
                local highlight = Instance.new("Highlight", v.Character)
                highlight.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
            end)
        end
    end
end)

-- --- 🖱️ YUXARI YUMRU RGB DÜYMƏ ---
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "KingSafeGui"

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.5, -27, 0, 15)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 30
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.ZIndex = 10

local Corner = Instance.new("UICorner", ToggleBtn)
Corner.CornerRadius = UDim.new(1, 0)

local Stroke = Instance.new("UIStroke", ToggleBtn)
Stroke.Thickness = 3

ToggleBtn.MouseButton1Click:Connect(function()
    Library:ToggleUI()
end)

-- ✨ FULL RGB DÖNGÜSÜ
task.spawn(function()
    while task.wait(0.1) do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Window:ChangeColor("Main", color) -- Panel kənarları RGB
        Stroke.Color = color -- Açma düyməsi RGB
    end
end)
