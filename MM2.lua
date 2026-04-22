local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:MakeWindow({
Title = "Kuo Hub [Beta-MM2]",
})

Window:AddMinimizeButton({
Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
Corner = { CornerRadius = UDim.new(35, 1) },
})

local Home = Window:Tab("Home")
local Combat = Window:Tab("Combat")

Home:Section("Main")

repeat task.wait() until game:IsLoaded()

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// CHARACTER
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

--// SETTINGS
local flying = false
local speed = 60
local ESP_ENABLED = false
local AUTO_WARP_GUN = false
local INFINITE_JUMP = false
local AIMLOCK = false
local LOCK_TARGET = nil
local NOCLIP = false
local AUTO_SHOOT = false
local AUTO_KNIFE = false
local KILL_AURA = false
local KNIFE_RANGE = 1000
local KILL_AURA_RANGE = 2000
local MAX_DISTANCE = 1000
local AUTO_COIN_COLLECT = false
local CHAT_ANNOUNCE = false
local Anti_Pling = false
local AUTO_PUSH = false
local AUTO_LEECH_MURDER = false
local LOOP_DELAY = 0.1
local lastEquip = 0

-- =========================
-- FLY
-- =========================
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)

local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(9e9,9e9,9e9)

local function setFly(state)
flying = state
bv.Parent = state and root or nil
bg.Parent = state and root or nil
end

RunService.RenderStepped:Connect(function()
if flying then
local cam = workspace.CurrentCamera
local moveDir = humanoid.MoveDirection
bv.Velocity = (cam.CFrame.LookVector * moveDir.Z + cam.CFrame.RightVector * moveDir.X) * speed
bg.CFrame = cam.CFrame
end
end)

-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer


-- =========================
-- ROLE SYSTEM
-- =========================
local function getRole(plr)
    local bp = plr:FindFirstChild("Backpack")
    local char = plr.Character

    if bp and bp:FindFirstChild("Knife") then return "Murderer" end
    if bp and bp:FindFirstChild("Gun") then return "Sheriff" end
    if char and char:FindFirstChild("Knife") then return "Murderer" end
    if char and char:FindFirstChild("Gun") then return "Sheriff" end

    return "Innocent"
end

-- =========================
-- CACHE (กันกระพริบ)
-- =========================
local lastRoles = {}

-- =========================
-- CREATE ESP (สีล้วน)
-- =========================
local function createESP(char)
    local hl = char:FindFirstChild("KuoHL")
    if not hl then
        hl = Instance.new("Highlight")
        hl.Name = "KuoHL"
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.Parent = char
    end
end

-- =========================
-- UPDATE ESP (แค่สี)
-- =========================
local function updateESP(char, role)
    local hl = char:FindFirstChild("KuoHL")
    if not hl then return end

    if role == "Murderer" then
        hl.FillColor = Color3.fromRGB(255,0,0)
        hl.OutlineColor = Color3.fromRGB(255,0,0)

    elseif role == "Sheriff" then
        hl.FillColor = Color3.fromRGB(170,0,255)
        hl.OutlineColor = Color3.fromRGB(170,0,255)

    else
        hl.FillColor = Color3.fromRGB(0,255,0)
        hl.OutlineColor = Color3.fromRGB(0,255,0)
    end
end

-- =========================
-- CLEAR ESP
-- =========================
local function clearESP(char)
    if not char then return end
    local hl = char:FindFirstChild("KuoHL")
    if hl then hl:Destroy() end
end

-- =========================
-- MAIN LOOP
-- =========================
RunService.Heartbeat:Connect(function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local char = plr.Character

            if char then
                if ESP_ENABLED then
                    local role = getRole(plr)

                    -- 🔥 กันโดนลบ ESP
                    if not char:FindFirstChild("KuoHL") then
                        createESP(char)
                        lastRoles[plr] = nil
                    end

                    -- 🔄 อัปเดตเฉพาะตอน role เปลี่ยน
                    if lastRoles[plr] ~= role then
                        lastRoles[plr] = role
                        updateESP(char, role)
                    end
                else
                    clearESP(char)
                end
            end
        end
    end
end)

-- =========================
-- INIT + CHARACTER SUPPORT
-- =========================
local function setupPlayer(plr)
    if plr == player then return end

    -- ตอนมีตัวละครอยู่แล้ว
    if plr.Character then
        createESP(plr.Character)
        local role = getRole(plr)
        lastRoles[plr] = role
        updateESP(plr.Character, role)
    end

    -- ตอนเกิดใหม่
    plr.CharacterAdded:Connect(function(char)
        char:WaitForChild("Head")

        if ESP_ENABLED then
            createESP(char)
            local role = getRole(plr)
            lastRoles[plr] = role
            updateESP(char, role)
        end
    end)

    -- 🔥 role มาใหม่ (เช่น ได้มีด/ปืน)
    plr.ChildAdded:Connect(function()
        lastRoles[plr] = nil
    end)

    if plr:FindFirstChild("Backpack") then
        plr.Backpack.ChildAdded:Connect(function()
            lastRoles[plr] = nil
        end)
    end
end

-- =========================
-- START
-- =========================
for _, plr in ipairs(Players:GetPlayers()) do
    setupPlayer(plr)
end

Players.PlayerAdded:Connect(setupPlayer)
-- =========================
-- 🚀 AUTO WARP GUN
-- =========================

task.spawn(function()
while task.wait(0.3) do
if AUTO_WARP_GUN then
local player = game.Players.LocalPlayer
local char = player.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")

local gun = workspace:FindFirstChild("GunDrop", true)
or workspace:FindFirstChild("Gun", true)

if hrp and gun then

-- 📌 เก็บตำแหน่งเดิม            
    local oldPos = hrp.CFrame            
  
    -- 🚀 วาร์ปไปปืน (แบบ BasePart หรือ Model ก็ได้)            
    local targetPart = gun:IsA("BasePart") and gun             
                    or gun:FindFirstChildWhichIsA("BasePart", true)            
  
    if targetPart then            
        hrp.CFrame = targetPart.CFrame            
  
        task.wait(0.2) -- ให้เกมจับปืนทัน            
  
        -- 🔙 วาร์ปกลับ            
        hrp.CFrame = oldPos            
    end            
  
    -- ปิดหลังใช้ (ตามแบบของคุณ)            
    AUTO_WARP_GUN = false            
end

end

end

end)

-- =========================
-- AUTO SHOOT (FIXED)
-- =========================
local function findMurderer()
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player and plr.Character and getRole(plr) == "Murderer" then
return plr
end
end
end

local function getLeadCFrame(targetChar, originPos)
local head = targetChar:FindFirstChild("Head")
local root = targetChar:FindFirstChild("HumanoidRootPart")
if not head or not root then return end

-- ✅ ใช้ตัวใหม่
local velocity = root.AssemblyLinearVelocity

local distance = (head.Position - originPos).Magnitude
local predictTime = math.clamp(distance / 200, 0.15, 0.35)

local predictedPos = head.Position + (velocity * predictTime)

-- ชดเชยการกระโดด (แกน Y)
predictedPos = predictedPos + Vector3.new(0, math.clamp(velocity.Y * 0.1, 0, 2), 0)

return CFrame.new(predictedPos)

end

task.spawn(function()
while task.wait(0.01) do
if not AUTO_SHOOT then continue end

local target = findMurderer()
if not target or not target.Character then continue end

local char = player.Character
local gun = char and char:FindFirstChild("Gun")
if not gun then continue end

local shootEvent = gun:FindFirstChild("Shoot")
local originPart = gun:FindFirstChild("Handle")
if not shootEvent or not originPart then continue end

local originCF = originPart.CFrame
local targetCF = getLeadCFrame(target.Character, originPart.Position)

if targetCF then
pcall(function()
shootEvent:FireServer(
originCF,
targetCF
)
end)
end

end

end)
-- =========================
-- INFINITE JUMP
-- =========================
UIS.JumpRequest:Connect(function()
if INFINITE_JUMP then
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end
end)

-- =========================
-- NOCLIP
-- =========================
RunService.Stepped:Connect(function()
if NOCLIP then
local char = player.Character
if char then
for _, v in ipairs(char:GetDescendants()) do
if v:IsA("BasePart") then v.CanCollide = false end
end
end
end
end)

-- =========================
-- AIMLOCK
-- =========================
local function getMurdererRoot()
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player and plr.Character and getRole(plr) == "Murderer" then
return plr.Character:FindFirstChild("HumanoidRootPart")
end
end
end

RunService.RenderStepped:Connect(function()
if AIMLOCK then
if not LOCK_TARGET or not LOCK_TARGET.Parent then
LOCK_TARGET = getMurdererRoot()
end
local cam = workspace.CurrentCamera
if LOCK_TARGET then
cam.CFrame = CFrame.new(cam.CFrame.Position, LOCK_TARGET.Position)
end
end
end)

-- =========================
-- 🔪 AUTO KNIFE + AUTO EQUIP (FINAL FIX)
-- =========================

local Players = game:GetService("Players")
local player = Players.LocalPlayer -- 🔥 แก้จาก LocalPlayers

-- =========================
-- 📦 GET CHARACTER
-- =========================
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
    local char = getChar()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- =========================
-- 🔥 AUTO EQUIP KNIFE
-- =========================
local function equipKnife()
    if tick() - lastEquip < 0.3 then return end
    lastEquip = tick()

    local char = getChar()
    local backpack = player:FindFirstChild("Backpack")

    if not char or not backpack then return end

    local knife = backpack:FindFirstChild("Knife")
    if knife then
        knife.Parent = char
    end
end

local function getKnife()
    local char = getChar()
    return char and char:FindFirstChild("Knife")
end

-- =========================
-- 🔪 THROW KNIFE
-- =========================
local function throwKnife(enemyRoot)
    local knife = getKnife()
    if not knife or not enemyRoot then return end

    local events = knife:FindFirstChild("Events")
    local throw = events and events:FindFirstChild("KnifeThrown")
    if not throw then return end

    local myRoot = getHRP()
    if not myRoot then return end

    local distance = (myRoot.Position - enemyRoot.Position).Magnitude
    local prediction = math.clamp(distance / 200, 0.1, 0.3)

    local velocity = enemyRoot.AssemblyLinearVelocity
    local predictedPos = enemyRoot.Position + (velocity * prediction)

    throw:FireServer(
        CFrame.new(myRoot.Position),
        CFrame.new(predictedPos)
    )
end

-- =========================
-- 🔪 STAB KNIFE
-- =========================
local function stabKnife(enemyRoot)
    local knife = getKnife()
    if not knife or not enemyRoot then return end

    local events = knife:FindFirstChild("Events")
    if not events then return end

    local handleTouched = events:FindFirstChild("HandleTouched")
    local stabbed = events:FindFirstChild("KnifeStabbed")

    if handleTouched then
        handleTouched:FireServer(enemyRoot)
    end

    if stabbed then
        stabbed:FireServer()
    end
end

-- =========================
-- 🎯 FIND TARGET
-- =========================
local function getNearestEnemy()
    local hrp = getHRP()
    if not hrp then return nil end

    local closest = nil
    local distMin = MAX_DISTANCE

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < distMin then
                    distMin = dist
                    closest = plr
                end
            end
        end
    end

    return closest
end

-- =========================
-- 💀 ATTACK (KILL AURA)
-- =========================
local function attack(plr)
    equipKnife()

    local knife = getKnife()
    if not knife then return end -- ✅ ต้องถือก่อน

    local hrp = getHRP()
    if not hrp or not plr.Character then return end

    local enemyRoot = plr.Character:FindFirstChild("HumanoidRootPart")
    if not enemyRoot then return end

    local old = hrp.CFrame

    hrp.CFrame = CFrame.lookAt(hrp.Position, enemyRoot.Position)
    hrp.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, -2)

    task.wait(0.05)

    for i = 1, 3 do
        throwKnife(enemyRoot)
        stabKnife(enemyRoot)
        task.wait(0.03)
    end

    task.wait(0.05)

    hrp.CFrame = old
end

-- =========================
-- 🔁 AUTO KNIFE LOOP (FIX)
-- =========================
task.spawn(function()
    while task.wait(0.1) do
        if not AUTO_KNIFE then continue end

        local target = getNearestEnemy()
        if not target or not target.Character then continue end

        local root = target.Character:FindFirstChild("HumanoidRootPart")
        if not root then continue end

        equipKnife()

        local knife = getKnife()
        if not knife then continue end -- ✅ กันยิงตอนยังไม่ถือ

        throwKnife(root)
    end
end)

-- =========================
-- 🔁 KILL AURA LOOP (FIX)
-- =========================
task.spawn(function()
    while task.wait(LOOP_DELAY) do
        if not KILL_AURA then continue end

        local target = getNearestEnemy()
        if not target then continue end

        equipKnife()

        local knife = getKnife()
        if not knife then continue end -- ✅ ต้องถือก่อน

        attack(target)
    end
end)

local TweenService = game:GetService("TweenService")

local COIN_SPEED = 30
local SAFE_DISTANCE = 40
local STUCK_TIME = 1

local currentTarget = nil
local lastMoveTime = tick()
local lastPos = nil

-- 🔍 หาเหรียญแบบฉลาด (หลบคน)
local function getSmartCoin(root)
local bestCoin = nil
local bestScore = math.huge

for _, coin in ipairs(workspace:GetDescendants()) do
if (coin.Name == "Coin" or coin.Name == "Coin_Server") and coin:IsA("BasePart") then

local dist = (coin.Position - root.Position).Magnitude

-- 🧠 เช็คศัตรูใกล้เหรียญ
local danger = 0
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
local d = (plr.Character.HumanoidRootPart.Position - coin.Position).Magnitude
if d < SAFE_DISTANCE then
danger = danger + (SAFE_DISTANCE - d)
end
end
end

-- 🎯 score ต่ำ = ดี
local score = dist + (danger * 5)

if score < bestScore then
bestScore = score
bestCoin = coin
end

end

end

return bestCoin

end

-- 🚀 Tween Fly (เนียน + กันแบน)
local function tweenTo(root, pos)
local dist = (root.Position - pos).Magnitude
local time = dist / COIN_SPEED

local tween = TweenService:Create(
root,
TweenInfo.new(time, Enum.EasingStyle.Linear),
{CFrame = CFrame.new(pos)}
)

tween:Play()
return tween

end

-- 🔥 LOOP
task.spawn(function()
while task.wait(0.01) do
if not AUTO_COIN_COLLECT then continue end

local char = player.Character
local root = char and char:FindFirstChild("HumanoidRootPart")
if not root then continue end

-- ❗ ปิด Fly ปกติ
if flying then
setFly(false)
end

-- 🎯 ล็อคเป้าหมาย
if not currentTarget or not currentTarget.Parent then
currentTarget = getSmartCoin(root)
end

if not currentTarget then continue end

local targetPos = currentTarget.Position + Vector3.new(0, 2, 0)

-- 🚀 Tween ไปหา
local tween = tweenTo(root, targetPos)

-- 🧠 Anti Stuck
local startTime = tick()
lastPos = root.Position

while tween.PlaybackState == Enum.PlaybackState.Playing do
task.wait(0.01)

if not AUTO_COIN_COLLECT then
tween:Cancel()
break
end

-- 🧱 ติด = วาร์ป
if (root.Position - lastPos).Magnitude < 1 then
if tick() - startTime > STUCK_TIME then
root.CFrame = CFrame.new(targetPos)
break
end
else
startTime = tick()
lastPos = root.Position
end

end

-- 🔄 รีเซ็ตเป้าหมาย
currentTarget = nil

end

end)

-- =========================
-- 📢 CHAT ANNOUNCE (FIXED)
-- =========================

local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 🔥 ส่งแชท (โคตรเสถียร)
local function sendChat(msg)
pcall(function()
if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then

local channels = TextChatService:WaitForChild("TextChannels", 2)
local channel = channels and channels:FindFirstChild("RBXGeneral")

if channel then
channel:SendAsync(msg)
else
warn("No RBXGeneral channel")
end

else
ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
:WaitForChild("SayMessageRequest")
:FireServer(msg, "All")
end

end)

end

-- 🔪 หา Murderer
local function getMurderer()
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player and getRole(plr) == "Murderer" then
return plr
end
end
end

-- 👮 หา Sheriff
local function getSheriffPlayer()
for _, plr in ipairs(Players:GetPlayers()) do
if plr ~= player and getRole(plr) == "Sheriff" then
return plr
end
end
end

-- 🔁 Loop ประกาศ
task.spawn(function()
local announced = false

while task.wait(0.1) do
if not CHAT_ANNOUNCE then
announced = false
continue
end

if not announced then
local murderer = getMurderer()
local sheriff = getSheriffPlayer()

if murderer and sheriff then
local msg = "Murderer: "..murderer.Name..
" | Sheriff: "..sheriff.Name..
" | Kuo Hub"

sendChat(msg)
announced = true

task.wait(0.01) -- ✅ ต้อง 1-2 วิ ถึงจะเสถียร

end

end

-- 🔄 รีรอบใหม่
if not getMurderer() and not getSheriffPlayer() then
announced = false
end

end

end)

-- =========================
-- SYSTEM: ANTI PLING (NO COLLIDE)
-- =========================

local function setCollision(character, state)
for _, part in ipairs(character:GetDescendants()) do
if part:IsA("BasePart") then
part.CanCollide = state
end
end
end

local function applyNoCollide(player)
if not player.Character then return end

setCollision(player.Character, false)

player.Character.DescendantAdded:Connect(function(part)
if part:IsA("BasePart") then
part.CanCollide = false
end
end)

end

-- =========================
-- MAIN LOOP (TOGGLE CONTROL)
-- =========================
task.spawn(function()
while task.wait(0.01) do
if Anti_Pling then
for _, plr in ipairs(Players:GetPlayers()) do
if plr.Character then
applyNoCollide(plr)
end
end
else
for _, plr in ipairs(Players:GetPlayers()) do
if plr.Character then
setCollision(plr.Character, true)
end
end
end
end
end)

-- =========================
-- INVISIBLE (MM2 FIX)
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
Home:Toggle({Title="ESP",Desc="ไฮไลต์ผู้เล่น",Callback=function(v) ESP_ENABLED=v end})
Home:Toggle({Title="Fly",Desc="บิน",Callback=function(v) setFly(v) end})
Home:Toggle({Title="Auto Warp Gun",Desc="วาร์ปเก็บปืน",Callback=function(v) AUTO_WARP_GUN=v end})
Home:Toggle({Title="Infinite Jump",Desc="กระโดดไม่จำกัด",Callback=function(v) INFINITE_JUMP=v end})
Home:Toggle({Title="NoClip",Desc="ทะลุกำแพง",Callback=function(v) NOCLIP=v end})

Combat:Toggle({Title="Aim Lock",Desc="ล็อคฆาตกร",Callback=function(v) AIMLOCK=v LOCK_TARGET=nil end})
Combat:Toggle({Title="Auto Shoot",Desc="ยิงออโต้",Callback=function(v) AUTO_SHOOT=v end})
Combat:Toggle({
Title="Auto Knife",
Desc="ปามีดอัตโนมัติ",
Callback=function(v)
AUTO_KNIFE=v
end
})
Combat:Toggle({
Title="Kill Aura",
Desc="ฆ่าทุกคนอัตโนมัติ",
Callback=function(v)
KILL_AURA=v
end
})

Home:Toggle({
Title = "Auto Coin Collect",
Desc = "ออโต้เก็บเหรียญ",
Callback = function(v)
AUTO_COIN_COLLECT = v
end
})

Home:Toggle({
Title="Reveal Role",
Desc="เปิดเผยวายร้าย",
Callback=function(v)
CHAT_ANNOUNCE = v
end
})

Home:Toggle({
Title="Anti-Pling",
Desc="กันปลิง",
Callback=function(v)
Anti_Pling = v
end
})

Combat:Toggle({
Title = "Invisible Mode",
Desc = "ร่องหน",
Callback = function(v)
applyInvisible(v)
end
})

getgenv().SpeedValue = 16

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function getChar()
return lp.Character or lp.CharacterAdded:Wait()
end

local function applySpeed(v)
local char = getChar()
local hum = char and char:FindFirstChildOfClass("Humanoid")
if hum then
hum.WalkSpeed = v
end
end

--========================
-- SLIDER
--========================
Home:AddSlider({
Name = "Adjust walking speed",
Min = 16,
Max = 200,
Default = 16,
Callback = function(v)
getgenv().SpeedValue = v
applySpeed(v)
end
})

--========================
-- MAIN MOVEMENT LOOP (FIXED)
--========================
task.spawn(function()
while task.wait(0.05) do
local char = lp.Character
if char then
local hrp = char:FindFirstChild("HumanoidRootPart")
local hum = char:FindFirstChildOfClass("Humanoid")

if hrp and hum then
local dir = hum.MoveDirection

if dir.Magnitude > 0 then
hrp.AssemblyLinearVelocity = dir * getgenv().SpeedValue
else
-- 🔥 stop clean (กันลื่น)
hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
end
end
end

end

end)

--========================
-- RESPWAN FIX
--========================
lp.CharacterAdded:Connect(function()
task.wait(0.5)
applySpeed(getgenv().SpeedValue)
end)

Home:AddSlider({
Name = "Adjust flight speed",
Min = 16,
Max = 200,
Default = 60,
Callback = function(v)
speed = v
end
})

Home:AddSlider({
Name = "Coin Collect Speed",
Min = 16,
Max = 200,
Default = 30,
Callback = function(v)
COIN_SPEED = v
end
})

-- KEY
UIS.InputBegan:Connect(function(i,g)
if not g and i.KeyCode == Enum.KeyCode.F then
setFly(not flying)
end
end)
