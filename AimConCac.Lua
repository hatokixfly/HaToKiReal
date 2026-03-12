local OrionLib = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

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

-- ESP
Tab:AddToggle({
Name = "ESP BOX",
Default = false,
Callback = function(v)
print("ESP:",v)
end
})

-- AIMBOT
Tab:AddToggle({
Name = "AIMBOT",
Default = false,
Callback = function(v)
print("Aimbot:",v)
end
})

-- SILENT AIM
Tab:AddToggle({
Name = "SILENT AIM",
Default = false,
Callback = function(v)
print("SilentAim:",v)
end
})

-- FOV
Tab:AddToggle({
Name = "FOV CIRCLE",
Default = false,
Callback = function(v)
print("FOV:",v)
end
})

Tab:AddSlider({
Name = "FOV RANGE",
Min = 0,
Max = 300,
Default = 100,
Increment = 1,
Callback = function(v)
print("FOV Size:",v)
end
})

Tab:AddToggle({
Name = "ANTI WALL AIM",
Default = true,
Callback = function(v)
print("WallCheck:",v)
end
})

OrionLib:Init()
