--// SIMPLE CUSTOM UI FRAMEWORK
--// XENO EXECUTOR + ANDROID SAFE

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
--v0.4
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
    Main.Size = UDim2.new(0,480,0,300)
    Main.Position = UDim2.fromScale(0.5,0.5)
    Main.AnchorPoint = Vector2.new(0.5,0.5)
    Main.Position = UDim2.fromScale(0.05,0.2)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Main.Active = true
    corner(Main,12)

    --========================
    -- TOPBAR
    --========================
    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1,0,0,45)
    Top.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Top.BorderSizePixel = 0
    Top.Active = true
    corner(Top,12)

    local Title = Instance.new("TextLabel", Top)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,-120,1,0)
    Title.Position = UDim2.new(0,12,0,0)
    Title.Text = title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextColor3 = Color3.new(1,1,1)

    -- Buttons
    local BtnHolder = Instance.new("Frame", Top)
    BtnHolder.Size = UDim2.new(0,70,1,0)
    BtnHolder.Position = UDim2.new(1,-75,0,0)
    BtnHolder.BackgroundTransparency = 1

    local function makeTopBtn(text)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0,30,0,24)
        b.BackgroundColor3 = Color3.fromRGB(55,55,55)
        b.Text = text
        b.Font = Enum.Font.GothamBold
        b.TextSize = 14
        b.TextColor3 = Color3.new(1,1,1)
        corner(b,6)
        return b
    end

    local MinBtn = makeTopBtn("_")
    MinBtn.Position = UDim2.new(0,0,0.5,-12)
    MinBtn.Parent = BtnHolder

    local CloseBtn = makeTopBtn("X")
    CloseBtn.Position = UDim2.new(0,35,0.5,-12)
    CloseBtn.Parent = BtnHolder

    --========================
    -- TAB BAR
    --========================
    local TabsBar = Instance.new("Frame", Main)
    TabsBar.Size = UDim2.new(0,120,1,-45)
    TabsBar.Position = UDim2.new(0,0,0,45)
    TabsBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    TabsBar.BorderSizePixel = 0

    local TabsLayout = Instance.new("UIListLayout", TabsBar)
    TabsLayout.Padding = UDim.new(0,6)
    padding(TabsBar,6)

    -- Pages
    local Pages = Instance.new("Frame", Main)
    Pages.Size = UDim2.new(1,-130,1,-55)
    Pages.Position = UDim2.new(0,125,0,50)
    Pages.BackgroundTransparency = 1

    --========================
    -- DRAG
    --========================
    local dragging, dragStart, startPos
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

    -- Minimize / Close
    local minimized = false
    local oldSize = Main.Size

    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        TabsBar.Visible = not minimized
        Pages.Visible = not minimized
        Main.Size = minimized and UDim2.new(oldSize.X.Scale, oldSize.X.Offset, 0, 45) or oldSize
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local Window = {}
    Window.Tabs = {}

    --========================
    -- TAB
    --========================
    function Window:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabsBar)
        TabBtn.Size = UDim2.new(1,0,0,36)
        TabBtn.Text = name
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 14
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        corner(TabBtn,6)

        local Page = Instance.new("ScrollingFrame", Pages)
        Page.Size = UDim2.new(1,0,1,0)
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarThickness = 3
        Page.Visible = false
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
            f.Size = UDim2.new(1,0,0,60)
            f.BackgroundColor3 = Color3.fromRGB(40,40,40)
            corner(f,8)

            local t = Instance.new("TextLabel", f)
            t.Text = title
            t.Font = Enum.Font.GothamBold
            t.TextSize = 14
            t.TextColor3 = Color3.new(1,1,1)
            t.BackgroundTransparency = 1
            t.Position = UDim2.new(0,6,0,4)
            t.Size = UDim2.new(1,-10,0,20)

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

        -- SLIDER TOGGLE
        function Tab:AddToggle(text, default, callback)
            local val = default == true

            local holder = Instance.new("Frame", Page)
            holder.Size = UDim2.new(1,0,0,40)
            holder.BackgroundColor3 = Color3.fromRGB(45,45,45)
            corner(holder,8)

            local label = Instance.new("TextLabel", holder)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1,-60,1,0)
            label.Position = UDim2.new(0,10,0,0)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Text = text
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextColor3 = Color3.new(1,1,1)

            local toggle = Instance.new("Frame", holder)
            toggle.Size = UDim2.new(0,36,0,18)
            toggle.Position = UDim2.new(1,-46,0.5,-9)
            toggle.BackgroundColor3 = Color3.fromRGB(35,35,35)
            corner(toggle,9)

            local knob = Instance.new("Frame", toggle)
            knob.Size = UDim2.new(0,14,0,14)
            corner(knob,7)

            local function refresh()
                knob.Position = val and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)
                knob.BackgroundColor3 = val and Color3.fromRGB(80,200,80) or Color3.fromRGB(180,180,180)
            end
            refresh()

            holder.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1
                or i.UserInputType == Enum.UserInputType.Touch then
                    val = not val
                    refresh()
                    if callback then pcall(callback,val) end
                end
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

        return Tab
    end

    return Window
end

return UI
