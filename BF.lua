local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/malcompetchthong-dev/ITKuo/refs/heads/main/KUOHUBUI.lua"))()

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

-- =========================
-- ตัวแปรหลัก
-- =========================
local AutoFarmlevel = false

-- =========================
-- Tabs
-- =========================
local Home = Window:Tab("Home")
local Combat = Window:Tab("Combat")

-- =========================
-- UI
-- =========================
Home:Section("Main")

Home:AddDiscordInvite({
    Name = "Kuo Hub",
    Description = "Join server",
    Logo = "rbxassetid://103308551113442",
    Invite = "https://discord.gg/Apn2j9Fez",
})

Home:Toggle({
    Title = "Auto Farm level",
    Desc = "ฟาร์มเลเวลอัตโนมัติ",
    Callback = function(v)
        AutoFarmlevel = v
    end
})

-- =========================
-- Services
-- =========================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- =========================
-- Functions
-- =========================
local function Char()
    return player.Character or player.CharacterAdded:Wait()
end

local function HRP()
    return Char():WaitForChild("HumanoidRootPart")
end

local function Hum()
    return Char():WaitForChild("Humanoid")
end

local function Level()
    return player.Data.Level.Value
end

-- =========================
-- Combat
-- =========================
local CombatList = {
    "Godhuman","Dragon Talon","Electric Claw","Sharkman Karate",
    "Death Step","Superhuman","Dragon Breath","Water Kung Fu",
    "Electric","Dark Step","Combat"
}

local function EquipCombat()
    for _,v in ipairs(CombatList) do
        if player.Backpack:FindFirstChild(v) then
            Hum():EquipTool(player.Backpack[v])
            break
        end
    end
end

-- =========================
-- Quest Table (FULL)
-- =========================
local QuestTable = {
    {1,9,"BanditQuest1",1,"Bandit"},
    {10,14,"BanditQuest1",2,"Monkey"},
    {15,29,"JungleQuest",1,"Gorilla"},
    {30,39,"JungleQuest",2,"Gorilla"},
    {40,59,"BuggyQuest1",1,"Pirate"},
    {60,74,"BuggyQuest1",2,"Brute"},
    {75,89,"DesertQuest",1,"Desert Bandit"},
    {90,99,"DesertQuest",2,"Desert Officer"},
    {100,119,"SnowQuest",1,"Snow Bandit"},
    {120,149,"SnowQuest",2,"Snowman"},
    {150,174,"MarinefordQuest",1,"Chief Petty Officer"},
    {175,199,"MarinefordQuest",2,"Sky Bandit"},
    {200,224,"SkyQuest",1,"Dark Master"},
    {225,249,"SkyQuest",2,"Toga Warrior"},
    {250,274,"ColosseumQuest",1,"Gladiator"},
    {275,299,"ColosseumQuest",2,"Gladiator"},
    {300,324,"MagmaQuest",1,"Military Soldier"},
    {325,374,"MagmaQuest",2,"Military Spy"},
    {375,399,"FishmanQuest",1,"Fishman Warrior"},
    {400,449,"FishmanQuest",2,"Fishman Commando"},
    {450,474,"SkyExp1Quest",1,"God's Guard"},
    {475,524,"SkyExp1Quest",2,"Shanda"},
    {525,549,"SkyExp2Quest",1,"Royal Squad"},
    {550,624,"SkyExp2Quest",2,"Royal Soldier"},
    {625,649,"FountainQuest",1,"Galley Pirate"},
    {650,700,"FountainQuest",2,"Galley Captain"},

    -- WORLD 2
    {700,724,"Area1Quest",1,"Raider"},
    {725,774,"Area1Quest",2,"Mercenary"},
    {775,799,"Area2Quest",1,"Swan Pirate"},
    {800,874,"Area2Quest",2,"Factory Staff"},
    {875,899,"MarineQuest2",1,"Marine Lieutenant"},
    {900,949,"MarineQuest2",2,"Marine Captain"},
    {950,999,"ZombieQuest",1,"Zombie"},
    {1000,1049,"ZombieQuest",2,"Vampire"},
    {1050,1099,"SnowMountainQuest",1,"Snow Trooper"},
    {1100,1149,"SnowMountainQuest",2,"Winter Warrior"},
    {1150,1199,"IceSideQuest",1,"Lab Subordinate"},
    {1200,1249,"IceSideQuest",2,"Horned Warrior"},
    {1250,1299,"FireSideQuest",1,"Magma Ninja"},
    {1300,1349,"FireSideQuest",2,"Lava Pirate"},
    {1350,1399,"ShipQuest1",1,"Ship Deckhand"},
    {1400,1449,"ShipQuest1",2,"Ship Engineer"},
    {1450,1499,"ShipQuest2",2,"Ship Steward"},

    -- WORLD 3
    {1500,1524,"PiratePortQuest",1,"Pirate Millionaire"},
    {1525,1574,"PiratePortQuest",2,"Pistol Billionaire"},
    {1575,1599,"AmazonQuest",1,"Dragon Crew Warrior"},
    {1600,1624,"AmazonQuest",2,"Dragon Crew Archer"},
    {1625,1649,"AmazonQuest2",1,"Female Islander"},
    {1650,1699,"AmazonQuest2",2,"Giant Islander"},
    {1700,1724,"MarineTreeIsland",1,"Marine Commodore"},
    {1725,1774,"MarineTreeIsland",2,"Marine Rear Admiral"},
    {1775,1799,"DeepForestIsland3",1,"Fishman Raider"},
    {1800,1824,"DeepForestIsland3",2,"Fishman Captain"},
    {1825,1849,"DeepForestIsland",1,"Forest Pirate"},
    {1850,1899,"DeepForestIsland",2,"Mythological Pirate"},
    {1900,1924,"DeepForestIsland2",1,"Jungle Pirate"},
    {1925,1974,"DeepForestIsland2",2,"Musketeer Pirate"},
    {1975,1999,"HauntedQuest1",1,"Reborn Skeleton"},
    {2000,2049,"HauntedQuest1",2,"Living Zombie"},
    {2050,2099,"HauntedQuest2",1,"Demonic Soul"},
    {2100,2149,"HauntedQuest2",2,"Posessed Mummy"},
    {2150,2199,"IceCreamQuest",1,"Ice Cream Chef"},
    {2200,2249,"IceCreamQuest",2,"Ice Cream Commander"},
    {2250,2299,"PeanutQuest",1,"Peanut Scout"},
    {2300,2349,"PeanutQuest",2,"Peanut President"},
    {2350,2399,"CakeQuest1",1,"Cake Guard"},
    {2400,2449,"CakeQuest1",2,"Baking Staff"},
    {2450,2499,"CakeQuest2",1,"Head Baker"},
    {2500,2549,"CakeQuest2",2,"Cake Guard"},
    {2550,2599,"ChocQuest1",1,"Cocoa Warrior"},
    {2600,2649,"ChocQuest1",2,"Chocolate Bar Battler"},
    {2650,2699,"ChocQuest2",1,"Sweet Thief"},
    {2700,2749,"ChocQuest2",2,"Candy Rebel"},
    {2750,2800,"TikiQuest",2,"Isle Champion"},
}

local function GetQuest()
    for _,v in pairs(QuestTable) do
        if Level() >= v[1] and Level() <= v[2] then
            return v
        end
    end
end

-- =========================
-- Quest
-- =========================
local function HasQuest()
    local q = player.PlayerGui:FindFirstChild("Main")
    return q and q:FindFirstChild("Quest") and q.Quest.Visible
end

local function StartQuest(q)
    if HasQuest() then return end
    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", q[3], q[4])
end

-- =========================
-- Movement
-- =========================
local function FlyTo(cf)
    local tween = TweenService:Create(
        HRP(),
        TweenInfo.new((HRP().Position - cf.Position).Magnitude / 250, Enum.EasingStyle.Linear),
        {CFrame = cf}
    )
    tween:Play()
    tween.Completed:Wait()
end

-- =========================
-- Auto Click
-- =========================
task.spawn(function()
    while task.wait(0.15) do
        if AutoFarmlevel then
            VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.05)
            VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end
end)

-- =========================
-- Main Loop
-- =========================
task.spawn(function()
    local hakiCD = false

    while task.wait() do
        if not AutoFarmlevel then continue end

        -- Auto Haki
        local buso = Char():FindFirstChild("HasBuso")
        if buso and not buso.Value and not hakiCD then
            hakiCD = true
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end)
            task.delay(1.5, function()
                hakiCD = false
            end)
        end

        local q = GetQuest()
        if not q then continue end

        EquipCombat()
        StartQuest(q)

        for _,mob in pairs(workspace.Enemies:GetChildren()) do
            if mob.Name == q[5]
            and mob:FindFirstChild("HumanoidRootPart")
            and mob.Humanoid.Health > 0 then

                FlyTo(mob.HumanoidRootPart.CFrame * CFrame.new(0,15,0))

                repeat
                    RunService.Heartbeat:Wait()
                    HRP().CFrame =
                        mob.HumanoidRootPart.CFrame
                        * CFrame.new(0,15,0)
                        * CFrame.Angles(math.rad(-90),0,0)
                until not AutoFarmlevel or mob.Humanoid.Health <= 0
            end
        end
    end
end)
