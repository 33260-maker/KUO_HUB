local kuolib = loadstring(game:HttpGet("https://raw.githubusercontent.com/33260-maker/KUO_HUB/refs/heads/main/Redzhubui.lua"))()

local Window = kuolib:MakeWindow({
  Title = "kuo Hub",
  SubTitle = "by kuo&ken",
  SaveFolder = "testando | kuo lib v5.lua"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://103308551113442", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

local Tab1 = Window:MakeTab({"Um", "cherry"})

Tab1:AddDiscordInvite({
    Name = "kuo hub",
    Description = "Join server",
    Logo = "rbxassetid://103308551113442",
    Invite = "https://discord.gg/Nv3uwZ28QZ",
})

redzlib:SetTheme("Dark")
redzlib:SetTheme("Darker")
redzlib:SetTheme("Purple")

Window:SelectTab(Tab1)

local Section = Tab1:AddSection({"Section"})
local Paragraph = Tab1:AddParagraph({"Paragraph", "This is a Paragraph\nSecond Line"})

local Dialog = Window:Dialog({
    Title = "Dialog",
    Text = "This is a Dialog",
    Options = {
      {"Confirm", function()
        
      end},
      {"Maybe", function()
        
      end},
      {"Cancel", function()
        
      end}
    }
})

Tab1:AddButton({"Print", function(Value)
    print("Hello World!")
end})
