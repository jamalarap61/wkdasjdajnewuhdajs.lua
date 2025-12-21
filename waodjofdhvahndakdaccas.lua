--// LimitHub Simple UI Library (Xeno Safe)
local UI = {}
UI.__index = UI
--v0.5
-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Utils
local function corner(o,r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,r)
    c.Parent = o
end

local function padding(o,p)
    local pd = Instance.new("UIPadding")
    pd.PaddingTop = UDim.new(0,p)
    pd.PaddingBottom = UDim.new(0,p)
    pd.PaddingLeft = UDim.new(0,p)
    pd.PaddingRight = UDim.new(0,p)
    pd.Parent = o
end

-- Window
function UI:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LimitHubUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 480, 0, 300) -- << SIZE
    Main.Position = UDim2.new(0.5,-240,0.5,-150)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    corner(Main,10)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,36)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Color3.new(1,1,1)

    local Tabs = Instance.new("Frame", Main)
    Tabs.Position = UDim2.new(0,0,0,36)
    Tabs.Size = UDim2.new(0,120,1,-36)
    Tabs.BackgroundColor3 = Color3.fromRGB(30,30,30)
    corner(Tabs,8)
    padding(Tabs,6)

    local TabList = Instance.new("UIListLayout", Tabs)
    TabList.Padding = UDim.new(0,6)

    local Pages = Instance.new("Frame", Main)
    Pages.Position = UDim2.new(0,130,0,36)
    Pages.Size = UDim2.new(1,-140,1,-46)
    Pages.BackgroundTransparency = 1

    local window = {}

    function window:CreateTab(name)
        local TabBtn = Instance.new("TextButton", Tabs)
        TabBtn.Size = UDim2.new(1,0,0,32)
        TabBtn.Text = name
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.TextSize = 13
        TabBtn.TextColor3 = Color3.new(1,1,1)
        TabBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        corner(TabBtn,6)

        local Page = Instance.new("ScrollingFrame", Pages)
        Page.Size = UDim2.new(1,0,1,0)
        Page.ScrollBarImageTransparency = 1
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.Visible = false
        padding(Page,6)

        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0,6)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            for _,v in ipairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
        end)

        if not Pages:FindFirstChildWhichIsA("ScrollingFrame") then
            Page.Visible = true
        end

        local Tab = {}

        function Tab:AddParagraph(title, desc)
            local box = Instance.new("Frame", Page)
            box.Size = UDim2.new(1,0,0,60)
            box.BackgroundColor3 = Color3.fromRGB(40,40,40)
            corner(box,6)
            padding(box,6)

            local t = Instance.new("TextLabel", box)
            t.Size = UDim2.new(1,0,0,18)
            t.BackgroundTransparency = 1
            t.Text = title
            t.Font = Enum.Font.GothamBold
            t.TextSize = 13
            t.TextColor3 = Color3.new(1,1,1)
            t.TextXAlignment = Left

            local d = Instance.new("TextLabel", box)
            d.Position = UDim2.new(0,0,0,22)
            d.Size = UDim2.new(1,0,1,-22)
            d.BackgroundTransparency = 1
            d.TextWrapped = true
            d.TextYAlignment = Top
            d.Text = desc
            d.Font = Enum.Font.Gotham
            d.TextSize = 12
            d.TextColor3 = Color3.fromRGB(200,200,200)
            d.TextXAlignment = Left
        end

        function Tab:AddSection(text)
            local lbl = Instance.new("TextLabel", Page)
            lbl.Size = UDim2.new(1,0,0,20)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 13
            lbl.TextColor3 = Color3.fromRGB(180,180,180)
            lbl.TextXAlignment = Left
        end

        function Tab:AddButton(text, cb)
            local btn = Instance.new("TextButton", Page)
            btn.Size = UDim2.new(1,0,0,32)
            btn.Text = text
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 13
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
            corner(btn,6)
            btn.MouseButton1Click:Connect(function()
                if cb then cb() end
            end)
        end

        function Tab:AddToggle(text, default, cb)
            local state = default or false

            local frame = Instance.new("Frame", Page)
            frame.Size = UDim2.new(1,0,0,32)
            frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
            corner(frame,6)
            padding(frame,6)

            local lbl = Instance.new("TextLabel", frame)
            lbl.Size = UDim2.new(1,-50,1,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 13
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.TextXAlignment = Left

            local tog = Instance.new("TextButton", frame)
            tog.Size = UDim2.new(0,36,0,18)
            tog.Position = UDim2.new(1,-40,0.5,-9)
            tog.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(80,80,80)
            corner(tog,9)
            tog.Text = ""

            tog.MouseButton1Click:Connect(function()
                state = not state
                tog.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(80,80,80)
                if cb then cb(state) end
            end)
        end

        function Tab:AddInput(text, placeholder, cb)
            local frame = Instance.new("Frame", Page)
            frame.Size = UDim2.new(1,0,0,36)
            frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
            corner(frame,6)
            padding(frame,6)

            local lbl = Instance.new("TextLabel", frame)
            lbl.Size = UDim2.new(0.4,0,1,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 13
            lbl.TextColor3 = Color3.new(1,1,1)
            lbl.TextXAlignment = Left

            local box = Instance.new("TextBox", frame)
            box.Position = UDim2.new(0.4,6,0,0)
            box.Size = UDim2.new(0.6,-6,1,0)
            box.Text = ""
            box.PlaceholderText = placeholder or ""
            box.Font = Enum.Font.Gotham
            box.TextSize = 13
            box.TextColor3 = Color3.new(1,1,1)
            box.BackgroundColor3 = Color3.fromRGB(60,60,60)
            corner(box,6)

            box.FocusLost:Connect(function()
                if cb then cb(box.Text) end
            end)
        end

        function Tab:AddCollapse(title, builder)
            local open = false

            local btn = Instance.new("TextButton", Page)
            btn.Size = UDim2.new(1,0,0,32)
            btn.Text = "▶ "..title
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 13
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            corner(btn,6)

            local cont = Instance.new("Frame", Page)
            cont.Size = UDim2.new(1,0,0,0)
            cont.BackgroundTransparency = 1
            cont.ClipsDescendants = true

            local lay = Instance.new("UIListLayout", cont)
            lay.Padding = UDim.new(0,6)

            lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if open then
                    cont.Size = UDim2.new(1,0,0,lay.AbsoluteContentSize.Y)
                end
            end)

            local sec = {}
            function sec:AddToggle(...) Tab.AddToggle(sec, ...) end
            function sec:AddButton(...) Tab.AddButton(sec, ...) end
            function sec:AddInput(...) Tab.AddInput(sec, ...) end
            function sec:AddParagraph(...) Tab.AddParagraph(sec, ...) end

            setmetatable(sec,{
                __index = function(_,k)
                    return function(...)
                        return Tab[k](Tab,...)
                    end
                end
            })

            if builder then
                local old = Page
                Page = cont
                builder(sec)
                Page = old
            end

            btn.MouseButton1Click:Connect(function()
                open = not open
                btn.Text = (open and "▼ " or "▶ ")..title
                cont.Size = open and UDim2.new(1,0,0,lay.AbsoluteContentSize.Y) or UDim2.new(1,0,0,0)
            end)
        end

        return Tab
    end

    return window
end

return UI
