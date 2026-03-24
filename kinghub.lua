local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👑 KING HUB | PREMIUM RGB",
   LoadingTitle = "King Hub Yüklənir...",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "KingHubConfig",
      FileName = "MainHub"
   },
   KeySystem = false -- Key istəmir
})

-- --- TABS ---
local Main = Window:CreateTab("Əsas Menu", 4483362458)
local Movement = Window:CreateTab("Hərəkət", 4483362458)
local Visuals = Window:NewTab("Görünüş", 4483362458)

-- --- SECTIONS & BUTTONS ---

Main:CreateButton({
   Name = "Scripti Yüklə (P8eK5qd2)",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/P8eK5qd2"))()
   end,
})

Movement:CreateSlider({
   Name = "Sürət (Speed)",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Sürət",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

Movement:CreateSlider({
   Name = "Tullanış (Jump)",
   Range = {50, 200},
   Increment = 1,
   Suffix = "Güc",
   CurrentValue = 50,
   Flag = "Slider2",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- 🌈 RGB PLATFORM (Anti-Fall)
local plat_toggle = false
Movement:CreateToggle({
   Name = "RGB Platform (Anti-Fall)",
   CurrentValue = false,
   Flag = "Toggle1",
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
            wait(0.1)
            p:Destroy()
         end
      end)
   end,
})

-- 👁️ ESP
Visuals:CreateButton({
   Name = "Enable KING ESP",
   Callback = function()
      for _, v in pairs(game.Players:GetChildren()) do
         if v.Name ~= game.Players.LocalPlayer.Name and v.Character then
            local highlight = Instance.new("Highlight", v.Character)
            highlight.FillColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
         end
      end
   end,
})

-- --- 🖱️ MÜTLƏQ GÖRÜNƏN YUXARI YUMRU DÜYMƏ ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingGuiSystem"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0.5, -30, 0, 20) -- Tam yuxarı mərkəz
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 35
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.ZIndex = 999999

local Corner = Instance.new("UICorner", ToggleBtn)
Corner.CornerRadius = UDim.new(1, 0)

local Stroke = Instance.new("UIStroke", ToggleBtn)
Stroke.Thickness = 4
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

ToggleBtn.MouseButton1Click:Connect(function()
   -- Rayfield-in öz daxili toggle funksiyası yoxdursa, GUI-ni gizlədirik
   pcall(function()
      game:GetService("CoreGui").Rayfield.Enabled = not game:GetService("CoreGui").Rayfield.Enabled
   end)
end)

-- ✨ RGB Effekt
spawn(function()
   while wait() do
      local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
      Stroke.Color = color
   end
end)
