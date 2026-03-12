repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

local AutoRaid = false

-- GUI

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,260,0,150)
main.Position = UDim2.new(0.05,0,0.45,0)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.Active = true
main.Draggable = true

Instance.new("UICorner",main)

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "PHUBABY"
title.TextColor3 = Color3.fromRGB(0,170,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local raid = Instance.new("TextButton")
raid.Parent = main
raid.Size = UDim2.new(0.9,0,0,45)
raid.Position = UDim2.new(0.05,0,0.45,0)
raid.BackgroundColor3 = Color3.fromRGB(20,20,20)
raid.TextColor3 = Color3.fromRGB(255,0,0)
raid.Font = Enum.Font.GothamBold
raid.TextScaled = true
raid.Text = "AUTO RAID : OFF"

Instance.new("UICorner",raid)

raid.MouseButton1Click:Connect(function()

AutoRaid = not AutoRaid

if AutoRaid then
raid.Text = "AUTO RAID : ON"
else
raid.Text = "AUTO RAID : OFF"
end

end)

-- ESP BOX

local Boxes = {}

local function CreateESP(plr)

if plr == LocalPlayer then return end

local box = Drawing.new("Square")
box.Color = Color3.fromRGB(255,0,0)
box.Thickness = 2
box.Filled = false

Boxes[plr] = box

end

for _,p in pairs(Players:GetPlayers()) do
CreateESP(p)
end

Players.PlayerAdded:Connect(CreateESP)

-- MAIN LOOP

RunService.RenderStepped:Connect(function()

if not AutoRaid then

for _,b in pairs(Boxes) do
b.Visible = false
end

return
end

local char = LocalPlayer.Character
if not char then return end

local hrp = char:FindFirstChild("HumanoidRootPart")

if not hrp then return end

for plr,box in pairs(Boxes) do

local enemy = plr.Character

if enemy and enemy:FindFirstChild("HumanoidRootPart") then

local root = enemy.HumanoidRootPart

-- ESP

local pos,vis = workspace.CurrentCamera:WorldToViewportPoint(root.Position)

if vis then
box.Size = Vector2.new(60,90)
box.Position = Vector2.new(pos.X-30,pos.Y-45)
box.Visible = true
else
box.Visible = false
end

-- TELEPORT

hrp.CFrame = root.CFrame * CFrame.new(0,0,3)

-- AUTO SLOT1

local tool = char:FindFirstChildOfClass("Tool")

if not tool then
local first = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
if first then
first.Parent = char
end
end

-- AUTO ATTACK

pcall(function()
mouse1click()
end)

end

end

end)

-- ANTI AFK

LocalPlayer.Idled:Connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
