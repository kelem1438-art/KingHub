-- Orion Library Yüklənməsi
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "👑 KING HUB | FULL RGB", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "KingHubRGB",
    IntroEnabled = true,
    IntroText = "King Hub Yüklənir..."
})

-- --- TABS ---
local Main = Window:MakeTab({Name = "Əsas Menu", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Movement = Window:MakeTab({Name = "Hərəkət", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local Visuals = Window:MakeTab({Name = "Görünüş", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- --- ƏSAS MENU ---
Main:AddButton({
	Name = "Scripti Yüklə (P8eK5qd2)",
	Callback = function()
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/P8eK5qd2"))()
        end)
  	end    
})

-- --- HƏRƏKƏT (SAFE MODE) ---
Movement:AddSlider({
	Name = "Sürət (Speed)",
	Min = 16,
	Max = 100, 
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Sürət",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

Movement:AddSlider({
	Name = "Tullanış (Jump)",
	Min = 50,
	Max = 150,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Güc",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- 🌈 RGB PLATFORM
local plat_toggle = false
Movement:AddToggle({
	Name = "RGB Platform (Ayaqaltı)",
	Default = false,
	Callback = function(Value)
		plat_toggle = Value
        game:GetService("RunService").RenderStepped:Connect(function()
            if plat_toggle and game.Players.LocalPlayer.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                local p = Instance.new("Part", workspace)
                p.Size = Vector3.new(8, 0.5, 8)
                p.Anchored = true
                p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.2, 0)
                p.Transparency = 0.5
                p.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                task.wait(0.1)
                p:Destroy()
            end
        end)
	end    
})

-- --- ESP ---
Visuals:AddButton({
	Name = "RGB ESP Aktiv Et",
	Callback = function()
        for _, v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name and v.Character then
                local h = Instance.new("Highlight", v.Character)
                h.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                h.OutlineColor = Color3.fromRGB(255,255,255)
            end
        end
  	end    
})

-- --- 🖱️ YUXARI YUMRU RGB DÜYMƏ ---

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local Corner = Instance.new("UICorner", ToggleBtn)
local Stroke = Instance.new("UIStroke", ToggleBtn)

ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.5, -27, 0, 15)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 30
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.ZIndex = 999
Corner.CornerRadius = UDim.new(1, 0)
Stroke.Thickness = 4

ToggleBtn.MouseButton1Click:Connect(function()
    OrionLib:Toggle()
end)

-- --- ✨ FULL RGB PANEL & BUTTON SYSTEM ---
task.spawn(function()
    while task.wait() do
        local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        
        -- Düymənin kənarlarını RGB edir
        Stroke.Color = color
        
        -- Panelin öz kənarlarını (tillerini) RGB edir
        pcall(function()
            if game:GetService("CoreGui"):FindFirstChild("Orion") then
                for _, v in pairs(game:GetService("CoreGui").Orion:GetDescendants()) do
                    if v:IsA("Frame") and v.Name == "Main" then
                        --
