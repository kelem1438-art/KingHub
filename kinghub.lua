repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer.Character

local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local PlayerGui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- KÖHNƏLƏRİ SİL
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
Intro.TextColor3 = Color3.fromRGB(255,255,255)
Intro.TextScaled = true
Intro.Font = Enum.Font.GothamBlack

TweenService:Create(Intro, TweenInfo.new(1), {
    TextColor3 = Color3.fromHSV(0,1,1)
}):Play()

task.wait(2)

TweenService:Create(Intro, TweenInfo.new(1), {
    TextTransparency = 1,
    BackgroundTransparency = 1
}):Play()

task.wait(1)
Intro:Destroy()

-- =========================
-- PANEL
-- =========================

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 360, 0, 480)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 4

-- BAŞLIQ
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "👑 KING HUB | PRO"
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
    player.Character.Humanoid.WalkSpeed += 10
end)

btn("Speed -10", 100, function()
    player.Character.Humanoid.WalkSpeed -= 10
end)

-- JUMP
btn("Jump +10", 150, function()
    player.Character.Humanoid.JumpPower += 10
end)

btn("Jump -10", 200, function()
    player.Character.Humanoid.JumpPower -= 10
end)

-- FLY
local fly = false
btn("Fly (Toggle)", 250, function()
    fly = not fly
end)

RunService.RenderStepped:Connect(function()
    if fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0,50,0)
    end
end)

-- ESP
local espOn = false

local function addESP(char)
    if char:FindFirstChild("Highlight") then return end
    local h = Instance.new("Highlight", char)
    h.FillTransparency = 0.5
end

btn("RGB ESP (Toggle)", 300, function()
    espOn = not espOn
end)

RunService.RenderStepped:Connect(function()
    if espOn then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                addESP(plr.Character)
                local h = plr.Character:FindFirstChild("Highlight")
                if h then
                    h.FillColor = Color3.fromHSV(tick()%5/5,1,1)
                end
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
