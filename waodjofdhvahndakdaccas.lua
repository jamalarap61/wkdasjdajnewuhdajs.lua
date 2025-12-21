
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

local UI = {}
UI.__index = UI

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
    Main.Parent = ScreenGui
    Main.Active = true
    corner(Main,12)

    -- Topbar
    local Top = Instance.new("Frame")
    Top.Size = UDim2.new(1,0,0,45)
    Top.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Top.BorderSizePixel = 0
    Top.Parent = Main
    Top.Active = true
    corner(Top,12)

    local Title = Instance.new("TextLabel")
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,-120,1,0)
    Title.Position = UDim2.new(0,12,0,0)
    Title.Text = title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Left
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Parent = Top

    -- Tab Buttons
    local TabsBar = Instance.new("Frame")
    TabsBar.Size = UDim2.new(0,120,1,-45)
    TabsBar.Position = UDim2.new(0,0,0,45)
    TabsBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    TabsBar.BorderSizePixel = 0
    TabsBar.Parent = Main

    local TabsLayout = Instance.new("UIListLayout", TabsBar)
    TabsLayout.Padding = UDim.new(0,6)
    padding(TabsBar,6)

    -- Content Holder
    local Pages = Instance.new("Frame")
    Pages.Size = UDim2.new(1,-130,1,-55)
    Pages.Position = UDim2.new(0,125,0,50)
    Pages.BackgroundTransparency = 1
    Pages.Parent = Main

    -- Drag
    local dragging, startPos, dragStart
    Top.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == MouseMovement or i.UserInputType == Touch) then
            local d = i.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,startPos.X.Offset + d.X,
                startPos.Y.Scale,startPos.Y.Offset + d.Y
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
        Page.Parent = Pages
        Page.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", Page)
        layout.Padding = UDim.new(0,8)
        padding(Page,8)

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
        -- ELEMENTS
        --========================
        function Tab:AddParagraph(title, text)
            local f = Instance.new("Frame", Page)
            f.BackgroundColor3 = Color3.fromRGB(40,40,40)
            f.Size = UDim2.new(1,0,0,60)
            corner(f,8)

            local t = Instance.new("TextLabel", f)
            t.Text = title
            t.Font = Enum.Font.GothamBold
            t.TextSize = 14
            t.TextColor3 = Color3.new(1,1,1)
            t.BackgroundTransparency = 1
            t.Size = UDim2.new(1,-10,0,20)
            t.Position = UDim2.new(0,6,0,4)

            local d = Instance.new("TextLabel", f)
            d.Text = text
            d.Font = Enum.Font.Gotham
            d.TextSize = 13
            d.TextWrapped = true
            d.TextColor3 = Color3.fromRGB(200,200,200)
            d.BackgroundTransparency = 1
            d.Position = UDim2.new(0,6,0,24)
            d.Size = UDim2.new(1,-10,0,30)
        end

        function Tab:AddToggle(text, default, callback)
            local val = default or false

            local btn = Instance.new("TextButton", Page)
            btn.Size = UDim2.new(1,0,0,40)
            btn.Text = text .. " : " .. (val and "ON" or "OFF")
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = val and Color3.fromRGB(60,120,60) or Color3.fromRGB(45,45,45)
            corner(btn,8)

            btn.MouseButton1Click:Connect(function()
                val = not val
                btn.Text = text .. " : " .. (val and "ON" or "OFF")
                btn.BackgroundColor3 = val and Color3.fromRGB(60,120,60) or Color3.fromRGB(45,45,45)
                if callback then pcall(callback,val) end
            end)
        end

        function Tab:AddButton(text, callback)
            local btn = Instance.new("TextButton", Page)
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

        function Tab:AddSection(text)
            local l = Instance.new("TextLabel", Page)
            l.Size = UDim2.new(1,0,0,24)
            l.Text = text
            l.Font = Enum.Font.GothamBold
            l.TextSize = 13
            l.TextColor3 = Color3.fromRGB(180,180,180)
            l.BackgroundTransparency = 1
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
            btn.Text = text .. " >"
            btn.BackgroundTransparency = 1
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)

            local inner = Instance.new("Frame", holder)
            inner.Position = UDim2.new(0,0,0,40)
            inner.Size = UDim2.new(1,0,0,0)
            inner.BackgroundTransparency = 1

            local lay = Instance.new("UIListLayout", inner)
            lay.Padding = UDim.new(0,6)
            padding(inner,6)

            lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if open then
                    holder.Size = UDim2.new(1,0,0,40 + lay.AbsoluteContentSize.Y + 8)
                    inner.Size = UDim2.new(1,0,0,lay.AbsoluteContentSize.Y)
                end
            end)

            btn.MouseButton1Click:Connect(function()
                open = not open
                btn.Text = text .. (open and " v" or " >")
                if open then
                    inner.Size = UDim2.new(1,0,0,lay.AbsoluteContentSize.Y)
                    holder.Size = UDim2.new(1,0,0,40 + lay.AbsoluteContentSize.Y + 8)
                else
                    holder.Size = UDim2.new(1,0,0,40)
                end
            end)

            if build then
                local proxy = {}
                function proxy:AddToggle(...)
                    Tab.AddToggle({Page = inner}, ...)
                end
                function proxy:AddButton(...)
                    Tab.AddButton({Page = inner}, ...)
                end
                build(proxy)
            end
        end

        return Tab
    end

    return Window
end

return UI
