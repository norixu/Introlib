local IntroLib = {}

-- tween service
local TweenService = game:GetService("TweenService")

-- lighting
local Lighting = game:GetService("Lighting")

-- play intro
function IntroLib:Play(Config)

-- config
Config = Config or {}

local LogoImage = Config.Logo or ""
local TitleText = Config.Title or "GAME"
local ContinueText = Config.ContinueText or "CLICK TO CONTINUE"

-- player
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- blur
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

-- gui
local Gui = Instance.new("ScreenGui")
Gui.Name = "IntroLib"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

-- background
local BG = Instance.new("Frame")
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
BG.BackgroundTransparency = 1
BG.Parent = Gui

-- top bar
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,0)
Top.BackgroundColor3 = Color3.new(0,0,0)
Top.BorderSizePixel = 0
Top.Parent = BG

-- bottom bar
local Bottom = Top:Clone()
Bottom.Position = UDim2.new(0,0,1,0)
Bottom.AnchorPoint = Vector2.new(0,1)
Bottom.Parent = BG

-- icon
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0,200,0,200)
Logo.Position = UDim2.new(0.5,0,0.5,0)
Logo.AnchorPoint = Vector2.new(0.5,0.5)
Logo.BackgroundTransparency = 1
Logo.Image = LogoImage
Logo.ImageTransparency = 1
Logo.Parent = BG

-- title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0,600,0,50)
Title.Position = UDim2.new(0.5,0,0.5,130)
Title.AnchorPoint = Vector2.new(0.5,0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = TitleText
Title.TextSize = 36
Title.TextColor3 = Color3.new(1,1,1)
Title.TextTransparency = 1
Title.Parent = BG

-- continue
local Continue = Instance.new("TextLabel")
Continue.Size = UDim2.new(0,400,0,30)
Continue.Position = UDim2.new(0.5,0,1,-60)
Continue.AnchorPoint = Vector2.new(0.5,0.5)
Continue.BackgroundTransparency = 1
Continue.Font = Enum.Font.Gotham
Continue.Text = ContinueText
Continue.TextSize = 18
Continue.TextColor3 = Color3.fromRGB(200,200,200)
Continue.TextTransparency = 1
Continue.Parent = BG


-- fade bg
TweenService:Create(
BG,
TweenInfo.new(1),
{BackgroundTransparency = 0}
):Play()

-- blur in
TweenService:Create(
Blur,
TweenInfo.new(1),
{Size = 24}
):Play()

-- bars in
TweenService:Create(
Top,
TweenInfo.new(1),
{Size = UDim2.new(1,0,0,60)}
):Play()

TweenService:Create(
Bottom,
TweenInfo.new(1),
{Size = UDim2.new(1,0,0,60)}
):Play()

task.wait(.5)

-- icon fade
TweenService:Create(
Logo,
TweenInfo.new(1),
{ImageTransparency = 0}
):Play()

-- icon zoom
TweenService:Create(
Logo,
TweenInfo.new(2,Enum.EasingStyle.Quint),
{Size = UDim2.new(0,260,0,260)}
):Play()

-- icon spin
TweenService:Create(
Logo,
TweenInfo.new(3,Enum.EasingStyle.Quint),
{Rotation = 360}
):Play()

task.wait(1)

-- title show
TweenService:Create(
Title,
TweenInfo.new(1),
{TextTransparency = 0}
):Play()

task.wait(.5)

-- continue show
TweenService:Create(
Continue,
TweenInfo.new(1),
{TextTransparency = 0}
):Play()

-- pulse loop
task.spawn(function()

while Gui.Parent do

TweenService:Create(
Logo,
TweenInfo.new(1),
{Size = UDim2.new(0,270,0,270)}
):Play()

task.wait(1)

TweenService:Create(
Logo,
TweenInfo.new(1),
{Size = UDim2.new(0,260,0,260)}
):Play()

task.wait(1)

end

end)

-- click close
BG.InputBegan:Connect(function(Input)

if Input.UserInputType == Enum.UserInputType.MouseButton1 then

TweenService:Create(
BG,
TweenInfo.new(1),
{BackgroundTransparency = 1}
):Play()

TweenService:Create(
Blur,
TweenInfo.new(1),
{Size = 0}
):Play()

TweenService:Create(
Logo,
TweenInfo.new(1),
{ImageTransparency = 1}
):Play()

TweenService:Create(
Title,
TweenInfo.new(1),
{TextTransparency = 1}
):Play()

TweenService:Create(
Continue,
TweenInfo.new(1),
{TextTransparency = 1}
):Play()

task.wait(1)

Blur:Destroy()
Gui:Destroy()

end

end)

end

function IntroLib:Skip()

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("IntroLib") then

game.Players.LocalPlayer.PlayerGui.IntroLib:Destroy()

end

end

return IntroLib
