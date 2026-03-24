repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- KÖHNƏLƏRİ SİL
for _, v in pairs(PlayerGui:GetChildren()) do
    if v.Name == "KingHubCustom" then
        v:Destroy()
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingHubCustom"
ScreenGui.Parent = PlayerGui

-- PANEL ÖLÇÜSÜ (BURDAN DƏYİŞ)
local PANEL_WIDTH = 360
local PANEL_HEIGHT = 320

-- PANEL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, PANEL_WIDTH, 0, PANEL_HEIGHT)
MainFrame.Position = UDim2.new(0.5, -PANEL_WIDTH/2, 0.5, -PANEL_HEIGHT/2)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Active = true
MainFrame.Draggable = true

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 4
Instance.new("UICorner", MainFrame)

-- BAŞLIQ
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "👑 KING HUB | PREMIUM"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20

-- INPUT BOX FUNKSİYASI
local function CreateInput(placeholder, pos)
    local box = Instance.new("TextBox", MainFrame)
    box.Size = UDim2.new(0,300,0,40)
    box.Position = pos
    box.PlaceholderText = placeholder
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.TextSize = 18
    Instance.new("UICorner", box)
    return box
end

-- SPEED INPUT
local speedBox = CreateInput("Speed yaz (məs: 120)", UDim2.new(0.5,-150,0,60))

local speedBtn = Instance.new("TextButton", MainFrame)
speedBtn.Size = UDim2.new(0,300,0,40)
speedBtn.Position = UDim2.new(0.5,-150,0,110)
speedBtn.Text = "Speed Aktiv Et"
speedBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
speedBtn.TextColor3 = Color3.fromRGB(255,255,255)
speedBtn.TextSize = 18
Instance.new("UICorner", speedBtn)

speedBtn.MouseButton1Click:Connect(function()
    local val = tonumber(speedBox.Text)
    if val then
        player.Character.Humanoid.WalkSpeed = val
    end
end)

-- JUMP INPUT
local jumpBox = CreateInput("Jump yaz (məs: 100)", UDim2.new(0.5,-150,0,160))

local jumpBtn = Instance.new("TextButton", MainFrame)
jumpBtn.Size = UDim2.new(0,300,0,40)
jumpBtn.Position = UDim2.new(0.5,-150,0,210)
jumpBtn.Text = "Jump Aktiv Et"
jumpBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
jumpBtn.TextColor3 = Color3.fromRGB(255,255,255)
jumpBtn.TextSize = 18
Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    local val = tonumber(jumpBox.Text)
    if val then
        player.Character.Humanoid.JumpPower = val
    end
end)

-- PLATFORM (ARTIQ ARXAYA ATMIR)
local platformOn = false

local platBtn = Instance.new("TextButton", MainFrame)
platBtn.Size = UDim2.new(0,300,0,40)
platBtn.Position = UDim2.new(0.5,-150,0,260)
platBtn.Text = "RGB Platform (Toggle)"
platBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
platBtn.TextColor3 = Color3.fromRGB(255,255,255)
platBtn.TextSize = 18
Instance.new("UICorner", platBtn)

platBtn.MouseButton1Click:Connect(function()
    platformOn = not platformOn
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if platformOn and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        
        local root = player.Character.HumanoidRootPart
        
        if player.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(8,0.5,8)
            p.Anchored = true
            p.CFrame = root.CFrame * CFrame.new(0,-3,0)
            p.Color = Color3.fromHSV(tick()%5/5,1,1)
            p.Material = Enum.Material.Neon
            task.wait(0.1)
            p:Destroy()
        end
    end
end)

-- TOGGLE DÜYMƏ
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0,60,0,60)
ToggleBtn.Position = UDim2.new(0.5,-30,0,20)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 35
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", ToggleBtn)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- RGB BORDER
task.spawn(function()
    while task.wait() do
        Stroke.Color = Color3.fromHSV(tick()%5/5,1,1)
        Title.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
    end
end)
