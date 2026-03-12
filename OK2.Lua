-- Nguyen Thanh Phu Hub - Client Preview Duplicate
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

-- OPEN BUTTON
local Open = Instance.new("TextButton", gui)
Open.Size = UDim2.new(0,120,0,40)
Open.Position = UDim2.new(0,20,0.5,-20)
Open.Text = "OPEN MENU"
Open.BackgroundColor3 = Color3.fromRGB(120,0,0)
Open.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Open)

-- MAIN
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0,300,0,200)
Main.Position = UDim2.new(0.5,-150,0.5,-100)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.Visible = false
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255,0,0)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "Nguyen Thanh Phu Hub"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(40,0,0)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close)

local Dup = Instance.new("TextButton", Main)
Dup.Size = UDim2.new(0.8,0,0,50)
Dup.Position = UDim2.new(0.1,0,0.5,-25)
Dup.Text = "DUPLICATE (PREVIEW)"
Dup.BackgroundColor3 = Color3.fromRGB(120,0,0)
Dup.TextColor3 = Color3.new(1,1,1)
Dup.Font = Enum.Font.GothamBold
Dup.TextSize = 16
Instance.new("UICorner", Dup)

Open.MouseButton1Click:Connect(function() Main.Visible = true end)
Close.MouseButton1Click:Connect(function() Main.Visible = false end)

-- Drag
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Duplicate preview (client-side)
Dup.MouseButton1Click:Connect(function()
	local char = player.Character
	if not char then return end
	local tool = char:FindFirstChildOfClass("Tool")
	if tool then
		local clone = tool:Clone()
		clone.Parent = player.Backpack
	end
end)
