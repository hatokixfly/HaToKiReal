--// HATOKI TOOL MENU

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- SETTINGS
local FOV = 70
local FOVCircleSize = 150
local FOVCircleTransparency = 0.3
local HighlightEnabled = false
local CameraLock = false
local CircleEnabled = true

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HatokiMenu"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,300,0,350)
Frame.Position = UDim2.new(0.3,0,0.3,0)
Frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
Title.Text = "HATOKI TOOL MENU"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- BUTTON FUNCTION
local function CreateButton(name,pos)
	local Btn = Instance.new("TextButton")
	Btn.Parent = Frame
	Btn.Size = UDim2.new(0.9,0,0,30)
	Btn.Position = pos
	Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	Btn.TextColor3 = Color3.fromRGB(255,255,255)
	Btn.Font = Enum.Font.Gotham
	Btn.TextSize = 14
	Btn.Text = name
	return Btn
end

-- SLIDER
local function CreateSlider(name,pos,min,max,default,callback)

	local Label = Instance.new("TextLabel")
	Label.Parent = Frame
	Label.Size = UDim2.new(0.9,0,0,20)
	Label.Position = pos
	Label.BackgroundTransparency = 1
	Label.TextColor3 = Color3.fromRGB(255,255,255)
	Label.Text = name.." : "..default
	Label.Font = Enum.Font.Gotham
	Label.TextSize = 14
	
	local Slider = Instance.new("Frame")
	Slider.Parent = Frame
	Slider.Size = UDim2.new(0.9,0,0,8)
	Slider.Position = pos + UDim2.new(0,0,0,20)
	Slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
	
	local Fill = Instance.new("Frame")
	Fill.Parent = Slider
	Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
	Fill.BackgroundColor3 = Color3.fromRGB(255,0,0)
	
	local dragging = false
	
	Slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)
	
	Slider.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging then
			
			local pos = math.clamp(
				(input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X,
				0,1
			)
			
			Fill.Size = UDim2.new(pos,0,1,0)
			
			local value = math.floor((min + (max-min)*pos))
			
			Label.Text = name.." : "..value
			
			callback(value)
			
		end
	end)
end

-- FOV SLIDER
CreateSlider(
"FOV",
UDim2.new(0.05,0,0.15,0),
60,
120,
70,
function(v)
	FOV = v
	Camera.FieldOfView = v
end)

-- FOV CIRCLE SIZE
CreateSlider(
"FOV Circle Size",
UDim2.new(0.05,0,0.3,0),
50,
400,
150,
function(v)
	FOVCircleSize = v
end)

-- TOGGLES
local HighlightBtn = CreateButton(
"PLAYER HIGHLIGHT : OFF",
UDim2.new(0.05,0,0.45,0))

local CameraBtn = CreateButton(
"CAMERA LOCK : OFF",
UDim2.new(0.05,0,0.55,0))

local CircleBtn = CreateButton(
"FOV CIRCLE : ON",
UDim2.new(0.05,0,0.65,0))

-- BUTTON LOGIC

HighlightBtn.MouseButton1Click:Connect(function()

	HighlightEnabled = not HighlightEnabled
	
	HighlightBtn.Text =
	"PLAYER HIGHLIGHT : "..(HighlightEnabled and "ON" or "OFF")
	
end)

CameraBtn.MouseButton1Click:Connect(function()

	CameraLock = not CameraLock
	
	CameraBtn.Text =
	"CAMERA LOCK : "..(CameraLock and "ON" or "OFF")
	
end)

CircleBtn.MouseButton1Click:Connect(function()

	CircleEnabled = not CircleEnabled
	
	CircleBtn.Text =
	"FOV CIRCLE : "..(CircleEnabled and "ON" or "OFF")
	
end)

-- HIGHLIGHT SYSTEM
local function UpdateHighlight()

	for _,player in pairs(Players:GetPlayers()) do
		
		if player ~= LocalPlayer and player.Character then
			
			local char = player.Character
			
			if HighlightEnabled then
				
				if not char:FindFirstChild("HatokiHighlight") then
					
					local hl = Instance.new("Highlight")
					hl.Name = "HatokiHighlight"
					hl.FillTransparency = 1
					hl.OutlineColor = Color3.fromRGB(255,0,0)
					hl.Parent = char
					
				end
				
			else
				
				if char:FindFirstChild("HatokiHighlight") then
					char.HatokiHighlight:Destroy()
				end
				
			end
			
		end
		
	end
	
end

-- FOV CIRCLE
local Circle = Drawing.new("Circle")
Circle.Thickness = 2
Circle.Color = Color3.fromRGB(255,0,0)
Circle.Filled = false

RunService.RenderStepped:Connect(function()

	UpdateHighlight()
	
	-- FOV circle
	
	Circle.Visible = CircleEnabled
	Circle.Radius = FOVCircleSize
	Circle.Transparency = 1 - FOVCircleTransparency
	Circle.Position = Vector2.new(
		Camera.ViewportSize.X/2,
		Camera.ViewportSize.Y/2
	)
	
	-- CAMERA LOCK
	
	if CameraLock then
		
		local closest
		local dist = FOVCircleSize
		
		for _,player in pairs(Players:GetPlayers()) do
			
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				
				local pos,onscreen =
				Camera:WorldToViewportPoint(
				player.Character.HumanoidRootPart.Position)
				
				if onscreen then
					
					local magnitude = (
					Vector2.new(pos.X,pos.Y) -
					Vector2.new(
					Camera.ViewportSize.X/2,
					Camera.ViewportSize.Y/2)
					).Magnitude
					
					if magnitude < dist then
						
						dist = magnitude
						closest = player
						
					end
					
				end
				
			end
			
		end
		
		if closest and closest.Character then
			
			Camera.CFrame = CFrame.new(
				Camera.CFrame.Position,
				closest.Character.HumanoidRootPart.Position
			)
			
		end
		
	end
	
end)
