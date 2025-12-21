local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

local UI = {}
UI.__index = UI
--v0.2
--========================
-- UTIL
--========================
local function corner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = obj
end

local function padding(obj, p)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0,p)
    pad.PaddingBottom = UDim.new(0,p)
    pad.PaddingLeft = UDim.new(0,p)
    pad.PaddingRight = UDim.new(0,p)
    pad.Parent = obj
end

--========================
-- WINDOW
--========================
function UI:CreateWindow(title)
    pcall(function()
        LP.PlayerGui:FindFirstChild("XenoUI"):Destroy()
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "XenoUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LP.PlayerGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.fromScale(0.9,0.6)
    Main.Position = UDim2.fromScale(0.05,0.2)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Parent = ScreenGui
    corner(Main,12)

    -- Topbar
    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1,0,0,45)
    Top.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Top.BorderSizePixel = 0
    Top.Active = true
    Top.Parent = Main
    corner(Top,12)

    local Title = Instance.new("TextLabel")
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,-20,1,0)
    Title.Position = UDim2.new(0,10,0,0)
    Title.Text = title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Parent = Top

    -- Tabs bar
    local TabsBar = Instance.new("Frame")
    TabsBar.Size = UDim2.new(0,130,1,-45)
    TabsBar.Position = UDim2.new(0,0,0,45)
    TabsBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    TabsBar.BorderSizePixel = 0
    TabsBar.Parent = Main
    padding(TabsBar,6)

    local TabsLayout = Instance.new("UIListLayout", TabsBar)
    TabsLayout.Padding = UDim.new(0,6)

    -- Pages
    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1,-140,1,-55)
    Pages.Position = UDim2.new(0,135,0,50)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    -- Drag (FIX ENUM)
    local dragging = false
    local dragStart, startPos

    Top.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            local delta = i.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local Window = {}
    Window.Tabs = {}

    --========================
    -- TAB
    --========================
    function Window:CreateTab(name)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1,0,0,36)
        TabBtn.Text = name
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 14
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        TabBtn.Parent = TabsBar
        corner(TabBtn,6)

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1,0,1,0)
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarThickness = 3
        Page.Visible = false
        Page.BackgroundTransparency = 1
        Page.Parent = Pages
        padding(Page,8)

        local layout = Instance.new("UIListLayout", Page)
        layout.Padding = UDim.new(0,8)

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            for _,t in pairs(Window.Tabs) do
                t.Page.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
            end
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        end)

        if #Window.Tabs == 0 then
            Page.Visible = true
            TabBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        end

        local Tab = {Page = Page, Button = TabBtn}
        table.insert(Window.Tabs, Tab)

        --========================
        -- ELEMENT FACTORY
        --========================
        local function getParent(p)
            return p or Page
        end

        function Tab:AddParagraph(title, text, parent)
            local f = Instance.new("Frame", getParent(parent))
            f.Size = UDim2.new(1,0,0,60)
            f.BackgroundColor3 = Color3.fromRGB(40,40,40)
            corner(f,8)

            local t = Instance.new("TextLabel", f)
            t.BackgroundTransparency = 1
            t.Size = UDim2.new(1,-10,0,20)
            t.Position = UDim2.new(0,6,0,4)
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.Text = title
            t.Font = Enum.Font.GothamBold
            t.TextSize = 14
            t.TextColor3 = Color3.new(1,1,1)

            local d = Instance.new("TextLabel", f)
            d.BackgroundTransparency = 1
            d.Position = UDim2.new(0,6,0,26)
            d.Size = UDim2.new(1,-10,0,28)
            d.TextWrapped = true
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Text = text
            d.Font = Enum.Font.Gotham
            d.TextSize = 13
            d.TextColor3 = Color3.fromRGB(200,200,200)
        end

        function Tab:AddToggle(text, default, callback, parent)
            local val = default == true
            local btn = Instance.new("TextButton", getParent(parent))
            btn.Size = UDim2.new(1,0,0,40)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)
            corner(btn,8)

            local function refresh()
                btn.Text = text .. " : " .. (val and "ON" or "OFF")
                btn.BackgroundColor3 = val and Color3.fromRGB(60,120,60) or Color3.fromRGB(45,45,45)
            end

            refresh()
            btn.MouseButton1Click:Connect(function()
                val = not val
                refresh()
                if callback then pcall(callback,val) end
            end)
        end

        function Tab:AddButton(text, callback, parent)
            local btn = Instance.new("TextButton", getParent(parent))
            btn.Size = UDim2.new(1,0,0,40)
            btn.Text = text
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            corner(btn,8)

            btn.MouseButton1Click:Connect(function()
                if callback then pcall(callback) end
            end)
        end

        function Tab:AddSection(text, parent)
            local l = Instance.new("TextLabel", getParent(parent))
            l.Size = UDim2.new(1,0,0,24)
            l.BackgroundTransparency = 1
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Text = text
            l.Font = Enum.Font.GothamBold
            l.TextSize = 13
            l.TextColor3 = Color3.fromRGB(180,180,180)
        end

        function Tab:AddCollapse(text, build)
            local open = false

            local holder = Instance.new("Frame", Page)
            holder.Size = UDim2.new(1,0,0,40)
            holder.BackgroundColor3 = Color3.fromRGB(45,45,45)
            holder.ClipsDescendants = true
            corner(holder,8)

            local btn = Instance.new("TextButton", holder)
            btn.Size = UDim2.new(1,0,0,40)
            btn.BackgroundTransparency = 1
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Text = "  "..text.." >"
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)

            local inner = Instance.new("Frame", holder)
            inner.Position = UDim2.new(0,0,0,40)
            inner.Size = UDim2.new(1,0,0,0)
            inner.BackgroundTransparency = 1
            padding(inner,6)

            local lay = Instance.new("UIListLayout", inner)
            lay.Padding = UDim.new(0,6)

            lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if open then
                    holder.Size = UDim2.new(1,0,0,40 + lay.AbsoluteContentSize.Y + 8)
                end
            end)

            btn.MouseButton1Click:Connect(function()
                open = not open
                btn.Text = "  "..text..(open and " v" or " >")
                holder.Size = open
                    and UDim2.new(1,0,0,40 + lay.AbsoluteContentSize.Y + 8)
                    or UDim2.new(1,0,0,40)
            end)

            if build then
                build({
                    AddToggle = function(_, ...) Tab:AddToggle(..., inner) end,
                    AddButton = function(_, ...) Tab:AddButton(..., inner) end,
                    AddSection = function(_, ...) Tab:AddSection(..., inner) end,
                    AddParagraph = function(_, ...) Tab:AddParagraph(..., inner) end,
                })
            end
        end

        return Tab
    end

    return Window
end

return UI
