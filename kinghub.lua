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

-- ======================
-- BLINK INTRO
-- ======================
local Intro = Instance.new("TextLabel", ScreenGui)
Intro.Size = UDim2.new(1,0,1,0)
Intro.BackgroundColor3 = Color3.fromRGB(0,0,0)
Intro.Text = "👑 KING HUB 👑"
Intro.TextScaled = true
Intro.Font = Enum.Font.GothamBlack
Intro.TextColor3 = Color3.fromRGB(255,255,255)

for i = 1,5 do
    Intro.TextTransparency = 0
    task.wait(0.2)
    Intro.TextTransparency = 1
    task.wait(0.2)
end

Intro:Destroy()

-- ======================
-- PANEL
-- ======================
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
Title.Text = "👑 KING HUB V5 PRO"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 20

-- INPUT FUNKSİYASI
local function inputBox(text, y)
    local box = Instance.new("TextBox", MainFrame)
    box.Size = UDim2.new(0,300,0,40)
    box.Position = UDim2.new(0.5,-150,0,y)
    box.PlaceholderText = text
    box.Text = ""
    box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.TextSize = 18
    Instance.new("UICorner", box)
    return box
end

-- SPEED INPUT
local speedBox = inputBox("Speed yaz (məs: 120)", 60)

local savedSpeed = 16

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
        savedSpeed = val
        getHumanoid().WalkSpeed = savedSpeed
    end
end)

-- JUMP INPUT
local jumpBox = inputBox("Jump yaz (məs: 120)", 170)

local savedJump = 50

local jumpBtn = Instance.new("TextButton", MainFrame)
jumpBtn.Size = UDim2.new(0,300,0,40)
jumpBtn.Position = UDim2.new(0.5,-150,0,220)
jumpBtn.Text = "Jump Aktiv Et"
jumpBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
jumpBtn.TextColor3 = Color3.fromRGB(255,255,255)
jumpBtn.TextSize = 18
Instance.new("UICorner", jumpBtn)

jumpBtn.MouseButton1Click:Connect(function()
    local val = tonumber(jumpBox.Text)
    if val then
        savedJump = val
        getHumanoid().JumpPower = savedJump
    end
end)

-- RESPAWN FIX
player.CharacterAdded:Connect(function(char)
    local h = char:WaitForChild("Humanoid")
    h.WalkSpeed = savedSpeed
    h.JumpPower = savedJump
end)

-- SPIN SPEED INPUT
local spinBox = inputBox("Spin sürəti (məs: 5)", 280)

local spin = false
local spinSpeed = 5

local spinBtn = Instance.new("TextButton", MainFrame)
spinBtn.Size = UDim2.new(0,300,0,40)
spinBtn.Position = UDim2.new(0.5,-150,0,330)
spinBtn.Text = "Spin Bot Aktiv Et"
spinBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
spinBtn.TextColor3 = Color3.fromRGB(255,255,255)
spinBtn.TextSize = 18
Instance.new("UICorner", spinBtn)

spinBtn.MouseButton1Click:Connect(function()
    local val = tonumber(spinBox.Text)
    if val then spinSpeed = val end
    spin = not spin
end)

RunService.RenderStepped:Connect(function()
    if spin and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(spinSpeed), 0)
    end
end)

-- RGB BORDER
task.spawn(function()
    while task.wait() do
        Stroke.Color = Color3.fromHSV(tick()%5/5,1,1)
        Title.TextColor3 = Color3.fromHSV(tick()%5/5,1,1)
    end
end)
