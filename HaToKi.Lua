--// HATOKI HUB
--// By Nguyễn Thanh Phú

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Notification
pcall(function()
StarterGui:SetCore("SendNotification",{
Title = "HATOKI HUB",
Text = "Script Loaded | By Nguyễn Thanh Phú",
Duration = 6
})
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.Name = "HatokiHub"

-- LOGO BUTTON
local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,30,0.5,-30)
logo.BackgroundColor3 = Color3.fromRGB(30,30,30)
logo.Text = "H"
logo.TextColor3 = Color3.fromRGB(255,255,255)
logo.TextSize = 28
logo.Font = Enum.Font.GothamBold

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

-- MAIN MENU
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,250,0,180)
main.Position = UDim2.new(0.5,-125,0.5,-90)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Visible = false

Instance.new("UICorner",main).CornerRadius = UDim.new(0,8)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "HATOKI HUB"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 18

-- AUTHOR
local author = Instance.new("TextLabel")
author.Parent = main
author.Position = UDim2.new(0,0,0,25)
author.Size = UDim2.new(1,0,0,20)
author.BackgroundTransparency = 1
author.Text = "By Nguyễn Thanh Phú"
author.Font = Enum.Font.Gotham
author.TextColor3 = Color3.fromRGB(180,180,180)
author.TextSize = 13

-- BUTTON CREATOR
function createToggle(name,y)

local frame = Instance.new("Frame")
frame.Parent = main
frame.Size = UDim2.new(1,-20,0,35)
frame.Position = UDim2.new(0,10,0,y)
frame.BackgroundTransparency = 1

local label = Instance.new("TextLabel")
label.Parent = frame
label.Size = UDim2.new(0.65,0,1,0)
label.Text = name
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Font = Enum.Font.Gotham
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left

local btn = Instance.new("TextButton")
btn.Parent = frame
btn.Size = UDim2.new(0.35,-5,0,25)
btn.Position = UDim2.new(0.65,5,0.5,-12)
btn.Text = "OFF"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.BackgroundColor3 = Color3.fromRGB(120,0,0)
btn.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner",btn)

return btn

end

local antiAFK = false
local autoJump = false

local btn1 = createToggle("ANTI AFK",60)
local btn2 = createToggle("AUTO JUMP",100)

-- Toggle logic
btn1.MouseButton1Click:Connect(function()

antiAFK = not antiAFK

if antiAFK then
btn1.Text = "ON"
btn1.BackgroundColor3 = Color3.fromRGB(0,170,0)
else
btn1.Text = "OFF"
btn1.BackgroundColor3 = Color3.fromRGB(120,0,0)
end

end)

btn2.MouseButton1Click:Connect(function()

autoJump = not autoJump

if autoJump then
btn2.Text = "ON"
btn2.BackgroundColor3 = Color3.fromRGB(0,170,0)
else
btn2.Text = "OFF"
btn2.BackgroundColor3 = Color3.fromRGB(120,0,0)
end

end)

-- OPEN MENU
logo.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)

-- DRAG LOGO
local dragging
local dragInput
local dragStart
local startPos

local function update(input)

local delta = input.Position - dragStart

logo.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)

end

logo.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then

dragging = true
dragStart = input.Position
startPos = logo.Position

input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)

end

end)

logo.InputChanged:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end

end)

UIS.InputChanged:Connect(function(input)

if input == dragInput and dragging then
update(input)
end

end)

-- AUTO JUMP LOOP
task.spawn(function()

while true do

if autoJump then

local char = player.Character
if char and char:FindFirstChildOfClass("Humanoid") then
char.Humanoid.Jump = true
end

end

task.wait(0.6)

end

end)

-- ANTI AFK LOOP
task.spawn(function()

while true do

if antiAFK then

local char = player.Character
if char and char:FindFirstChild("HumanoidRootPart") then

char.HumanoidRootPart.CFrame =
char.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(3),0)

end

end

task.wait(30)

end

end)
