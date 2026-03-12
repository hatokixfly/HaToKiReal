--// HATOKI GAME TOOL
--// Made for Executors: Synapse / Fluxus / Arceus X / Hydrogen

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- STATES
local AutoClick = false
local AutoJump = false
local AntiAFK = false
local SpinCamera = false
local MoveRandom = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HATOKI_TOOL"

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,220,0,260)
Main.Position = UDim2.new(1,-230,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0

local UIStroke = Instance.new("UICorner",Main)
UIStroke.CornerRadius = UDim.new(0,8)

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "HATOKI GAME TOOL"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- BUTTON CREATOR
function createToggle(text, pos, callback)

    local Frame = Instance.new("Frame",Main)
    Frame.Size = UDim2.new(1,-20,0,32)
    Frame.Position = UDim2.new(0,10,0,pos)
    Frame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel",Frame)
    Label.Size = UDim2.new(0.65,0,1,0)
    Label.Text = text
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton",Frame)
    Button.Size = UDim2.new(0.35,-5,0,26)
    Button.Position = UDim2.new(0.65,5,0.5,-13)
    Button.Text = "OFF"
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.BackgroundColor3 = Color3.fromRGB(120,0,0)
    Button.TextColor3 = Color3.new(1,1,1)

    local Corner = Instance.new("UICorner",Button)

    local state = false

    Button.MouseButton1Click:Connect(function()
        state = not state

        if state then
            Button.Text = "ON"
            Button.BackgroundColor3 = Color3.fromRGB(0,170,0)
        else
            Button.Text = "OFF"
            Button.BackgroundColor3 = Color3.fromRGB(120,0,0)
        end

        callback(state)
    end)
end

-- TOGGLES

createToggle("AUTO CLICK",50,function(v)
    AutoClick = v
end)

createToggle("AUTO JUMP",85,function(v)
    AutoJump = v
end)

createToggle("AUTO TREO GAME",120,function(v)
    AntiAFK = v
end)

createToggle("AUTO SPIN CAMERA",155,function(v)
    SpinCamera = v
end)

createToggle("AUTO MOVE RANDOM",190,function(v)
    MoveRandom = v
end)

-- HIDE BUTTON

local Hide = Instance.new("TextButton")
Hide.Parent = Main
Hide.Size = UDim2.new(1,-20,0,28)
Hide.Position = UDim2.new(0,10,1,-35)
Hide.Text = "HIDE MENU"
Hide.Font = Enum.Font.GothamBold
Hide.TextSize = 13
Hide.BackgroundColor3 = Color3.fromRGB(40,40,40)
Hide.TextColor3 = Color3.new(1,1,1)

local Corner = Instance.new("UICorner",Hide)

local hidden = false

Hide.MouseButton1Click:Connect(function()

    hidden = not hidden

    if hidden then
        for _,v in pairs(Main:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end
        Title.Visible = false
        Hide.Text = "SHOW MENU"
        Main.Size = UDim2.new(0,220,0,40)
    else
        for _,v in pairs(Main:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = true
            end
        end
        Title.Visible = true
        Hide.Text = "HIDE MENU"
        Main.Size = UDim2.new(0,220,0,260)
    end

end)

-- AUTO CLICK LOOP

task.spawn(function()
    while true do
        if AutoClick then
            VIM:SendMouseButtonEvent(0,0,0,true,game,0)
            VIM:SendMouseButtonEvent(0,0,0,false,game,0)
        end
        task.wait(0.1)
    end
end)

-- AUTO JUMP

task.spawn(function()
    while true do
        if AutoJump then
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char.Humanoid.Jump = true
            end
        end
        task.wait(0.5)
    end
end)

-- ANTI AFK

task.spawn(function()
    while true do
        if AntiAFK then
            camera.CFrame = camera.CFrame * CFrame.Angles(0,math.rad(5),0)

            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char.Humanoid.Jump = true
            end
        end
        task.wait(30)
    end
end)

-- SPIN CAMERA

RunService.RenderStepped:Connect(function()

    if SpinCamera then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            camera.CFrame = CFrame.new(root.Position) *
            CFrame.Angles(0,tick()%360,0) *
            CFrame.new(0,2,8)
        end
    end

end)

-- RANDOM MOVE

task.spawn(function()
    while true do
        if MoveRandom then

            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then

                local root = char.HumanoidRootPart
                local offset = Vector3.new(
                    math.random(-5,5),
                    0,
                    math.random(-5,5)
                )

                root.CFrame = root.CFrame + offset

            end

        end
        task.wait(5)
    end
end)
