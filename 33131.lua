local genv = getgenv()
local fenv = getfenv()

game:IsLoaded()
genv.__MKS_OPEN = true

local Services = setmetatable({}, {
    __index = function(self, name)
        rawset(self, name, cloneref(game:GetService(name)))
        return self[name]
    end,
})

Services.Players          = cloneref(game:GetService("Players"))
Services.TweenService     = cloneref(game:GetService("TweenService"))
Services.UserInputService = cloneref(game:GetService("UserInputService"))
Services.HttpService      = cloneref(game:GetService("HttpService"))
Services.ContentProvider  = cloneref(game:GetService("ContentProvider"))
Services.CoreGui          = cloneref(game:GetService("CoreGui"))
Services.Lighting         = cloneref(game:GetService("Lighting"))
Services.RbxAnalyticsService = cloneref(game:GetService("RbxAnalyticsService"))
Services.RunService       = cloneref(game:GetService("RunService"))
Services.SoundService     = cloneref(game:GetService("SoundService"))

local LocalPlayer    = Services.Players.LocalPlayer
local TouchEnabled   = Services.UserInputService.TouchEnabled
local MouseEnabled   = Services.UserInputService.MouseEnabled
makefolder("michigun.xyz")

local SDK
task.spawn(function()
    SDK = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
    SDK.service    = "key"
    SDK.identifier = "11133"
    SDK.provider   = "key"
end)

local SCRIPT_KEY = genv.SCRIPT_KEY

local Color_BgPrimary   = Color3.fromRGB(247, 245, 240)
local Color_BgSecondary = Color3.fromRGB(240, 237, 230)
local Color_White       = Color3.fromRGB(255, 255, 255)
local Color_BgCard      = Color3.fromRGB(255, 255, 255)
local Color_BgCardSoft  = Color3.fromRGB(235, 230, 220)
local Color_BgCardAlt   = Color3.fromRGB(225, 220, 210)
local Color_Border      = Color3.fromRGB(215, 205, 190)
local Color_TextDark    = Color3.fromRGB(44, 42, 38)
local Color_TextMuted   = Color3.fromRGB(110, 105, 95)
local Color_Gold        = Color3.fromRGB(190, 150, 100)
local Color_Green       = Color3.fromRGB(40, 150, 90)
local Color_Orange      = Color3.fromRGB(230, 140, 50)
local Color_TextDim     = Color3.fromRGB(100, 95, 85)
local Color_Discord     = Color3.fromRGB(88, 101, 242)

local Palette_Success = {
    bg     = Color3.fromRGB(240, 252, 244),
    border = Color3.fromRGB(180, 230, 200),
    text   = Color3.fromRGB(30, 120, 70),
    button = Color3.fromRGB(200, 240, 215),
}
local Palette_Error = {
    bg     = Color3.fromRGB(254, 242, 242),
    border = Color3.fromRGB(252, 165, 165),
    text   = Color3.fromRGB(185, 28, 28),
    button = Color3.fromRGB(252, 200, 200),
}
local Palette_Warning = {
    bg     = Color3.fromRGB(255, 251, 235),
    border = Color3.fromRGB(253, 230, 138),
    text   = Color3.fromRGB(180, 83, 9),
    button = Color3.fromRGB(253, 240, 200),
}

local ASSET_Logo        = "rbxassetid://92253403464658"
local ASSET_Discord     = "rbxassetid://101192191207677"
local ASSET_Close       = "rbxassetid://116396312853810"
local ASSET_Key         = "rbxassetid://83474888140571"
local ASSET_Info        = "rbxassetid://114567720540659"
local ASSET_Lock        = "rbxassetid://116918931002434"
local ASSET_Check       = "rbxassetid://86817768619372"
local ASSET_Copy        = "rbxassetid://116378866141355"
local ASSET_Placeholder = "rbxassetid://136533241128438"
local SOUND_Click       = "rbxassetid://9069509838"
local SOUND_Success     = "rbxassetid://9070146059"

local KEY_PATTERN = "^michigun%.xyz%-%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"

local guiGuid = Services.HttpService:GenerateGUID(false)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name             = guiGuid:sub(1, 8)
ScreenGui.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn     = false
ScreenGui.IgnoreGuiInset   = true
ScreenGui.Parent           = Services.CoreGui

local blurGuid = Services.HttpService:GenerateGUID(false)
local BackdropBlur = Instance.new("BlurEffect")
BackdropBlur.Name    = blurGuid:sub(1, 6)
BackdropBlur.Size    = 0
BackdropBlur.Parent  = Services.Lighting

local Backdrop = Instance.new("Frame")
Backdrop.BackgroundTransparency = 1
Backdrop.BackgroundColor3       = Color3.new(0, 0, 0)
Backdrop.ZIndex                 = 1
Backdrop.BorderSizePixel        = 0
Backdrop.Size                   = UDim2.new(1, 0, 1, 0)
Backdrop.Parent                 = ScreenGui

local Window = Instance.new("Frame")
Window.Visible             = false
Window.BackgroundColor3    = Color_BgPrimary
Window.ClipsDescendants    = true
Window.ZIndex              = 2
Window.BorderSizePixel     = 0
Window.Size                = UDim2.new(0, 360, 0, 388)
Window.Parent              = ScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 8)
WindowCorner.Parent       = Window

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color       = Color3.fromRGB(255, 255, 255)
WindowStroke.Thickness   = 1.5
WindowStroke.Transparency = 0
WindowStroke.Parent      = Window

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(220, 180, 110)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(220, 180, 110)),
})
StrokeGradient.Parent = WindowStroke

local LeftDoor = Instance.new("Frame")
LeftDoor.BackgroundColor3   = Color_BgPrimary
LeftDoor.Position           = UDim2.new(0, 0, 0, 0)
LeftDoor.ZIndex             = 10
LeftDoor.BorderSizePixel    = 0
LeftDoor.Size               = UDim2.new(0.5, 0, 1, 0)
LeftDoor.Parent             = Window
local LeftDoorCorner = Instance.new("UICorner")
LeftDoorCorner.CornerRadius = UDim.new(0, 0)
LeftDoorCorner.Parent       = LeftDoor

local RightDoor = Instance.new("Frame")
RightDoor.BackgroundColor3  = Color_BgPrimary
RightDoor.Position          = UDim2.new(0.5, 0, 0, 0)
RightDoor.ZIndex            = 10
RightDoor.BorderSizePixel   = 0
RightDoor.Size              = UDim2.new(0.5, 0, 1, 0)
RightDoor.Parent            = Window

local Logo = Instance.new("ImageLabel")
Logo.ImageColor3            = Color_Gold
Logo.Image                  = ASSET_Logo
Logo.BackgroundTransparency = 1
Logo.Position               = UDim2.new(0.5, -29, 0.5, -29)
Logo.ZIndex                 = 11
Logo.ImageTransparency      = 0
Logo.Size                   = UDim2.new(0, 58, 0, 58)
Logo.Parent                 = Window

local HeaderBar = Instance.new("Frame")
HeaderBar.BackgroundColor3 = Color_BgSecondary
HeaderBar.ZIndex           = 3
HeaderBar.BorderSizePixel  = 0
HeaderBar.Size             = UDim2.new(1, 0, 0, 46)
HeaderBar.Parent           = Window

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent       = HeaderBar

local HeaderBottomMask = Instance.new("Frame")
HeaderBottomMask.BackgroundColor3 = Color_BgSecondary
HeaderBottomMask.Position         = UDim2.new(0, 0, 1, -10)
HeaderBottomMask.ZIndex           = 3
HeaderBottomMask.BorderSizePixel  = 0
HeaderBottomMask.Size             = UDim2.new(1, 0, 0, 10)
HeaderBottomMask.Parent           = HeaderBar

local HeaderDivider = Instance.new("Frame")
HeaderDivider.BackgroundColor3 = Color_BgCardAlt
HeaderDivider.Position         = UDim2.new(0, 0, 1, -1)
HeaderDivider.ZIndex           = 4
HeaderDivider.BorderSizePixel  = 0
HeaderDivider.Size             = UDim2.new(1, 0, 0, 1)
HeaderDivider.Parent           = HeaderBar

local CameraInput = require(
    LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput")
)

HeaderBar.InputBegan:Connect(function(input, _)
    local _isLeftClick = input.UserInputType == Enum.UserInputType.MouseButton1
    local _isTouch     = input.UserInputType == Enum.UserInputType.Touch
end)
Window.InputBegan:Connect(function(input, _)
    local _isLeftClick = input.UserInputType == Enum.UserInputType.MouseButton1
    local _isTouch     = input.UserInputType == Enum.UserInputType.Touch
end)
Services.UserInputService.InputChanged:Connect(function() end)
Services.UserInputService.InputEnded:Connect(function() end)

local HeaderLogo = Instance.new("ImageLabel")
HeaderLogo.ImageColor3            = Color_Gold
HeaderLogo.Image                  = ASSET_Logo
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Position               = UDim2.new(0, 14, 0.5, -9)
HeaderLogo.ZIndex                 = 4
HeaderLogo.Size                   = UDim2.new(0, 18, 0, 18)
HeaderLogo.Parent                 = HeaderBar

local BrandLabel = Instance.new("TextLabel")
BrandLabel.TextColor3            = Color_TextDark
BrandLabel.Text                  = "michigun.xyz"
BrandLabel.Font                  = Enum.Font.GothamBlack
BrandLabel.BackgroundTransparency = 1
BrandLabel.Position              = UDim2.new(0, 38, 0.5, -9)
BrandLabel.TextXAlignment        = Enum.TextXAlignment.Left
BrandLabel.ZIndex                = 4
BrandLabel.TextSize              = 12
BrandLabel.Size                  = UDim2.new(0, 90, 0, 18)
BrandLabel.Parent                = HeaderBar

local StatusLabel = Instance.new("TextLabel")
StatusLabel.TextColor3            = Color_TextMuted
StatusLabel.Text                  = ""
StatusLabel.Font                  = Enum.Font.Gotham
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position              = UDim2.new(0, 136, 0.5, -7)
StatusLabel.TextXAlignment        = Enum.TextXAlignment.Left
StatusLabel.ZIndex                = 4
StatusLabel.TextSize              = 10
StatusLabel.Size                  = UDim2.new(1, -210, 0, 14)
StatusLabel.Parent                = HeaderBar

local DiscordButton = Instance.new("TextButton")
DiscordButton.AutoButtonColor   = false
DiscordButton.ZIndex            = 5
DiscordButton.Position          = UDim2.new(1, -68, 0.5, -13)
DiscordButton.Text              = ""
DiscordButton.BackgroundColor3  = Color3.fromRGB(230, 225, 215)
DiscordButton.Size              = UDim2.new(0, 26, 0, 26)
DiscordButton.Parent            = HeaderBar

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 8)
DiscordCorner.Parent       = DiscordButton

local DiscordScale = DiscordButton:FindFirstChildOfClass("UIScale")

local function tweenScale(button, scale, duration)
    local s = button:FindFirstChildOfClass("UIScale")
    if not s then return end
    Services.TweenService:Create(s,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Scale = scale }):Play()
end

DiscordButton.MouseEnter:Connect(function()
    tweenScale(DiscordButton, 1.03, 0.15)
end)
DiscordButton.MouseLeave:Connect(function()
    tweenScale(DiscordButton, 1, 0.15)
end)
DiscordButton.MouseButton1Down:Connect(function()
    tweenScale(DiscordButton, 0.96, 0.08)
end)
DiscordButton.MouseButton1Up:Connect(function()
    tweenScale(DiscordButton, 1.03, 0.08)
end)

local DiscordIcon = Instance.new("ImageLabel")
DiscordIcon.ImageColor3            = Color_Discord
DiscordIcon.Image                  = ASSET_Discord
DiscordIcon.BackgroundTransparency = 1
DiscordIcon.Position               = UDim2.new(0.5, -7, 0.5, -7)
DiscordIcon.ZIndex                 = 6
DiscordIcon.Size                   = UDim2.new(0, 14, 0, 14)
DiscordIcon.Parent                 = DiscordButton

DiscordButton.MouseEnter:Connect(function()
    Services.TweenService:Create(DiscordButton,
        TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = Color3.fromRGB(88, 101, 242) }):Play()
end)
DiscordButton.MouseLeave:Connect(function()
    Services.TweenService:Create(DiscordButton,
        TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = Color3.fromRGB(230, 225, 215) }):Play()
end)
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/G5vEkrAXnF")
    local icon = DiscordButton:FindFirstChildOfClass("ImageLabel")
    Services.TweenService:Create(icon,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { ImageColor3 = Color_Green }):Play()
    task.delay(1.2, function()
        Services.TweenService:Create(icon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { ImageColor3 = Color_Discord }):Play()
    end)
end)

local CloseButton = Instance.new("TextButton")
CloseButton.AutoButtonColor   = false
CloseButton.ZIndex            = 5
CloseButton.Position          = UDim2.new(1, -36, 0.5, -13)
CloseButton.Text              = ""
CloseButton.BackgroundColor3  = Color3.fromRGB(230, 225, 215)
CloseButton.Size              = UDim2.new(0, 26, 0, 26)
CloseButton.Parent            = HeaderBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent       = CloseButton

local CloseScale = CloseButton:FindFirstChildOfClass("UIScale")
CloseButton.MouseEnter:Connect(function() tweenScale(CloseButton, 1.03, 0.15) end)
CloseButton.MouseLeave:Connect(function() tweenScale(CloseButton, 1, 0.15) end)
CloseButton.MouseButton1Down:Connect(function() tweenScale(CloseButton, 0.96, 0.08) end)
CloseButton.MouseButton1Up:Connect(function() tweenScale(CloseButton, 1.03, 0.08) end)

local CloseIcon = Instance.new("ImageLabel")
CloseIcon.ImageColor3            = Color_TextMuted
CloseIcon.Image                  = ASSET_Close
CloseIcon.BackgroundTransparency = 1
CloseIcon.Position               = UDim2.new(0.5, -5, 0.5, -6)
CloseIcon.ZIndex                 = 6
CloseIcon.Size                   = UDim2.new(0, 11, 0, 11)
CloseIcon.Parent                 = CloseButton

CloseButton.MouseEnter:Connect(function()
    Services.TweenService:Create(CloseButton,
        TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = Color3.fromRGB(210, 70, 80) }):Play()
end)
CloseButton.MouseLeave:Connect(function()
    Services.TweenService:Create(CloseButton,
        TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = Color3.fromRGB(230, 225, 215) }):Play()
end)

local TabBar = Instance.new("Frame")
TabBar.BackgroundColor3  = Color_BgSecondary
TabBar.Position          = UDim2.new(0, 0, 0, 46)
TabBar.ZIndex            = 3
TabBar.BorderSizePixel   = 0
TabBar.Size              = UDim2.new(1, 0, 0, 36)
TabBar.Parent            = Window

local TabBarDivider = Instance.new("Frame")
TabBarDivider.BackgroundColor3 = Color_BgCardAlt
TabBarDivider.Position         = UDim2.new(0, 0, 1, -1)
TabBarDivider.ZIndex           = 4
TabBarDivider.BorderSizePixel  = 0
TabBarDivider.Size             = UDim2.new(1, 0, 0, 1)
TabBarDivider.Parent           = TabBar

local ActiveTabPill = Instance.new("Frame")
ActiveTabPill.BackgroundColor3 = Color_White
ActiveTabPill.Position         = UDim2.new(0, 7, 0.5, -12)
ActiveTabPill.ZIndex           = 4
ActiveTabPill.BorderSizePixel  = 0
ActiveTabPill.Size             = UDim2.new(0, 166, 0, 24)
ActiveTabPill.Parent           = TabBar

local PillCorner = Instance.new("UICorner")
PillCorner.CornerRadius = UDim.new(0, 8)
PillCorner.Parent       = ActiveTabPill

local PillStroke = Instance.new("UIStroke")
PillStroke.Color       = Color_Border
PillStroke.Thickness   = 1
PillStroke.Transparency = 0
PillStroke.Parent      = ActiveTabPill

local KeyTabButton = Instance.new("TextButton")
KeyTabButton.ZIndex             = 5
KeyTabButton.BackgroundTransparency = 1
KeyTabButton.Position           = UDim2.new(0, 0, 0, 0)
KeyTabButton.Text               = ""
KeyTabButton.AutoButtonColor    = false
KeyTabButton.Size               = UDim2.new(0, 180, 1, 0)
KeyTabButton.Parent             = TabBar

local KeyTabContent = Instance.new("Frame")
KeyTabContent.ZIndex             = 6
KeyTabContent.BackgroundTransparency = 1
KeyTabContent.Size               = UDim2.new(1, 0, 1, 0)
KeyTabContent.Parent             = KeyTabButton

local KeyTabLayout = Instance.new("UIListLayout")
KeyTabLayout.VerticalAlignment    = Enum.VerticalAlignment.Center
KeyTabLayout.FillDirection        = Enum.FillDirection.Horizontal
KeyTabLayout.HorizontalAlignment  = Enum.HorizontalAlignment.Center
KeyTabLayout.Padding              = UDim.new(0, 5)
KeyTabLayout.SortOrder            = Enum.SortOrder.LayoutOrder
KeyTabLayout.Parent               = KeyTabContent

local KeyTabIcon = Instance.new("ImageLabel")
KeyTabIcon.ImageColor3            = Color_TextMuted
KeyTabIcon.Image                  = ASSET_Key
KeyTabIcon.BackgroundTransparency = 1
KeyTabIcon.ZIndex                 = 6
KeyTabIcon.LayoutOrder            = 1
KeyTabIcon.Size                   = UDim2.new(0, 13, 0, 13)
KeyTabIcon.Parent                 = KeyTabContent

local KeyTabLabel = Instance.new("TextLabel")
KeyTabLabel.LayoutOrder           = 2
KeyTabLabel.TextColor3            = Color_TextMuted
KeyTabLabel.Text                  = "Chave"
KeyTabLabel.Font                  = Enum.Font.GothamSemibold
KeyTabLabel.BackgroundTransparency = 1
KeyTabLabel.TextSize              = 11
KeyTabLabel.ZIndex                = 6
KeyTabLabel.AutomaticSize         = Enum.AutomaticSize.X
KeyTabLabel.Size                  = UDim2.new(0, 0, 0, 13)
KeyTabLabel.Parent                = KeyTabContent

local KeyTabPage = Instance.new("Frame")
KeyTabPage.Visible              = false
KeyTabPage.BackgroundTransparency = 1
KeyTabPage.Position             = UDim2.new(0, 0, 0, 82)
KeyTabPage.ZIndex               = 3
KeyTabPage.ClipsDescendants     = true
KeyTabPage.Size                 = UDim2.new(1, 0, 0, 306)
KeyTabPage.Parent               = Window

KeyTabButton.MouseButton1Click:Connect(function()
    Services.TweenService:Create(ActiveTabPill,
        TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Position = UDim2.new(0, 7, 0.5, -12) }):Play()
    Services.TweenService:Create(KeyTabLabel,
        TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextColor3 = Color_TextDark }):Play()
    Services.TweenService:Create(KeyTabIcon,
        TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { ImageColor3 = Color_Gold }):Play()
    KeyTabPage.Visible = true
end)

local InfoTabButton = Instance.new("TextButton")
InfoTabButton.ZIndex             = 5
InfoTabButton.BackgroundTransparency = 1
InfoTabButton.Position           = UDim2.new(0, 180, 0, 0)
InfoTabButton.Text               = ""
InfoTabButton.AutoButtonColor    = false
InfoTabButton.Size               = UDim2.new(0, 180, 1, 0)
InfoTabButton.Parent             = TabBar

local InfoTabContent = Instance.new("Frame")
InfoTabContent.ZIndex             = 6
InfoTabContent.BackgroundTransparency = 1
InfoTabContent.Size               = UDim2.new(1, 0, 1, 0)
InfoTabContent.Parent             = InfoTabButton

local InfoTabLayout = Instance.new("UIListLayout")
InfoTabLayout.VerticalAlignment    = Enum.VerticalAlignment.Center
InfoTabLayout.FillDirection        = Enum.FillDirection.Horizontal
InfoTabLayout.HorizontalAlignment  = Enum.HorizontalAlignment.Center
InfoTabLayout.Padding              = UDim.new(0, 5)
InfoTabLayout.SortOrder            = Enum.SortOrder.LayoutOrder
InfoTabLayout.Parent               = InfoTabContent

local InfoTabIcon = Instance.new("ImageLabel")
InfoTabIcon.ImageColor3            = Color_TextMuted
InfoTabIcon.Image                  = ASSET_Info
InfoTabIcon.BackgroundTransparency = 1
InfoTabIcon.ZIndex                 = 6
InfoTabIcon.LayoutOrder            = 1
InfoTabIcon.Size                   = UDim2.new(0, 13, 0, 13)
InfoTabIcon.Parent                 = InfoTabContent

local InfoTabLabel = Instance.new("TextLabel")
InfoTabLabel.LayoutOrder           = 2
InfoTabLabel.TextColor3            = Color_TextMuted
InfoTabLabel.Text                  = "Informações"
InfoTabLabel.Font                  = Enum.Font.GothamSemibold
InfoTabLabel.BackgroundTransparency = 1
InfoTabLabel.TextSize              = 11
InfoTabLabel.ZIndex                = 6
InfoTabLabel.AutomaticSize         = Enum.AutomaticSize.X
InfoTabLabel.Size                  = UDim2.new(0, 0, 0, 13)
InfoTabLabel.Parent                = InfoTabContent

local InfoTabPage = Instance.new("Frame")
InfoTabPage.Visible              = false
InfoTabPage.BackgroundTransparency = 1
InfoTabPage.Position             = UDim2.new(0, 0, 0, 82)
InfoTabPage.ZIndex               = 3
InfoTabPage.ClipsDescendants     = true
InfoTabPage.Size                 = UDim2.new(1, 0, 0, 306)
InfoTabPage.Parent               = Window

InfoTabButton.MouseButton1Click:Connect(function()
    Services.TweenService:Create(ActiveTabPill,
        TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Position = UDim2.new(0, 187, 0.5, -12) }):Play()
    Services.TweenService:Create(KeyTabLabel,
        TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextColor3 = Color_TextMuted }):Play()
    Services.TweenService:Create(KeyTabIcon,
        TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { ImageColor3 = Color_TextMuted }):Play()
    Services.TweenService:Create(InfoTabLabel,
        TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextColor3 = Color_TextDark }):Play()
    Services.TweenService:Create(InfoTabIcon,
        TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { ImageColor3 = Color_Gold }):Play()
    KeyTabPage.Visible  = false
    InfoTabPage.Visible = true
end)

local KeyScroll = Instance.new("ScrollingFrame")
KeyScroll.ScrollBarImageColor3  = Color3.fromRGB(55, 55, 65)
KeyScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
KeyScroll.ScrollBarThickness     = 3
KeyScroll.BackgroundTransparency = 1
KeyScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
KeyScroll.ZIndex                 = 4
KeyScroll.BorderSizePixel        = 0
KeyScroll.Size                   = UDim2.new(1, 0, 1, 0)
KeyScroll.Parent                 = KeyTabPage

local KeyScrollPadding = Instance.new("UIPadding")
KeyScrollPadding.PaddingTop    = UDim.new(0, 12)
KeyScrollPadding.PaddingBottom = UDim.new(0, 12)
KeyScrollPadding.PaddingLeft   = UDim.new(0, 12)
KeyScrollPadding.PaddingRight  = UDim.new(0, 14)
KeyScrollPadding.Parent        = KeyScroll

local KeyScrollLayout = Instance.new("UIListLayout")
KeyScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
KeyScrollLayout.Padding   = UDim.new(0, 8)
KeyScrollLayout.Parent    = KeyScroll

local KeyInputRow = Instance.new("Frame")
KeyInputRow.LayoutOrder      = 1
KeyInputRow.BackgroundColor3 = Color_BgCard
KeyInputRow.ZIndex           = 5
KeyInputRow.BorderSizePixel  = 0
KeyInputRow.Size             = UDim2.new(1, 0, 0, 44)
KeyInputRow.Parent           = KeyScroll

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent       = KeyInputRow

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Color       = Color_Border
KeyInputStroke.Thickness   = 1
KeyInputStroke.Transparency = 0
KeyInputStroke.Parent      = KeyInputRow

local KeyInputIcon = Instance.new("ImageLabel")
KeyInputIcon.ImageColor3            = Color_TextMuted
KeyInputIcon.Image                  = ASSET_Lock
KeyInputIcon.BackgroundTransparency = 1
KeyInputIcon.Position               = UDim2.new(0, 11, 0.5, -7)
KeyInputIcon.ZIndex                 = 7
KeyInputIcon.Size                   = UDim2.new(0, 15, 0, 15)
KeyInputIcon.Parent                 = KeyInputRow

local KeyInput = Instance.new("TextBox")
KeyInput.TextColor3            = Color_TextDark
KeyInput.Text                  = ""
KeyInput.ZIndex                = 7
KeyInput.ClearTextOnFocus      = false
KeyInput.TextXAlignment        = Enum.TextXAlignment.Left
KeyInput.Font                  = Enum.Font.GothamMedium
KeyInput.BackgroundTransparency = 1
KeyInput.Position              = UDim2.new(0, 32, 0, 1)
KeyInput.PlaceholderColor3     = Color_TextMuted
KeyInput.PlaceholderText       = "Cole sua chave aqui..."
KeyInput.TextSize              = 12
KeyInput.Size                  = UDim2.new(1, -34, 1, -2)
KeyInput.Parent                = KeyInputRow

KeyInput.Focused:Connect(function()
    Services.TweenService:Create(KeyInputStroke,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Color = Color_Gold, Transparency = 0 }):Play()
end)
KeyInput.FocusLost:Connect(function()
    Services.TweenService:Create(KeyInputStroke,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Color = Color_Border, Transparency = 0 }):Play()
end)

KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    local text = KeyInput.Text
    local _len = #text
    local _isValid = text:match(KEY_PATTERN)
    Services.TweenService:Create(KeyInputStroke,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Color = Color_Green, Transparency = 0.3 }):Play()
end)

local HintRow = Instance.new("Frame")
HintRow.LayoutOrder      = 2
HintRow.BackgroundColor3 = Color_BgCard
HintRow.ZIndex           = 5
HintRow.BorderSizePixel  = 0
HintRow.Size             = UDim2.new(1, 0, 0, 34)
HintRow.Parent           = KeyScroll

local HintCorner = Instance.new("UICorner")
HintCorner.CornerRadius = UDim.new(0, 8)
HintCorner.Parent       = HintRow
HintRow.BackgroundColor3 = Color3.fromRGB(250, 248, 245)

local HintStroke = Instance.new("UIStroke")
HintStroke.Color       = Color3.fromRGB(225, 220, 210)
HintStroke.Thickness   = 1
HintStroke.Transparency = 0
HintStroke.Parent      = HintRow

local HintDot = Instance.new("Frame")
HintDot.BackgroundColor3 = Color_TextDim
HintDot.Position         = UDim2.new(0, 11, 0.5, -3)
HintDot.ZIndex           = 6
HintDot.BorderSizePixel  = 0
HintDot.Size             = UDim2.new(0, 6, 0, 6)
HintDot.Parent           = HintRow
local HintDotCorner = Instance.new("UICorner")
HintDotCorner.CornerRadius = UDim.new(1, 0)
HintDotCorner.Parent       = HintDot

local HintText = Instance.new("TextLabel")
HintText.TextColor3            = Color_TextDim
HintText.Text                  = "Pegue a chave e cole-a acima"
HintText.Font                  = Enum.Font.GothamMedium
HintText.BackgroundTransparency = 1
HintText.TextXAlignment        = Enum.TextXAlignment.Left
HintText.Position              = UDim2.new(0, 24, 0, 0)
HintText.ZIndex                = 6
HintText.TextSize              = 10
HintText.Size                  = UDim2.new(1, -32, 1, 0)
HintText.Parent                = HintRow

local Divider1 = Instance.new("Frame")
Divider1.LayoutOrder      = 3
Divider1.BackgroundColor3 = Color_BgCardAlt
Divider1.ZIndex           = 5
Divider1.BorderSizePixel  = 0
Divider1.Size             = UDim2.new(1, 0, 0, 1)
Divider1.Parent           = KeyScroll

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.LayoutOrder     = 4
GetKeyButton.AutoButtonColor = false
GetKeyButton.ZIndex          = 5
GetKeyButton.Text            = ""
GetKeyButton.BackgroundColor3 = Color_BgCardSoft
GetKeyButton.Size            = UDim2.new(1, 0, 0, 44)
GetKeyButton.Parent          = KeyScroll

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent       = GetKeyButton

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Color       = Color_Border
GetKeyStroke.Thickness   = 1
GetKeyStroke.Transparency = 0
GetKeyStroke.Parent      = GetKeyButton

local GetKeyScale = GetKeyButton:FindFirstChildOfClass("UIScale")
GetKeyButton.MouseEnter:Connect(function() tweenScale(GetKeyButton, 1.03, 0.15) end)
GetKeyButton.MouseLeave:Connect(function() tweenScale(GetKeyButton, 1, 0.15) end)
GetKeyButton.MouseButton1Down:Connect(function() tweenScale(GetKeyButton, 0.96, 0.08) end)
GetKeyButton.MouseButton1Up:Connect(function() tweenScale(GetKeyButton, 1.03, 0.08) end)

local GetKeyIcon = Instance.new("ImageLabel")
GetKeyIcon.ImageColor3            = Color_TextDark
GetKeyIcon.Image                  = ASSET_Key
GetKeyIcon.BackgroundTransparency = 1
GetKeyIcon.Position               = UDim2.new(0.5, -52, 0.5, -8)
GetKeyIcon.ZIndex                 = 6
GetKeyIcon.Size                   = UDim2.new(0, 16, 0, 16)
GetKeyIcon.Parent                 = GetKeyButton

local GetKeyLabel = Instance.new("TextLabel")
GetKeyLabel.TextColor3            = Color_TextDark
GetKeyLabel.Text                  = "Pegar chave"
GetKeyLabel.Font                  = Enum.Font.GothamBold
GetKeyLabel.BackgroundTransparency = 1
GetKeyLabel.TextXAlignment        = Enum.TextXAlignment.Left
GetKeyLabel.Position              = UDim2.new(0.5, -28, 0.5, -8)
GetKeyLabel.ZIndex                = 6
GetKeyLabel.TextSize              = 13
GetKeyLabel.Size                  = UDim2.new(0, 70, 0, 16)
GetKeyLabel.Parent                = GetKeyButton

local RedeemButton = Instance.new("TextButton")
RedeemButton.LayoutOrder     = 5
RedeemButton.AutoButtonColor = false
RedeemButton.ZIndex          = 5
RedeemButton.Text            = ""
RedeemButton.BackgroundColor3 = Color_BgCardSoft
RedeemButton.Size            = UDim2.new(1, 0, 0, 44)
RedeemButton.Parent          = KeyScroll

local RedeemCorner = Instance.new("UICorner")
RedeemCorner.CornerRadius = UDim.new(0, 8)
RedeemCorner.Parent       = RedeemButton

local RedeemStroke = Instance.new("UIStroke")
RedeemStroke.Color       = Color_Border
RedeemStroke.Thickness   = 1
RedeemStroke.Transparency = 0
RedeemStroke.Parent      = RedeemButton

local RedeemScale = RedeemButton:FindFirstChildOfClass("UIScale")
RedeemButton.MouseEnter:Connect(function() tweenScale(RedeemButton, 1.03, 0.15) end)
RedeemButton.MouseLeave:Connect(function() tweenScale(RedeemButton, 1, 0.15) end)
RedeemButton.MouseButton1Down:Connect(function() tweenScale(RedeemButton, 0.96, 0.08) end)
RedeemButton.MouseButton1Up:Connect(function() tweenScale(RedeemButton, 1.03, 0.08) end)

local RedeemIcon = Instance.new("ImageLabel")
RedeemIcon.ImageColor3            = Color_TextDark
RedeemIcon.Image                  = ASSET_Check
RedeemIcon.BackgroundTransparency = 1
RedeemIcon.Position               = UDim2.new(0.5, -52, 0.5, -8)
RedeemIcon.ZIndex                 = 6
RedeemIcon.Size                   = UDim2.new(0, 16, 0, 16)
RedeemIcon.Parent                 = RedeemButton

local RedeemLabel = Instance.new("TextLabel")
RedeemLabel.TextColor3            = Color_TextDark
RedeemLabel.Text                  = "Resgatar"
RedeemLabel.Font                  = Enum.Font.GothamBold
RedeemLabel.BackgroundTransparency = 1
RedeemLabel.TextXAlignment        = Enum.TextXAlignment.Left
RedeemLabel.Position              = UDim2.new(0.5, -28, 0.5, -8)
RedeemLabel.ZIndex                = 6
RedeemLabel.TextSize              = 13
RedeemLabel.Size                  = UDim2.new(0, 70, 0, 16)
RedeemLabel.Parent                = RedeemButton

local Divider2 = Instance.new("Frame")
Divider2.LayoutOrder      = 6
Divider2.BackgroundColor3 = Color_BgCardAlt
Divider2.ZIndex           = 5
Divider2.BorderSizePixel  = 0
Divider2.Size             = UDim2.new(1, 0, 0, 1)
Divider2.Parent           = KeyScroll

local PremiumRow = Instance.new("Frame")
PremiumRow.LayoutOrder          = 7
PremiumRow.BackgroundTransparency = 1
PremiumRow.ZIndex               = 5
PremiumRow.BorderSizePixel      = 0
PremiumRow.Size                 = UDim2.new(1, 0, 0, 48)
PremiumRow.Parent               = KeyScroll

local PremiumHighlight = Instance.new("Frame")
PremiumHighlight.BackgroundColor3    = Color3.fromRGB(220, 180, 110)
PremiumHighlight.BackgroundTransparency = 0.8
PremiumHighlight.Position            = UDim2.new(0, -2, 0, -2)
PremiumHighlight.ZIndex              = 4
PremiumHighlight.BorderSizePixel     = 0
PremiumHighlight.Size                = UDim2.new(1, 4, 1, 4)
PremiumHighlight.Parent              = PremiumRow

local HighlightCorner = Instance.new("UICorner")
HighlightCorner.CornerRadius = UDim.new(0, 10)
HighlightCorner.Parent       = PremiumHighlight

task.spawn(function()
    while task.wait(1.2) do
        Services.TweenService:Create(PremiumHighlight,
            TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { BackgroundTransparency = 0.6 }):Play()
        task.wait(1.2)
        Services.TweenService:Create(PremiumHighlight,
            TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { BackgroundTransparency = 0.85 }):Play()
    end
end)

local PremiumCard = Instance.new("Frame")
PremiumCard.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PremiumCard.ZIndex           = 5
PremiumCard.BorderSizePixel  = 0
PremiumCard.Size             = UDim2.new(1, 0, 1, 0)
PremiumCard.Parent           = PremiumRow

local PremiumCardCorner = Instance.new("UICorner")
PremiumCardCorner.CornerRadius = UDim.new(0, 8)
PremiumCardCorner.Parent       = PremiumCard

local PremiumCardStroke = Instance.new("UIStroke")
PremiumCardStroke.Color       = Color3.fromRGB(255, 255, 255)
PremiumCardStroke.Thickness   = 1.2
PremiumCardStroke.Transparency = 0
PremiumCardStroke.Parent      = PremiumCard

local PremiumCardStrokeGradient = Instance.new("UIGradient")
PremiumCardStrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(210, 160, 90)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(245, 220, 180)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(210, 160, 90)),
})
PremiumCardStrokeGradient.Parent = PremiumCardStroke

task.spawn(function()
    while task.wait(0.03) do
        PremiumCardStrokeGradient.Rotation = (PremiumCardStrokeGradient.Rotation + 2) % 360
    end
end)

local PremiumShimmer = Instance.new("UIGradient")
PremiumShimmer.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,    Color3.fromRGB(253, 248, 235)),
    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(253, 248, 235)),
    ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(253, 248, 235)),
    ColorSequenceKeypoint.new(1,    Color3.fromRGB(253, 248, 235)),
})
PremiumShimmer.Offset   = Vector2.new(-1, 0)
PremiumShimmer.Rotation = 20
PremiumShimmer.Parent   = PremiumCard

task.spawn(function()
    while true do
        PremiumShimmer.Offset = Vector2.new(-1, 0)
        local tween = Services.TweenService:Create(PremiumShimmer,
            TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { Offset = Vector2.new(1, 0) })
        tween:Play()
        tween.Completed:Wait()
        task.wait(2.5)
    end
end)

local PremiumTitle = Instance.new("TextLabel")
PremiumTitle.TextColor3            = Color3.fromRGB(130, 90, 10)
PremiumTitle.Text                  = "Compre o premium"
PremiumTitle.Font                  = Enum.Font.GothamBold
PremiumTitle.BackgroundTransparency = 1
PremiumTitle.TextXAlignment        = Enum.TextXAlignment.Left
PremiumTitle.Position              = UDim2.new(0, 12, 0, 8)
PremiumTitle.ZIndex                = 6
PremiumTitle.TextSize              = 11
PremiumTitle.Size                  = UDim2.new(1, -156, 0, 16)
PremiumTitle.Parent                = PremiumCard

task.spawn(function()
    local colorA = Color3.fromRGB(130, 90, 10)
    local colorB = Color3.fromRGB(160, 110, 10)
    local current = colorA
    while task.wait(0.8) do
        current = (current == colorA) and colorB or colorA
        Services.TweenService:Create(PremiumTitle,
            TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            { TextColor3 = current }):Play()
    end
end)

local PremiumPrice = Instance.new("TextLabel")
PremiumPrice.TextColor3            = Color_Green
PremiumPrice.Text                  = "Preço: $19.97"
PremiumPrice.Font                  = Enum.Font.GothamBold
PremiumPrice.BackgroundTransparency = 1
PremiumPrice.TextXAlignment        = Enum.TextXAlignment.Left
PremiumPrice.Position              = UDim2.new(0, 12, 0, 26)
PremiumPrice.ZIndex                = 6
PremiumPrice.TextSize              = 10
PremiumPrice.Size                  = UDim2.new(1, -156, 0, 14)
PremiumPrice.Parent                = PremiumCard

local BuyPremiumButton = Instance.new("TextButton")
BuyPremiumButton.TextColor3       = Color3.fromRGB(255, 255, 255)
BuyPremiumButton.Text             = "Comprar"
BuyPremiumButton.AutoButtonColor  = false
BuyPremiumButton.Font             = Enum.Font.GothamBold
BuyPremiumButton.Position         = UDim2.new(1, -76, 0.5, -13)
BuyPremiumButton.BackgroundColor3 = Color3.fromRGB(44, 42, 38)
BuyPremiumButton.ZIndex           = 7
BuyPremiumButton.TextSize         = 11
BuyPremiumButton.Size             = UDim2.new(0, 68, 0, 26)
BuyPremiumButton.Parent           = PremiumCard

local BuyPremiumCorner = Instance.new("UICorner")
BuyPremiumCorner.CornerRadius = UDim.new(0, 5)
BuyPremiumCorner.Parent       = BuyPremiumButton

local BuyPremiumStroke = Instance.new("UIStroke")
BuyPremiumStroke.Color       = Color3.fromRGB(60, 55, 50)
BuyPremiumStroke.Thickness   = 1
BuyPremiumStroke.Transparency = 0
BuyPremiumStroke.Parent      = BuyPremiumButton

BuyPremiumButton.MouseEnter:Connect(function() tweenScale(BuyPremiumButton, 1.03, 0.15) end)
BuyPremiumButton.MouseLeave:Connect(function() tweenScale(BuyPremiumButton, 1, 0.15) end)
BuyPremiumButton.MouseButton1Down:Connect(function() end)
BuyPremiumButton.MouseButton1Up:Connect(function() end)
BuyPremiumButton.MouseButton1Click:Connect(function()
    setclipboard("https://www.michigun.xyz/premium")
end)

local InfoScroll = Instance.new("ScrollingFrame")
InfoScroll.ScrollBarImageColor3  = Color3.fromRGB(55, 55, 65)
InfoScroll.AutomaticCanvasSize    = Enum.AutomaticSize.Y
InfoScroll.ScrollBarThickness     = 3
InfoScroll.BackgroundTransparency = 1
InfoScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
InfoScroll.ZIndex                 = 4
InfoScroll.BorderSizePixel        = 0
InfoScroll.Size                   = UDim2.new(1, 0, 1, 0)
InfoScroll.Parent                 = InfoTabPage

local InfoScrollPadding = Instance.new("UIPadding")
InfoScrollPadding.PaddingTop    = UDim.new(0, 12)
InfoScrollPadding.PaddingBottom = UDim.new(0, 12)
InfoScrollPadding.PaddingLeft   = UDim.new(0, 12)
InfoScrollPadding.PaddingRight  = UDim.new(0, 14)
InfoScrollPadding.Parent        = InfoScroll

local InfoScrollLayout = Instance.new("UIListLayout")
InfoScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
InfoScrollLayout.Padding   = UDim.new(0, 8)
InfoScrollLayout.Parent    = InfoScroll

local ProfileRow = Instance.new("Frame")
ProfileRow.LayoutOrder      = 1
ProfileRow.BackgroundColor3 = Color_BgCard
ProfileRow.ZIndex           = 5
ProfileRow.BorderSizePixel  = 0
ProfileRow.Size             = UDim2.new(1, 0, 0, 70)
ProfileRow.Parent           = InfoScroll

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(0, 8)
ProfileCorner.Parent       = ProfileRow

local ProfileAvatar = Instance.new("ImageLabel")
ProfileAvatar.BackgroundColor3 = Color_BgCardSoft
ProfileAvatar.Image            = ""
ProfileAvatar.BackgroundTransparency = 0
ProfileAvatar.Position         = UDim2.new(0, 12, 0.5, -22)
ProfileAvatar.ZIndex           = 6
ProfileAvatar.BorderSizePixel  = 0
ProfileAvatar.Size             = UDim2.new(0, 44, 0, 44)
ProfileAvatar.Parent           = ProfileRow

local ProfileAvatarCorner = Instance.new("UICorner")
ProfileAvatarCorner.CornerRadius = UDim.new(0, 8)
ProfileAvatarCorner.Parent       = ProfileAvatar

local ProfileAvatarStroke = Instance.new("UIStroke")
ProfileAvatarStroke.Color       = Color_Gold
ProfileAvatarStroke.Thickness   = 1.5
ProfileAvatarStroke.Transparency = 0.5
ProfileAvatarStroke.Parent      = ProfileAvatar

task.spawn(function()
    local ok, _ = pcall(function()
        ProfileAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=48&h=48"
    end)
end)

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.TextColor3            = Color_TextMuted
WelcomeLabel.Text                  = "Bem-vindo,"
WelcomeLabel.Font                  = Enum.Font.Gotham
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextXAlignment        = Enum.TextXAlignment.Left
WelcomeLabel.Position              = UDim2.new(0, 66, 0, 16)
WelcomeLabel.ZIndex                = 6
WelcomeLabel.TextSize              = 10
WelcomeLabel.Size                  = UDim2.new(1, -68, 0, 14)
WelcomeLabel.Parent                = ProfileRow

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.TextColor3            = Color_TextDark
DisplayNameLabel.Text                  = LocalPlayer.DisplayName
DisplayNameLabel.TextTruncate          = Enum.TextTruncate.AtEnd
DisplayNameLabel.Font                  = Enum.Font.GothamBold
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.TextXAlignment        = Enum.TextXAlignment.Left
DisplayNameLabel.Position              = UDim2.new(0, 66, 0, 32)
DisplayNameLabel.ZIndex                = 6
DisplayNameLabel.TextSize              = 14
DisplayNameLabel.Size                  = UDim2.new(1, -68, 0, 18)
DisplayNameLabel.Parent                = ProfileRow

local executorName, executorVersion = identifyexecutor()

local ExecutorRow = Instance.new("Frame")
ExecutorRow.LayoutOrder      = 2
ExecutorRow.BackgroundColor3 = Color_BgCard
ExecutorRow.ZIndex           = 5
ExecutorRow.BorderSizePixel  = 0
ExecutorRow.Size             = UDim2.new(1, 0, 0, 34)
ExecutorRow.Parent           = InfoScroll

local ExecutorCorner = Instance.new("UICorner")
ExecutorCorner.CornerRadius = UDim.new(0, 8)
ExecutorCorner.Parent       = ExecutorRow

local ExecutorLabel = Instance.new("TextLabel")
ExecutorLabel.TextColor3            = Color_TextMuted
ExecutorLabel.Text                  = "Executor"
ExecutorLabel.Font                  = Enum.Font.Gotham
ExecutorLabel.BackgroundTransparency = 1
ExecutorLabel.TextXAlignment        = Enum.TextXAlignment.Left
ExecutorLabel.Position              = UDim2.new(0, 12, 0, 0)
ExecutorLabel.ZIndex                = 6
ExecutorLabel.TextSize              = 10
ExecutorLabel.Size                  = UDim2.new(0, 88, 1, 0)
ExecutorLabel.Parent                = ExecutorRow

local ExecutorValue = Instance.new("TextLabel")
ExecutorValue.TextColor3            = Color_TextDark
ExecutorValue.Text                  = tostring(executorName)
ExecutorValue.TextTruncate          = Enum.TextTruncate.AtEnd
ExecutorValue.Font                  = Enum.Font.GothamSemibold
ExecutorValue.BackgroundTransparency = 1
ExecutorValue.TextXAlignment        = Enum.TextXAlignment.Right
ExecutorValue.Position              = UDim2.new(0, 92, 0, 0)
ExecutorValue.ZIndex                = 6
ExecutorValue.TextSize              = 11
ExecutorValue.Size                  = UDim2.new(1, -104, 1, 0)
ExecutorValue.Parent                = ExecutorRow

local DeviceRow = Instance.new("Frame")
DeviceRow.LayoutOrder      = 3
DeviceRow.BackgroundColor3 = Color_BgCard
DeviceRow.ZIndex           = 5
DeviceRow.BorderSizePixel  = 0
DeviceRow.Size             = UDim2.new(1, 0, 0, 34)
DeviceRow.Parent           = InfoScroll

local DeviceCorner = Instance.new("UICorner")
DeviceCorner.CornerRadius = UDim.new(0, 8)
DeviceCorner.Parent       = DeviceRow

local DeviceLabel = Instance.new("TextLabel")
DeviceLabel.TextColor3            = Color_TextMuted
DeviceLabel.Text                  = "Dispositivo"
DeviceLabel.Font                  = Enum.Font.Gotham
DeviceLabel.BackgroundTransparency = 1
DeviceLabel.TextXAlignment        = Enum.TextXAlignment.Left
DeviceLabel.Position              = UDim2.new(0, 12, 0, 0)
DeviceLabel.ZIndex                = 6
DeviceLabel.TextSize              = 10
DeviceLabel.Size                  = UDim2.new(0, 88, 1, 0)
DeviceLabel.Parent                = DeviceRow

local DeviceValue = Instance.new("TextLabel")
DeviceValue.TextColor3            = Color_TextDark
DeviceValue.Text                  = "PC"
DeviceValue.TextTruncate          = Enum.TextTruncate.AtEnd
DeviceValue.Font                  = Enum.Font.GothamSemibold
DeviceValue.BackgroundTransparency = 1
DeviceValue.TextXAlignment        = Enum.TextXAlignment.Right
DeviceValue.Position              = UDim2.new(0, 92, 0, 0)
DeviceValue.ZIndex                = 6
DeviceValue.TextSize              = 11
DeviceValue.Size                  = UDim2.new(1, -104, 1, 0)
DeviceValue.Parent                = DeviceRow

local HwidRow = Instance.new("Frame")
HwidRow.LayoutOrder      = 4
HwidRow.BackgroundColor3 = Color_BgCard
HwidRow.ZIndex           = 5
HwidRow.BorderSizePixel  = 0
HwidRow.Size             = UDim2.new(1, 0, 0, 34)
HwidRow.Parent           = InfoScroll

local HwidCorner = Instance.new("UICorner")
HwidCorner.CornerRadius = UDim.new(0, 8)
HwidCorner.Parent       = HwidRow

local HwidLabel = Instance.new("TextLabel")
HwidLabel.TextColor3            = Color_TextMuted
HwidLabel.Text                  = "HWID"
HwidLabel.Font                  = Enum.Font.Gotham
HwidLabel.BackgroundTransparency = 1
HwidLabel.TextXAlignment        = Enum.TextXAlignment.Left
HwidLabel.Position              = UDim2.new(0, 12, 0, 0)
HwidLabel.ZIndex                = 6
HwidLabel.TextSize              = 10
HwidLabel.Size                  = UDim2.new(0, 50, 1, 0)
HwidLabel.Parent                = HwidRow

local _hwidType     = type(gethwid())
local _getdeviceid  = fenv.getdeviceid
local _clientIdType = type(tostring(Services.RbxAnalyticsService:GetClientId()))

local HwidValue = Instance.new("TextLabel")
HwidValue.TextColor3            = Color_TextDark
HwidValue.Text                  = "\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2"
HwidValue.Font                  = Enum.Font.Gotham
HwidValue.BackgroundTransparency = 1
HwidValue.TextXAlignment        = Enum.TextXAlignment.Left
HwidValue.Position              = UDim2.new(0, 60, 0, 0)
HwidValue.ZIndex                = 6
HwidValue.TextSize              = 10
HwidValue.Size                  = UDim2.new(1, -84, 1, 0)
HwidValue.Parent                = HwidRow

local HwidCopyButton = Instance.new("TextButton")
HwidCopyButton.AutoButtonColor   = false
HwidCopyButton.ZIndex            = 6
HwidCopyButton.Position          = UDim2.new(1, -28, 0.5, -11)
HwidCopyButton.Text              = ""
HwidCopyButton.BackgroundColor3  = Color_BgCardSoft
HwidCopyButton.Size              = UDim2.new(0, 22, 0, 22)
HwidCopyButton.Parent            = HwidRow

local HwidCopyCorner = Instance.new("UICorner")
HwidCopyCorner.CornerRadius = UDim.new(0, 6)
HwidCopyCorner.Parent       = HwidCopyButton

HwidCopyButton.MouseEnter:Connect(function() tweenScale(HwidCopyButton, 1.03, 0.15) end)
HwidCopyButton.MouseLeave:Connect(function() tweenScale(HwidCopyButton, 1, 0.15) end)
HwidCopyButton.MouseButton1Down:Connect(function() tweenScale(HwidCopyButton, 0.96, 0.08) end)
HwidCopyButton.MouseButton1Up:Connect(function() tweenScale(HwidCopyButton, 1.03, 0.08) end)

local HwidCopyIcon = Instance.new("ImageLabel")
HwidCopyIcon.ImageColor3            = Color_TextMuted
HwidCopyIcon.Image                  = ASSET_Copy
HwidCopyIcon.BackgroundTransparency = 1
HwidCopyIcon.Position               = UDim2.new(0.5, -5, 0.5, -6)
HwidCopyIcon.ZIndex                 = 7
HwidCopyIcon.Size                   = UDim2.new(0, 11, 0, 11)
HwidCopyIcon.Parent                 = HwidCopyButton

HwidCopyButton.MouseButton1Click:Connect(function()
    setclipboard("N/D")
    HwidValue.Text = "Copiado!"
    HwidValue.TextColor3 = Color_Green
    task.delay(1.5, function()
        HwidValue.Text = "\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2\xE2\x80\xA2"
        HwidValue.TextColor3 = Color_TextDark
    end)
end)

local FooterDivider = Instance.new("Frame")
FooterDivider.LayoutOrder      = 5
FooterDivider.BackgroundColor3 = Color_BgCardAlt
FooterDivider.ZIndex           = 5
FooterDivider.BorderSizePixel  = 0
FooterDivider.Size             = UDim2.new(1, 0, 0, 1)
FooterDivider.Parent           = InfoScroll

local ThanksCard = Instance.new("Frame")
ThanksCard.LayoutOrder      = 6
ThanksCard.BackgroundColor3 = Color_BgCard
ThanksCard.ZIndex           = 5
ThanksCard.BorderSizePixel  = 0
ThanksCard.Size             = UDim2.new(1, 0, 0, 46)
ThanksCard.Parent           = InfoScroll

local ThanksCorner = Instance.new("UICorner")
ThanksCorner.CornerRadius = UDim.new(0, 8)
ThanksCorner.Parent       = ThanksCard
ThanksCard.BackgroundColor3 = Color3.fromRGB(240, 235, 225)

local ThanksTitle = Instance.new("TextLabel")
ThanksTitle.TextColor3            = Color_TextDark
ThanksTitle.Text                  = ""
ThanksTitle.Font                  = Enum.Font.GothamBold
ThanksTitle.BackgroundTransparency = 1
ThanksTitle.TextXAlignment        = Enum.TextXAlignment.Center
ThanksTitle.Position              = UDim2.new(0, 0, 0, 6)
ThanksTitle.ZIndex                = 6
ThanksTitle.TextSize              = 17
ThanksTitle.Size                  = UDim2.new(1, 0, 0, 22)
ThanksTitle.Parent                = ThanksCard

local ThanksSubtitle = Instance.new("TextLabel")
ThanksSubtitle.TextColor3            = Color_TextMuted
ThanksSubtitle.Text                  = ""
ThanksSubtitle.Font                  = Enum.Font.Gotham
ThanksSubtitle.BackgroundTransparency = 1
ThanksSubtitle.TextXAlignment        = Enum.TextXAlignment.Center
ThanksSubtitle.Position              = UDim2.new(0, 0, 0, 30)
ThanksSubtitle.ZIndex                = 6
ThanksSubtitle.TextSize              = 10
ThanksSubtitle.Size                  = UDim2.new(1, 0, 0, 14)
ThanksSubtitle.Parent                = ThanksCard

local clockConnection
clockConnection = Services.RunService.Heartbeat:Connect(function()
    ThanksTitle.Text = os.date("%I:%M:%S %p")
    ThanksSubtitle.Text = os.date("%b %d, %Y")
end)

local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = 0.5
    sound.Parent = Services.SoundService
    sound:Play()
    task.delay(1.5, function()
        sound:Destroy()
    end)
end

local function setGetKeyStatus(palette, statusText)
    Services.TweenService:Create(GetKeyButton,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = palette.bg }):Play()
    Services.TweenService:Create(GetKeyStroke,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Color = palette.border }):Play()
    Services.TweenService:Create(GetKeyLabel,
        TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextColor3 = palette.text }):Play()
    GetKeyLabel.Text = statusText
end

local function setRedeemStatus(palette, statusText)
    Services.TweenService:Create(RedeemButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = palette.button }):Play()
    Services.TweenService:Create(RedeemStroke,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Color = palette.border }):Play()
    Services.TweenService:Create(RedeemIcon,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { ImageColor3 = palette.text }):Play()
    Services.TweenService:Create(RedeemLabel,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextColor3 = palette.text }):Play()
    RedeemLabel.Text = statusText
end

local function closeModal()
    LeftDoor.Visible  = true
    RightDoor.Visible = true
    Logo.Visible      = true
    LeftDoor.Position  = UDim2.new(-0.5, 0, 0, 0)
    RightDoor.Position = UDim2.new(1, 0, 0, 0)
    Logo.ImageTransparency = 1

    Services.TweenService:Create(LeftDoor,
        TweenInfo.new(0.48, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Position = UDim2.new(0, 0, 0, 0) }):Play()
    Services.TweenService:Create(RightDoor,
        TweenInfo.new(0.48, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Position = UDim2.new(0.5, 0, 0, 0) }):Play()
    task.delay(0.38, function()
        Services.TweenService:Create(Logo,
            TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { ImageTransparency = 0 }):Play()
    end)
    task.delay(0.1, function()
        Services.TweenService:Create(Backdrop,
            TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { BackgroundTransparency = 1 }):Play()
    end)
    task.delay(0.1, function()
        Services.TweenService:Create(BackdropBlur,
            TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { Size = 0 }):Play()
    end)
    task.delay(0.82, function()
        ScreenGui:Destroy()
    end)
end

GetKeyButton.MouseButton1Click:Connect(function()
    task.delay(0.6, function() end) 
    GetKeyButton.Active = false

    setGetKeyStatus(Palette_Warning, "Abrindo link...")
    playSound(SOUND_Click)

    local link = SDK.get_key_link()
    setclipboard(link)

    task.wait(0.5)
    Services.TweenService:Create(GetKeyButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { BackgroundColor3 = Palette_Success.button }):Play()
    Services.TweenService:Create(GetKeyStroke,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Color = Palette_Success.border }):Play()
    Services.TweenService:Create(GetKeyIcon,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { ImageColor3 = Palette_Success.text }):Play()
    Services.TweenService:Create(GetKeyLabel,
        TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { TextColor3 = Palette_Success.text }):Play()
    GetKeyLabel.Text = "Link copiado  \xEF\xBD\x9C  complete os passos e cole a chave"

    playSound(SOUND_Success)

    task.delay(0.7, function()
        GetKeyButton.Active = true
    end)
end)

RedeemButton.MouseButton1Click:Connect(function()
    task.delay(0.3, function() end)  

    local keyText = KeyInput.Text
    local _len = #keyText
    local _isValid = keyText:match(KEY_PATTERN)

    task.delay(0.8, function() end) 

    RedeemButton.Active = false
    setRedeemStatus(Palette_Warning, "Checando...")

    task.spawn(function()
        local result = SDK.check_key(keyText)
        local isValid = result.valid
        makefolder("michigun.xyz")

        if isValid then
            genv.SCRIPT_KEY = keyText
            setRedeemStatus(Palette_Success, "Aceito")
            playSound(SOUND_Success)
            task.delay(1.25, closeModal)
        else
            setRedeemStatus(Palette_Error, "Chave inválida")
            playSound(SOUND_Click)
            task.delay(1.5, function()
                RedeemButton.Active = true
                setRedeemStatus({
                    bg     = Color_BgCardSoft,
                    border = Color_Border,
                    text   = Color_TextDark,
                    button = Color_BgCardSoft,
                }, "Resgatar")
            end)
        end
    end)
end)

KeyInput.FocusLost:Connect(function()
    local keyText = KeyInput.Text
    local _len = #keyText
    local _isValid = keyText:match(KEY_PATTERN)
end)

ScreenGui.Destroying:Connect(function()
    if clockConnection then
        clockConnection:Disconnect()
    end
    if BackdropBlur then
        BackdropBlur:Destroy()
    end
    genv.__MKS_OPEN = nil
end)

local viewport = workspace.CurrentCamera.ViewportSize
local posX = math.floor(viewport.X / 2 - 180)
local posY = math.floor(viewport.Y / 2 - 194)
Window.Position = UDim2.new(0, posX, 0, posY)

Services.TweenService:Create(ActiveTabPill,
    TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Position = UDim2.new(0, 7, 0.5, -12) }):Play()
Services.TweenService:Create(KeyTabLabel,
    TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { TextColor3 = Color_TextDark }):Play()
Services.TweenService:Create(KeyTabIcon,
    TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { ImageColor3 = Color_Gold }):Play()
Services.TweenService:Create(InfoTabLabel,
    TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { TextColor3 = Color_TextMuted }):Play()
Services.TweenService:Create(InfoTabIcon,
    TweenInfo.new(0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { ImageColor3 = Color_TextMuted }):Play()
InfoTabPage.Visible = false
KeyTabPage.Visible  = true

task.spawn(function()
    local tempLabels = {}
    local assetIds = {
        ASSET_Close, ASSET_Info, ASSET_Copy, ASSET_Key, ASSET_Logo,
        ASSET_Placeholder, ASSET_Lock, ASSET_Discord, ASSET_Check,
    }
    for i, id in ipairs(assetIds) do
        local label = Instance.new("ImageLabel")
        label.Image = id
        tempLabels[i] = label
    end
    Services.ContentProvider:PreloadAsync(tempLabels)
    for _, label in ipairs(tempLabels) do
        label:Destroy()
    end
end)

task.wait(0.1)
Window.Visible = true

Services.TweenService:Create(Backdrop,
    TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { BackgroundTransparency = 0.62 }):Play()
Services.TweenService:Create(BackdropBlur,
    TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { Size = 18 }):Play()
Services.TweenService:Create(Logo,
    TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    { ImageTransparency = 1 }):Play()

task.delay(0.45, function() end)

return ScreenGui
