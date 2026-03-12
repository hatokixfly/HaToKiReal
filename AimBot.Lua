
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/awfulwaffle/rojo/master/src/Client/GuiLibrary.lua"))()
local Main = Library:CreateWindow("PHU HUB", Color3.fromRGB(0, 0, 0), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

Main:SelectPage("Main")

local espBox = Main:MakeToggle("ESP BOX", false, function(value)
    if value then
        -- ESP Box code here
    else
        -- Turn off ESP Box code here
    end
end)

local aimbot = Main:MakeToggle("AIMBOT", false, function(value)
    if value then
        -- Aimbot code here
    else
        -- Turn off Aimbot code here
    end
end)

local silentAim = Main:MakeToggle("SILENT AIM", false, function(value)
    if value then
        -- Silent Aim code here
    else
        -- Turn off Silent Aim code here
    end
end)

local fovCircle = Main:MakeToggle("FOV CIRCLE", false, function(value)
    if value then
        -- FOV Circle code here
    else
        -- Turn off FOV Circle code here
    end
end)

local fovRange = Main:MakeSlider("FOV RANGE", 0, 300, 100, function(value)
    -- FOV Range code here
end)

local antiWallAim = Main:MakeToggle("ANTI WALL AIM", false, function(value)
    if value then
        -- Anti Wall Aim code here
    else
        -- Turn off Anti Wall Aim code here
    end
end)

-- Notification
local notification = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local text = Instance.new("TextLabel")

notification.Name = "Notification"
notification.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
frame.Parent = notification

text.Size = UDim2.new(1, -10, 1, -10)
text.Position = UDim2.new(0, 5, 0, 5)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.Text = "SCRIPT BY NGUYEN THANH PHU"
text.Font = Enum.Font.SourceSansBold
text.TextScaled = true
text.Parent = frame

-- Animation for notification
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local goal = {Position = UDim2.new(0, 10, 0, -50)}
tweenService:Create(frame, tweenInfo, goal):Play()

-- Animation for menu
local menuTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local menuGoal = {Position = UDim2.new(0, 0, 0, 0)}
Main:TweenPosition(menuGoal, menuTweenInfo)

-- Close and Minimize buttons
Main:AddButton("Close", function()
    Main:Hide()
end)

Main:AddButton("Minimize", function()
    Main:Minimize()
end)

-- Reopen button
local reopenButton = Instance.new("TextButton")
reopenButton.Size = UDim2.new(0, 50, 0, 50)
reopenButton.Position = UDim2.new(1, -60, 0, 10)
reopenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
reopenButton.BorderSizePixel = 0
reopenButton.Text = ""
reopenButton.Parent = notification

reopenButton.MouseButton1Click:Connect(function()
    Main:Show()
end)
