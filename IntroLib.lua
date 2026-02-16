local IntroLib = {}

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

function IntroLib:Play(Config)

Config = Config or {}

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local FadeTime = Config.FadeTime or 1
local Duration = Config.Duration

local Closed = false

local Gui = Instance.new("ScreenGui")
Gui.Name = "IntroLib"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.fromScale(1,1)
Background.BackgroundColor3 = Config.BackgroundColor or Color3.new(0,0,0)
Background.BackgroundTransparency = Config.BackgroundTransparency or 0
Background.Parent = Gui

local Blur

if Config.Blur then

Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

TweenService:Create(
Blur,
TweenInfo.new(FadeTime),
{
Size = Config.BlurSize or 24
}
):Play()

end

local Logo

if Config.Logo then

Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Image = Config.Logo
Logo.AnchorPoint = Vector2.new(.5,.5)
Logo.Position = Config.LogoPosition or UDim2.fromScale(.5,.35)
Logo.Size = Config.LogoSize or UDim2.fromOffset(140,140)
Logo.BackgroundTransparency = 1
Logo.ImageTransparency = Config.LogoTransparency or 1
Logo.Parent = Background

if Config.LogoCornerRadius then

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,Config.LogoCornerRadius)
Corner.Parent = Logo

end

if Config.LogoStroke then

local Stroke = Instance.new("UIStroke")
Stroke.Color = Config.LogoStroke
Stroke.Thickness = Config.LogoStrokeThickness or 2
Stroke.Parent = Logo

end

TweenService:Create(
Logo,
TweenInfo.new(FadeTime),
{
ImageTransparency = 0
}
):Play()

if Config.LogoAnimation == "Spin" then

task.spawn(function()

while not Closed do

Logo.Rotation += Config.LogoSpinSpeed or 1

task.wait()

end

end)

end

if Config.LogoAnimation == "Pulse" then

local BaseSize = Logo.Size

task.spawn(function()

while not Closed do

TweenService:Create(
Logo,
TweenInfo.new(.8),
{
Size = BaseSize + UDim2.fromOffset(10,10)
}
):Play()

task.wait(.8)

TweenService:Create(
Logo,
TweenInfo.new(.8),
{
Size = BaseSize
}
):Play()

task.wait(.8)

end

end)

end

end

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(.5,.5)
Title.Position = UDim2.fromScale(.5,.55)
Title.Size = UDim2.fromScale(1,0)
Title.BackgroundTransparency = 1
Title.Font = Config.TitleFont or Enum.Font.GothamBold
Title.Text = Config.Title or ""
Title.TextSize = Config.TitleSize or 40
Title.TextColor3 = Config.TitleColor or Color3.new(1,1,1)
Title.TextTransparency = 1
Title.Parent = Background

TweenService:Create(
Title,
TweenInfo.new(FadeTime),
{
TextTransparency = 0
}
):Play()

local Continue = Instance.new("TextLabel")
Continue.Name = "Continue"
Continue.AnchorPoint = Vector2.new(.5,.5)
Continue.Position = UDim2.fromScale(.5,.9)
Continue.Size = UDim2.fromScale(1,0)
Continue.BackgroundTransparency = 1
Continue.Font = Config.ContinueFont or Enum.Font.Gotham
Continue.Text = Config.ContinueText or ""
Continue.TextSize = Config.ContinueSize or 18
Continue.TextColor3 = Config.ContinueColor or Color3.fromRGB(200,200,200)
Continue.TextTransparency = 1
Continue.Parent = Background

TweenService:Create(
Continue,
TweenInfo.new(FadeTime),
{
TextTransparency = 0
}
):Play()

local ProgressBar

if Config.ProgressBar then

local Holder = Instance.new("Frame")
Holder.Name = "ProgressHolder"
Holder.AnchorPoint = Vector2.new(.5,.5)
Holder.Position = Config.ProgressPosition or UDim2.fromScale(.5,.75)
Holder.Size = Config.ProgressSize or UDim2.fromOffset(320,4)
Holder.BackgroundColor3 = Config.ProgressBackground or Color3.fromRGB(50,50,50)
Holder.BorderSizePixel = 0
Holder.Parent = Background

local Corner = Instance.new("UICorner")
Corner.Parent = Holder

ProgressBar = Instance.new("Frame")
ProgressBar.Name = "Progress"
ProgressBar.Size = UDim2.fromScale(0,1)
ProgressBar.BackgroundColor3 = Config.ProgressColor or Color3.new(1,1,1)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = Holder

local Corner2 = Instance.new("UICorner")
Corner2.Parent = ProgressBar

TweenService:Create(
ProgressBar,
TweenInfo.new(Config.ProgressTime or 3),
{
Size = UDim2.fromScale(1,1)
}
):Play()

end

local function Close()

if Closed then return end
Closed = true

TweenService:Create(
Background,
TweenInfo.new(FadeTime),
{
BackgroundTransparency = 1
}
):Play()

if Logo then

TweenService:Create(
Logo,
TweenInfo.new(FadeTime),
{
ImageTransparency = 1
}
):Play()

end

TweenService:Create(
Title,
TweenInfo.new(FadeTime),
{
TextTransparency = 1
}
):Play()

TweenService:Create(
Continue,
TweenInfo.new(FadeTime),
{
TextTransparency = 1
}
):Play()

if Blur then

TweenService:Create(
Blur,
TweenInfo.new(FadeTime),
{
Size = 0
}
):Play()

end

task.wait(FadeTime)

Gui:Destroy()

if Blur then
Blur:Destroy()
end

end

if Config.ClickToSkip ~= false then

Background.InputBegan:Connect(function(Input)

if Input.UserInputType == Enum.UserInputType.MouseButton1 then
Close()
end

end)

end

UIS.InputBegan:Connect(function(Input,GameProcessed)

if GameProcessed then return end

if Input.KeyCode == (Config.SkipKey or Enum.KeyCode.Space) then
Close()
end

end)

if Duration then
task.delay(Duration,Close)
end

return {

Skip = Close,
Destroy = Close

}

end

return IntroLib
