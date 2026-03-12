-- PHU HUB REACT STYLE

local OrionLib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

local ESPEnabled = false
local AimbotEnabled = false
local SilentAimEnabled = false
local FOVEnabled = false
local WallCheck = true
local FOVSize = 100

-- FOV Circle
local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(255,0,0)
FOV.Thickness = 2
FOV.Filled = false
FOV.Radius = FOVSize
FOV.Visible = false

RunService.RenderStepped:Connect(function()
FOV.Position = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
FOV.Radius = FOVSize
FOV.Visible = FOVEnabled
end)

-- ESP
RunService.RenderStepped:Connect(function()

if not ESPEnabled then return end

for i,v in pairs(Players:GetPlayers()) do
if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

if not v.Character:FindFirstChild("PHU_ESP") then

local box = Instance.new("BoxHandleAdornment")
box.Name = "PHU_ESP"
box.Adornee = v.Character.HumanoidRootPart
box.AlwaysOnTop = true
box.ZIndex = 5
box.Size = Vector3.new(4,6,2)
box.Color3 = Color3.fromRGB(255,0,0)
box.Transparency = 0.4
box.Parent = v.Character

end

end
end

end)

-- Get Closest Player
local function getClosest()

local closest = nil
local dist = math.huge

for i,v in pairs(Players:GetPlayers()) do
if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then

local pos,visible = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

if visible then

local mag = (Vector2.new(pos.X,pos.Y) - Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude

if mag < dist and mag < FOVSize then

if WallCheck then

local ray = Ray.new(Camera.CFrame.Position,(v.Character.HumanoidRootPart.Position - Camera.CFrame.Position).Unit * 500)

local hit = workspace:FindPartOnRay(ray,LocalPlayer.Character)

if hit and not hit:IsDescendantOf(v.Character) then
continue
end

end

dist = mag
closest = v

end

end

end
end

return closest

end

-- AIMBOT
RunService.RenderStepped:Connect(function()

if not AimbotEnabled then return end

local target = getClosest()

if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then

Camera.CFrame = CFrame.new(Camera.CFrame.Position,target.Character.HumanoidRootPart.Position)

end

end)

-- SILENT AIM
local old
old = hookmetamethod(game,"__namecall",function(self,...)

local args = {...}
local method = getnamecallmethod()

if SilentAimEnabled and method == "Raycast" then

local target = getClosest()

if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then

args[2] = (target.Character.HumanoidRootPart.Position - args[1]).Unit * 1000

return old(self,unpack(args))

end

end

return old(self,...)

end)

-- GUI
local Window = OrionLib:MakeWindow({
Name = "PHU HUB",
HidePremium = false,
SaveConfig = false,
IntroText = "PhuBaby-KernelX"
})

local Tab = Window:MakeTab({
Name = "Main",
Icon = "rbxassetid://4483345998"
})

Tab:AddToggle({
Name = "ESP BOX",
Default = false,
Callback = function(v)
ESPEnabled = v
end
})

Tab:AddToggle({
Name = "AIMBOT",
Default = false,
Callback = function(v)
AimbotEnabled = v
end
})

Tab:AddToggle({
Name = "SILENT AIM",
Default = false,
Callback = function(v)
SilentAimEnabled = v
end
})

Tab:AddToggle({
Name = "FOV CIRCLE",
Default = false,
Callback = function(v)
FOVEnabled = v
end
})

Tab:AddSlider({
Name = "FOV RANGE",
Min = 0,
Max = 300,
Default = 100,
Increment = 1,
Callback = function(v)
FOVSize = v
end
})

Tab:AddToggle({
Name = "ANTI WALL AIM",
Default = true,
Callback = function(v)
WallCheck = v
end
})

OrionLib:Init()
