local IntroLib = {}

-- tween
local TweenService = game:GetService("TweenService")

-- play
function IntroLib:Play(Config)

Config = Config or {}

local TitleText = Config.Title or "hello"
local CreditText = Config.Credit or "credit"

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- gui
local Gui = Instance.new("ScreenGui")
Gui.Name = "IntroLib"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

-- bg
local BG = Instance.new("Frame")
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundColor3 = Color3.new(0,0,0)
BG.Parent = Gui

-- particles folder
local Particles = Instance.new("Folder")
Particles.Parent = BG

-- make particles
for i = 1,80 do

local Dot = Instance.new("Frame")

Dot.Size = UDim2.new(0,math.random(2,6),0,math.random(2,6))

Dot.Position = UDim2.new(
math.random(),
0,
math.random(),
0
)

Dot.BackgroundColor3 = Color3.fromRGB(200,200,200)

Dot.BorderSizePixel = 0

Dot.BackgroundTransparency = math.random(20,60)/100

Dot.Parent = Particles

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1,0)
Corner.Parent = Dot

-- animate
task.spawn(function()

while Dot.Parent do

local NewPos = UDim2.new(
math.random(),
0,
math.random(),
0
)

TweenService:Create(
Dot,
TweenInfo.new(math.random(10,20)),
{Position = NewPos}
):Play()

task.wait(math.random(10,20))

end

end)

end

-- title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.Position = UDim2.new(0,0,0.5,-25)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = TitleText
Title.TextSize = 28
Title.TextColor3 = Color3.new(1,1,1)
Title.TextTransparency = 1
Title.Parent = BG

-- credit
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1,0,0,30)
Credit.Position = UDim2.new(0,0,1,-40)
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.Gotham
Credit.Text = CreditText
Credit.TextSize = 16
Credit.TextColor3 = Color3.fromRGB(200,200,200)
Credit.TextTransparency = 1
Credit.Parent = BG

-- fade in title
TweenService:Create(
Title,
TweenInfo.new(1),
{TextTransparency = 0}
):Play()

-- fade in credit
TweenService:Create(
Credit,
TweenInfo.new(1),
{TextTransparency = 0}
):Play()

-- click close
BG.InputBegan:Connect(function(Input)

if Input.UserInputType == Enum.UserInputType.MouseButton1 then

TweenService:Create(
BG,
TweenInfo.new(1),
{BackgroundTransparency = 1}
):Play()

TweenService:Create(
Title,
TweenInfo.new(1),
{TextTransparency = 1}
):Play()

TweenService:Create(
Credit,
TweenInfo.new(1),
{TextTransparency = 1}
):Play()

task.wait(1)

Gui:Destroy()

end

end)

end

return IntroLib
