--// Kuo Hub | Rainbow Glow UI Full v2.4 (Border Rainbow, Tabs Normal, Window Minimize)

local Players = game:GetService("Players")      
                                            local UIS = game:GetService("UserInputService")      
                                            local TweenService = game:GetService("TweenService")      
                                            local RunService = game:GetService("RunService")      
                                            local player = Players.LocalPlayer      
  
                                            -- ScreenGui      
                                            local gui = Instance.new("ScreenGui")      
                                            gui.Name = "KuoHub"      
                                            gui.ResetOnSpawn = false      
                                            gui.Parent = player:WaitForChild("PlayerGui")      
  
                                            -- Auto Detect Device      
                                            local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled      
  
                                            -- Rainbow 7 Colors      
                                            local rainbowColors = {      
                                            Color3.fromRGB(255, 0, 0),      
                                            Color3.fromRGB(255, 127, 0),      
                                            Color3.fromRGB(255, 255, 0),      
                                            Color3.fromRGB(0, 255, 0),      
                                            Color3.fromRGB(0, 0, 255),      
                                            Color3.fromRGB(75, 0, 130),      
                                            Color3.fromRGB(148, 0, 211)      
                                            }      
  
                                            -- Function: Tween UIStroke Color (for Borders only)      
                                            local function tweenStrokeColor(stroke)      
                                            task.spawn(function()      
                                            local i = 1      
                                            while true do      
                                            if stroke then      
                                            TweenService:Create(stroke, TweenInfo.new(1), {Color = rainbowColors[i]}):Play()      
                                            end      
                                            i = i + 1      
                                            if i > #rainbowColors then i = 1 end      
                                            task.wait(1)      
                                            end      
                                            end)      
                                            end      
  
                                            -- Main Frame      
                                            local main = Instance.new("Frame", gui)      
                                            main.Size = UDim2.new(0,620,0,380)      
                                            main.Position = UDim2.new(0.5,-310,0.5,-190)      
                                            main.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            main.BorderSizePixel = 0      
                                            main.Active = true      
                                            main.Draggable = true      
                                            local uiScale = Instance.new("UIScale", main)      
                                            uiScale.Scale = isMobile and 0.9 or 1      
                                            local mainCorner = Instance.new("UICorner", main)      
                                            mainCorner.CornerRadius = UDim.new(0,15)      
  
                                            -- Main Border Stroke (Rainbow)      
                                            local mainStroke = Instance.new("UIStroke", main)      
                                            mainStroke.Thickness = 5      
                                            tweenStrokeColor(mainStroke)      
  
                                            -- Title      
                                            local title = Instance.new("TextLabel", main)      
                                            title.Size = UDim2.new(1,0,0,40)      
                                            title.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            title.Text = "Kuo Hub v2.4"      
                                            title.TextColor3 = Color3.fromRGB(255,255,255)      
                                            title.Font = Enum.Font.GothamBold      
                                            title.TextSize = 16      
                                            local titleCorner = Instance.new("UICorner", title)      
                                            titleCorner.CornerRadius = UDim.new(0,15)      
  
                                            -- Sidebar      
                                            local SIDEBAR_WIDTH = isMobile and 140 or 160      
                                            local sidebar = Instance.new("Frame", main)      
                                            sidebar.Position = UDim2.new(0,0,0,40)      
                                            sidebar.Size = UDim2.new(0,SIDEBAR_WIDTH,1,-40)      
                                            sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            sidebar.BorderSizePixel = 0      
                                            local sidebarCorner = Instance.new("UICorner", sidebar)      
                                            sidebarCorner.CornerRadius = UDim.new(0,15)      
                                            local sideLayout = Instance.new("UIListLayout", sidebar)      
                                            sideLayout.Padding = UDim.new(0,6)      
                                            sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center      
                                            local sidePadding = Instance.new("UIPadding", sidebar)      
                                            sidePadding.PaddingTop = UDim.new(0,6)      
  
                                            -- Sidebar Border Stroke (Rainbow)      
                                            local sideStroke = Instance.new("UIStroke", sidebar)      
                                            sideStroke.Thickness = 4      
                                            tweenStrokeColor(sideStroke)      
  
                                            -- Content      
                                            local content = Instance.new("Frame", main)      
                                            content.Position = UDim2.new(0,SIDEBAR_WIDTH,0,40)      
                                            content.Size = UDim2.new(1,-SIDEBAR_WIDTH,1,-40)      
                                            content.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            content.BorderSizePixel = 0      
                                            local contentCorner = Instance.new("UICorner", content)      
                                            contentCorner.CornerRadius = UDim.new(0,15)      
  
                                            -- Content Border Stroke (Rainbow)      
                                            local contentStroke = Instance.new("UIStroke", content)      
                                            contentStroke.Thickness = 4      
                                            tweenStrokeColor(contentStroke)      
  
                                            -- Tab System      
                                            local CurrentTab = nil      
                                            local Tabs = {}      
  
                                            local function applyButtonStroke(btn)      
                                            local stroke = Instance.new("UIStroke", btn)      
                                            stroke.Thickness = 3      
                                            stroke.Color = Color3.fromRGB(0,140,255) -- Fixed color for buttons (not rainbow)      
                                            end      
  
                                            local function CreateTab(name)      
                                            local btn = Instance.new("TextButton", sidebar)      
                                            btn.Size = UDim2.new(1,-12,0,36)      
                                            btn.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            btn.Text = name      
                                            btn.TextColor3 = Color3.fromRGB(255,255,255)      
                                            btn.Font = Enum.Font.Gotham      
                                            btn.TextSize = 14      
                                            btn.AutoButtonColor = false      
                                            local btnCorner = Instance.new("UICorner", btn)      
                                            btnCorner.CornerRadius = UDim.new(0,8)      
                                            applyButtonStroke(btn)      
  
                                            local page = Instance.new("ScrollingFrame", content)      
                                            page.Size = UDim2.new(1,0,1,0)      
                                            page.CanvasSize = UDim2.new(0,0,0,0)      
                                            page.ScrollBarImageTransparency = 0.6      
                                            page.Visible = false      
                                            page.BackgroundTransparency = 1      
                                            page.BorderSizePixel = 0      
                                            page.AutomaticCanvasSize = Enum.AutomaticSize.Y      
                                            local layout = Instance.new("UIListLayout", page)      
                                            layout.Padding = UDim.new(0,8)      
                                            local padding = Instance.new("UIPadding", page)      
                                            padding.PaddingTop = UDim.new(0,8)      
                                            padding.PaddingLeft = UDim.new(0,8)      
                                            padding.PaddingRight = UDim.new(0,8)      
  
                                            btn.MouseButton1Click:Connect(function()      
                                            if CurrentTab then      
                                            CurrentTab.page.Visible = false      
                                            CurrentTab.button.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            end      
                                            page.Visible = true      
                                            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)      
                                            CurrentTab = {page=page, button=btn}      
                                            end)      
                                            if not CurrentTab then      
                                            task.defer(function() btn.MouseButton1Click:Fire() end)      
                                            end      
  
                                            local tabObj = {}      
                                            tabObj.Page = page      
                                            tabObj.Button = btn      
  
                                            function tabObj:AddToggle(text, callback)      
                                            local btn = Instance.new("TextButton", self.Page)      
                                            btn.Size = UDim2.new(1,0,0,38)      
                                            btn.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            btn.Text = text.." : OFF"      
                                            btn.TextColor3 = Color3.fromRGB(255,255,255)      
                                            btn.Font = Enum.Font.Gotham      
                                            btn.TextSize = 14      
                                            btn.AutoButtonColor = false      
                                            local c = Instance.new("UICorner", btn)      
                                            c.CornerRadius = UDim.new(0,8)      
                                            applyButtonStroke(btn)      
  
                                            local state = false      
                                            btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50,50,50) end)      
                                            btn.MouseLeave:Connect(function() btn.BackgroundColor3 = state and Color3.fromRGB(70,220,120) or Color3.fromRGB(25,25,25) end)      
                                            btn.MouseButton1Click:Connect(function()      
                                            state = not state      
                                            btn.Text = text..(state and " : ON" or " : OFF")      
                                            local targetColor = state and Color3.fromRGB(70,220,120) or Color3.fromRGB(25,25,25)      
                                            TweenService:Create(btn,TweenInfo.new(0.3),{BackgroundColor3=targetColor}):Play()      
                                            callback(state)      
                                            end)      
  
                                            end      
  
                                            Tabs[name] = tabObj      
                                            return tabObj      
  
                                            end      
  
                                            -- Window:AddMinimizeButton (กลับมา)      
                                            function Window_AddMinimizeButton(config)      
                                            local btnConfig = config.Button or {}      
                                            local cornerConfig = config.Corner or {}      
  
                                            local btn = Instance.new("ImageButton", gui)      
                                            btn.Size = isMobile and UDim2.new(0,60,0,60) or UDim2.new(0,50,0,50)      
                                            btn.Position = UDim2.new(0,20,0.5,-30)      
                                            btn.Image = btnConfig.Image or ""      
                                            btn.BackgroundTransparency = btnConfig.BackgroundTransparency or 0      
                                            btn.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            btn.BorderSizePixel = 0      
                                            btn.Active = true      
                                            btn.Draggable = true      
  
                                            if cornerConfig.CornerRadius then      
                                            local c = Instance.new("UICorner", btn)      
                                            c.CornerRadius = cornerConfig.CornerRadius      
                                            end      
  
                                            local minimized = false      
                                            btn.MouseButton1Click:Connect(function()      
                                            minimized = not minimized      
                                            main.Visible = not minimized      
                                            end)      
  
                                            return btn      
  
                                            end      
  
                                            Window_AddMinimizeButton({      
                                            Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },      
                                            Corner = { CornerRadius = UDim.new(0, 35) }      
                                            })      
  
                                            -- Minimize / Close Buttons (บน Main)      
                                            local minimizeBtn = Instance.new("TextButton", main)      
                                            minimizeBtn.Size = UDim2.new(0,30,0,30)      
                                            minimizeBtn.Position = UDim2.new(1,-70,0,5)      
                                            minimizeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            minimizeBtn.Text = "-"      
                                            minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)      
                                            minimizeBtn.Font = Enum.Font.GothamBold      
                                            minimizeBtn.TextSize = 20      
                                            minimizeBtn.AutoButtonColor = false      
                                            local minCorner = Instance.new("UICorner", minimizeBtn)      
                                            minCorner.CornerRadius = UDim.new(0,5)      
  
                                            local isMinimized = false      
                                            minimizeBtn.MouseButton1Click:Connect(function()      
                                            isMinimized = not isMinimized      
                                            if isMinimized then      
                                            sidebar.Visible = false      
                                            content.Visible = false      
                                            TweenService:Create(main, TweenInfo.new(0.3), {Size=UDim2.new(0,620,0,40)}):Play()      
                                            else      
                                            sidebar.Visible = true      
                                            content.Visible = true      
                                            TweenService:Create(main, TweenInfo.new(0.3), {Size=UDim2.new(0,620,0,380)}):Play()      
                                            end      
                                            end)      
  
                                            local closeBtn = Instance.new("TextButton", main)      
                                            closeBtn.Size = UDim2.new(0,30,0,30)      
                                            closeBtn.Position = UDim2.new(1,-35,0,5)      
                                            closeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)      
                                            closeBtn.Text = "X"      
                                            closeBtn.TextColor3 = Color3.fromRGB(255,255,255)      
                                            closeBtn.Font = Enum.Font.GothamBold      
                                            closeBtn.TextSize = 20      
                                            closeBtn.AutoButtonColor = false      
                                            local closeCorner = Instance.new("UICorner", closeBtn)      
                                            closeCorner.CornerRadius = UDim.new(0,5)      
                                            closeBtn.MouseButton1Click:Connect(function()      
                                            main:Destroy()      
                                            end)      
                                            -- =========================      
                                            -- Player Profile (BOTTOM FIXED)      
                                            -- =========================      
                                            local profile = Instance.new("Frame", sidebar)      
                                            profile.Size = UDim2.new(1,-12,0,70)      
                                            profile.AnchorPoint = Vector2.new(0,1)      
                                            profile.Position = UDim2.new(0,6,1,-6)      
                                            profile.BackgroundColor3 = Color3.fromRGB(20,20,20)      
                                            profile.BorderSizePixel = 0      
                                            profile.ZIndex = 10      
                                            Instance.new("UICorner", profile).CornerRadius = UDim.new(0,10)      
  
                                            -- Avatar (Circle)      
                                            local avatar = Instance.new("ImageLabel", profile)      
                                            avatar.Size = UDim2.new(0,48,0,48)      
                                            avatar.Position = UDim2.new(0,8,0.5,-24)      
                                            avatar.BackgroundTransparency = 1      
                                            avatar.ScaleType = Enum.ScaleType.Crop      
                                            avatar.ZIndex = 11      
                                            avatar.Image = Players:GetUserThumbnailAsync(      
                                            player.UserId,      
                                            Enum.ThumbnailType.HeadShot,      
                                            Enum.ThumbnailSize.Size100x100      
                                            )      
                                            Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)      
  
                                            -- DisplayName (TOP)      
                                            local displayName = Instance.new("TextLabel", profile)      
                                            displayName.BackgroundTransparency = 1      
                                            displayName.Position = UDim2.new(0,64,0,6)      
                                            displayName.Size = UDim2.new(1,-72,0,24)      
                                            displayName.Text = player.DisplayName      
                                            displayName.Font = Enum.Font.GothamBold      
                                            displayName.TextSize = 14      
                                            displayName.TextWrapped = true      
                                            displayName.TextXAlignment = Enum.TextXAlignment.Left      
                                            displayName.TextYAlignment = Enum.TextYAlignment.Top      
                                            displayName.TextColor3 = Color3.new(1,1,1)      
                                            displayName.ZIndex = 11      
                                            displayName.AutomaticSize = Enum.AutomaticSize.Y      
  
                                            -- Username (BOTTOM, NOT CUT)      
                                            local username = Instance.new("TextLabel", profile)      
                                            username.BackgroundTransparency = 1      
                                            username.Position = UDim2.new(0,64,0,30)      
                                            username.Size = UDim2.new(1,-72,0,34)      
                                            username.Text = "@"..player.Name      
                                            username.Font = Enum.Font.Gotham      
                                            username.TextSize = 12      
                                            username.TextWrapped = true      
                                            username.TextXAlignment = Enum.TextXAlignment.Left      
                                            username.TextYAlignment = Enum.TextYAlignment.Top      
                                            username.TextColor3 = Color3.fromRGB(180,180,180)      
                                            username.ZIndex = 11      
                                            username.AutomaticSize = Enum.AutomaticSize.Y      
  
                                            -- Tabs      
                                            local MainTab = CreateTab("🏠 Main")      
                                            local PlayerTab = CreateTab("👤 Player")      
                                            local FarmTab = CreateTab("🌲 Farming")      
                                            local NightsTab = CreateTab("🏕️ 99 Nights")      
  
                                            -- Demo Toggles      
  
                                            MainTab:AddToggle("🔗 Discord", function()      
  
                                            pcall(function() setclipboard("https://discord.gg/Nv3uwZ28QZ") end)      
  
                                            end)

PlayerTab:AddToggle("✈️ Fly 360", function(state)
if state then

pcall(function()  
        loadstring(game:HttpGet("https://pastebin.com/raw/WAV2j9rz"))()  
    end)  
end
end)
-- ===============================
-- 🌲 AUTO TREE (MULTI CUT)
-- ===============================
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local foliage = workspace.Map.Foliage
local DAMAGE_REMOTE = RS.RemoteEvents.ToolDamageObject

-- ===== SETTINGS =====
local AutoTree = false
local CUT_DISTANCE = 200
local CUT_DELAY = 0.25
local HIT_ID = "1_9492572250"

-- ===== AXE =====
local function GetAxe()
    local inv = player:FindFirstChild("Inventory")
    if not inv then return nil end
    return inv:FindFirstChild("Strong Axe")
        or inv:FindFirstChild("Good Axe")
        or inv:FindFirstChild("Old Axe")
end

-- ===== ROOT =====
local function GetRoot()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ===== TREE CHECK =====
local function IsAlive(tree)
    return tree and tree.Parent and tree:IsDescendantOf(workspace)
end

-- ===== GET TREES IN RANGE =====
local function GetTreesInRange()
    local root = GetRoot()
    if not root then return {} end

    local trees = {}
    for _, t in ipairs(foliage:GetChildren()) do
        if t.Name == "Small Tree" and IsAlive(t) then
            local d = (t:GetPivot().Position - root.Position).Magnitude
            if d <= CUT_DISTANCE then
                table.insert(trees, t)
            end
        end
    end
    return trees
end

-- ===== HIGHLIGHT MULTI =====
local highlights = {}

local function ClearHighlights()
    for _, h in pairs(highlights) do
        if h then h:Destroy() end
    end
    highlights = {}
end

local function HighlightTree(tree)
    if highlights[tree] then return end

    local h = Instance.new("Highlight")
    h.FillColor = Color3.fromRGB(255,80,80)
    h.FillTransparency = 0.35
    h.OutlineColor = Color3.new(1,1,1)
    h.Adornee = tree
    h.Parent = tree

    highlights[tree] = h
end

-- ===== UI =====
FarmTab:AddToggle("🌲 Auto Tree (Beta)", function(v)
    AutoTree = v
    if not v then
        ClearHighlights()
    end
end)

-- ===== MAIN LOOP =====
task.spawn(function()
    while task.wait(CUT_DELAY) do
        if not AutoTree then continue end

        local axe = GetAxe()
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if not axe or not hum then continue end

        -- Equip ขวาน
        if hum:FindFirstChildOfClass("Tool") ~= axe then
            hum:EquipTool(axe)
            task.wait(0.1)
        end

        local trees = GetTreesInRange()

        -- ลบ Highlight ของต้นที่ตายแล้ว
        for tree, h in pairs(highlights) do
            if not IsAlive(tree) then
                h:Destroy()
                highlights[tree] = nil
            end
        end

        -- ตัดทุกต้นในระยะ
        for _, tree in ipairs(trees) do
            HighlightTree(tree)

            pcall(function()
                DAMAGE_REMOTE:InvokeServer(
                    tree,
                    axe,
                    HIT_ID,
                    tree:GetPivot()
                )
            end)
        end
    end
end)
  local KillAura = false                                                    NightsTab:AddToggle("⚔️ Kill Aura (Stable)", function(state)
KillAura = state
end)

local Players = game:GetService("Players")      
                                            local RS = game:GetService("ReplicatedStorage")      
                                            local player = Players.LocalPlayer      
                                            local DAMAGE_REMOTE = RS.RemoteEvents:WaitForChild("ToolDamageObject")      
  
                                            local RANGE = 160      
                                            local COOLDOWN = 0.15      
                                            local HIT_ID = "1_4478233043"      
  
                                            task.spawn(function()      
                                            while task.wait(COOLDOWN) do      
                                            if not KillAura then continue end      
  
                                            local char = player.Character        
                                                local hum = char and char:FindFirstChildOfClass("Humanoid")        
                                                    local root = char and char:FindFirstChild("HumanoidRootPart")        
                                                        local inv = player:FindFirstChild("Inventory")        
  
                                                            if not char or not hum or not root or not inv then continue end        
  
                                                                local tool = inv:FindFirstChild("Good Axe") or inv:FindFirstChild("Old Axe")        
                                                                    if not tool then continue end        
  
                                                                        -- ✅ Equip แบบถูกต้อง (ไม่วาป์)        
                                                                            if hum:GetState() ~= Enum.HumanoidStateType.Dead then        
                                                                                    if hum:FindFirstChildOfClass("Tool") ~= tool then        
                                                                                                hum:EquipTool(tool)        
                                                                                                        end        
                                                                                                            end        
  
                                                                                                                for _, mob in ipairs(workspace.Characters:GetChildren()) do        
                                                                                                                        if mob ~= char then        
                                                                                                                                    local mroot = mob:FindFirstChild("HumanoidRootPart")        
                                                                                                                                                local mhum = mob:FindFirstChildOfClass("Humanoid")        
  
                                                                                                                                                            if mroot and mhum and mhum.Health > 0 then        
                                                                                                                                                                            if (mroot.Position - root.Position).Magnitude <= RANGE then        
                                                                                                                                                                                                pcall(function()        
                                                                                                                                                                                                                        DAMAGE_REMOTE:InvokeServer(        
                                                                                                                                                                                                                                                    mob,        
                                                                                                                                                                                                                                                                                tool,        
                                                                                                                                                                                                                                                                                                            HIT_ID,        
                                                                                                                                                                                                                                                                                                                                        mroot.CFrame        
                                                                                                                                                                                                                                                                                                                                                                )        
                                                                                                                                                                                                                                                                                                                                                                                    end)        
                                                                                                                                                                                                                                                                                                                                                                                                    end        
                                                                                                                                                                                                                                                                                                                                                                                                                end        
                                                                                                                                                                                                                                                                                                                                                                                                                        end        
                                                                                                                                                                                                                                                                                                                                                                                                                            end        
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end)

-- ===== GOD MODE (Infinite Health) =====
local infiniteHealthEnabled = false
local healthConnection = nil

local function ActivateInfiniteHealth(character)
if not character or not character:FindFirstChild("Humanoid") then return end

if healthConnection then healthConnection:Disconnect() end  

healthConnection = character.Humanoid.Changed:Connect(function(property)  
    if infiniteHealthEnabled then  
        if property == "Health" and character.Humanoid.Health < 100 then  
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")  
            if remote and remote:FindFirstChild("DamagePlayer") then  
                remote.DamagePlayer:FireServer(math.huge * -1)  
            end  
        end  
    end  
end)

end

-- Auto-activate on respawn
player.CharacterAdded:Connect(function(char)
if infiniteHealthEnabled then
ActivateInfiniteHealth(char)
end
end)

NightsTab:AddToggle("🛡️ God Mode", function(state)
infiniteHealthEnabled = state

if state then  
    if player.Character then  
        ActivateInfiniteHealth(player.Character)  
    end  
      
    game:GetService("StarterGui"):SetCore("SendNotification", {  
        Title = "Kuo Hub",  
        Text = "God Mode Activated!",  
        Duration = 3  
    })  
else  
    if healthConnection then  
        healthConnection:Disconnect()  
        healthConnection = nil  
    end  
      
    game:GetService("StarterGui"):SetCore("SendNotification", {  
        Title = "Kuo Hub",  
        Text = "God Mode Disabled",  
        Duration = 3  
    })  
end

end)

-- Auto Burn (Fly)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local AutoBurnFly = false      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local burnRemote = game:GetService("ReplicatedStorage").RemoteEvents:WaitForChild("RequestBurnItem")      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local fire = workspace.Map.Campground.MainFire      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local SPEED = 120      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local burnCooldown = 0.15      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            FarmTab:AddToggle("🔥 Auto Burn (Fly)", function(state)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            AutoBurnFly = state      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local function flyTo(hrp, targetCFrame)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local dist = (hrp.Position - targetCFrame.Position).Magnitude      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local time = dist / SPEED      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = targetCFrame})      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            tween:Play()      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            tween.Completed:Wait()      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local function findBurnItem()      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            for _, v in ipairs(workspace:GetDescendants()) do      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if v.Name == "Log" or v.Name == "Coal" then      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local part = v:IsA("Model") and (v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true)) or v:IsA("BasePart") and v      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if part then return v, part end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            task.spawn(function()      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            while task.wait(0.5) do      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if not AutoBurnFly then continue end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local char = player.Character      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local hrp = char and char:FindFirstChild("HumanoidRootPart")      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if not hrp then continue end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local item, part = findBurnItem()      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if item and part then      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            flyTo(hrp, part.CFrame * CFrame.new(0,3,-2))      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            task.wait(burnCooldown)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if fire and fire.PrimaryPart then      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            flyTo(hrp, fire.PrimaryPart.CFrame * CFrame.new(0,3,-3))      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            task.wait(burnCooldown)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            local inv = player:FindFirstChild("Inventory")      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if inv then      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            for _, it in ipairs(inv:GetChildren()) do      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            if it.Name == "Log" or it.Name == "Coal" then      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            pcall(function() burnRemote:FireServer(fire, it) end)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            task.wait(burnCooldown)      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end      
  
                                                                                                                                                                                                                                                                                                                                                                                                                            end)
