local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👑 KING HUB | PREMIUM RGB",
   LoadingTitle = "King Hub Yüklənir...",
   LoadingSubtitle = "Təhlükəsizlik Sistemi Aktivdir",
   ConfigurationSaving = {Enabled = false},
   KeySystem = false
})

-- --- TABS ---
local Main = Window:CreateTab("Əsas Menu", 4483362458)
local Movement = Window:CreateTab("Hərəkət", 4483362458)

-- --- SECTIONS (Bölmələr vacibdir!) ---
local MainSection = Main:CreateSection("Script Yükləyici")
local MoveSection = Movement:CreateSection("Oyunçu Ayarları")

-- --- BUTTONS & SLIDERS ---

MainSection:CreateButton({
   Name = "P8eK5qd2 Scriptini İşə Sal",
   Callback = function()
      pcall(function()
         loadstring(game:HttpGet("https://pastebin.com/raw/P8eK5qd2"))()
      end)
   end,
})

MoveSection:CreateSlider({
   Name = "Sürət (Speed)",
   Range = {16, 300}, -- Atılmamaq üçün maksimumu 300 etdim
   Increment = 1,
   CurrentValue = 60,
   Callback = function(Value)
      pcall(function()
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end)
   end,
})

MoveSection:CreateSlider({
   Name = "Tullanış (Jump)",
   Range = {25, 150},
   Increment = 1,
   CurrentValue = 25,
   Callback = function(Value)
      pcall(function()
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      end)
   end,
})

-- 🌈 RGB PLATFORM (Ayaqaltı blok)
local plat_toggle = false
MoveSection:CreateToggle({
   Name = "RGB Platform (Düşməmək Üçün)",
   CurrentValue = false,
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
   end,
})

-- --- 🖱️ MÜTLƏQ GÖRÜNƏN YUXARI YUMRU DÜYMƏ ---
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "KingGuiSystem"
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0.5, -30, 0, 20)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 35
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.ZIndex = 999999
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

local Stroke = Instance.new("UIStroke", ToggleBtn)
Stroke.Thickness = 4
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

ToggleBtn.MouseButton1Click:Connect(function()
   pcall(function()
      game:GetService("CoreGui").Rayfield.MainGui.Visible = not game:GetService("CoreGui").Rayfield.MainGui.Visible
   end)
end)

-- ✨ RGB Effekt Loop
spawn(function()
   while task.wait() do
      Stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
   end
end)
