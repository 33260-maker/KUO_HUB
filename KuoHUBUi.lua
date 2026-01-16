--// Kuo Hub | Rainbow Glow UI Full v2.4 (Fixed Minimize Bug & Small Profile)

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

-- Rainbow 7 Colors Logic
local rainbowColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(148, 0, 211)
}

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

local sideStroke = Instance.new("UIStroke", sidebar)
sideStroke.Thickness = 4
tweenStrokeColor(sideStroke)

-- Content Area
local content = Instance.new("Frame", main)
content.Position = UDim2.new(0,SIDEBAR_WIDTH,0,40)
content.Size = UDim2.new(1,-SIDEBAR_WIDTH,1,-40)
content.BackgroundColor3 = Color3.fromRGB(25,25,25)
content.BorderSizePixel = 0
local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0,15)

local contentStroke = Instance.new("UIStroke", content)
contentStroke.Thickness = 4
tweenStrokeColor(contentStroke)

-- =========================          
-- Player Profile (Small & Fixed Position)
-- =========================          
local profile = Instance.new("Frame", main) 
profile.Name = "UserProfile"
profile.Size = UDim2.new(0, SIDEBAR_WIDTH - 16, 0, 55) 
profile.AnchorPoint = Vector2.new(0, 1) 
profile.Position = UDim2.new(0, 8, 1, -8) 
profile.BackgroundColor3 = Color3.fromRGB(20, 20, 20)          
profile.BorderSizePixel = 0          
profile.ZIndex = 25 
Instance.new("UICorner", profile).CornerRadius = UDim.new(0, 8)          

local avatar = Instance.new("ImageLabel", profile)          
avatar.Size = UDim2.new(0, 38, 0, 38)          
avatar.Position = UDim2.new(0, 8, 0.5, -19)          
avatar.BackgroundTransparency = 1          
avatar.ZIndex = 26          
avatar.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)          
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)          

local displayName = Instance.new("TextLabel", profile)          
displayName.BackgroundTransparency = 1          
displayName.Position = UDim2.new(0, 54, 0, 8)        
displayName.Size = UDim2.new(1, -60, 0, 20)          
displayName.Text = player.DisplayName          
displayName.Font = Enum.Font.GothamBold          
displayName.TextSize = 13          
displayName.TextColor3 = Color3.new(1, 1, 1)          
displayName.TextXAlignment = Enum.TextXAlignment.Left          
displayName.ZIndex = 26          

local username = Instance.new("TextLabel", profile)          
username.BackgroundTransparency = 1          
username.Position = UDim2.new(0, 54, 0, 24)        
username.Size = UDim2.new(1, -60, 0, 20)          
username.Text = "@"..player.Name          
username.Font = Enum.Font.Gotham          
username.TextSize = 11          
username.TextColor3 = Color3.fromRGB(160, 160, 160)          
username.TextXAlignment = Enum.TextXAlignment.Left          
username.ZIndex = 26          

-- Minimize Logic (FIXED BUG: Profile will hide too)
local topMinimize = Instance.new("TextButton", main)
topMinimize.Size = UDim2.new(0,30,0,30)
topMinimize.Position = UDim2.new(1,-70,0,5)
topMinimize.BackgroundColor3 = Color3.fromRGB(25,25,25)
topMinimize.Text = "-"
topMinimize.TextColor3 = Color3.new(1,1,1)
topMinimize.Font = Enum.Font.GothamBold
topMinimize.TextSize = 20
Instance.new("UICorner", topMinimize).CornerRadius = UDim.new(0,5)

local isMinimized = false
topMinimize.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    sidebar.Visible = not isMinimized
    content.Visible = not isMinimized
    profile.Visible = not isMinimized -- แก้บัค: สั่งให้ Profile หายไปพร้อม Sidebar
    
    local targetSize = isMinimized and UDim2.new(0,620,0,40) or UDim2.new(0,620,0,380)
    TweenService:Create(main, TweenInfo.new(0.3), {Size=targetSize}):Play()
end)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,5)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Floating Minimize Button (Circle)
function Window_AddMinimizeButton(config)
    local minBtn = Instance.new("ImageButton", gui)
    minBtn.Size = isMobile and UDim2.new(0,60,0,60) or UDim2.new(0,50,0,50)
    minBtn.Position = UDim2.new(0,20,0.5,-30)
    minBtn.Image = config.Button.Image or ""
    minBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    minBtn.Active = true
    minBtn.Draggable = true
    Instance.new("UICorner", minBtn).CornerRadius = config.Corner.CornerRadius
    minBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    return minBtn
end

Window_AddMinimizeButton({
    Button = { Image = "rbxassetid://103308551113442" },
    Corner = { CornerRadius = UDim.new(0, 35) }
})

-- Tab System Logic
local CurrentTab = nil
local function applyButtonStroke(btn)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 3
    stroke.Color = Color3.fromRGB(0,140,255)
end

-- ===============================
-- 👤 PROFILE NAME SYSTEM (SAFE)
-- ===============================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Frame: profile (ต้องมีอยู่แล้ว)
-- ImageLabel: avatar (ต้องมีอยู่แล้ว)

-- Display Name
local displayName = Instance.new("TextLabel")
displayName.Name = "DisplayName"
displayName.Parent = profile
displayName.Position = UDim2.new(0, 54, 0, 6)
displayName.Size = UDim2.new(1, -60, 0, 22)
displayName.BackgroundTransparency = 1
displayName.Text = player.DisplayName
displayName.Font = Enum.Font.GothamBold
displayName.TextColor3 = Color3.new(1,1,1)

-- 🔒 ป้องกันล้น
displayName.TextScaled = true
displayName.TextWrapped = false
displayName.ClipsDescendants = true
displayName.TextXAlignment = Enum.TextXAlignment.Left
displayName.TextYAlignment = Enum.TextYAlignment.Center

-- Username
local username = Instance.new("TextLabel")
username.Name = "Username"
username.Parent = profile
username.Position = UDim2.new(0, 54, 0, 26)
username.Size = UDim2.new(1, -60, 0, 18)
username.BackgroundTransparency = 1
username.Text = "@" .. player.Name
username.Font = Enum.Font.Gotham
username.TextColor3 = Color3.fromRGB(160,160,160)

-- 🔒 ป้องกันล้น
username.TextScaled = true
username.TextWrapped = false
username.ClipsDescendants = true
username.TextXAlignment = Enum.TextXAlignment.Left
username.TextYAlignment = Enum.TextYAlignment.Center
-- Export Library
_G.KuoHub = { CreateTab = CreateTab }
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
_G.KuoHub = _G.KuoHub or {}
_G.KuoHub.CreateTab = CreateTab
