repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- HUMANOID FIX
local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid")
end

-- GUI SİL
for _, v in pairs(PlayerGui:GetChildren()) do
    if v.Name == "KingHubCustom" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "KingHubCustom"

-- PANEL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 380, 0, 520)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 4

-- TITLE
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "👑 KING HUB | STABLE"
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
local savedSpeed = 16

btn("Speed +10", 50, function()
    local h = getHumanoid()
    savedSpeed = h.WalkSpeed + 10
    h.WalkSpeed = savedSpeed
end)

btn("Speed -10", 100, function()
    local h = getHumanoid()
    savedSpeed = h.WalkSpeed - 10
    h.WalkSpeed = savedSpeed
end)

-- JUMP
local savedJump = 50

btn("Jump +10", 150, function()
    local h = getHumanoid()
    savedJump = h.JumpPower + 10
    h.JumpPower = savedJump
end)

btn("Jump -10", 200, function()
    local h = getHumanoid()
    savedJump = h.JumpPower - 10
    h.JumpPower = savedJump
end)

-- RESPAWN FIX
player.CharacterAdded:Connect(function(char)
    local h = char:WaitForChild("Humanoid")
    h.WalkSpeed = savedSpeed
    h.JumpPower = savedJump
end)

-- SPIN BOT (RESPAWN ETMƏYƏCƏK)
local spin = false
btn("Spin Bot (Fix)", 250, function()
    spin = not spin
end)

RunService.RenderStepped:Connect(function()
    if spin and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(4), 0)
    end
end)

-- FLY (STABİL)
local fly = false
btn("Fly (Toggle)", 300, function()
    fly = not fly
end)

RunService.RenderStepped:Connect(function()
    if fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0,40,0)
    end
end)

-- ESP (STABİL)
local espOn = false
btn("RGB ESP", 350, function()
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

-- ANTI RAGDOLL (STABİL)
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

-- RGB BORDER
task.spawn(function()
    while task.wait() do
        Stroke.Color = Color3.fromHSV(tick()%5/5,1,1)
        Title.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
    end
end)
