local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:MakeWindow({
Title = "Kuo Hub [Beta-99Nights]",
})

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
Corner = { CornerRadius = UDim.new(35, 1) },
})
-- =========================
-- UI
-- =========================
local Home = Window:Tab("Home")
local Combat = Window:Tab("Combat")

Home:Section("Main")

-- =========================
-- SERVICES
-- =========================
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer

-- =========================
-- REMOTES
-- =========================
local DamageRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject")
local EquipRemote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("EquipItemHandle")

-- =========================
-- SETTINGS
-- =========================
local KILLAURA = false
local FARM_TREE = false
local infiniteHealthEnabled = false
local healthConnection = nil

local RANGE = 80
local HIT_DELAY = 0.1

-- =========================
-- UI TOGGLES
-- =========================
Home:AddDiscordInvite({
    Name = "Kuo Hub",
    Description = "Join server",
    Logo = "rbxassetid://103308551113442",
    Invite = "https://discord.gg/Apn2j9Fez",
})

Home:Toggle({
    Title = "Kill Aura",
    Desc = "ฆ่ามอนอัตโนมัติ",
    Callback = function(v)
        KILLAURA = v
    end
})

Home:Toggle({
    Title = "Auto Farm Tree",
    Desc = "ตัดไม้ทีละต้น",
    Callback = function(v)
        FARM_TREE = v
    end
})

Combat:Toggle({
    Title = "God Mode",
    Desc = "อมตะ(เปิดไปนานๆเกมอาจแลคได้)",
    Callback = function(v)
        infiniteHealthEnabled = v
        if v and lp.Character then
            ActivateInfiniteHealth(lp.Character)
        elseif healthConnection then
            healthConnection:Disconnect()
            healthConnection = nil
        end
    end
})

-- =========================
-- CHARACTER
-- =========================
local function getChar()
    return lp.Character or lp.CharacterAdded:Wait()
end

local function getRoot()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- =========================
-- TOOL
-- =========================
local function getAxe()
    local inv = lp:FindFirstChild("Inventory")
    if not inv then return end

    for _,v in pairs(inv:GetChildren()) do
        if v.Name:lower():find("axe") then
            return v
        end
    end
end

local lastEquip = 0
local function equipAxe(axe)
    if tick() - lastEquip > 1 then
        lastEquip = tick()
        EquipRemote:FireServer("FireAllClients", axe)
    end
end

-- =========================
-- KILLAURA
-- =========================
local function getMonsters()
    local folder = workspace:FindFirstChild("Characters")
    if not folder then return {} end

    local hrp = getRoot()
    if not hrp then return {} end

    local list = {}

    for _,mob in pairs(folder:GetChildren()) do
        local root = mob:FindFirstChild("HumanoidRootPart")
        local hum = mob:FindFirstChildOfClass("Humanoid")

        if root and hum and hum.Health > 0 then
            local dist = (root.Position - hrp.Position).Magnitude
            if dist <= RANGE then
                table.insert(list, {mob = mob, root = root})
            end
        end
    end

    return list
end

local function hit(mob, root, axe)
    pcall(function()
        DamageRemote:InvokeServer(
            mob,
            axe,
            "1_4478233043",
            root.CFrame
        )
    end)
end

-- =========================
-- GOD MODE
-- =========================
function ActivateInfiniteHealth(character)
    if not character or not character:FindFirstChild("Humanoid") then return end

    if healthConnection then
        healthConnection:Disconnect()
    end

    local humanoid = character:FindFirstChild("Humanoid")

    healthConnection = humanoid.Changed:Connect(function(prop)
        if infiniteHealthEnabled then
            if prop == "Health" and humanoid.Health < humanoid.MaxHealth then
                local remote = ReplicatedStorage:FindFirstChild("RemoteEvents")
                if remote and remote:FindFirstChild("DamagePlayer") then
                    remote.DamagePlayer:FireServer(math.huge * -1)
                end
            end
        end
    end)
end

lp.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if infiniteHealthEnabled then
        ActivateInfiniteHealth(char)
    end
end)

-- =========================
-- 🌲 TREE SYSTEM
-- =========================
local Foliage = workspace:WaitForChild("Map"):WaitForChild("Foliage")

local highlight = Instance.new("Highlight")
highlight.FillColor = Color3.fromRGB(0,255,0)
highlight.OutlineColor = Color3.fromRGB(255,255,255)
highlight.FillTransparency = 0.5
highlight.Parent = game.CoreGui

local function getNearestTree()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local root = char.HumanoidRootPart
    local closest = nil
    local minDist = 150

    for _, v in pairs(Foliage:GetChildren()) do
        if v.Name == "Small Tree" then
            local part = v:FindFirstChildWhichIsA("BasePart")
            if part then
                local dist = (part.Position - root.Position).Magnitude
                if dist <= minDist then
                    minDist = dist
                    closest = v
                end
            end
        end
    end

    return closest
end

-- =========================
-- 🔥 THREAD 1: KILLAURA
-- =========================
task.spawn(function()
    while task.wait(0.3) do
        if not KILLAURA then continue end

        local axe = getAxe()
        if not axe then continue end

        equipAxe(axe)

        for _,data in pairs(getMonsters()) do
            hit(data.mob, data.root, axe)
            task.wait(HIT_DELAY)
        end
    end
end)

-- =========================
-- 🌲 THREAD 2: FARM TREE
-- =========================
task.spawn(function()
    while task.wait(0.4) do
        if not FARM_TREE then continue end

        local axe = getAxe()
        if not axe then continue end

        local Tree = getNearestTree()

        if Tree then
            highlight.Adornee = Tree

            while Tree and Tree.Parent and FARM_TREE do
                EquipRemote:FireServer("FireAllClients", axe)

                local args = {
                    Tree,
                    axe,
                    "1_4478233043",
                    CFrame.new(73.76412963867188, 4.6776556968688965, -88.8170394897461,
                        0.0038667151238769293, -9.135444400953929e-08, -0.9999925494194031,
                        -7.452111816519391e-08, 1, -9.164328673705313e-08,
                        0.9999925494194031, 7.487491870961094e-08, 0.0038667151238769293)
                }

                DamageRemote:InvokeServer(unpack(args))
                task.wait(0.1)
            end
        end
    end
end)
