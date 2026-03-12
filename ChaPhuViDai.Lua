--// PHUBABY SCRIPT

repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

--========================
-- LOADING SCREEN
--========================

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Parent = game.CoreGui
LoadingGui.ResetOnSpawn = false

local BG = Instance.new("Frame")
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
BG.Parent = LoadingGui

local Text = Instance.new("TextLabel")
Text.Parent = BG
Text.Text = "PHUBABY LOADING..."
Text.TextColor3 = Color3.fromRGB(255,0,0)
Text.Font = Enum.Font.GothamBold
Text.TextScaled = true
Text.BackgroundTransparency = 1
Text.Position = UDim2.new(0.3,0,0.4,0)
Text.Size = UDim2.new(0.4,0,0.1,0)

local BarBG = Instance.new("Frame")
BarBG.Parent = BG
BarBG.Position = UDim2.new(0.25,0,0.55,0)
BarBG.Size = UDim2.new(0.5,0,0.03,0)
BarBG.BackgroundColor3 = Color3.fromRGB(20,20,20)

local Bar = Instance.new("Frame")
Bar.Parent = BarBG
Bar.Size = UDim2.new(0,0,1,0)
Bar.BackgroundColor3 = Color3.fromRGB(255,0,0)

for i = 1,100 do
Bar.Size = UDim2.new(i/100,0,1,0)
wait(0.02)
end

wait(0.3)
LoadingGui:Destroy()

--========================
-- MAIN GUI
--========================

local GUI = Instance.new("ScreenGui")
GUI.Parent = game.CoreGui
GUI.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Parent = GUI
Main.Size = UDim2.new(0,320,0,260)
Main.Position = UDim2.new(0.35,0,0.25,0)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.Active = true
Main.Draggable = true

local Corner = Instance.new("UICorner",Main)

-- TITLE

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "PhuBaby"
Title.TextScaled = true

-- RAINBOW TEXT

spawn(function()
local hue = 0
while wait() do
Title.TextColor3 = Color3.fromHSV(hue,1,1)
hue = hue + 0.01
if hue >= 1 then
hue = 0
end
end
end)

-- CLOSE BUTTON

local Close = Instance.new("TextButton")
Close.Parent = Main
Close.Text = "X"
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.BackgroundColor3 = Color3.fromRGB(255,0,0)

-- MINIMIZE

local Min = Instance.new("TextButton")
Min.Parent = Main
Min.Text = "-"
Min.Size = UDim2.new(0,30,0,30)
Min.Position = UDim2.new(1,-70,0,5)
Min.BackgroundColor3 = Color3.fromRGB(255,0,0)

-- OPEN BUTTON

local Open = Instance.new("TextButton")
Open.Parent = GUI
Open.Text = "OPEN"
Open.Size = UDim2.new(0,80,0,40)
Open.Position = UDim2.new(0,10,0.5,0)
Open.Visible = false
Open.BackgroundColor3 = Color3.fromRGB(255,0,0)

Close.MouseButton1Click:Connect(function()
Main.Visible = false
Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
Main.Visible = true
Open.Visible = false
end)

Min.MouseButton1Click:Connect(function()
Main.Size = UDim2.new(0,320,0,40)
end)

--========================
-- BUTTON CREATOR
--========================

local function CreateButton(name,pos)
local B = Instance.new("TextButton")
B.Parent = Main
B.Size = UDim2.new(0.9,0,0,35)
B.Position = UDim2.new(0.05,0,0,pos)
B.BackgroundColor3 = Color3.fromRGB(20,20,20)
B.TextColor3 = Color3.fromRGB(255,0,0)
B.Font = Enum.Font.GothamBold
B.Text = name
B.TextScaled = true

local C = Instance.new("UICorner",B)

return B
end

--========================
-- BUTTONS
--========================

local AutoClick = CreateButton("AUTO CLICK CHÉM",50)
local AutoEquip = CreateButton("AUTO EQUIP SLOT 1",90)
local ESP = CreateButton("PLAYER BOX ESP",130)
local AntiAFK = CreateButton("ANTI AFK",170)

--========================
-- AUTO CLICK
--========================

local Clicking = false

AutoClick.MouseButton1Click:Connect(function()

Clicking = not Clicking

if Clicking then
print("[ PHUBABY ] AUTO CLICK ĐÃ BẬT")

spawn(function()
while Clicking do
pcall(function()
mouse1click()
end)
task.wait()
end
end)

else
print("AUTO CLICK ĐÃ TẮT")
end

end)

--========================
-- AUTO EQUIP SLOT 1
--========================

local Equip = false

AutoEquip.MouseButton1Click:Connect(function()

Equip = not Equip

if Equip then
print("[ PHUBABY ] AUTO EQUIP KIẾM ĐÃ BẬT")

spawn(function()

while Equip do

local char = LocalPlayer.Character
if char then

local tool = char:FindFirstChildOfClass("Tool")

if not tool then

local backpack = LocalPlayer.Backpack
local first = backpack:GetChildren()[1]

if first then
first.Parent = char
end

end

end

task.wait(0.3)

end

end)

end

end)

--========================
-- ESP
--========================

local ESPEnabled = false
local Boxes = {}

local function CreateESP(plr)

if plr == LocalPlayer then return end

local Box = Drawing.new("Square")
Box.Color = Color3.fromRGB(255,0,0)
Box.Thickness = 2
Box.Filled = false

Boxes[plr] = Box

end

for _,p in pairs(Players:GetPlayers()) do
CreateESP(p)
end

Players.PlayerAdded:Connect(CreateESP)

ESP.MouseButton1Click:Connect(function()

ESPEnabled = not ESPEnabled

if ESPEnabled then
print("[ PHUBABY ] PLAYER BOX ĐÃ BẬT")
else
print("PLAYER BOX ĐÃ TẮT")
end

end)

RunService.RenderStepped:Connect(function()

if not ESPEnabled then

for _,box in pairs(Boxes) do
box.Visible = false
end

return
end

for plr,box in pairs(Boxes) do

local char = plr.Character
if char and char:FindFirstChild("HumanoidRootPart") then

local pos,onscreen = workspace.CurrentCamera:WorldToViewportPoint(char.HumanoidRootPart.Position)

if onscreen then

box.Size = Vector2.new(60,90)
box.Position = Vector2.new(pos.X-30,pos.Y-45)
box.Visible = true

else
box.Visible = false
end

end

end

end)

--========================
-- ANTI AFK
--========================

LocalPlayer.Idled:Connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

print("ANTI AFK ĐÃ BẬT")
