--// Nguyen Thanh Phu Hub
--// Auto Spawn Pet System

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Parent = gui
Main.Size = UDim2.new(0,350,0,420)
Main.Position = UDim2.new(0.5,-175,0.5,-210)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.AnchorPoint = Vector2.new(0.5,0.5)

Instance.new("UICorner",Main)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Color = Color3.fromRGB(255,0,0)
Stroke.Thickness = 2

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Nguyen Thanh Phu Hub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255,0,0)

-- CLOSE BUTTON
local Close = Instance.new("TextButton")
Close.Parent = Main
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(40,0,0)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Close)

-- MINIMIZE
local Min = Instance.new("TextButton")
Min.Parent = Main
Min.Size = UDim2.new(0,30,0,30)
Min.Position = UDim2.new(1,-70,0,5)
Min.Text = "-"
Min.BackgroundColor3 = Color3.fromRGB(40,0,0)
Min.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Min)

-- PET NAME INPUT
local Input = Instance.new("TextBox")
Input.Parent = Main
Input.Size = UDim2.new(0.8,0,0,40)
Input.Position = UDim2.new(0.1,0,0,120)
Input.PlaceholderText = "Enter Pet Name..."
Input.BackgroundColor3 = Color3.fromRGB(20,20,20)
Input.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Input)

-- CLEAR INPUT
local Clear = Instance.new("TextButton")
Clear.Parent = Main
Clear.Size = UDim2.new(0.35,0,0,30)
Clear.Position = UDim2.new(0.1,0,0,170)
Clear.Text = "Clear"
Clear.BackgroundColor3 = Color3.fromRGB(30,0,0)
Clear.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Clear)

Clear.MouseButton1Click:Connect(function()
	Input.Text = ""
end)

-- TOGGLE SPAWN
local spawnEnabled = true

local Toggle = Instance.new("TextButton")
Toggle.Parent = Main
Toggle.Size = UDim2.new(0.35,0,0,30)
Toggle.Position = UDim2.new(0.55,0,0,170)
Toggle.Text = "Spawn: ON"
Toggle.BackgroundColor3 = Color3.fromRGB(30,0,0)
Toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Toggle)

Toggle.MouseButton1Click:Connect(function()

	spawnEnabled = not spawnEnabled

	if spawnEnabled then
		Toggle.Text = "Spawn: ON"
	else
		Toggle.Text = "Spawn: OFF"
	end

end)

-- CATEGORY DROPDOWN
local Categories = {"Gold","Diamond","Galaxy","Celestial","Normal"}
local SelectedCategory = "Gold"

local Drop = Instance.new("TextButton")
Drop.Parent = Main
Drop.Size = UDim2.new(0.8,0,0,35)
Drop.Position = UDim2.new(0.1,0,0,220)
Drop.Text = "Category: Gold"
Drop.BackgroundColor3 = Color3.fromRGB(20,20,20)
Drop.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Drop)

local DropFrame = Instance.new("Frame")
DropFrame.Parent = Main
DropFrame.Size = UDim2.new(0.8,0,0,150)
DropFrame.Position = UDim2.new(0.1,0,0,260)
DropFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
DropFrame.Visible = false
Instance.new("UICorner",DropFrame)

local Layout = Instance.new("UIListLayout",DropFrame)

for _,cat in pairs(Categories) do

	local Btn = Instance.new("TextButton")
	Btn.Parent = DropFrame
	Btn.Size = UDim2.new(1,0,0,30)
	Btn.Text = cat
	Btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	Btn.TextColor3 = Color3.new(1,1,1)

	Btn.MouseButton1Click:Connect(function()

		SelectedCategory = cat
		Drop.Text = "Category: "..cat
		DropFrame.Visible = false

	end)

end

Drop.MouseButton1Click:Connect(function()
	DropFrame.Visible = not DropFrame.Visible
end)

-- SPAWN BUTTON
local Spawn = Instance.new("TextButton")
Spawn.Parent = Main
Spawn.Size = UDim2.new(0.8,0,0,40)
Spawn.Position = UDim2.new(0.1,0,0,330)
Spawn.Text = "SPAWN PET"
Spawn.BackgroundColor3 = Color3.fromRGB(120,0,0)
Spawn.TextColor3 = Color3.new(1,1,1)
Spawn.Font = Enum.Font.GothamBold
Spawn.TextSize = 16
Instance.new("UICorner",Spawn)

-- NOTIFICATION
local function notify(text)

	local Noti = Instance.new("TextLabel")
	Noti.Parent = gui
	Noti.Size = UDim2.new(0,250,0,40)
	Noti.Position = UDim2.new(0.5,-125,0,60)
	Noti.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Noti.TextColor3 = Color3.fromRGB(255,0,0)
	Noti.Text = text
	Instance.new("UICorner",Noti)

	task.wait(2)

	Noti:Destroy()

end

-- SPAWN PET SYSTEM
Spawn.MouseButton1Click:Connect(function()

	if not spawnEnabled then
		notify("Spawn Disabled")
		return
	end

	local petName = Input.Text

	if petName == "" then
		notify("Enter Pet Name")
		return
	end

	local folder = ReplicatedStorage:FindFirstChild("Pets")

	if not folder then
		notify("Pets Folder Not Found")
		return
	end

	local categoryFolder = folder:FindFirstChild(SelectedCategory)

	if not categoryFolder then
		notify("Category Not Found")
		return
	end

	local pet = categoryFolder:FindFirstChild(petName)

	if pet then

		local clone = pet:Clone()
		clone.Parent = player.Backpack

		local char = player.Character
		local hum = char:FindFirstChildOfClass("Humanoid")

		if hum then
			hum:EquipTool(clone)
		end

		notify("Pet Spawned: "..petName)

	else

		notify("Pet Not Found")

	end

end)

-- DRAG SYSTEM
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

-- BUTTON EVENTS
Close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

Min.MouseButton1Click:Connect(function()
	Main.Size = UDim2.new(0,350,0,40)
end)

-- OPEN ANIMATION
Main.Size = UDim2.new(0,0,0,0)

TweenService:Create(
	Main,
	TweenInfo.new(0.5,Enum.EasingStyle.Back),
	{Size = UDim2.new(0,350,0,420)}
):Play()
