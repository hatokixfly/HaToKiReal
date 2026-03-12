--// Nguyen Thanh Phu Script
--// BLACK RED MODERN GUI

repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

--====================================================
-- SCREEN GUI
--====================================================

local gui = Instance.new("ScreenGui")
gui.Name = "NguyenThanhPhuUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

--====================================================
-- FAKE LOADING
--====================================================

local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1,0,1,0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local title = Instance.new("TextLabel", loadingFrame)
title.Size = UDim2.new(1,0,0.1,0)
title.Position = UDim2.new(0,0,0.35,0)
title.Text = "Nguyen Thanh Phu Script"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.TextScaled = true
title.BackgroundTransparency = 1

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1,0,0.05,0)
loadingText.Position = UDim2.new(0,0,0.45,0)
loadingText.Text = "Loading System..."
loadingText.TextColor3 = Color3.fromRGB(255,255,255)
loadingText.TextScaled = true
loadingText.BackgroundTransparency = 1

local barBG = Instance.new("Frame", loadingFrame)
barBG.Size = UDim2.new(0.4,0,0.03,0)
barBG.Position = UDim2.new(0.3,0,0.55,0)
barBG.BackgroundColor3 = Color3.fromRGB(20,20,20)
barBG.BorderSizePixel = 0

local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(255,0,0)
bar.BorderSizePixel = 0

for i=1,100 do
	bar.Size = UDim2.new(i/100,0,1,0)
	wait(0.03)
end

loadingFrame:Destroy()

--====================================================
-- NOTIFICATION
--====================================================

local function Notify(text)

	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0,250,0,40)
	frame.Position = UDim2.new(1,-260,1,-80)
	frame.BackgroundColor3 = Color3.fromRGB(0,0,0)

	local txt = Instance.new("TextLabel", frame)
	txt.Size = UDim2.new(1,0,1,0)
	txt.Text = text
	txt.TextColor3 = Color3.fromRGB(255,0,0)
	txt.BackgroundTransparency = 1
	txt.TextScaled = true

	frame:TweenPosition(
		UDim2.new(1,-260,1,-120),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad,
		0.3,
		true
	)

	wait(3)

	frame:Destroy()

end

--====================================================
-- MAIN MENU
--====================================================

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,350,0,420)
menu.Position = UDim2.new(0.5,-175,0.5,-210)
menu.BackgroundColor3 = Color3.fromRGB(0,0,0)
menu.BorderColor3 = Color3.fromRGB(255,0,0)

-- HEADER

local header = Instance.new("TextLabel", menu)
header.Size = UDim2.new(1,0,0,40)
header.Text = "Nguyen Thanh Phu"
header.TextColor3 = Color3.fromRGB(255,0,0)
header.BackgroundTransparency = 1
header.TextScaled = true

-- LOGO

local logo = Instance.new("ImageLabel", menu)
logo.Size = UDim2.new(0,40,0,40)
logo.Position = UDim2.new(1,-45,0,0)
logo.BackgroundTransparency = 1
logo.Image = "https://i.imgur.com/hNq3yDy.jpeg"

-- CLOSE BUTTON

local close = Instance.new("TextButton", menu)
close.Size = UDim2.new(0,40,0,25)
close.Position = UDim2.new(1,-45,0,45)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,0,0)

-- OPEN ICON

local open = Instance.new("ImageButton", gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0,20,0.5,0)
open.Image = "https://i.imgur.com/hNq3yDy.jpeg"
open.Visible = false

close.MouseButton1Click:Connect(function()
	menu.Visible = false
	open.Visible = true
end)

open.MouseButton1Click:Connect(function()
	menu.Visible = true
	open.Visible = false
end)

--====================================================
-- DRAG SYSTEM
--====================================================

local dragging
local dragInput
local dragStart
local startPos

menu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = menu.Position
	end
end)

menu.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		menu.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

--====================================================
-- BUTTON CREATOR
--====================================================

local y = 80

local function CreateButton(name,callback)

	local btn = Instance.new("TextButton", menu)
	btn.Size = UDim2.new(0.9,0,0,35)
	btn.Position = UDim2.new(0.05,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.TextColor3 = Color3.fromRGB(255,0,0)
	btn.Text = name
	btn.TextScaled = true

	y = y + 45

	btn.MouseButton1Click:Connect(callback)

end

--====================================================
-- ABOUT
--====================================================

CreateButton("ABOUT", function()

	Notify("Script by Nguyen Thanh Phu")

end)

--====================================================
-- ANTI AFK
--====================================================

CreateButton("ANTI AFK", function()

	LocalPlayer.Idled:Connect(function()

		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

	end)

	Notify("Anti AFK Enabled")

end)

--====================================================
-- SAVE LOCATION
--====================================================

local savedPos

CreateButton("SAVE LOCATION", function()

	savedPos = LocalPlayer.Character.HumanoidRootPart.Position
	Notify("Location Saved")

end)

--====================================================
-- TELEPORT SAVED
--====================================================

CreateButton("TELEPORT SAVED", function()

	if savedPos then

		LocalPlayer.Character.HumanoidRootPart.CFrame =
			CFrame.new(savedPos)

	end

end)

--====================================================
-- TELEPORT BASE
--====================================================

CreateButton("TELEPORT BASE", function()

	local base = workspace:FindFirstChild("Base")

	if base then

		LocalPlayer.Character.HumanoidRootPart.CFrame =
			base.CFrame

	end

end)

--====================================================
-- AUTO MONEY
--====================================================

local autoMoney = false

CreateButton("AUTO MONEY", function()

	autoMoney = not autoMoney

	if autoMoney then

		Notify("Auto Money Enabled")

		while autoMoney do

			local money = workspace:FindFirstChild("Money")

			if money then

				LocalPlayer.Character.HumanoidRootPart.CFrame =
					money.CFrame

			end

			wait(1)

		end

	end

end)

--====================================================
-- AUTO PET
--====================================================

local autoPet = false

CreateButton("AUTO PET", function()

	autoPet = not autoPet

	if autoPet then

		Notify("Auto Pet Enabled")

		while autoPet do

			for _,v in pairs(workspace:GetDescendants()) do

				if v:IsA("Model") then

					if v:FindFirstChild("Head") then

						if string.find(v.Name,"Thiên") then

							LocalPlayer.Character.HumanoidRootPart.CFrame =
								v.Head.CFrame

							wait(1)

						end

					end

				end

			end

			wait(2)

		end

	end

end)

--====================================================
-- END
--====================================================

Notify("Script Loaded")
