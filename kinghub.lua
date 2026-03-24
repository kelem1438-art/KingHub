repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- HUMANOID FIX (RESPAWN ÜÇÜN)
local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

-- KÖHNƏ GUI SİL
for _, v in pairs(PlayerGui:GetChildren()) do
    if v.Name == "KingHubCustom" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "KingHubCustom"

-- =========================
-- OPEN ANIMATION
-- =========================
local Intro = Instance.new("TextLabel", ScreenGui)
Intro.Size = UDim2.new(1,0,1,0)
Intro.BackgroundColor3 = Color3.fromRGB(0,0,0)
Intro.Text = "👑 KING HUB 👑"
Intro.TextScaled = true
Intro.Font = Enum.Font.GothamBlack
Intro.TextColor3 = Color3.fromRGB(255,255,255)

task.wait(2)
Intro:Destroy()

-- =========================
-- PANEL
-- =========================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 360, 0, 520)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 4

-- TITLE
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "👑 KING HUB | STEAL A BRAINROT"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20

-- BUTTON FUNKSİYASI
local function btn(text, y, func)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0,300,0,40)
    b.Position = UDim2.new(0.5,-150,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.TextSize = 18
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- SPEED
btn("Speed +10", 50, function()
    local h = getHumanoid()
    h.WalkSpeed += 10
end)

btn("Speed -10", 100, function()
    local h = getHumanoid()
    h.WalkSpeed -= 10
end)

-- JUMP
btn("Jump +10", 150, function()
    local h = getHumanoid()
    h.JumpPower += 10
end)

btn("Jump -10", 200, function()
    local h = getHumanoid()
    h.JumpPower -= 10
end)

-- SPIN BOT
local spin = false
btn("Spin Bot (Toggle)", 250, function()
    spin = not spin
end)

RunService.RenderStepped:Connect(function()
    if spin and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(20), 0)
    end
end)

-- FLY
local fly = false
btn("Fly (Toggle)", 300, function()
    fly = not fly
end)

RunService.RenderStepped:Connect(function()
    if fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0,50,0)
    end
end)

-- AUTO GRAB
local autoGrab = false
btn("Auto Grab (Yaxınlaşanda)", 350, function()
    autoGrab = not autoGrab
end)

RunService.RenderStepped:Connect(function()
    if not autoGrab then return end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local root = char.HumanoidRootPart

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            
            local targetRoot = plr.Character.HumanoidRootPart
            local distance = (root.Position - targetRoot.Position).Magnitude
            
            if distance < 6 then
                firetouchinterest(root, targetRoot, 0)
                firetouchinterest(root, targetRoot, 1)
            end
        end
    end
end)

-- ANTI RAGDOLL
local function antiRagdoll(char)
    local humanoid = char:WaitForChild("Humanoid")

    RunService.Stepped:Connect(function()
        if humanoid and humanoid.Parent then
            humanoid.PlatformStand = false
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

if player.Character then antiRagdoll(player.Character) end
player.CharacterAdded:Connect(antiRagdoll)

-- ESP
local espOn = false
btn("RGB ESP", 400, function()
    espOn = not espOn
end)

RunService.RenderStepped:Connect(function()
    if espOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                if not plr.Character:FindFirstChild("Highlight") then
                    local h = Instance.new("Highlight", plr.Character)
                    h.FillTransparency = 0.5
                end
                plr.Character.Highlight.FillColor = Color3.fromHSV(tick()%5/5,1,1)
            end
        end
    end
end)

-- RGB BORDER
task.spawn(function()
    while task.wait() do
        Stroke.Color = Color3.fromHSV(tick()%5/5,1,1)
        Title.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
    end
end)
