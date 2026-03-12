repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local mouse = LocalPlayer:GetMouse()

-- SETTINGS
local KillAura = false
local AutoClick = false
local Range = 25

-- GUI

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,320,0,260)
main.Position = UDim2.new(0.35,0,0.25,0)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Active = true
main.Draggable = true

Instance.new("UICorner",main)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "PHUBABY"
title.Font = Enum.Font.GothamBold
title.TextScaled = true

spawn(function()
local h=0
while true do
title.TextColor3 = Color3.fromHSV(h,1,1)
h=h+0.01
if h>1 then h=0 end
task.wait()
end
end)

-- BUTTON CREATOR

local function Button(name,pos)

local b = Instance.new("TextButton")
b.Parent = main
b.Size = UDim2.new(0.9,0,0,35)
b.Position = UDim2.new(0.05,0,0,pos)
b.Text = name
b.Font = Enum.Font.GothamBold
b.TextScaled = true
b.BackgroundColor3 = Color3.fromRGB(25,25,25)
b.TextColor3 = Color3.fromRGB(255,0,0)

Instance.new("UICorner",b)

return b
end

local b1 = Button("AUTO CLICK",50)
local b2 = Button("KILL AURA",95)
local b3 = Button("ANTI AFK",140)

-- AUTO CLICK

b1.MouseButton1Click:Connect(function()

AutoClick = not AutoClick

spawn(function()
while AutoClick do
pcall(function()
mouse1click()
end)
task.wait()
end
end)

end)

-- KILL AURA

b2.MouseButton1Click:Connect(function()

KillAura = not KillAura

end)

RunService.RenderStepped:Connect(function()

if KillAura == false then return end

local char = LocalPlayer.Character
if not char then return end

local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return end

for _,plr in pairs(Players:GetPlayers()) do

if plr ~= LocalPlayer then

local enemy = plr.Character
if enemy and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then

local dist = (enemy.HumanoidRootPart.Position - hrp.Position).Magnitude

if dist <= Range then

-- AUTO ATTACK
pcall(function()
mouse1click()
end)

end

end

end

end

end)

-- ANTI AFK

b3.MouseButton1Click:Connect(function()

LocalPlayer.Idled:Connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

end)
