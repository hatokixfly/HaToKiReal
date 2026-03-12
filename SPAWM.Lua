--// Nguyen Thanh Phu Hub
--// Spawn Tool GUI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NguyenThanhPhuHub"
ScreenGui.Parent = playerGui

--// Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,350,0,420)
Main.Position = UDim2.new(0.5,-175,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5,0.5)

local Corner = Instance.new("UICorner",Main)
Corner.CornerRadius = UDim.new(0,12)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Color = Color3.fromRGB(255,0,0)
Stroke.Thickness = 2

--// Glow
local Glow = Instance.new("UIStroke")
Glow.Parent = Main
Glow.Color = Color3.fromRGB(255,0,0)
Glow.Thickness = 6
Glow.Transparency = 0.7

--// Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Nguyen Thanh Phu Hub"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Main

--// Logo
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0,60,0,60)
Logo.Position = UDim2.new(0.5,-30,0,40)
Logo.BackgroundTransparency = 1
Logo.Image = "IMAGE_LINK"
Logo.Parent = Main

local LogoCorner = Instance.new("UICorner",Logo)
LogoCorner.CornerRadius = UDim.new(1,0)

--// Close Button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.BackgroundColor3 = Color3.fromRGB(40,0,0)
Close.Parent = Main
Instance.new("UICorner",Close)

--// Minimize
local Min = Instance.new("TextButton")
Min.Size = UDim2.new(0,30,0,30)
Min.Position = UDim2.new(1,-70,0,5)
Min.Text = "-"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 18
Min.TextColor3 = Color3.fromRGB(255,255,255)
Min.BackgroundColor3 = Color3.fromRGB(40,0,0)
Min.Parent = Main
Instance.new("UICorner",Min)

--// Input
local Input = Instance.new("TextBox")
Input.Size = UDim2.new(0.8,0,0,40)
Input.Position = UDim2.new(0.1,0,0,120)
Input.PlaceholderText = "Enter Tool Name..."
Input.Text = ""
Input.TextColor3 = Color3.new(1,1,1)
Input.BackgroundColor3 = Color3.fromRGB(20,20,20)
Input.Parent = Main
Instance.new("UICorner",Input)

--// Clear Button
local Clear = Instance.new("TextButton")
Clear.Size = UDim2.new(0.3,0,0,30)
Clear.Position = UDim2.new(0.1,0,0,170)
Clear.Text = "Clear"
Clear.BackgroundColor3 = Color3.fromRGB(30,0,0)
Clear.TextColor3 = Color3.new(1,1,1)
Clear.Parent = Main
Instance.new("UICorner",Clear)

--// Toggle
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0.3,0,0,30)
Toggle.Position = UDim2.new(0.6,0,0,170)
Toggle.Text = "Spawn: ON"
Toggle.BackgroundColor3 = Color3.fromRGB(30,0,0)
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Parent = Main
Instance.new("UICorner",Toggle)

local spawnEnabled = true

Toggle.MouseButton1Click:Connect(function()
	spawnEnabled = not spawnEnabled
	
	if spawnEnabled then
		Toggle.Text = "Spawn: ON"
	else
		Toggle.Text = "Spawn: OFF"
	end
end)

Clear.MouseButton1Click:Connect(function()
	Input.Text = ""
end)

--// Dropdown
local Categories = {"Gold","Diamond","Galaxy","Celestial","Normal"}
local SelectedCategory = "Gold"

local Drop = Instance.new("TextButton")
Drop.Size = UDim2.new(0.8,0,0,35)
Drop.Position = UDim2.new(0.1,0,0,210)
Drop.Text = "Category: Gold"
Drop.BackgroundColor3 = Color3.fromRGB(20,20,20)
Drop.TextColor3 = Color3.new(1,1,1)
Drop.Parent = Main
Instance.new("UICorner",Drop)

local DropFrame = Instance.new("Frame")
DropFrame.Size = UDim2.new(0.8,0,0,150)
DropFrame.Position = UDim2.new(0.1,0,0,250)
DropFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
DropFrame.Visible = false
DropFrame.Parent = Main
Instance.new("UICorner",DropFrame)

local Layout = Instance.new("UIListLayout",DropFrame)

for _,cat in pairs(Categories) do
	
	local Btn = Instance.new("TextButton")
	Btn.Size = UDim2.new(1,0,0,30)
	Btn.Text = cat
	Btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	Btn.TextColor3 = Color3.new(1,1,1)
	Btn.Parent = DropFrame
	
	Btn.MouseButton1Click:Connect(function()
		
		SelectedCategory = cat
		Drop.Text = "Category: "..cat
		DropFrame.Visible = false
		
	end)
	
end

Drop.MouseButton1Click:Connect(function()
	DropFrame.Visible = not DropFrame.Visible
end)

--// Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,0,0,30)
Status.Position = UDim2.new(0,0,0,370)
Status.BackgroundTransparency = 1
Status.Text = "Selected Category: GOLD"
Status.TextColor3 = Color3.fromRGB(255,0,0)
Status.Font = Enum.Font.Gotham
Status.TextSize = 14
Status.Parent = Main

Drop:GetPropertyChangedSignal("Text"):Connect(function()
	Status.Text = "Selected Category: "..string.upper(SelectedCategory)
end)

--// Spawn Button
local Spawn = Instance.new("TextButton")
Spawn.Size = UDim2.new(0.8,0,0,40)
Spawn.Position = UDim2.new(0.1,0,0,320)
Spawn.Text = "SPAWN TOOL"
Spawn.BackgroundColor3 = Color3.fromRGB(120,0,0)
Spawn.TextColor3 = Color3.new(1,1,1)
Spawn.Font = Enum.Font.GothamBold
Spawn.TextSize = 16
Spawn.Parent = Main
Instance.new("UICorner",Spawn)

--// Notification
local function notify(text)

	local Noti = Instance.new("TextLabel")
	Noti.Size = UDim2.new(0,250,0,40)
	Noti.Position = UDim2.new(0.5,-125,0,50)
	Noti.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Noti.TextColor3 = Color3.fromRGB(255,0,0)
	Noti.Text = text
	Noti.Parent = ScreenGui
	Instance.new("UICorner",Noti)

	task.wait(2)

	Noti:Destroy()

end

--// Spawn Tool System
Spawn.MouseButton1Click:Connect(function()

	if not spawnEnabled then
		notify("Spawn Disabled")
		return
	end

	local toolName = Input.Text

	if toolName == "" then
		notify("Enter Tool Name")
		return
	end

	local tool = game.ReplicatedStorage:FindFirstChild(toolName)

	if tool then

		local clone = tool:Clone()
		clone.Parent = player.Backpack

		local char = player.Character
		local hum = char:FindFirstChildOfClass("Humanoid")

		if hum then
			hum:EquipTool(clone)
		end

		notify("Tool Spawned Successfully")

	else

		notify("Tool Not Found")

	end

end)

--// Drag System
local dragging
local dragInput
local dragStart
local startPos

Main.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
	
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)

	if input == dragInput and dragging then
		
		local delta = input.Position - dragStart
		
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		
	end
	
end)

--// Buttons
Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

Min.MouseButton1Click:Connect(function()
	Main.Size = UDim2.new(0,350,0,40)
end)

--// Open Animation
Main.Size = UDim2.new(0,0,0,0)

TweenService:Create(
	Main,
	TweenInfo.new(0.5,Enum.EasingStyle.Back),
	{Size = UDim2.new(0,350,0,420)}
):Play()
