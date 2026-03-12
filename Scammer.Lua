repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local mouse = LocalPlayer:GetMouse()

-- SETTINGS
local AutoFarm = false
local KillAura = false
local Range = 30

-- GUI

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,280,0,220)
main.Position = UDim2.new(0.4,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
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

-- BUTTON FUNCTION

local function Toggle(name,pos)

local state=false

local b = Instance.new("TextButton")
b.Parent = main
b.Size = UDim2.new(0.9,0,0,35)
b.Position = UDim2.new(0.05,0,0,pos)
b.BackgroundColor3 = Color3.fromRGB(25,25,25)
b.TextColor3 = Color3.fromRGB(255,0,0)
b.Text = name.." : OFF"
b.Font = Enum.Font.GothamBold
b.TextScaled = true

Instance.new("UICorner",b)

b.MouseButton1Click:Connect(function()

state = not state

if state then
b.Text = name.." : ON"
else
b.Text = name.." : OFF"
end

if name=="AUTO TREO GAME" then
AutoFarm = state
end

if name=="KILL AURA" then
KillAura = state
end

end)

return function()
return state
end

end

local autoFarmToggle = Toggle("AUTO TREO GAME",60)
local auraToggle = Toggle("KILL AURA",110)

-- AUTO SLOT1

task.spawn(function()

while true do

if AutoFarm then

local char = LocalPlayer.Character
if char then

local tool = char:FindFirstChildOfClass("Tool")

if not tool then
local first = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
if first then
first.Parent = char
end
end

pcall(function()
mouse1click()
end)

end

end

task.wait(0.1)

end

end)

-- KILL AURA

RunService.RenderStepped:Connect(function()

if not KillAura then return end

local char = LocalPlayer.Character
if not char then return end

local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return end

for _,plr in pairs(Players:GetPlayers()) do

if plr ~= LocalPlayer then

local enemy = plr.Character
if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then

local root = enemy:FindFirstChild("HumanoidRootPart")

if root then

local dist = (root.Position - hrp.Position).Magnitude

if dist <= Range then

pcall(function()
mouse1click()
end)

end

end

end

end

end

end)

-- ANTI AFK

LocalPlayer.Idled:Connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
