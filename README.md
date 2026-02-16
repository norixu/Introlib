# IntroLib

Simple and customizable intro UI library for Roblox.

Designed for clean intros for any scripts with logo support, animations, progress bar, and full visual control.

---

# Quick Install

```lua
local Intro = loadstring(game:HttpGet("https://raw.githubusercontent.com/norixu/Introlib/refs/heads/main/IntroLib.lua"))()

Intro:Play({

Logo = "rbxassetid://YOUR_ICON_ID",

Title = "Loading...",

ContinueText = "Click to continue"

})
```

---

# Example

```lua
local Intro = loadstring(game:HttpGet("https://raw.githubusercontent.com/norixu/Introlib/refs/heads/main/IntroLib.lua"))()

Intro:Play({

Logo = "rbxassetid://5048929690",

LogoSize = UDim2.fromOffset(180,180),

LogoPosition = UDim2.fromScale(0.5,0.38),

LogoCornerRadius = 16,

LogoStroke = Color3.fromRGB(255,255,255),

LogoStrokeThickness = 2,

LogoAnimation = "Pulse",

Title = "Loading Hub...",

TitleSize = 42,

TitleColor = Color3.fromRGB(255,255,255),

ContinueText = "Press space or click",

ContinueSize = 18,

ContinueColor = Color3.fromRGB(180,180,180),

BackgroundColor = Color3.fromRGB(0,0,0),

BackgroundTransparency = 0,

Blur = false,

ProgressBar = true,

ProgressSize = UDim2.fromOffset(360,6),

ProgressColor = Color3.fromRGB(255,255,255),

ProgressBackground = Color3.fromRGB(40,40,40),

ProgressTime = 4,

Duration = nil,

ClickToSkip = true,

SkipKey = Enum.KeyCode.Space,

FadeTime = 1

})
```

---

# Logo Animations

Pulse

```lua
LogoAnimation = "Pulse"
```

Spin

```lua
LogoAnimation = "Spin"
```

None

```lua
LogoAnimation = nil
```

---

# Options

Logo

* Logo
* LogoSize
* LogoPosition
* LogoCornerRadius
* LogoStroke
* LogoStrokeThickness
* LogoAnimation

Title

* Title
* TitleSize
* TitleColor

Continue Text

* ContinueText
* ContinueSize
* ContinueColor

Background

* BackgroundColor
* BackgroundTransparency
* Blur
* BlurSize

Progress Bar

* ProgressBar
* ProgressSize
* ProgressColor
* ProgressBackground
* ProgressTime

Control

* Duration
* ClickToSkip
* SkipKey
* FadeTime

---

# Skip Control

Supports:

Mouse click
Key press
Automatic close

---

# Return

```lua
local Controller = Intro:Play()

Controller:Skip()

Controller:Destroy()
```

---

# Module Install

```lua
local Intro = require(path)

Intro:Play()
```

---

# GitHub

https://github.com/norixu/Introlib
