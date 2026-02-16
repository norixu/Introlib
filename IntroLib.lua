local IntroLib = {}

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

function IntroLib:Play(Config)

Config = Config or {}

local TitleText = Config.Title or "hello"
local CreditText = Config.Credit or ""
local SubtitleText = Config.Subtitle or ""

local Duration = Config.Duration or 5
local FadeTime = Config.FadeTime or 1

local ClickToSkip = Config.ClickToSkip ~= false
local SkipKey = Config.SkipKey or Enum.KeyCode.Space

local BackgroundColor = Config.BackgroundColor or Color3.new(0,0,0)

local TitleColor = Config.TitleColor or Color3.new(1,1,1)
local CreditColor = Config.CreditColor or Color3.fromRGB(200,200,200)
local SubtitleColor = Config.SubtitleColor or Color3.fromRGB(180,180,180)

local TitleFont = Config.TitleFont or Enum.Font.GothamBold
local CreditFont = Config.CreditFont or Enum.Font.Gotham
local SubtitleFont = Config.SubtitleFont or Enum.Font.Gotham

local SnowEnabled = Config.Snow ~= false
local SnowAmount = Config.SnowAmount or 60
local SnowSpeed = Config.SnowSpeed or {8,15}

local BlurEnabled = Config.Blur or false
local BlurSize = Config.BlurSize or 24

local GradientEnabled = Config.Gradient or false

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Closed = false

local function Close()

if Closed then return end
Closed = true

TweenService:Create(BG,TweenInfo.new(FadeTime),{BackgroundTransparency = 1}):Play()
TweenService:Create(Title,TweenInfo.new(FadeTime),{TextTransparency = 1}):Play()
TweenService:Create(Credit,TweenInfo.new(FadeTime),{TextTransparency = 1}):Play()
TweenService:Create(Subtitle,TweenInfo.new(FadeTime),{TextTransparency = 1}):Play()

if Blur then
TweenService:Create(Blur,TweenInfo.new(FadeTime),{Size = 0}):Play()
end

task.wait(FadeTime)

if Blur then
Blur:Destroy()
end

Gui:Destroy()

end

local Gui = Instance.new("ScreenGui")
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

BG = Instance.new("Frame")
BG.Size = UDim2.new(1,0,1,0)
BG.BackgroundColor3 = BackgroundColor
BG.Parent = Gui

if GradientEnabled then

local Grad = Instance.new("UIGradient")
Grad.Color = ColorSequence.new{
ColorSequenceKeypoint.new(0, BackgroundColor),
ColorSequenceKeypoint.new(1, BackgroundColor:Lerp(Color3.new(1,1,1),0.1))
}
Grad.Rotation = 90
Grad.Parent = BG

end

if BlurEnabled then

Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

TweenService:Create(
Blur,
TweenInfo.new(FadeTime),
{Size = BlurSize}
):Play()

end

local SnowFolder = Instance.new("Folder")
SnowFolder.Parent = BG

if SnowEnabled then

for i=1,SnowAmount do

local Snow = Instance.new("ImageLabel")

Snow.Image = "rbxassetid://94938365473619"
Snow.BackgroundTransparency = 1

local Size = math.random(5,15)

Snow.Size = UDim2.new(0,Size,0,Size)

Snow.ImageTransparency = math.random(20,60)/100

Snow.Parent = SnowFolder

task.spawn(function()

while Snow.Parent and not Closed do

Snow.Position = UDim2.new(math.random(),0,-0.1,0)

local Speed = math.random(SnowSpeed[1],SnowSpeed[2])

TweenService:Create(
Snow,
TweenInfo.new(Speed,Enum.EasingStyle.Linear),
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

end

Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,60)
Title.Position = UDim2.new(0,0,0.5,-60)
Title.BackgroundTransparency = 1
Title.Font = TitleFont
Title.Text = TitleText
Title.TextSize = 36
Title.TextColor3 = TitleColor
Title.TextTransparency = 1
Title.Parent = BG

Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1,0,0,40)
Subtitle.Position = UDim2.new(0,0,0.5,0)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = SubtitleFont
Subtitle.Text = SubtitleText
Subtitle.TextSize = 22
Subtitle.TextColor3 = SubtitleColor
Subtitle.TextTransparency = 1
Subtitle.Parent = BG

Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1,0,0,30)
Credit.Position = UDim2.new(0,0,1,-40)
Credit.BackgroundTransparency = 1
Credit.Font = CreditFont
Credit.Text = CreditText
Credit.TextSize = 16
Credit.TextColor3 = CreditColor
Credit.TextTransparency = 1
Credit.Parent = BG

TweenService:Create(Title,TweenInfo.new(FadeTime),{TextTransparency=0}):Play()
TweenService:Create(Subtitle,TweenInfo.new(FadeTime),{TextTransparency=0}):Play()
TweenService:Create(Credit,TweenInfo.new(FadeTime),{TextTransparency=0}):Play()

if ClickToSkip then

BG.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
Close()
end
end)

end

UIS.InputBegan:Connect(function(input,gp)

if gp then return end

if input.KeyCode == SkipKey then

Close()

end

end)

if Duration then

task.delay(Duration,function()

Close()

end)

end

return {

Skip = Close,

Destroy = Close

}

end

return IntroLib
