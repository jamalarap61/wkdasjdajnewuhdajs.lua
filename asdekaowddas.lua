--v2

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local GuiService = game:GetService("GuiService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiscordAdsUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- COLORS
local colors = {
    Main = Color3.fromRGB(24, 24, 36),
    Card = Color3.fromRGB(32, 32, 48),
    Accent = Color3.fromRGB(114, 137, 218),
    Text = Color3.fromRGB(235, 235, 245),
    Muted = Color3.fromRGB(160, 160, 180)
}

-- BACKGROUND
local blur = Instance.new("Frame", screenGui)
blur.Size = UDim2.fromScale(1, 1)
blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blur.BackgroundTransparency = 0.45
blur.BorderSizePixel = 0

-- MAIN CARD
local main = Instance.new("Frame", screenGui)
main.Size = UDim2.fromOffset(380, 260)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = colors.Card
main.BorderSizePixel = 0

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = colors.Accent
stroke.Transparency = 0.6
stroke.Thickness = 1

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -40, 0, 36)
title.Position = UDim2.fromOffset(20, 20)
title.BackgroundTransparency = 1
title.Text = "Join Our Discord"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = colors.Text
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center

-- DESCRIPTION
local desc = Instance.new("TextLabel", main)
desc.Size = UDim2.new(1, -40, 0, 60)
desc.Position = UDim2.fromOffset(20, 65)
desc.BackgroundTransparency = 1
desc.TextWrapped = true
desc.Text = "Get updates, scripts, support, and exclusive features by joining the official LimitHub Discord server."
desc.Font = Enum.Font.Gotham
desc.TextSize = 14
desc.TextColor3 = colors.Muted
desc.TextXAlignment = Enum.TextXAlignment.Center
desc.TextYAlignment = Enum.TextYAlignment.Center

-- JOIN BUTTON
local joinBtn = Instance.new("TextButton", main)
joinBtn.Size = UDim2.new(1, -40, 0, 44)
joinBtn.Position = UDim2.fromOffset(20, 145)
joinBtn.BackgroundColor3 = colors.Accent
joinBtn.Text = "Join Discord"
joinBtn.Font = Enum.Font.GothamBold
joinBtn.TextSize = 16
joinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
joinBtn.BorderSizePixel = 0
Instance.new("UICorner", joinBtn).CornerRadius = UDim.new(0, 10)

-- SKIP BUTTON
local skipBtn = Instance.new("TextButton", main)
skipBtn.Size = UDim2.new(1, -40, 0, 32)
skipBtn.Position = UDim2.fromOffset(20, 198)
skipBtn.BackgroundTransparency = 1
skipBtn.Text = "Skip"
skipBtn.Font = Enum.Font.Gotham
skipBtn.TextSize = 14
skipBtn.TextColor3 = colors.Muted
skipBtn.BorderSizePixel = 0

-- FOOTER
local footer = Instance.new("TextLabel", main)
footer.Size = UDim2.new(1, 0, 0, 18)
footer.Position = UDim2.new(0, 0, 1, -22)
footer.BackgroundTransparency = 1
footer.Text = "discord.gg/limithub"
footer.Font = Enum.Font.Gotham
footer.TextSize = 12
footer.TextColor3 = colors.Muted
footer.TextTransparency = 0.4
footer.TextXAlignment = Enum.TextXAlignment.Center
footer.TextYAlignment = Enum.TextYAlignment.Center

-- ACTIONS
joinBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/limithub")
    end

    joinBtn.Text = "Link Copied, Opening Discord..."
    task.wait(0.6)
    screenGui:Destroy()
end)

skipBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)


    
--loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/wkdasjdajnewuhdajs.lua/refs/heads/main/asdekaowddas.lua"))()








local function Notify(text, dura)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "LimitHub",
            Text = text,
            Icon = "rbxassetid://102794753447548",
            Duration = dura or 5,
        })
    end)
end

if game.PlaceId == 126884695634066 then
-- ZZZZZ2 = Grow A Garden
loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/Mslspakwnendlsowjnssoaknana/refs/heads/main/ZZZZZ2.lua"))()
Notify("[Grow A Garden] Loaded Successfully")
elseif game.PlaceId == 121864768012064 then
-- ZZZZZ1 = Fish It
loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/Mslspakwnendlsowjnssoaknana/refs/heads/main/ZZZZZ1.lua"))()
Notify("[Fish It] Loaded Successfully")
elseif game.PlaceId == 126509999114328 then 
-- ZZZZZ3 = 99 Nights in Forest
loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/Mslspakwnendlsowjnssoaknana/refs/heads/main/ZZZZZ3.lua"))()
Notify("[99 Nights in Forest] Loaded Successfully")
elseif game.PlaceId == 79546208627805 then
--99 Night in Forest Lobby
Notify("[Lobby] Please Enter in Game First", 30)
elseif game.PlaceId == 96342491571673 or game.PlaceId == 109983668079237 then
-- ZZZZZ4 = Steal a Brainrot
loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/Mslspakwnendlsowjnssoaknana/refs/heads/main/ZZZZZ4.lua"))()
Notify("[Steal a Brainrot] Loaded Successfully")
elseif game.PlaceId == 131623223084840 then
-- ZZZZZ5 Escape Tsunami for Brainrot
loadstring(game:HttpGet("https://raw.githubusercontent.com/jamalarap61/Mslspakwnendlsowjnssoaknana/refs/heads/main/ZZZZZ5.lua"))()
else
Notify("[Warning] Game Not Supported!", 30)
return
end
