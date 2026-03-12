--// Notification
game.StarterGui:SetCore("SendNotification",{
Title = "KernelX - HaToKi",
Text = "Script By KernelX",
Duration = 5
})

--// Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

--// ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "KernelX"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

--// Open Button
local open = Instance.new("TextButton")
open.Size = UDim2.new(0,120,0,40)
open.Position = UDim2.new(0,10,0.5,-20)
open.BackgroundColor3 = Color3.fromRGB(0,0,0)
open.TextColor3 = Color3.fromRGB(255,0,0)
open.Text = "OPEN MENU"
open.Parent = gui

--// Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0,350,0,260)
main.Position = UDim2.new(0.5,-175,0.5,-130)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.Visible = false
main.Parent = gui

--// Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "KernelX - HaToKi"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.TextScaled = true
title.Parent = main

--// Close Button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-40,0,0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(20,20,20)
close.TextColor3 = Color3.fromRGB(255,0,0)
close.Parent = main

close.MouseButton1Click:Connect(function()
main.Visible = false
end)

open.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)

--// Drag System
local dragging = false
local dragInput
local dragStart
local startPos

main.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = main.Position
end
end)

main.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)

UIS.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
main.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)
end
end)

--// Tabs
local tabs = {"MAIN","VISUAL","AIM","INFO"}
local pages = {}

for i,v in pairs(tabs) do
local b = Instance.new("TextButton")
b.Size = UDim2.new(0,80,0,30)
b.Position = UDim2.new(0,(i-1)*85,0,45)
b.Text = v
b.BackgroundColor3 = Color3.fromRGB(20,20,20)
b.TextColor3 = Color3.fromRGB(255,0,0)
b.Parent = main

local page = Instance.new("Frame")
page.Size = UDim2.new(1,0,1,-80)
page.Position = UDim2.new(0,0,0,80)
page.BackgroundTransparency = 1
page.Visible = false
page.Parent = main

pages[v] = page

b.MouseButton1Click:Connect(function()
for k,p in pairs(pages) do
p.Visible = false
end
page.Visible = true
end)
end

pages["MAIN"].Visible = true

--// Anti AFK
local anti = Instance.new("TextButton")
anti.Size = UDim2.new(0,160,0,30)
anti.Position = UDim2.new(0,10,0,10)
anti.Text = "Anti AFK"
anti.BackgroundColor3 = Color3.fromRGB(30,30,30)
anti.TextColor3 = Color3.fromRGB(255,0,0)
anti.Parent = pages["MAIN"]

anti.MouseButton1Click:Connect(function()
for i,v in pairs(getconnections(LP.Idled)) do
v:Disable()
end
game.StarterGui:SetCore("SendNotification",{Title="KernelX",Text="Anti AFK Enabled",Duration=3})
end)

--// FOV Circle
local fov = Drawing.new("Circle")
fov.Color = Color3.fromRGB(255,0,0)
fov.Radius = 120
fov.Thickness = 2
fov.Filled = false
fov.Visible = true

RunService.RenderStepped:Connect(function()
fov.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
end)

--// ESP
local espEnabled = false

local function createESP(player)
if player == LP then return end

RunService.RenderStepped:Connect(function()
if espEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

local pos,vis = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)

if vis then
local box = Drawing.new("Square")
box.Size = Vector2.new(40,60)
box.Position = Vector2.new(pos.X-20,pos.Y-30)
box.Color = Color3.fromRGB(255,0,0)
box.Visible = true
else
end

end
end)
end

for i,v in pairs(Players:GetPlayers()) do
createESP(v)
end

Players.PlayerAdded:Connect(createESP)

local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0,160,0,30)
espButton.Position = UDim2.new(0,10,0,10)
espButton.Text = "Player ESP"
espButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
espButton.TextColor3 = Color3.fromRGB(255,0,0)
espButton.Parent = pages["VISUAL"]

espButton.MouseButton1Click:Connect(function()
espEnabled = not espEnabled
game.StarterGui:SetCore("SendNotification",{Title="KernelX",Text="ESP "..tostring(espEnabled),Duration=3})
end)

--// AIM LOCK
local aim = false

local function getClosest()
local closest
local dist = fov.Radius

for i,v in pairs(Players:GetPlayers()) do
if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

local pos,vis = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

if vis then
local mag = (Vector2.new(pos.X,pos.Y) -
Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude

if mag < dist then
dist = mag
closest = v
end

end
end
end

return closest
end

RunService.RenderStepped:Connect(function()
if aim then
local target = getClosest()
if target and target.Character then
Camera.CFrame = CFrame.new(
Camera.CFrame.Position,
target.Character.HumanoidRootPart.Position
)
end
end
end)

local aimButton = Instance.new("TextButton")
aimButton.Size = UDim2.new(0,160,0,30)
aimButton.Position = UDim2.new(0,10,0,10)
aimButton.Text = "Aim Lock"
aimButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
aimButton.TextColor3 = Color3.fromRGB(255,0,0)
aimButton.Parent = pages["AIM"]

aimButton.MouseButton1Click:Connect(function()
aim = not aim
game.StarterGui:SetCore("SendNotification",{Title="KernelX",Text="Aim Lock "..tostring(aim),Duration=3})
end)

--// INFO
local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,-20,1,-20)
info.Position = UDim2.new(0,10,0,10)
info.BackgroundTransparency = 1
info.TextColor3 = Color3.fromRGB(255,0,0)
info.TextScaled = true
info.Text = [[

Discord:
discord.gg/tV5RhPgsz

Facebook:
Fb.com/htknew.cityy

TikTok:
@HaToKiReal

Telegram:
@HaToKiReal

Instagram:
fu._xinmo

]]
info.Parent = pages["INFO"]
