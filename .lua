-- Полная очистка интерфейса при перезапусках скрипта
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local playerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
if not playerGui then return end

if playerGui:FindFirstChild("MM2_Mobile_BlackMenu") then
    playerGui["MM2_Mobile_BlackMenu"]:Destroy()
end

-- Переменные управления
local espEnabled = false
local highlights = {}

-- Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2_Mobile_BlackMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- ГЛАВНОЕ ОКНО (Чисто черный цвет)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UIDim2.new(0, 330, 0, 220)
MainFrame.Position = UIDim2.new(0.5, -165, 0.3, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- Скрипт плавного перемещения (Drag) пальцем для мобильных (Замена устаревшему .Draggable)
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UIDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- ЗАГОЛОВОК
local Title = Instance.new("TextLabel")
Title.Size = UIDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Title.Text = "  MM2 BLACK MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- КНОПКА СВЕРНУТЬ [_]
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UIDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UIDim2.new(1, -60, 0, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MinimizeBtn.Text = "_"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.TextSize = 14
MinimizeBtn.Parent = MainFrame

-- ПЛАВАЮЩАЯ ИКОНКА (Появляется, когда меню скрыто)
local OpenIcon = Instance.new("TextButton")
OpenIcon.Name = "OpenIcon"
OpenIcon.Size = UIDim2.new(0, 50, 0, 50)
OpenIcon.Position = UIDim2.new(0.1, 0, 0.2, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
OpenIcon.BorderSizePixel = 1
OpenIcon.BorderColor3 = Color3.fromRGB(50, 50, 50)
OpenIcon.Text = "MM2"
OpenIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenIcon.Font = Enum.Font.SourceSansBold
OpenIcon.TextSize = 14
OpenIcon.Visible = false
OpenIcon.Parent = ScreenGui

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenIcon.Visible = true
end)

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenIcon.Visible = false
end)

-- КНОПКА ЗАКРЫТИЯ [X]
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UIDim2.new(0, 30, 0, 30)
CloseBtn.Position = UIDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- БАР ВКЛАДОК
local TabBar = Instance.new("Frame")
TabBar.Size = UIDim2.new(0, 95, 1, -30)
TabBar.Position = UIDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
TabBar.Parent = MainFrame

local TabESPBtn = Instance.new("TextButton")
TabESPBtn.Size = UIDim2.new(1, 0, 0, 40)
TabESPBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabESPBtn.Text = "ESP Роли"
TabESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabESPBtn.Font = Enum.Font.SourceSansBold
TabESPBtn.TextSize = 13
TabESPBtn.Parent = TabBar

local TabFlingBtn = Instance.new("TextButton")
TabFlingBtn.Size = UIDim2.new(1, 0, 0, 40)
TabFlingBtn.Position = UIDim2.new(0, 0, 0, 42)
TabFlingBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TabFlingBtn.Text = "Fling Меню"
TabFlingBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
TabFlingBtn.Font = Enum.Font.SourceSansBold
TabFlingBtn.TextSize = 13
TabFlingBtn.Parent = TabBar

-- СТРАНИЦЫ
local ContentESP = Instance.new("Frame")
ContentESP.Size = UIDim2.new(1, -105, 1, -40)
ContentESP.Position = UIDim2.new(0, 100, 0, 35)
ContentESP.BackgroundTransparency = 1
ContentESP.Visible = true
ContentESP.Parent = MainFrame

local ContentFling = Instance.new("Frame")
ContentFling.Size = UIDim2.new(1, -105, 1, -40)
ContentFling.Position = UIDim2.new(0, 100, 0, 35)
ContentFling.BackgroundTransparency = 1
ContentFling.Visible = false
ContentFling.Parent = MainFrame

TabESPBtn.MouseButton1Click:Connect(function()
    ContentESP.Visible = true
    ContentFling.Visible = false
    TabESPBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabFlingBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
end)

TabFlingBtn.MouseButton1Click:Connect(function()
    ContentESP.Visible = false
    ContentFling.Visible = true
    TabESPBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    TabFlingBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end)

---------------------------------------------------------
-- ИСПРАВЛЕННАЯ ЛОГИКА ОПРЕДЕЛЕНИЯ РОЛЕЙ И ФУНКЦИЙ MM2
---------------------------------------------------------
local function getPlayerRole(p)
    if not p or not p:FindFirstChild("Backpack") or not p.Character then return "Innocent" end
    
    if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then 
        return "Murderer" 
    end
    
    local gun = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
    if gun then
        -- Проверка на подбор оружия (Герой): во многих версиях модов MM2 ставится тег FakeGun или Claimed
        if p:FindFirstChild("FakeGun") or gun:FindFirstChild("Claimed") or p:FindFirstChild("Gold") or gun.Name == "HeroGun" then
            return "Hero"
        else 
            return "Sheriff" 
        end
    end
    return "Innocent"
end

local function updateESP()
    if not espEnabled then
        for _, h in pairs(highlights) do if h then h:Destroy() end end
        table.clear(highlights)
        return
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local char = player.Character
            local role = getPlayerRole(player)
            local highlight = char:FindFirstChild("MM2_Highlight")
            
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "MM2_Highlight"
                highlight.Parent = char
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0.3
                highlight.FillTransparency = 0.4
                highlights[player.Name] = highlight
            end
            
            -- Четкое соответствие цветам из ТЗ:
            if role == "Murderer" then 
                highlight.FillColor = Color3.fromRGB(255, 0, 0)       -- Красный
            elseif role == "Sheriff" then 
                highlight.FillColor = Color3.fromRGB(0, 0, 255)       -- Синий
            elseif role == "Hero" then 
                highlight.FillColor = Color3.fromRGB(255, 255, 0)     -- Желтый
            else 
                highlight.FillColor = Color3.fromRGB(0, 255, 0)       -- Зеленый
            end
        end
    end
end

-- Безопасный и мощный Fling без багов смерти персонажа
local function killFling(targetRole)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if getPlayerRole(player) == targetRole then
                local targetHRP = player.Character.HumanoidRootPart
                local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local localHumanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                
                if localHRP and localHumanoid then
                    local oldPos = localHRP.CFrame
                    
                    -- Отключаем коллизию персонажа на время флинга, чтобы не умереть вместе с целью
                    local desc = LocalPlayer.Character:GetDescendants()
                    for _, v in pairs(desc) do
                        if v:IsA("BasePart") then v.CanCollide = false end
                    end
                    
                    -- Прикладываем огромную угловую скорость вращения
                    local bV = Instance.new("BodyAngularVelocity")
                    bV.AngularVelocity = Vector3.new(0, 999999, 0)
                    bV.MaxTorque = Vector3.new(0, 999999, 0)
                    bV.Parent = localHRP
                    
                    -- Удержание на цели для гарантированного вылета игрока
