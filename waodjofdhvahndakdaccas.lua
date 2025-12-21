--// XENO UI LIBRARY FINAL
--// Android Friendly | Minimize + Close | NO ERROR

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
--v1.2

local UI = {}
UI.__index = UI

--================ UTIL ================
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

--================ WINDOW ================
function UI:CreateWindow(title)
    pcall(function()
        LP.PlayerGui:FindFirstChild("XenoUI"):Destroy()
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "XenoUI"
    gui.ResetOnSpawn = false
    gui.Parent = LP.PlayerGui

    local Main = Instance.new("Frame", gui)
    Main.Size = UDim2.new(0,480,0,300)
    Main.Position = UDim2.fromScale(0.5,0.5)
    Main.AnchorPoint = Vector2.new(0.5,0.5)
    Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Main.BorderSizePixel = 0
    Main.Active = true
    corner(Main,12)

    --================ TOPBAR =================
    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1,0,0,40)
    Top.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Top.BorderSizePixel = 0
    Top.Active = true
    corner(Top,12)

    local Title = Instance.new("TextLabel", Top)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1,-80,1,0)
    Title.Position = UDim2.new(0,10,0,0)
    Title.Text = title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextColor3 = Color3.new(1,1,1)

    local MinBtn = Instance.new("TextButton", Top)
    MinBtn.Size = UDim2.new(0,30,0,30)
    MinBtn.Position = UDim2.new(1,-70,0.5,-15)
    MinBtn.Text = "—"
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    MinBtn.TextColor3 = Color3.new(1,1,1)
    corner(MinBtn,6)

    local CloseBtn = Instance.new("TextButton", Top)
    CloseBtn.Size = UDim2.new(0,30,0,30)
    CloseBtn.Position = UDim2.new(1,-35,0.5,-15)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.BackgroundColor3 = Color3.fromRGB(150,60,60)
    CloseBtn.TextColor3 = Color3.new(1,1,1)
    corner(CloseBtn,6)

    --================ BODY =================
    local Body = Instance.new("Frame", Main)
    Body.Position = UDim2.new(0,0,0,40)
    Body.Size = UDim2.new(1,0,1,-40)
    Body.BackgroundTransparency = 1

    local TabsBar = Instance.new("Frame", Body)
    TabsBar.Size = UDim2.new(0,120,1,0)
    TabsBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    TabsBar.BorderSizePixel = 0

    local tabLayout = Instance.new("UIListLayout", TabsBar)
    tabLayout.Padding = UDim.new(0,6)
    padding(TabsBar,6)

    local Pages = Instance.new("Frame", Body)
    Pages.Size = UDim2.new(1,-130,1,-10)
    Pages.Position = UDim2.new(0,125,0,5)
    Pages.BackgroundTransparency = 1

    --================ DRAG =================
    local dragging, dStart, sPos
    Top.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dStart = i.Position
            sPos = Main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - dStart
            Main.Position = UDim2.new(sPos.X.Scale,sPos.X.Offset+d.X,sPos.Y.Scale,sPos.Y.Offset+d.Y)
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        Body.Visible = not minimized
        Main.Size = minimized and UDim2.new(0,480,0,40) or UDim2.new(0,480,0,300)
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    local Window = {Tabs = {}}

    function Window:CreateTab(name)
        local btn = Instance.new("TextButton", TabsBar)
        btn.Size = UDim2.new(1,0,0,34)
        btn.Text = name
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        corner(btn,6)

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
            Page.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
        end)

        btn.MouseButton1Click:Connect(function()
            for _,t in pairs(Window.Tabs) do
                t.Page.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(45,45,45)
            end
            Page.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        end)

        if #Window.Tabs == 0 then
            Page.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        end

        local Tab = {Page=Page,Button=btn}
        table.insert(Window.Tabs, Tab)

        --=========== ELEMENTS ===========

        function Tab:AddParagraph(title,text)
            local f = Instance.new("Frame",Page)
            f.Size = UDim2.new(1,0,0,60)
            f.BackgroundColor3 = Color3.fromRGB(40,40,40)
            corner(f,8)

            local t = Instance.new("TextLabel",f)
            t.Size = UDim2.new(1,-10,0,20)
            t.Position = UDim2.new(0,6,0,4)
            t.Text = title
            t.Font = Enum.Font.GothamBold
            t.TextSize = 14
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.BackgroundTransparency = 1
            t.TextColor3 = Color3.new(1,1,1)

            local d = Instance.new("TextLabel",f)
            d.Size = UDim2.new(1,-10,0,30)
            d.Position = UDim2.new(0,6,0,24)
            d.TextWrapped = true
            d.Text = text
            d.Font = Enum.Font.Gotham
            d.TextSize = 13
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.BackgroundTransparency = 1
            d.TextColor3 = Color3.fromRGB(200,200,200)
        end

        function Tab:AddToggle(text,default,cb)
            local val = default or false
            local holder = Instance.new("Frame",Page)
            holder.Size = UDim2.new(1,0,0,40)
            holder.BackgroundColor3 = Color3.fromRGB(45,45,45)
            corner(holder,8)

            local lbl = Instance.new("TextLabel",holder)
            lbl.Size = UDim2.new(1,-60,1,0)
            lbl.Position = UDim2.new(0,10,0,0)
            lbl.Text = text
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.BackgroundTransparency = 1
            lbl.TextColor3 = Color3.new(1,1,1)

            local sw = Instance.new("TextButton",holder)
            sw.Size = UDim2.new(0,40,0,20)
            sw.Position = UDim2.new(1,-50,0.5,-10)
            sw.BackgroundColor3 = val and Color3.fromRGB(80,160,80) or Color3.fromRGB(90,90,90)
            sw.Text = ""
            corner(sw,20)

            local dot = Instance.new("Frame",sw)
            dot.Size = UDim2.new(0,18,0,18)
            dot.Position = val and UDim2.new(1,-19,0,1) or UDim2.new(0,1,0,1)
            dot.BackgroundColor3 = Color3.new(1,1,1)
            corner(dot,20)

            sw.MouseButton1Click:Connect(function()
                val = not val
                sw.BackgroundColor3 = val and Color3.fromRGB(80,160,80) or Color3.fromRGB(90,90,90)
                dot.Position = val and UDim2.new(1,-19,0,1) or UDim2.new(0,1,0,1)
                if cb then pcall(cb,val) end
            end)
        end

        function Tab:AddButton(text, callback)
            local btn = Instance.new("TextButton",Page)
            btn.Size = UDim2.new(1, 0, 0, 38)
            btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
            btn.Text = text
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextColor3 = Color3.new(1,1,1)
            corner(btn, 8)
            btn.MouseButton1Click:Connect(function()
                if callback then pcall(callback) end
            end)
        end

        function Tab:AddSection(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,0,26)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(180,180,180)

    -- Parent ke Page
    lbl.Parent = Page

    -- SET POSITION DI DEPAN SEMUA ELEMEN LAIN
    local layout = Page:FindFirstChildOfClass("UIListLayout")
    if layout then
        lbl.LayoutOrder = (layout:GetChildren()[1] and layout:GetChildren()[1].LayoutOrder or 0) - 1
    else
        lbl.LayoutOrder = 0
    end
end


        function Tab:AddInput(text,default,cb)
            local f = Instance.new("Frame",Page)
            f.Size = UDim2.new(1,0,0,40)
            f.BackgroundColor3 = Color3.fromRGB(45,45,45)
            corner(f,8)

            local lbl = Instance.new("TextLabel",f)
            lbl.Size = UDim2.new(0.4,0,1,0)
            lbl.Position = UDim2.new(0,10,0,0)
            lbl.Text = text
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.BackgroundTransparency = 1
            lbl.TextColor3 = Color3.new(1,1,1)

            local box = Instance.new("TextBox",f)
            box.Size = UDim2.new(0.5,0,0,26)
            box.Position = UDim2.new(0.5,0,0.5,-13)
            box.Text = default or ""
            box.Font = Enum.Font.Gotham
            box.TextSize = 14
            box.BackgroundColor3 = Color3.fromRGB(35,35,35)
            box.TextColor3 = Color3.new(1,1,1)
            corner(box,6)

            box.FocusLost:Connect(function()
                if cb then pcall(cb,box.Text) end
            end)
        end

        return Tab
    end

    return Window
end

return UI
