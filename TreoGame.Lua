--// HATOKI HUB RED EDITION
--// Nguyễn Thanh Phú

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Notification function
local function notify(text)
pcall(function()
StarterGui:SetCore("SendNotification",{
Title = "HATOKI HUB",
Text = text,
Duration = 4
})
end)
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.Name = "HatokiHub"

-- LOADING SCREEN
local loadFrame = Instance.new("Frame",gui)
loadFrame.Size = UDim2.new(1,0,1,0)
loadFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)

local loadText = Instance.new("TextLabel",loadFrame)
loadText.Size = UDim2.new(1,0,0,60)
loadText.Position = UDim2.new(0,0,0.4,0)
loadText.BackgroundTransparency = 1
loadText.TextColor3 = Color3.fromRGB(255,0,0)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 28
loadText.Text = "Nguyễn Thanh Phú"

local percent = Instance.new("TextLabel",loadFrame)
percent.Size = UDim2.new(1,0,0,40)
percent.Position = UDim2.new(0,0,0.5,0)
percent.BackgroundTransparency = 1
percent.TextColor3 = Color3.fromRGB(255,255,255)
percent.Font = Enum.Font.Gotham
percent.TextSize = 20
percent.Text = "Loading 0%"

-- LOADING COUNT
for i=1,100 do
percent.Text = "Loading "..i.."%"
task.wait(0.02)
end

loadFrame:Destroy()

notify("HATOKI HUB Loaded")

-- LOGO BUTTON
local logo = Instance.new("TextButton",gui)
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0,30,0.5,-30)
logo.BackgroundColor3 = Color3.fromRGB(40,0,0)
logo.Text = "H"
logo.Font = Enum.Font.GothamBold
logo.TextSize = 26
logo.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

-- MAIN MENU
local main = Instance.new("Frame",gui)
main.Size = UDim2.new(0,260,0,220)
main.Position = UDim2.new(0.5,-130,0.5,-110)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Visible = false

Instance.new("UICorner",main).CornerRadius = UDim.new(0,8)

-- TITLE
local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "HATOKI HUB"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

-- ADMIN INFO
local info = Instance.new("TextLabel",main)
info.Position = UDim2.new(0,0,0,35)
info.Size = UDim2.new(1,0,0,40)
info.BackgroundTransparency = 1
info.Text = "Admin: Nguyễn Thanh Phú\nTikTok: @HaToKiReal | IG: Fu._xinmo"
info.TextColor3 = Color3.fromRGB(200,200,200)
info.Font = Enum.Font.Gotham
info.TextSize = 12

-- BUTTON CREATOR
function createToggle(name,pos)

local frame = Instance.new("Frame",main)
frame.Size = UDim2.new(1,-20,0,35)
frame.Position = UDim2.new(0,10,0,pos)
frame.BackgroundTransparency = 1

local label = Instance.new("TextLabel",frame)
label.Size = UDim2.new(0.6,0,1,0)
label.BackgroundTransparency = 1
label.Text = name
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Font = Enum.Font.Gotham
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left

local btn = Instance.new("TextButton",frame)
btn.Size = UDim2.new(0.35,-5,0,26)
btn.Position = UDim2.new(0.65,5,0.5,-13)
btn.Text = "OFF"
btn.BackgroundColor3 = Color3.fromRGB(120,0,0)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12

Instance.new("UICorner",btn)

return btn
end

local antiAFK = false
local autoJump = false
local spin = false

local b1 = createToggle("ANTI AFK",90)
local b2 = createToggle("AUTO JUMP",130)
local b3 = createToggle("SPIN CAMERA",170)

-- Toggle logic
b1.MouseButton1Click:Connect(function()
antiAFK = not antiAFK
b1.Text = antiAFK and "ON" or "OFF"
b1.BackgroundColor3 = antiAFK and Color3.fromRGB(200,0,0) or Color3.fromRGB(120,0,0)
notify("Anti AFK "..(antiAFK and "Enabled" or "Disabled"))
end)

b2.MouseButton1Click:Connect(function()
autoJump = not autoJump
b2.Text = autoJump and "ON" or "OFF"
b2.BackgroundColor3 = autoJump and Color3.fromRGB(200,0,0) or Color3.fromRGB(120,0,0)
notify("Nhảy 1 lần để kích hoạt Auto Jump")
end)

b3.MouseButton1Click:Connect(function()
spin = not spin
b3.Text = spin and "ON" or "OFF"
b3.BackgroundColor3 = spin and Color3.fromRGB(200,0,0) or Color3.fromRGB(120,0,0)
notify("Spin Camera "..(spin and "Enabled" or "Disabled"))
end)

-- OPEN MENU
logo.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)

-- DRAG LOGO
local drag
local dragInput
local start
local startPos

logo.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
drag = true
start = input.Position
startPos = logo.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
drag = false
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
if input == dragInput and drag then
local delta = input.Position - start
logo.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)
end
end)

-- AUTO JUMP SYSTEM
task.spawn(function()
while true do
if autoJump then
local char = player.Character
if char and char:FindFirstChildOfClass("Humanoid") then
if char.Humanoid.FloorMaterial == Enum.Material.Air then
else
char.Humanoid.Jump = true
end
end
end
task.wait(0.4)
end
end)

-- ANTI AFK
task.spawn(function()
while true do
if antiAFK then
local char = player.Character
if char and char:FindFirstChild("HumanoidRootPart") then
char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(4),0)
end
end
task.wait(30)
end
end)

-- SPIN CAMERA
RunService.RenderStepped:Connect(function()
if spin then
local char = player.Character
if char and char:FindFirstChild("HumanoidRootPart") then
local root = char.HumanoidRootPart
camera.CFrame = CFrame.new(root.Position) * CFrame.Angles(0,tick()%360,0) * CFrame.new(0,2,8)
end
end
end)
