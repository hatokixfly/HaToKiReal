--// HATOKI HUB PRO
--// Black Red UI
--// ESP + Training Mode

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- SETTINGS

local Settings = {
FOV = 120,
CircleSize = 200,
CircleVisible = true,
ESP = true,
Highlight = true,
Training = true
}

--====================
-- FOV CIRCLE
--====================

local Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(0,255,0)
Circle.Thickness = 2
Circle.Filled = false
Circle.Transparency = 1
Circle.Visible = true

--====================
-- ESP STORAGE
--====================

local ESP = {}

local function CreateESP(player)

local Box = Drawing.new("Square")
Box.Color = Color3.fromRGB(0,255,0)
Box.Thickness = 2
Box.Filled = false

local Name = Drawing.new("Text")
Name.Size = 16
Name.Center = true
Name.Color = Color3.fromRGB(0,255,0)
Name.Text = player.Name

ESP[player] = {Box=Box,Name=Name}

end

for _,p in pairs(Players:GetPlayers()) do
if p ~= LocalPlayer then
CreateESP(p)
end
end

Players.PlayerAdded:Connect(function(p)
CreateESP(p)
end)

--====================
-- TARGET SYSTEM
--====================

local function GetClosest()

local target=nil
local dist=math.huge

for _,p in pairs(Players:GetPlayers()) do

if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then

local root = p.Character.HumanoidRootPart

local pos,visible = Camera:WorldToViewportPoint(root.Position)

if visible then

local mag = (Vector2.new(pos.X,pos.Y) - Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude

if mag < Settings.CircleSize and mag < dist then

dist = mag
target = p

end

end

end

end

return target

end

--====================
-- GUI
--====================

local gui = Instance.new("ScreenGui",game.CoreGui)

local Main = Instance.new("Frame",gui)
Main.Size = UDim2.new(0,260,0,360)
Main.Position = UDim2.new(0.5,-130,0.5,-180)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)

Instance.new("UICorner",Main)

local stroke = Instance.new("UIStroke",Main)
stroke.Color = Color3.fromRGB(255,0,0)

local title = Instance.new("TextLabel",Main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "HATOKI HUB PRO"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,0,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

-- CLOSE BUTTON

local close = Instance.new("TextButton",Main)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "-"
close.BackgroundColor3 = Color3.fromRGB(30,30,30)

Instance.new("UICorner",close)

local open = Instance.new("TextButton",gui)
open.Size = UDim2.new(0,60,0,30)
open.Position = UDim2.new(0,20,0.5,0)
open.Text = "OPEN"
open.Visible=false

close.MouseButton1Click:Connect(function()
Main.Visible=false
open.Visible=true
end)

open.MouseButton1Click:Connect(function()
Main.Visible=true
open.Visible=false
end)

--====================
-- DRAG
--====================

local dragging
local dragStart
local startPos

Main.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then

dragging=true
dragStart=input.Position
startPos=Main.Position

end

end)

UIS.InputChanged:Connect(function(input)

if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then

local delta=input.Position-dragStart

Main.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset+delta.X,
startPos.Y.Scale,
startPos.Y.Offset+delta.Y
)

end

end)

UIS.InputEnded:Connect(function(input)

if input.UserInputType==Enum.UserInputType.MouseButton1 then
dragging=false
end

end)

--====================
-- LOOP
--====================

RunService.RenderStepped:Connect(function()

Circle.Visible = Settings.CircleVisible
Circle.Radius = Settings.CircleSize
Circle.Position = Vector2.new(
Camera.ViewportSize.X/2,
Camera.ViewportSize.Y/2
)

-- ESP

for player,data in pairs(ESP) do

local char = player.Character

if char and char:FindFirstChild("HumanoidRootPart") then

local root = char.HumanoidRootPart

local pos,visible = Camera:WorldToViewportPoint(root.Position)

if visible and Settings.ESP then

local dist = (Camera.CFrame.Position-root.Position).Magnitude
local scale = math.clamp(3000/dist,20,300)

data.Box.Size = Vector2.new(scale,scale*1.5)
data.Box.Position = Vector2.new(pos.X-scale/2,pos.Y-scale)
data.Box.Visible = true

data.Name.Text = player.Name.." ["..math.floor(dist).."]"
data.Name.Position = Vector2.new(pos.X,pos.Y-scale)
data.Name.Visible = true

else

data.Box.Visible=false
data.Name.Visible=false

end

end

end

-- TRAINING MODE

if Settings.Training then

local target = GetClosest()

if target and target.Character then

local root = target.Character:FindFirstChild("HumanoidRootPart")

if root then

local cf = CFrame.new(Camera.CFrame.Position,root.Position)

Camera.CFrame = Camera.CFrame:Lerp(cf,0.08)

end

end

end

end)
