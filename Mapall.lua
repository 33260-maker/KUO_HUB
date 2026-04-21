local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
Corner = { CornerRadius = UDim.new(35, 1) },
})

local Home = Window:Tab("Home")

Home:Section("Main")

repeat task.wait() until game:IsLoaded()

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// CHARACTER
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

--// SETTINGS
local flying = false
local speed = 60
local noclip = false
local infjump = false
local godmode = false

-- =========================
-- GOD MODE
-- =========================
RunService.Heartbeat:Connect(function()
    if godmode then
        local char = getChar()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end
    end
end)

-- =========================
-- FLY
-- =========================
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)

local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(9e9,9e9,9e9)

local function setFly(state)
    flying = state
    local char = getChar()
    local root = char:WaitForChild("HumanoidRootPart")
    
    bv.Parent = state and root or nil
    bg.Parent = state and root or nil
end

RunService.RenderStepped:Connect(function()
    if flying then
        local char = getChar()
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if hum and root then
            local cam = workspace.CurrentCamera
            local moveDir = hum.MoveDirection
            
            bv.Velocity = (cam.CFrame.LookVector * moveDir.Z + cam.CFrame.RightVector * moveDir.X) * speed
            bg.CFrame = cam.CFrame
        end
    end
end)

-- =========================
-- NOCLIP
-- =========================
RunService.Stepped:Connect(function()
    if noclip then
        local char = getChar()
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- =========================
-- INFINITE JUMP
-- =========================
UIS.JumpRequest:Connect(function()
    if infjump then
        local char = getChar()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
-- =========================      
-- ร่องหน      
-- =========================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local invisible = false
local bodyParts = {}
local character, humanoid, rootPart

local function setupCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")

    bodyParts = {}

    for _, v in pairs(character:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency == 0 then
            table.insert(bodyParts, v)
        end
    end
end

local function setInvisible(state)
    invisible = state

    for _, v in pairs(bodyParts) do
        v.Transparency = invisible and 0.5 or 0
    end
end

-- 🔥 ตัวนี้เอาไปใช้กับ Toggle
function applyInvisible(state)
    setInvisible(state)
end

-- setup ครั้งแรก
setupCharacter()

-- ระบบล่องหน (ของเดิม 100%)
RunService.Heartbeat:Connect(function()
    if invisible and rootPart and humanoid then
        local cf = rootPart.CFrame
        local camOff = humanoid.CameraOffset

        rootPart.CFrame = cf * CFrame.new(0, -200000, 0)
        humanoid.CameraOffset = Vector3.new(
            camOff.X,
            camOff.Y + 200000,
            camOff.Z
        )

        RunService.RenderStepped:Wait()

        rootPart.CFrame = cf
        humanoid.CameraOffset = camOff
    end
end)

-- กันตายแล้วพัง
player.CharacterAdded:Connect(function()
    invisible = false
    setupCharacter()
end)

-- =========================
-- UI
-- =========================
Home:AddDiscordInvite({
Name = "Kuo Hub",
Description = "Join server",
Logo = "rbxassetid://103308551113442",
Invite = "https://discord.gg/Apn2j9Fez",
})

Home:Toggle({
    Title="God Mode",
    Desc="อมตะ (รีเลือดตลอด)",
    Callback=function(v)
        godmode = v
    end
})

Home:Toggle({
    Title="Fly",
    Desc="บิน",
    Callback=function(v)
        setFly(v)
    end
})

Home:Toggle({
    Title="Noclip",
    Desc="เดินทะลุ",
    Callback=function(v)
        noclip = v
    end
})

Home:Toggle({
    Title="Infinite Jump",
    Desc="กระโดดไม่จำกัด",
    Callback=function(v)
        infjump = v
    end
})

Home:Toggle({
    Title = "Invisible Mode",
    Desc = "ร่องหน",
    Callback = function(v)
        applyInvisible(v)
    end
})

Home:AddSlider({
    Name = "Adjust walking speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(v)
        local char = getChar()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = v
        end
    end
})


Home:AddSlider({
    Name = "Adjust flight speed",
    Min = 16,
    Max = 200,
    Default = 60,
    Callback = function(v)
        speed = v
    end
})

-- KEY
UIS.InputBegan:Connect(function(i,g)
    if not g and i.KeyCode == Enum.KeyCode.F then
        setFly(not flying)
    end
end)
