local IntroLib = {}

local TweenService = game:GetService("TweenService")

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

-- background
local BG = Instance.new("Frame")
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundColor3 = Color3.new(0,0,0)
BG.Parent = Gui

-- snow folder
local SnowFolder = Instance.new("Folder")
SnowFolder.Parent = BG

-- make snow
for i = 1,60 do

local Snow = Instance.new("ImageLabel")

Snow.Image = "rbxassetid://94938365473619"

local Size = math.random(5,15)

Snow.Size = UDim2.new(0,Size,0,Size)

Snow.Position = UDim2.new(
math.random(),
0,
math.random(-1,0),
0
)

Snow.BackgroundTransparency = 1
Snow.ImageTransparency = math.random(20,60)/100

Snow.Parent = SnowFolder


-- falling loop
task.spawn(function()

while Snow.Parent do

Snow.Position = UDim2.new(
math.random(),
0,
-0.1,
0
)

local Speed = math.random(8,15)

TweenService:Create(

Snow,

TweenInfo.new(Speed, Enum.EasingStyle.Linear),

{

Position = UDim2.new(

Snow.Position.X.Scale,

0,

1.1,

0

)

}

):Play()

task.wait(Speed)

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


-- fade in
TweenService:Create(
Title,
TweenInfo.new(1),
{TextTransparency = 0}
):Play()

TweenService:Create(
Credit,
TweenInfo.new(1),
{TextTransparency = 0}
):Play()


-- click close
BG.InputBegan:Connect(function(Input)

if Input.UserInputType == Enum.UserInputType.MouseButton1 then

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

TweenService:Create(
BG,
TweenInfo.new(1),
{BackgroundTransparency = 1}
):Play()

task.wait(1)

Gui:Destroy()

end

end)

end

return IntroLib
