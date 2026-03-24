repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- KÖHNƏ QALIQLARI SİL
for _, v in pairs(PlayerGui:GetChildren()) do
    if v.Name == "KingHubCustom" then
        v:Destroy()
    end
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingHubCustom"
ScreenGui.Parent = PlayerGui

-- PANEL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Corner = Instance.new("UICorner", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 4

-- BAŞLIQ
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "👑 KING HUB | PREMIUM"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- DÜYMƏ FUNKSİYASI
local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0,300,0,40)
    btn.Position = pos
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 18
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- SCRIPT LOAD
CreateButton("Scripti İşə Sal", UDim2.new(0.5,-150,0,50), function()
    pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/P8eK5qd2"))()
    end)
end)

-- SPEED
CreateButton("Sürət Aktiv Et (100)", UDim2.new(0.5,-150,0,100), function()
    player.Character.Humanoid.WalkSpeed = 100
end)

-- ESP
CreateButton("RGB ESP", UDim2.new(0.5,-150,0,150), function()
    for _, v in pairs(game.Players:GetChildren()) do
        if v ~= player and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromHSV(tick()%5/5,1,1)
        end
    end
end)

-- RGB PLATFORM (TOGGLE)
local platformOn = false
CreateButton("RGB Platform (Toggle)", UDim2.new(0.5,-150,0,200), function()
    platformOn = not platformOn
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if platformOn and player.Character and player.Character:FindFirstChild("Humanoid") then
        if player.Character.Humanoid.FloorMaterial == Enum.Material.Air then
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(8,0.5,8)
            p.Anchored = true
            p.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.2,0)
            p.Color = Color3.fromHSV(tick()%5/5,1,1)
            task.wait(0.1)
            p:Destroy()
        end
    end
end)

-- TOGGLE DÜYMƏ (EKRANIN YUXARISINDA)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0,60,0,60)
ToggleBtn.Position = UDim2.new(0.5,-30,0,20)
ToggleBtn.Text = "👑"
ToggleBtn.TextSize = 35
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)

local TStroke = Instance.new("UIStroke", ToggleBtn)
TStroke.Thickness = 4

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- RGB LOOP
task.spawn(function()
    while task.wait() do
        local color = Color3.fromHSV(tick()%5/5,1,1)
        Stroke.Color = color
        TStroke.Color = color
        Title.TextColor3 = color
    end
end)
