--// HATOKI TOOL MENU
--// Optimized Script
--// Dark UI Black + Red

--================================================
-- SERVICES
--================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--================================================
-- SETTINGS
--================================================

local Settings = {
    FOV = 70,
    FOVCircleEnabled = false,
    FOVCircleSize = 150,
    FOVTransparency = 0.2,
    HighlightEnabled = false,
    TrainingMode = false
}

--================================================
-- DRAWING FOV CIRCLE
--================================================

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = Settings.FOVCircleSize
FOVCircle.Color = Color3.fromRGB(0,255,0)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Transparency = 1

--================================================
-- GUI
--================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HatokiMenu"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,300,0,420)
Main.Position = UDim2.new(0.5,-150,0.5,-200)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Parent = ScreenGui

Instance.new("UICorner",Main)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255,0,0)
Stroke.Thickness = 1.5
Stroke.Parent = Main

-- TITLE

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "AIMBOT FOV - HATOKIREAL"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- CONTAINER

local Container = Instance.new("Frame")
Container.Parent = Main
Container.Position = UDim2.new(0,0,0,40)
Container.Size = UDim2.new(1,0,1,-40)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout")
Layout.Parent = Container
Layout.Padding = UDim.new(0,6)

--================================================
-- DRAG SYSTEM
--================================================

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

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
        update(input)
    end
end)

--================================================
-- UI FRAMEWORK
--================================================

local function CreateSection(name)

    local Label = Instance.new("TextLabel")
    Label.Text = name
    Label.Size = UDim2.new(1,-10,0,25)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255,80,80)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.Parent = Container

end

local function CreateButton(text,callback)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-10,0,30)
    Button.Text = text
    Button.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.Parent = Container

    Instance.new("UICorner",Button)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255,0,0)
    Stroke.Parent = Button

    Button.MouseButton1Click:Connect(callback)

end

local function CreateToggle(text,callback)

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(1,-10,0,30)
    Toggle.Text = text.." : OFF"
    Toggle.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Toggle.TextColor3 = Color3.new(1,1,1)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 14
    Toggle.Parent = Container

    Instance.new("UICorner",Toggle)

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255,0,0)
    Stroke.Parent = Toggle

    local state=false

    Toggle.MouseButton1Click:Connect(function()

        state = not state

        Toggle.Text = text.." : "..(state and "ON" or "OFF")

        callback(state)

    end)

end

local function CreateSlider(text,min,max,default,callback)

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,-10,0,40)
    Frame.BackgroundTransparency = 1
    Frame.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Text = text.." : "..default
    Label.Size = UDim2.new(1,0,0,20)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.Parent = Frame

    local Slider = Instance.new("TextButton")
    Slider.Size = UDim2.new(1,0,0,10)
    Slider.Position = UDim2.new(0,0,0,25)
    Slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Slider.Text = ""
    Slider.Parent = Frame

    Instance.new("UICorner",Slider)

    local dragging=false

    Slider.MouseButton1Down:Connect(function()
        dragging=true
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dragging=false
        end
    end)

    UIS.InputChanged:Connect(function(input)

        if dragging then

            local pos=(input.Position.X-Slider.AbsolutePosition.X)/Slider.AbsoluteSize.X
            pos=math.clamp(pos,0,1)

            local value=math.floor(min+(max-min)*pos)

            Label.Text=text.." : "..value

            callback(value)

        end

    end)

end

--================================================
-- FOV SYSTEM
--================================================

CreateSection("FOV SYSTEM")

CreateSlider(
"Camera FOV",
60,
120,
70,
function(value)

Settings.FOV=value
Camera.FieldOfView=value

end
)

--================================================
-- FOV CIRCLE
--================================================

CreateSection("FOV CIRCLE")

CreateToggle(
"Enable FOV Circle",
function(state)

Settings.FOVCircleEnabled=state
FOVCircle.Visible=state

end
)

CreateSlider(
"Circle Size",
50,
400,
150,
function(value)

Settings.FOVCircleSize=value
FOVCircle.Radius=value

end
)

CreateSlider(
"Transparency",
0,
1,
1,
function(value)

Settings.FOVTransparency=value
FOVCircle.Transparency=value

end
)

--================================================
-- PLAYER HIGHLIGHT
--================================================

CreateSection("PLAYER HIGHLIGHT")

CreateToggle(
"Highlight Players",
function(state)

Settings.HighlightEnabled=state

end
)

--================================================
-- TRAINING MODE
--================================================

CreateSection("TARGET TRAINING")

CreateToggle(
"Training Mode",
function(state)

Settings.TrainingMode=state

end
)

--================================================
-- VISIBILITY CHECK
--================================================

local function IsVisible(part)

local origin = Camera.CFrame.Position
local direction = (part.Position-origin).Unit*500

local ray = RaycastParams.new()
ray.FilterDescendantsInstances = {LocalPlayer.Character}
ray.FilterType = Enum.RaycastFilterType.Blacklist

local result = workspace:Raycast(origin,direction,ray)

if result and result.Instance:IsDescendantOf(part.Parent) then
return true
end

return false

end

--================================================
-- TARGET SYSTEM
--================================================

local function GetClosestTarget()

local closest=nil
local dist=math.huge

for _,player in pairs(Players:GetPlayers()) do

if player~=LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

local pos,visible=Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)

if visible then

local mag=(Vector2.new(pos.X,pos.Y)-Vector2.new(Mouse.X,Mouse.Y)).Magnitude

if mag<Settings.FOVCircleSize and mag<dist then

if IsVisible(player.Character.HumanoidRootPart) then

dist=mag
closest=player

end

end

end

end

end

return closest

end

--================================================
-- HIGHLIGHT SYSTEM
--================================================

local function UpdateHighlight()

for _,p in pairs(Players:GetPlayers()) do

if p~=LocalPlayer and p.Character then

local h=p.Character:FindFirstChild("HatokiHighlight")

if Settings.HighlightEnabled then

if not h then

local highlight=Instance.new("Highlight")
highlight.Name="HatokiHighlight"
highlight.FillTransparency=1
highlight.OutlineColor=Color3.fromRGB(0,255,0)
highlight.Parent=p.Character

end

else

if h then
h:Destroy()
end

end

end

end

end

--================================================
-- RENDER LOOP
--================================================

RunService.RenderStepped:Connect(function()

-- Update FOV Circle

FOVCircle.Position = Vector2.new(
Camera.ViewportSize.X/2,
Camera.ViewportSize.Y/2
)

-- Highlight

UpdateHighlight()

-- Training Mode

if Settings.TrainingMode then

local target=GetClosestTarget()

if target and target.Character then

local part=target.Character:FindFirstChild("HumanoidRootPart")

if part then

local cf=CFrame.new(Camera.CFrame.Position,part.Position)

Camera.CFrame=Camera.CFrame:Lerp(cf,0.08)

end

end

end

end)
