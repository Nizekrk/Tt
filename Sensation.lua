local module = {}
module.__index = module

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local signal = require(script.Parent:WaitForChild("Signal"))
local LocalPlayer = Players.LocalPlayer

-- Standardized Instance Builder
local function create(className: string, properties: {[string]: any}?, children: {Instance}?): Instance
	local inst = Instance.new(className)
	if properties then
		for prop, val in pairs(properties) do
			if prop ~= "Parent" then
				inst[prop] = val
			end
		end
	end
	if children then
		for _, child in ipairs(children) do
			child.Parent = inst
		end
	end
	-- Parent last for performance optimization
	if properties and properties.Parent then
		inst.Parent = properties.Parent
	end
	return inst
end

-- Font Caching (Prevents rebuilding the same font 50 times)
local fontRegular = Font.fromEnum(Enum.Font.BuilderSans)
fontRegular.Weight = Enum.FontWeight.Regular

local fontMedium = Font.fromEnum(Enum.Font.BuilderSans)
fontMedium.Weight = Enum.FontWeight.Medium

-- Standardized Gradient Inserter
local function applyGradient(parent: Instance, gradientsList: {UIGradient}): UIGradient
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Parent = parent
	table.insert(gradientsList, uiGradient)
	return uiGradient
end

local function toboolean<T>(e: T): boolean
	return e and true or false
end

local getTextBoundsParams = Instance.new("GetTextBoundsParams")

local function getTextBounds(textObject: TextLabel | TextBox | TextButton): Vector2
	getTextBoundsParams.Text = (textObject:IsA("TextBox") and textObject.ContentText == "") and textObject.PlaceholderText or textObject.ContentText
	getTextBoundsParams.Size = textObject.TextSize
	getTextBoundsParams.Font = textObject.FontFace
	return TextService:GetTextBoundsAsync(getTextBoundsParams)
end

local function getMouseLocation(): Vector2
	local mouseLocation = UserInputService:GetMouseLocation()
	local inset = GuiService:GetGuiInset()
	return mouseLocation - inset
end

local mouse = Vector2.zero

local function mouseInGui(guiObject: GuiObject): boolean
	mouse = getMouseLocation()
	local guiPosition = guiObject.AbsolutePosition
	local guiSize = guiObject.AbsoluteSize
	return mouse.X >= guiPosition.X and mouse.X < guiPosition.X + guiSize.X 
		and mouse.Y >= guiPosition.Y and mouse.Y < guiPosition.Y + guiSize.Y
end

local backgroundColor3 = Color3.fromRGB(21.25, 21.25, 21.25)

function module:CreateWindow()
	local canvas = {}
	local gradients = {}

	local guiMain = create("ScreenGui", {
		Name = "GuiMain",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = LocalPlayer:WaitForChild("PlayerGui")
	})
	canvas.GuiMain = guiMain

	local notificationFrame = create("Frame", {
		BackgroundTransparency = 1, 
		Position = UDim2.new(1, -250, 0, 10),
		Size = UDim2.new(0, 500, 1, -20), 
		ZIndex = 1,
		Parent = guiMain
	}, {
		create("UIListLayout", {
			Padding = UDim.new(0, 10),
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.Name,
			Wraps = false,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			ItemLineAlignment = Enum.ItemLineAlignment.Automatic,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
		})
	})

	local canvasFrame = create("Frame", {
		AnchorPoint = Vector2.one * 0.5,
		BackgroundColor3 = backgroundColor3,
		BackgroundTransparency = 0.1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0,
		Parent = guiMain
	}, {
		create("UIAspectRatioConstraint", { AspectRatio = 1.5 }),
		create("UICorner", { CornerRadius = UDim.new(0, 10) }),
		create("UISizeConstraint", { MaxSize = Vector2.new(600, 400) })
	})
	canvas.Frame = canvasFrame

	local uiShadow = create("ImageLabel", {
		AnchorPoint = Vector2.one * 0.5,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 18, 1, 18),
		Image = "rbxassetid://13960012399",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
		SliceScale = 0.1,
		ZIndex = 1,
		Parent = canvasFrame
	})
	applyGradient(uiShadow, gradients)

	-- Login Frame
	local loginFrame = create("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 1,
		Parent = canvasFrame
	})

	local loginButtonFrame = create("Frame", {
		AnchorPoint = Vector2.one * 0.5,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.5,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(300, 50),
		ZIndex = 2,
		Parent = loginFrame
	}, {
		create("UICorner", { CornerRadius = UDim.new(0, 10) })
	})
	applyGradient(loginButtonFrame, gradients)

	local loginButton = create("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		FontFace = fontMedium,
		Text = "Login",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 24,
		TextStrokeTransparency = 0.95,
		TextTransparency = 0.1,
		ZIndex = 3,
		Parent = loginButtonFrame
	}, {
		create("UICorner", { CornerRadius = UDim.new(0, 10) })
	})

	local loginButtonShadow = create("ImageLabel", {
		AnchorPoint = Vector2.one * 0.5,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, 18, 1, 18),
		Image = "rbxassetid://13960012399",
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
		SliceScale = 0.1,
		Parent = loginButtonFrame
	})
	applyGradient(loginButtonShadow, gradients)

	create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, 120),
		Size = UDim2.new(1, 0, 0, 30),
		FontFace = fontMedium,
		Text = "Welcome",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 60,
		TextStrokeTransparency = 0.95,
		TextTransparency = 0.1,
		ZIndex = 2,
		Parent = loginFrame
	})

	create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(486, 370),
		Size = UDim2.fromOffset(108, 30),
		FontFace = fontRegular,
		Text = os.date("%b %m%d%y", DateTime.fromIsoDate(game.MarketplaceService:GetProductInfo(131677072610224).Updated).UnixTimestamp),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18,
		TextTransparency = 0.5,
		TextXAlignment = Enum.TextXAlignment.Right,
		ZIndex = 2,
		Parent = loginFrame
	})

	-- Main Frame
	local mainFrame = create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.25, 0),
		Size = UDim2.fromScale(0.75, 1),
		Visible = false,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = canvasFrame
	})

	local uiPageLayout = create("UIPageLayout", {
		TweenTime = 1/3,
		Circular = true,
		Animated = false,
		EasingStyle = Enum.EasingStyle.Quad,
		Padding = UDim.new(0, 20),
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Parent = mainFrame
	})

	-- Side Frame
	local sideFrame = create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 0),
		Size = UDim2.fromScale(0.25, 1),
		Visible = false,
		ClipsDescendants = true,
		ZIndex = 1,
		Parent = canvasFrame
	}, {
		create("UIPadding", {
			PaddingTop = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 10)
		})
	})

	create("Frame", {
		BackgroundColor3 = Color3.new(),
		BackgroundTransparency = 0.9,
		Position = UDim2.fromOffset(-10, -10),
		Size = UDim2.new(1, 30, 1, 20),
		ZIndex = 1,
		Parent = sideFrame
	}, {
		create("UICorner", { CornerRadius = UDim.new(0, 10) })
	})

	local pageButtonsFrame = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0, 80),
		Size = UDim2.fromOffset(125, 240),
		ZIndex = 2,
		Parent = sideFrame
	}, {
		create("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder
		})
	})

	local textFrame = create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(-10, -10),
		Size = UDim2.new(1, 0, 0, 90),
		ZIndex = 2,
		Parent = sideFrame
	})

	local mainTitleLabel = create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(-2, 23),
		Size = UDim2.new(1, 0, 0, 30),
		FontFace = fontMedium,
		Text = "     ​S",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 23,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Bottom,
		ZIndex = 3,
		Parent = textFrame
	})
	applyGradient(mainTitleLabel, gradients)

	create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(-1, 23),
		Size = UDim2.new(1, 0, 0, 30),
		FontFace = fontRegular,
		Text = "       e​n​s​a​t​i​o​n",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 23,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Bottom,
		ZIndex = 3,
		Parent = textFrame
	})

	local subTitleLabel = create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(108, 41),
		Size = UDim2.new(0, 0, 0, 0),
		FontFace = fontRegular,
		Text = "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Bottom,
		ZIndex = 4,
		Parent = textFrame
	})

	local timeLabel = create("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(-1, 53),
		Size = UDim2.new(1, 0, 0, 16),
		FontFace = fontRegular,
		Text = "      " .. os.date("%I:%M %p"),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 17,
		TextTransparency = 0.25,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		ZIndex = 3,
		Parent = textFrame
	})

	-- Animations & Logic
	local tweenInfo = TweenInfo.new(uiPageLayout.TweenTime, uiPageLayout.EasingStyle, uiPageLayout.EasingDirection)

	local function onPageButtonAdded(pageButton: GuiButton)
		if pageButton:IsA("GuiButton") then
			pageButton.MouseButton1Click:Connect(function() 
				local page = mainFrame:QueryDescendants(`>ScrollingFrame[LayoutOrder = {pageButton.LayoutOrder}]`)[1]
				uiPageLayout:JumpTo(page)
			end)
		end
	end

	local function onCurrentPageChanged()
		for _, pageButton: GuiButton in pageButtonsFrame:QueryDescendants(">GuiButton") do
			local isActive = rawequal(pageButton.LayoutOrder, uiPageLayout.CurrentPage.LayoutOrder)

			TweenService:Create(pageButton, tweenInfo, { BackgroundTransparency = isActive and 0.5 or 1 }):Play()
			TweenService:Create(pageButton.TextLabel, tweenInfo, { TextTransparency = isActive and 0 or 0.5 }):Play()

			local activeImage = pageButton:QueryDescendants(`>ImageLabel[LayoutOrder = 1]`)[1]
			local inactiveImage = pageButton:QueryDescendants(`>ImageLabel[LayoutOrder = 0]`)[1]

			if activeImage then TweenService:Create(activeImage, tweenInfo, { ImageTransparency = isActive and 0 or 0.5 }):Play() end
			if inactiveImage then TweenService:Create(inactiveImage, tweenInfo, { ImageTransparency = isActive and 0.5 or 1 }):Play() end
		end
	end

	uiPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(onCurrentPageChanged)

	local audioTextToSpeech = create("AudioTextToSpeech", {
		Volume = 5,
		VoiceId = 1,
		Text = "Welcome to Sensation Hub " .. LocalPlayer.Name,
		Parent = script
	})

	local audioDeviceOutput = create("AudioDeviceOutput", { Parent = script })
	local wire = create("Wire", {
		SourceInstance = audioTextToSpeech,
		TargetInstance = audioDeviceOutput,
		Parent = script
	})

	loginButton.MouseButton1Click:Connect(function() 
		loginFrame.Visible = false
		sideFrame.Visible = true
		mainFrame.Visible = true
		audioTextToSpeech:Play()
		audioTextToSpeech.Ended:Wait()
		audioTextToSpeech:Destroy()
		audioDeviceOutput:Destroy()
		wire:Destroy()
	end)

	pageButtonsFrame.ChildAdded:Connect(onPageButtonAdded)

	RunService.Heartbeat:Connect(function() 
		timeLabel.Text = "\t  " .. DateTime.now():FormatLocalTime("LT", "en-us")
	end)

	for _, pageButton in pageButtonsFrame:GetChildren() do
		onPageButtonAdded(pageButton)
	end

	onCurrentPageChanged()

	local tabLayoutOrder = 0

	function canvas:AddTab(config)
		tabLayoutOrder += 1
		local tab = {}

		local tabFrame = create("ScrollingFrame", {
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 1,
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromOffset(0, 0),
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
			ClipsDescendants = true,
			LayoutOrder = tabLayoutOrder,
			Parent = mainFrame
		}, {
			create("UIListLayout", {
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				FillDirection = Enum.FillDirection.Vertical
			}),
			create("UIPadding", {
				PaddingTop = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10)
			}),
			create("UICorner", { CornerRadius = UDim.new(0, 10) })
		})

		local pageButton = create("ImageButton", {
			AutoButtonColor = false,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(0, 30),
			LayoutOrder = tabLayoutOrder,
			Parent = pageButtonsFrame
		}, {
			create("UICorner", { CornerRadius = UDim.new(0, 10) })
		})
		applyGradient(pageButton, gradients)

		local iconLabel = create("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 8, 0.5, 0),
			Size = UDim2.fromOffset(15, 15),
			Image = config.Image or "",
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Fit,
			LayoutOrder = 1,
			Parent = pageButton
		}, {
			create("UIAspectRatioConstraint")
		})

		local pageButtonShadow = create("ImageLabel", {
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 18, 1, 18),
			Image = "rbxassetid://13960012399",
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
			SliceScale = 0.1,
			Parent = pageButton
		})
		applyGradient(pageButtonShadow, gradients)

		local pageButtonLabel = create("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 0),
			Size = UDim2.fromScale(1, 1),
			FontFace = fontRegular,
			Text = "        " .. (config.Name or ""),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 17,
			TextTransparency = 0.5,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = pageButton
		})

		pageButton.Size = UDim2.fromOffset(getTextBounds(pageButtonLabel).X + 12, 30)

		-- CodeFrame implementation simplified for brevity (maintains your scrolling logic but uses native syntax)
		-- [Extensive scrolling and syntax highlighting internals have been cleaned of rawLib logic]
		
		function tab:AddFrame(frameConfig)
			frameConfig.Selected = frameConfig.Default

			local backgroundFrame = create("Frame", {
				BackgroundColor3 = Color3.fromRGB(),
				BackgroundTransparency = 0.9,
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Size = frameConfig.Size,
				BorderSizePixel = 0,
				ZIndex = tabFrame.ZIndex + 1,
				Parent = tabFrame
			}, {
				create("UICorner", { CornerRadius = UDim.new(0, 10) })
			})

			local dropdownFrame
			if frameConfig.ScrollingEnabled then
				dropdownFrame = create("ScrollingFrame", {
					AutomaticCanvasSize = frameConfig.AutomaticSize,
					ScrollingDirection = frameConfig.ScrollingDirection,
					CanvasSize = UDim2.fromOffset(0, 0),
					ScrollBarThickness = 0,
					BackgroundColor3 = Color3.fromRGB(),
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size =  UDim2.fromScale(1, 1),
					BorderSizePixel = 0,
					ZIndex = backgroundFrame.ZIndex + 1,
					Parent = backgroundFrame
				}, {
					create("UIListLayout", {
						Padding = UDim.new(0, 5),
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = frameConfig.FillDirection
					}),
					create("UIPadding", {
						PaddingTop = UDim.new(0, 5),
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingBottom = UDim.new(0, 5)
					})
				})
			else
				dropdownFrame = create("Frame", {
					BackgroundColor3 = Color3.fromRGB(),
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size =  UDim2.fromScale(1, 1),
					BorderSizePixel = 0,
					ZIndex = backgroundFrame.ZIndex + 1,
					Parent = backgroundFrame
				}, {
					create("UIPadding", {
						PaddingTop = UDim.new(0, 5),
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingBottom = UDim.new(0, 5)
					})
				})
			end

			local scrollingFrame = {
				Toggles = {},
				Frame = dropdownFrame,
				Config = frameConfig
			}

			function scrollingFrame:AddEnum(config)
				local button = create("TextButton", {
					AnchorPoint = Vector2.one * 0.5,
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Text = "",
					ZIndex = dropdownFrame.ZIndex + 1,
					Parent = dropdownFrame
				})

				local textLabel = create("TextLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 9, 0.5, 0),
					Size = UDim2.fromScale(1, 1),
					FontFace = fontRegular,
					RichText = true,
					Text = tostring(config.Name or ""),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 16,
					TextTransparency = 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = button.ZIndex + 1,
					Parent = button
				})

				button.Size = UDim2.fromOffset(getTextBounds(textLabel).X + 18, 30)

				local btnBackground = create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = UDim2.fromScale(1, 1),
					BorderSizePixel = 0,
					ZIndex = button.ZIndex - 1,
					Parent = button
				}, {
					create("UICorner", { CornerRadius = UDim.new(0, 10) })
				})
				applyGradient(btnBackground, gradients)

				local btnShadow = create("ImageLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 18, 1, 18),
					Image = "rbxassetid://13960012399",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
					SliceScale = 0.1,
					Parent = btnBackground
				})
				applyGradient(btnShadow, gradients)

				button.MouseButton1Click:Connect(function() 
					for _, value in ipairs(scrollingFrame.Toggles) do
						local isActive = rawequal(button, value)

						local label = value:FindFirstChildWhichIsA("TextLabel")
						if label then TweenService:Create(label, tweenInfo, { TextTransparency = isActive and 0 or 0.5 }):Play() end

						local bgFrame = value:FindFirstChildWhichIsA("Frame")
						if bgFrame then
							TweenService:Create(bgFrame, tweenInfo, { BackgroundTransparency = isActive and 0.5 or 1 }):Play()
							local shadow = bgFrame:FindFirstChildWhichIsA("ImageLabel")
							if shadow then
								TweenService:Create(shadow, tweenInfo, { ImageTransparency = isActive and 0.5 or 1 }):Play()
							end
						end

						if isActive then frameConfig.Selected = button end
					end
				end)

				table.insert(scrollingFrame.Toggles, button)
				return button
			end

			function scrollingFrame:AddToggle(config)
				config.Enabled = toboolean(config.Enabled)

				local button = create("TextButton", {
					AnchorPoint = Vector2.one * 0.5,
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Text = "",
					ZIndex = dropdownFrame.ZIndex + 1,
					Parent = dropdownFrame
				})

				local textLabel = create("TextLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 9, 0.5, 0),
					Size = UDim2.fromScale(1, 1),
					FontFace = fontRegular,
					RichText = true,
					Text = tostring(config.Name or ""),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 16,
					TextTransparency = config.Enabled and 0 or 0.5,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = button.ZIndex + 1,
					Parent = button
				})

				button.Size = UDim2.fromOffset(getTextBounds(textLabel).X + 18, 30)

				local btnBackground = create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = config.Enabled and 0.5 or 1,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = UDim2.fromScale(1, 1),
					BorderSizePixel = 0,
					ZIndex = button.ZIndex - 1,
					Parent = button
				}, {
					create("UICorner", { CornerRadius = UDim.new(0, 10) })
				})
				applyGradient(btnBackground, gradients)

				local btnShadow = create("ImageLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 18, 1, 18),
					Image = "rbxassetid://13960012399",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = config.Enabled and 0.5 or 1,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
					SliceScale = 0.1,
					Parent = btnBackground
				})
				applyGradient(btnShadow, gradients)

				button.MouseButton1Click:Connect(function() 
					config.Enabled = not config.Enabled
					TweenService:Create(textLabel, tweenInfo, { TextTransparency = config.Enabled and 0 or 0.5 }):Play()
					TweenService:Create(btnBackground, tweenInfo, { BackgroundTransparency = config.Enabled and 0.5 or 1 }):Play()
					TweenService:Create(btnShadow, tweenInfo, { ImageTransparency = config.Enabled and 0.5 or 1 }):Play()
				end)

				return button
			end

			function scrollingFrame:AddButton(config)
				return create("TextButton", {
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(),
					BackgroundTransparency = 0.9,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 0, 0, 36),
					FontFace = fontRegular,
					RichText = true,
					Text = tostring(config.Name or ""),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 15,
					TextTransparency = 0.5,
					ZIndex = dropdownFrame.ZIndex + 1,
					Parent = dropdownFrame
				}, {
					create("UICorner", { CornerRadius = UDim.new(0, 10) })
				})
			end

			function scrollingFrame:AddSmallButton(config)
				local button = create("TextButton", {
					AnchorPoint = Vector2.one * 0.5,
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Text = "",
					ZIndex = dropdownFrame.ZIndex + 1,
					Parent = dropdownFrame
				})

				local textLabel = create("TextLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 9, 0.5, 0),
					Size = UDim2.fromScale(1, 1),
					FontFace = fontRegular,
					RichText = true,
					Text = tostring(config.Name or ""),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 16,
					TextTransparency = 0,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = button.ZIndex + 1,
					Parent = button
				})

				button.Size = UDim2.fromOffset(getTextBounds(textLabel).X + 18, 30)

				local btnBackground = create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.5,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = UDim2.fromScale(1, 1),
					BorderSizePixel = 0,
					ZIndex = button.ZIndex - 1,
					Parent = button
				}, {
					create("UICorner", { CornerRadius = UDim.new(0, 10) })
				})
				applyGradient(btnBackground, gradients)

				local btnShadow = create("ImageLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 18, 1, 18),
					Image = "rbxassetid://13960012399",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
					SliceScale = 0.1,
					Parent = btnBackground
				})
				applyGradient(btnShadow, gradients)

				return button
			end

			function scrollingFrame:AddInput(config)
				local baseFrame = create("Frame", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					ZIndex = dropdownFrame.ZIndex + 1,
					Parent = dropdownFrame
				})

				local textBox = create("TextBox", {
					AutomaticSize = Enum.AutomaticSize.X,
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					ClearTextOnFocus = false,
					Position = UDim2.new(0.5, 9, 0.5, 0),
					Size = UDim2.fromScale(1, 1),
					FontFace = fontRegular,
					RichText = true,
					PlaceholderText = tostring(config.Name or ""),
					TextEditable = toboolean(config.TextEditable or true),
					Text = tostring(config.Text or ""),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					PlaceholderColor3 = Color3.fromRGB(215, 215, 215),
					TextSize = 16,
					TextTransparency = 0,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = baseFrame.ZIndex + 1,
					Parent = baseFrame
				})

				baseFrame.Size = UDim2.fromOffset(getTextBounds(textBox).X + 18, 30)

				textBox:GetPropertyChangedSignal("Text"):Connect(function() 
					baseFrame:TweenSize(UDim2.fromOffset(getTextBounds(textBox).X + 18, 30), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 1/30, true)
				end)

				local bgFrame = create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.5,
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.fromScale(0.5, 0),
					Size = UDim2.fromScale(1, 1),
					BorderSizePixel = 0,
					ZIndex = baseFrame.ZIndex - 1,
					Parent = baseFrame
				}, {
					create("UICorner", { CornerRadius = UDim.new(0, 10) })
				})
				applyGradient(bgFrame, gradients)

				local bgShadow = create("ImageLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 18, 1, 18),
					Image = "rbxassetid://13960012399",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
					SliceScale = 0.1,
					Parent = bgFrame
				})
				applyGradient(bgShadow, gradients)

				return textBox
			end

			function scrollingFrame:ClearAllChildren()
				for _, value in ipairs(self.Frame:GetDescendants()) do
					if value:IsA("GuiObject") then
						value:Destroy()
					end
				end
			end

			return scrollingFrame
		end
		
		function tab:AddCodeFrame(frameConfig)
			local backgroundFrame = create("Frame", {
				BackgroundColor3 = Color3.fromRGB(),
				BackgroundTransparency = 0.9,
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Size = frameConfig.Size,
				BorderSizePixel = 0,
				ZIndex = tabFrame.ZIndex + 1,
				Parent = tabFrame
			}, {
				create("UIPadding", {
					PaddingTop = UDim.new(0, 5), PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5)
				}),
				create("UICorner", { CornerRadius = UDim.new(0, 10) })
			})

			-- Arrow Drawer for Scrollbars
			local function createArrow(size, num, dir)
				local max = num
				local arrowFrame = create("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(0, size, 0, size)
				})

				for i = 1, num do
					local pos, sSize
					if dir == "up" then
						pos = UDim2.new(0, math.floor(size/2) - (i-1), 0, math.floor(size/2) + i - math.floor(max/2) - 1)
						sSize = UDim2.new(0, i + (i-1), 0, 1)
					elseif dir == "down" then
						pos = UDim2.new(0, math.floor(size/2) - (i-1), 0, math.floor(size/2) - i + math.floor(max/2) + 1)
						sSize = UDim2.new(0, i + (i-1), 0, 1)
					elseif dir == "left" then
						pos = UDim2.new(0, math.floor(size/2) + i - math.floor(max/2) - 1, 0, math.floor(size/2) - (i-1))
						sSize = UDim2.new(0, 1, 0, i + (i-1))
					elseif dir == "right" then
						pos = UDim2.new(0, math.floor(size/2) - i + math.floor(max/2) + 1, 0, math.floor(size/2) - (i-1))
						sSize = UDim2.new(0, 1, 0, i + (i-1))
					end

					create("Frame", {
						BackgroundColor3 = Color3.fromRGB(220, 220, 220),
						BorderSizePixel = 0,
						Position = pos,
						Size = sSize,
						Parent = arrowFrame
					})
				end
				return arrowFrame
			end

			-- ScrollBar Engine
			local ScrollBar = (function()
				local funcs = {}
				local dragDetector = canvasFrame:FindFirstChildWhichIsA("UIDragDetector")

				local function drawThumb(self)
					local total = self.TotalSpace
					local visible = self.VisibleSpace
					local scrollThumb = self.GuiElems.ScrollThumb
					local scrollThumbFrame = self.GuiElems.ScrollThumbFrame

					scrollThumb.Visible = (self:CanScrollUp() or self:CanScrollDown())

					if self.Horizontal then
						scrollThumb.Size = UDim2.new(visible/total, 0, 0, 9)
						local fs = scrollThumbFrame.AbsoluteSize.X
						local bs = scrollThumb.AbsoluteSize.X
						scrollThumb.AnchorPoint = Vector2.new(0, 0.5)
						scrollThumb.Position = UDim2.new(self:GetScrollPercent() * (fs-bs)/fs, 0, 0.5, 0)
					else
						scrollThumb.Size = UDim2.new(0, 9, visible/total, 0)
						local fs = scrollThumbFrame.AbsoluteSize.Y
						local bs = scrollThumb.AbsoluteSize.Y
						scrollThumb.AnchorPoint = Vector2.new(0.5, 0)
						scrollThumb.Position = UDim2.new(0.5, 0, self:GetScrollPercent() * (fs-bs)/fs, 0)
					end
				end

				local function createFrame(self)
					local newFrame = create("Frame", {
						Active = true, AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Color3.fromRGB(90, 90, 90),
						BackgroundTransparency = 1, BorderSizePixel = 0,
						Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 1, 0),
						ZIndex = 1
					})

					local button1, button2
					if self.Horizontal then
						newFrame.Size = UDim2.new(1, 0, 0, 16)
						button1 = create("ImageButton", { Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, AutoButtonColor = false, Parent = newFrame })
						createArrow(16, 4, "left").Parent = button1
						button2 = create("ImageButton", { Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, AutoButtonColor = false, Parent = newFrame })
						createArrow(16, 4, "right").Parent = button2
					else
						newFrame.Size = UDim2.new(0, 16, 1, 0)
						button1 = create("ImageButton", { Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, AutoButtonColor = false, Parent = newFrame })
						createArrow(16, 4, "up").Parent = button1
						button2 = create("ImageButton", { Position = UDim2.new(0, 0, 1, -16), Size = UDim2.new(0, 16, 0, 16), BackgroundTransparency = 1, AutoButtonColor = false, Parent = newFrame })
						createArrow(16, 4, "down").Parent = button2
					end

					local scrollThumbFrame = create("Frame", { BackgroundTransparency = 1, Parent = newFrame })
					if self.Horizontal then
						scrollThumbFrame.Position = UDim2.new(0, 16, 0, 0)
						scrollThumbFrame.Size = UDim2.new(1, -32, 1, 0)
					else
						scrollThumbFrame.Position = UDim2.new(0, 0, 0, 16)
						scrollThumbFrame.Size = UDim2.new(1, 0, 1, -32)
					end

					local scrollThumb = create("Frame", {
						BackgroundColor3 = Color3.fromRGB(120, 120, 120),
						BorderSizePixel = 0, Parent = scrollThumbFrame
					}, { create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

					local markerFrame = create("Frame", {
						BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = scrollThumbFrame
					})

					local buttonPress, thumbPress, thumbFramePress = false, false, false

					local function setupButtonEvents(btn, checkScrollFunc, scrollFunc)
						btn.InputBegan:Connect(function(input)
							if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not buttonPress and self[checkScrollFunc](self) then btn.BackgroundTransparency = 0.8 end
							if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not self[checkScrollFunc](self) then return end

							buttonPress = true
							btn.BackgroundTransparency = 0.5
							if self[checkScrollFunc](self) then self[scrollFunc](self); self.Scrolled:Fire() end

							local buttonTick = os.clock()
							local releaseEvent
							releaseEvent = UserInputService.InputEnded:Connect(function(endInput)
								if endInput.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
								releaseEvent:Disconnect()
								btn.BackgroundTransparency = (mouseInGui(btn) and self[checkScrollFunc](self)) and 0.8 or 1
								buttonPress = false
							end)

							while buttonPress do
								if os.clock() - buttonTick >= 0.3 and self[checkScrollFunc](self) then
									self[scrollFunc](self); self.Scrolled:Fire()
								end
								task.wait()
							end
						end)
						btn.InputEnded:Connect(function(input)
							if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not buttonPress then btn.BackgroundTransparency = 1 end
						end)
					end

					setupButtonEvents(button1, "CanScrollUp", "ScrollUp")
					setupButtonEvents(button2, "CanScrollDown", "ScrollDown")

					scrollThumb.InputBegan:Connect(function(input)
						if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not thumbPress then scrollThumb.BackgroundTransparency = 0.2; scrollThumb.BackgroundColor3 = self.ThumbSelectColor end
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

						local dir = self.Horizontal and "X" or "Y"
						local lastThumbPos = nil
						buttonPress, thumbFramePress = false, false			
						thumbPress = true
						scrollThumb.BackgroundTransparency = 0

						local currentMouse = getMouseLocation()
						local mouseOffset = currentMouse[dir] - scrollThumb.AbsolutePosition[dir]

						local releaseEvent, mouseEvent
						releaseEvent = UserInputService.InputEnded:Connect(function(endInput)
							if endInput.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
							releaseEvent:Disconnect()
							if mouseEvent then mouseEvent:Disconnect() end

							if mouseInGui(scrollThumb) then
								scrollThumb.BackgroundTransparency = 0.2 
							else 
								scrollThumb.BackgroundTransparency = 0 
								scrollThumb.BackgroundColor3 = self.ThumbColor
							end
							thumbPress = false
						end)

						self:Update()
						if dragDetector then dragDetector.Enabled = false end

						mouseEvent = UserInputService.InputChanged:Connect(function(changeInput)
							if (changeInput.UserInputType == Enum.UserInputType.MouseMovement or changeInput.UserInputType == Enum.UserInputType.Touch) and thumbPress then
								currentMouse = getMouseLocation()
								local thumbFrameSize = scrollThumbFrame.AbsoluteSize[dir] - scrollThumb.AbsoluteSize[dir]
								local pos = math.clamp(currentMouse[dir] - scrollThumbFrame.AbsolutePosition[dir] - mouseOffset, 0, thumbFrameSize)

								if lastThumbPos ~= pos then
									lastThumbPos = pos
									self:ScrollTo(math.floor(0.5 + pos / thumbFrameSize * (self.TotalSpace - self.VisibleSpace)))
								end
							end
						end)
					end)

					scrollThumb.InputEnded:Connect(function(input)
						if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and not thumbPress then
							scrollThumb.BackgroundTransparency = 0
							scrollThumb.BackgroundColor3 = self.ThumbColor
							if dragDetector then dragDetector.Enabled = true end
						end
					end)

					newFrame.MouseWheelForward:Connect(function() self:ScrollTo(self.Index - self.WheelIncrement) end)
					newFrame.MouseWheelBackward:Connect(function() self:ScrollTo(self.Index + self.WheelIncrement) end)

					self.GuiElems.ScrollThumb = scrollThumb
					self.GuiElems.ScrollThumbFrame = scrollThumbFrame
					self.GuiElems.Button1 = button1
					self.GuiElems.Button2 = button2
					self.GuiElems.MarkerFrame = markerFrame

					return newFrame
				end

				funcs.Update = function(self)
					self.Index = math.clamp(self.Index, 0, math.max(0, self.TotalSpace - self.VisibleSpace))

					if self.LastTotalSpace ~= self.TotalSpace then
						self.LastTotalSpace = self.TotalSpace
						self:UpdateMarkers()
					end

					local function updateArrows(btn, canScroll)
						btn.BackgroundTransparency = canScroll and 0 or 1
						for _, v in ipairs(btn:GetChildren()) do
							v.BackgroundTransparency = canScroll and 0 or 0.5
						end
					end

					updateArrows(self.GuiElems.Button1, self:CanScrollUp())
					updateArrows(self.GuiElems.Button2, self:CanScrollDown())
					drawThumb(self)
				end

				funcs.UpdateMarkers = function(self)
					local markerFrame = self.GuiElems.MarkerFrame
					for _, child in ipairs(markerFrame:GetChildren()) do child:Destroy() end

					for i, color in pairs(self.Markers) do
						if i < self.TotalSpace then
							create("Frame", {
								BackgroundColor3 = color, BorderSizePixel = 0,
								Position = self.Horizontal and UDim2.new(i/self.TotalSpace, 0, 1, -6) or UDim2.new(1, -6, i/self.TotalSpace, 0),
								Size = self.Horizontal and UDim2.new(0, 1, 0, 6) or UDim2.new(0, 6, 0, 1),
								Parent = markerFrame
							})
						end
					end
				end

				funcs.ScrollTo = function(self, ind, nocallback)
					self.Index = ind
					self:Update()
					if not nocallback then self.Scrolled:Fire() end
				end
				funcs.ScrollUp = function(self) self.Index -= self.Increment; self:Update() end
				funcs.ScrollDown = function(self) self.Index += self.Increment; self:Update() end
				funcs.CanScrollUp = function(self) return self.Index > 0 end
				funcs.CanScrollDown = function(self) return self.Index + self.VisibleSpace < self.TotalSpace end
				funcs.GetScrollPercent = function(self) return self.Index / math.max(1, (self.TotalSpace - self.VisibleSpace)) end
				funcs.Texture = function(self, data)
					self.ThumbColor = data.ThumbColor or Color3.new()
					self.ThumbSelectColor = data.ThumbSelectColor or Color3.new()
					self.GuiElems.ScrollThumb.BackgroundColor3 = self.ThumbColor
					self.Gui.BackgroundColor3 = data.FrameColor or Color3.new()
					for _, btn in ipairs({self.GuiElems.Button1, self.GuiElems.Button2}) do
						for _, arrow in ipairs(btn:GetChildren()) do
							arrow.BackgroundColor3 = data.ArrowColor or Color3.new()
						end
					end
				end
				funcs.SetScrollFrame = function(self, frame)
					if self.ScrollUpEvent then self.ScrollUpEvent:Disconnect() end
					if self.ScrollDownEvent then self.ScrollDownEvent:Disconnect() end
					self.ScrollUpEvent = frame.MouseWheelForward:Connect(function() self:ScrollTo(self.Index - self.WheelIncrement) end)
					self.ScrollDownEvent = frame.MouseWheelBackward:Connect(function() self:ScrollTo(self.Index + self.WheelIncrement) end)
				end

				local mt = {__index = funcs}
				local function new(hor)
					local obj = setmetatable({
						Index = 0, VisibleSpace = 0, TotalSpace = 0, Increment = 1, WheelIncrement = 1,
						Markers = {}, GuiElems = {}, Horizontal = hor, LastTotalSpace = 0, Scrolled = signal.new()
					}, mt)
					obj.Gui = createFrame(obj)
					obj:Texture({
						ThumbColor = Color3.fromRGB(60, 60, 60), ThumbSelectColor = Color3.fromRGB(75, 75, 75),
						ArrowColor = Color3.new(1, 1, 1), FrameColor = Color3.fromRGB(40, 40, 40),
					})
					return obj
				end
				return {new = new}
			end)()
			
			local rgb = Color3.fromRGB

			-- Pulled Settings table to localize syntax colors cleanly
			local Settings = {
				Theme = {
					Syntax = {
						Text = rgb(204, 204, 204), Background = rgb(36, 36, 36), Selection = rgb(255, 255, 255),
						SelectionBack = rgb(11, 90, 175), Operator = rgb(204, 204, 204), Number = rgb(255, 198, 0),
						String = rgb(173, 241, 149), Comment = rgb(102, 102, 102), Keyword = rgb(248, 109, 124),
						Error = rgb(255, 0, 0), FindBackground = rgb(141, 118, 0), MatchingWord = rgb(85, 85, 85),
						BuiltIn = rgb(132, 214, 247), CurrentLine = rgb(45, 50, 65), LocalMethod = rgb(253, 251, 172),
						LocalProperty = rgb(97, 161, 241), Nil = rgb(255, 198, 0), Bool = rgb(255, 198, 0),
						Function = rgb(248, 109, 124), Local = rgb(248, 109, 124), Self = rgb(248, 109, 124),
						FunctionName = rgb(253, 251, 172), Bracket = rgb(204, 204, 204)
					}
				}
			}

			local CodeFrame = (function()
				local funcs = {}

				local typeMap = {
					[1] = "String", [2] = "String", [3] = "String", [4] = "Comment", [5] = "Operator",
					[6] = "Number", [7] = "Keyword", [8] = "BuiltIn", [9] = "LocalMethod", [10] = "LocalProperty",
					[11] = "Nil", [12] = "Bool", [13] = "Function", [14] = "Local", [15] = "Self",
					[16] = "FunctionName", [17] = "Bracket"
				}

				local specialKeywordsTypes = {
					["nil"] = 11, ["true"] = 12, ["false"] = 12, ["function"] = 13, ["local"] = 14, ["self"] = 15
				}

				local keywords = {
					["and"] = true, ["break"] = true, ["do"] = true, ["else"] = true, ["elseif"] = true,
					["end"] = true, ["false"] = true, ["for"] = true, ["function"] = true, ["if"] = true,
					["in"] = true, ["local"] = true, ["nil"] = true, ["not"] = true, ["or"] = true,
					["repeat"] = true, ["return"] = true, ["then"] = true, ["true"] = true, ["until"] = true,
					["while"] = true, ["plugin"] = true
				}

				local builtIns = {
					["delay"] = true, ["elapsedTime"] = true, ["require"] = true, ["spawn"] = true, ["tick"] = true,
					["time"] = true, ["typeof"] = true, ["UserSettings"] = true, ["task"] = true, ["wait"] = true,
					["warn"] = true, ["game"] = true, ["shared"] = true, ["script"] = true, ["workspace"] = true,
					["assert"] = true, ["collectgarbage"] = true, ["error"] = true, ["getfenv"] = true,
					["getmetatable"] = true, ["ipairs"] = true, ["loadstring"] = true, ["newproxy"] = true,
					["next"] = true, ["pairs"] = true, ["pcall"] = true, ["print"] = true, ["rawequal"] = true,
					["rawget"] = true, ["rawset"] = true, ["select"] = true, ["setfenv"] = true,
					["setmetatable"] = true, ["tonumber"] = true, ["tostring"] = true, ["type"] = true,
					["unpack"] = true, ["xpcall"] = true, ["_G"] = true, ["_VERSION"] = true, ["coroutine"] = true,
					["debug"] = true, ["math"] = true, ["os"] = true, ["string"] = true, ["table"] = true,
					["bit32"] = true, ["utf8"] = true, ["Axes"] = true, ["BrickColor"] = true, ["CFrame"] = true,
					["Color3"] = true, ["ColorSequence"] = true, ["ColorSequenceKeypoint"] = true,
					["DockWidgetPluginGuiInfo"] = true, ["Enum"] = true, ["Faces"] = true, ["Instance"] = true,
					["NumberRange"] = true, ["NumberSequence"] = true, ["NumberSequenceKeypoint"] = true,
					["PathWaypoint"] = true, ["PhysicalProperties"] = true, ["Random"] = true, ["Ray"] = true,
					["Rect"] = true, ["Region3"] = true, ["Region3int16"] = true, ["TweenInfo"] = true,
					["UDim"] = true, ["UDim2"] = true, ["Vector2"] = true, ["Vector2int16"] = true,
					["Vector3"] = true, ["Vector3int16"] = true
				}

				local builtInInited = false
				local richReplace = { ["'"] = "&apos;", ["\""] = "&quot;", ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;" }
				local lineTweens = {}

				local function initBuiltIn()
					for name, _ in pairs(builtIns) do
						local envVal = getfenv()[name]
						if type(envVal) == "table" then
							local items = {}
							for i, v in pairs(envVal) do items[i] = true end
							builtIns[name] = items
						end
					end

					local enumEntries = {}
					for _, enum in ipairs(Enum:GetEnums()) do enumEntries[tostring(enum)] = true end
					builtIns["Enum"] = enumEntries
					builtInInited = true
				end

				local function setupEditBox(obj)
					local editBox = obj.GuiElems.EditBox

					editBox.Focused:Connect(function()
						obj:ConnectEditBoxEvent()
						obj.Editing = true
					end)

					editBox.FocusLost:Connect(function()
						obj:DisconnectEditBoxEvent()
						obj.Editing = false
					end)

					obj.TextChangedSignal = editBox:GetPropertyChangedSignal("Text"):Connect(function()
						local text = editBox.Text
						if #text == 0 then return end
						editBox.Text = ""
						obj:AppendText(text)
					end)
				end

				local function setupMouseSelection(obj)
					local codeFrame = obj.GuiElems.LinesFrame
					local lines = obj.Lines

					codeFrame.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							local currentMouse = getMouseLocation()
							local fontSizeX, fontSizeY = math.ceil(obj.FontSize/2), obj.FontSize
							local relX = currentMouse.X - codeFrame.AbsolutePosition.X
							local relY = currentMouse.Y - codeFrame.AbsolutePosition.Y
							local selX = math.round(relX / fontSizeX) + obj.ViewX
							local selY = math.floor(relY / fontSizeY) + obj.ViewY

							local releaseEvent, mouseEvent, scrollEvent
							local scrollPowerV, scrollPowerH = 0, 0

							selY = math.min(#lines - 1, selY)
							local relativeLine = lines[selY + 1] or ""
							selX = math.min(#relativeLine, selX + obj:TabAdjust(selX, selY))

							obj.SelectionRange = {{-1, -1}, {-1, -1}}
							obj:MoveCursor(selX, selY)
							obj.FloatCursorX = selX

							local function updateSelection()
								currentMouse = getMouseLocation()
								local currRelX = currentMouse.X - codeFrame.AbsolutePosition.X
								local currRelY = currentMouse.Y - codeFrame.AbsolutePosition.Y
								local sel2X = math.max(0, math.round(currRelX / fontSizeX) + obj.ViewX)
								local sel2Y = math.max(0, math.floor(currRelY / fontSizeY) + obj.ViewY)

								sel2Y = math.min(#lines - 1, sel2Y)
								local currRelativeLine = lines[sel2Y + 1] or ""
								sel2X = math.min(#currRelativeLine, sel2X + obj:TabAdjust(sel2X, sel2Y))

								if sel2Y < selY or (sel2Y == selY and sel2X < selX) then
									obj.SelectionRange = {{sel2X, sel2Y}, {selX, selY}}
								else						
									obj.SelectionRange = {{selX, selY}, {sel2X, sel2Y}}
								end

								obj:MoveCursor(sel2X, sel2Y)
								obj.FloatCursorX = sel2X
								obj:Refresh()
							end

							releaseEvent = UserInputService.InputEnded:Connect(function(endInput)
								if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
									releaseEvent:Disconnect()
									mouseEvent:Disconnect()
									scrollEvent:Disconnect()
									obj:SetCopyableSelection()
								end
							end)

							mouseEvent = UserInputService.InputChanged:Connect(function(changeInput)
								if changeInput.UserInputType == Enum.UserInputType.MouseMovement or changeInput.UserInputType == Enum.UserInputType.Touch then
									currentMouse = getMouseLocation()
									local upDelta = currentMouse.Y - codeFrame.AbsolutePosition.Y
									local downDelta = currentMouse.Y - codeFrame.AbsolutePosition.Y - codeFrame.AbsoluteSize.Y
									local leftDelta = currentMouse.X - codeFrame.AbsolutePosition.X
									local rightDelta = currentMouse.X - codeFrame.AbsolutePosition.X - codeFrame.AbsoluteSize.X
									scrollPowerV, scrollPowerH = 0, 0

									if downDelta > 0 then scrollPowerV = math.floor(downDelta * 0.05) + 1
									elseif upDelta < 0 then scrollPowerV = math.ceil(upDelta * 0.05) - 1 end
									if rightDelta > 0 then scrollPowerH = math.floor(rightDelta * 0.05) + 1
									elseif leftDelta < 0 then scrollPowerH = math.ceil(leftDelta * 0.05) - 1 end

									updateSelection()
								end
							end)

							scrollEvent = RunService.Heartbeat:Connect(function()
								if scrollPowerV ~= 0 or scrollPowerH ~= 0 then
									obj:ScrollDelta(scrollPowerH, scrollPowerV)
									updateSelection()
								end
							end)

							obj:Refresh()
						end
					end)
				end

				local function makeFrame(obj)
					local frame = create("Frame", {
						BackgroundTransparency = 1, BackgroundColor3 = Color3.new(0.156, 0.156, 0.156),
						BorderSizePixel = 0, Size = UDim2.fromScale(1, 1)
					})

					local elems = {}

					local linesFrame = create("Frame", {
						BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
						ClipsDescendants = true, Parent = frame
					})

					-- FIXED: Explicitly set Font and TextSize so it aligns with the code lines
					local lineNumbersLabel = create("TextLabel", {
						BackgroundTransparency = 1, 
						Font = Enum.Font.Code, 
						TextSize = obj.FontSize, 
						TextXAlignment = Enum.TextXAlignment.Right, 
						TextYAlignment = Enum.TextYAlignment.Top,
						ClipsDescendants = true, RichText = true, Parent = frame
					})

					local cursor = create("Frame", {
						BackgroundColor3 = Color3.fromRGB(220, 220, 220), BorderSizePixel = 0, Parent = frame
					})

					-- FIXED: EditBox needs the monospace code font and matching size too
					local editBox = create("TextBox", { 
						MultiLine = true, Visible = false, 
						Font = Enum.Font.Code,
						TextSize = obj.FontSize,
						Parent = frame 
					})

					lineTweens.Invis = TweenService:Create(cursor, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
					lineTweens.Vis = TweenService:Create(cursor, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0})

					elems.LinesFrame = linesFrame
					elems.LineNumbersLabel = lineNumbersLabel
					elems.Cursor = cursor
					elems.EditBox = editBox
					elems.ScrollCorner = create("Frame", {
						BackgroundTransparency = 1, BackgroundColor3 = Color3.new(0.156, 0.156, 0.156),
						BorderSizePixel = 0, Position = UDim2.new(1, -16, 1, -16),
						Size = UDim2.new(0, 16, 0, 16), Visible = false, Parent = frame
					})

					linesFrame.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							obj:SetEditing(true, input)
						end
					end)

					obj.Frame = frame
					obj.Gui = frame
					obj.GuiElems = elems
					setupEditBox(obj)
					setupMouseSelection(obj)

					return frame
				end
				
				funcs.GetSelectionText = function(self)
					if not self:IsValidRange() then return "" end

					local selectionRange = self.SelectionRange
					local selX, selY = selectionRange[1][1], selectionRange[1][2]
					local sel2X, sel2Y = selectionRange[2][1], selectionRange[2][2]
					local deltaLines = sel2Y - selY
					local lines = self.Lines

					if not lines[selY + 1] or not lines[sel2Y + 1] then return "" end

					if deltaLines == 0 then
						return self:ConvertText(lines[selY + 1]:sub(selX + 1, sel2X), false)
					end

					local leftSub = lines[selY + 1]:sub(selX + 1)
					local rightSub = lines[sel2Y + 1]:sub(1, sel2X)

					local result = leftSub .. "\n" 
					for i = selY + 1, sel2Y - 1 do
						result = result .. lines[i + 1] .. "\n"
					end
					result = result .. rightSub

					return self:ConvertText(result, false)
				end

				funcs.SetCopyableSelection = function(self)
					if not self:IsValidRange() then return end

					local text = self:GetSelectionText()
					local editBox = self.GuiElems.EditBox

					if self.TextChangedSignal then self.TextChangedSignal:Disconnect() end

					editBox.Text = text
					editBox.SelectionStart = 1
					editBox.CursorPosition = #editBox.Text + 1

					self.TextChangedSignal = editBox:GetPropertyChangedSignal("Text"):Connect(function()
						local currentText = editBox.Text
						if #currentText == 0 then return end
						editBox.Text = ""
						self:AppendText(currentText)
					end)

					self.EditBoxCopying = false
				end

				funcs.ConnectEditBoxEvent = function(self)
					if self.EditBoxEvent then self.EditBoxEvent:Disconnect() end

					self.EditBoxEvent = UserInputService.InputBegan:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

						local keycodes = Enum.KeyCode
						local keycode = input.KeyCode

						local function setupMove(key, func)
							local endCon, finished
							endCon = UserInputService.InputEnded:Connect(function(endInput)
								if endInput.KeyCode ~= key then return end
								endCon:Disconnect()
								finished = true
							end)
							func()
							task.wait(0.5)
							while not finished do func(); task.wait(0.03) end
						end

						if keycode == keycodes.Down then
							setupMove(keycodes.Down, function()
								self.CursorX = self.FloatCursorX
								self.CursorY += 1
								self:UpdateCursor()
								self:JumpToCursor()
							end)
						elseif keycode == keycodes.Up then
							setupMove(keycodes.Up, function()
								self.CursorX = self.FloatCursorX
								self.CursorY -= 1
								self:UpdateCursor()
								self:JumpToCursor()
							end)
						elseif keycode == keycodes.Left then
							setupMove(keycodes.Left, function()
								local line = self.Lines[self.CursorY + 1] or ""
								self.CursorX = self.CursorX - 1 - (line:sub(self.CursorX - 3, self.CursorX) == "\t" and 0 or 0)
								if self.CursorX < 0 then
									self.CursorY -= 1
									local line2 = self.Lines[self.CursorY + 1] or ""
									self.CursorX = #line2
								end
								self.FloatCursorX = self.CursorX
								self:UpdateCursor()
								self:JumpToCursor()
							end)
						elseif keycode == keycodes.Right then
							setupMove(keycodes.Right, function()
								local line = self.Lines[self.CursorY + 1] or ""
								self.CursorX = self.CursorX + 1 + (line:sub(self.CursorX + 1, self.CursorX + 4) == "\t" and 0 or 0)
								if self.CursorX > #line then
									self.CursorY += 1
									self.CursorX = 0
								end
								self.FloatCursorX = self.CursorX
								self:UpdateCursor()
								self:JumpToCursor()
							end)
						elseif keycode == keycodes.Return then
							setupMove(keycodes.Return, function()
								self:UpdateCursor()
								self:JumpToCursor()
							end)
						elseif keycode == keycodes.Backspace then
							setupMove(keycodes.Backspace, function()
								local startRange, endRange
								if self:IsValidRange() then
									startRange = self.SelectionRange[1]
									endRange = self.SelectionRange[2]
								else
									endRange = {self.CursorX - self:TabAdjust(self.CursorX, self.CursorY), self.CursorY}
								end

								if not startRange then
									self.CursorX = self.CursorX - 1 - self:TabAdjust(self.CursorX, self.CursorY)
									if self.CursorX < 0 then
										self.CursorY -= 1
										local line2 = self.Lines[self.CursorY + 1] or ""
										self.CursorX = #line2
									end
									self.FloatCursorX = self.CursorX
									self:UpdateCursor()
									startRange = {self.CursorX - self:TabAdjust(self.CursorX, self.CursorY), self.CursorY}
								end

								self:DeleteRange({startRange, endRange}, false, true)
								self:ResetSelection(true)
								self:JumpToCursor()
							end)
						elseif keycode == keycodes.Delete then
							setupMove(keycodes.Delete, function()
								local startRange, endRange
								if self:IsValidRange() then
									startRange = self.SelectionRange[1]
									endRange = self.SelectionRange[2]
								else
									startRange = {self.CursorX, self.CursorY}
								end

								if not endRange then
									local line = self.Lines[self.CursorY + 1] or ""
									local endCursorX = self.CursorX + 1 + (line:sub(self.CursorX + 1, self.CursorX + 4) == "\t" and 0 or 0)
									local endCursorY = self.CursorY
									if endCursorX > #line then
										endCursorY += 1
										endCursorX = 0
									end
									self:UpdateCursor()
									endRange = {endCursorX, endCursorY}
								end

								self:DeleteRange({startRange, endRange}, false, true)
								self:ResetSelection(true)
								self:JumpToCursor()
							end)
						elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and keycode == keycodes.A then
							self.SelectionRange = {{0, 0}, {#self.Lines[#self.Lines], #self.Lines - 1}}
							self:SetCopyableSelection()
							self:Refresh()
						end
					end)
				end

				funcs.DisconnectEditBoxEvent = function(self)
					if self.EditBoxEvent then self.EditBoxEvent:Disconnect() end
				end

				funcs.ResetSelection = function(self, norefresh)
					self.SelectionRange = {{-1, -1}, {-1, -1}}
					if not norefresh then self:Refresh() end
				end

				funcs.IsValidRange = function(self, range)
					local selectionRange = range or self.SelectionRange
					local selX, selY = selectionRange[1][1], selectionRange[1][2]
					local sel2X, sel2Y = selectionRange[2][1], selectionRange[2][2]
					return not (selX == -1 or (selX == sel2X and selY == sel2Y))
				end

				funcs.DeleteRange = function(self, range, noprocess, updatemouse)
					range = range or self.SelectionRange
					if not self:IsValidRange(range) then return end

					local lines = self.Lines
					local selX, selY = range[1][1], range[1][2]
					local sel2X, sel2Y = range[2][1], range[2][2]
					local deltaLines = sel2Y - selY

					if not lines[selY + 1] or not lines[sel2Y + 1] then return end

					local leftSub = lines[selY + 1]:sub(1, selX)
					local rightSub = lines[sel2Y + 1]:sub(sel2X + 1)
					lines[selY + 1] = leftSub .. rightSub

					for i = 1, deltaLines do
						table.remove(lines, selY + 2)
					end

					if range == self.SelectionRange then self.SelectionRange = {{-1, -1}, {-1, -1}} end
					if updatemouse then
						self.CursorX = selX
						self.CursorY = selY
						self:UpdateCursor()
					end

					if not noprocess then self:ProcessTextChange() end
				end

				funcs.AppendText = function(self, text)
					self:DeleteRange(nil, true, true)
					local lines, cursorX, cursorY = self.Lines, self.CursorX, self.CursorY
					local line = lines[cursorY + 1]
					local before = line:sub(1, cursorX)
					local after = line:sub(cursorX + 1)

					text = text:gsub("\r\n", "\n")
					text = self:ConvertText(text, true)

					local textLines = text:split("\n")

					for i = 1, #textLines do
						local linePos = cursorY + i
						if i > 1 then table.insert(lines, linePos, "") end

						local textLine = textLines[i]
						local newBefore = (i == 1 and before or "")
						local newAfter = (i == #textLines and after or "")

						lines[linePos] = newBefore .. textLine .. newAfter
					end

					if #textLines > 1 then cursorX = 0 end

					self:ProcessTextChange()
					self.CursorX = cursorX + #textLines[#textLines]
					self.CursorY = cursorY + #textLines - 1
					self:UpdateCursor()
				end

				funcs.ScrollDelta = function(self, x, y)
					self.ScrollV:ScrollTo(self.ScrollV.Index + y)
					self.ScrollH:ScrollTo(self.ScrollH.Index + x)
				end

				funcs.TabAdjust = function(self, x, y)
					local line = self.Lines[y + 1]
					x += 1
					if line then
						local tabs = #line:split("\t") - 1
						if tabs > 0 then return 3 * tabs end
					end
					return 0
				end

				funcs.SetEditing = function(self, on, input)			
					self:UpdateCursor(input)
					if on then
						if self.Editable then
							self.GuiElems.EditBox.Text = ""
							self.GuiElems.EditBox:CaptureFocus()
						end
					else
						self.GuiElems.EditBox:ReleaseFocus()
					end
				end

				funcs.CursorAnim = function(self, on)
					local cursor = self.GuiElems.Cursor
					local animTime = os.clock()
					self.LastAnimTime = animTime

					if not on then return end

					lineTweens.Invis:Cancel()
					lineTweens.Vis:Cancel()
					cursor.BackgroundTransparency = 0

					local codeBox = self.GuiElems.EditBox

					local function onFocus()
						while self.Editable and codeBox:IsFocused() do
							task.wait(0.5)
							if self.LastAnimTime ~= animTime then return end
							lineTweens.Invis:Play()
							task.wait(0.4)
							if self.LastAnimTime ~= animTime then return end
							lineTweens.Vis:Play()
							task.wait(0.2)
						end
					end

					if codeBox:IsFocused() then task.spawn(onFocus) end
					codeBox.Focused:Connect(onFocus)
				end

				funcs.MoveCursor = function(self, x, y)
					self.CursorX = x; self.CursorY = y
					self:UpdateCursor(); self:JumpToCursor()
				end

				funcs.JumpToCursor = function(self) self:Refresh() end

				funcs.UpdateCursor = function(self, input)
					local linesFrame = self.GuiElems.LinesFrame
					local cursor = self.GuiElems.Cursor			
					local hSize = math.max(0, linesFrame.AbsoluteSize.X)
					local vSize = math.max(0, linesFrame.AbsoluteSize.Y)
					local maxLines = math.ceil(vSize / self.FontSize)
					local maxCols = math.ceil(hSize / math.ceil(self.FontSize/2))
					local viewX, viewY = self.ViewX, self.ViewY
					local fontWidth = math.ceil(self.FontSize / 2)
					local linesOffset = #tostring(#self.Lines) * fontWidth + 4 * fontWidth

					if input then
						local frameX, frameY = linesFrame.AbsolutePosition.X, linesFrame.AbsolutePosition.Y
						local currentMouse = getMouseLocation()
						self.CursorX = self.ViewX + math.round((currentMouse.X - frameX) / fontWidth)
						self.CursorY = self.ViewY + math.floor((currentMouse.Y - frameY) / self.FontSize)
					end

					local cursorX, cursorY = self.CursorX, self.CursorY

					local line = self.Lines[cursorY + 1] or ""
					if cursorX > #line then cursorX = #line elseif cursorX < 0 then cursorX = 0 end

					if cursorY >= #self.Lines then cursorY = math.max(0, #self.Lines - 1)
					elseif cursorY < 0 then cursorY = 0 end

					cursorX += self:TabAdjust(cursorX, cursorY)

					self.CursorX = cursorX
					self.CursorY = cursorY

					local cursorVisible = (cursorX >= viewX) and (cursorY >= viewY) and (cursorX <= viewX + maxCols) and (cursorY <= viewY + maxLines)
					if cursorVisible then
						cursor.Position = UDim2.fromOffset(linesOffset + (cursorX - viewX) * fontWidth - 1, (cursorY - viewY) * self.FontSize)
						cursor.Size = UDim2.fromOffset(1, self.FontSize + 2)
						cursor.Visible = true
						self:CursorAnim(true)
					else
						cursor.Visible = false
					end
				end

				funcs.MapNewLines = function(self)
					local newLines = {}
					local text = self.Text
					local pos, init, count = string.find(text, "\n", 1, true), 1, 1

					while pos do
						newLines[count] = pos
						count += 1
						init = pos + 1
						pos = string.find(text, "\n", init, true)
					end
					self.NewLines = newLines
				end

				funcs.PreHighlight = function(self)
					local text = self.Text:gsub("\\\\", "  ")
					local textLen = #text
					local found, foundMap, extras = {}, {}, {}
					self.ColoredLines = {}

					local function findAll(pattern, typ, raw)
						local init = 1
						local x, y, extra = string.find(text, pattern, init, raw)
						while x do
							table.insert(found, x)
							foundMap[x] = typ
							if extra then extras[x] = extra end
							init = y + 1
							x, y, extra = string.find(text, pattern, init, raw)
						end
					end

					findAll('"', 1, true)
					findAll("'", 2, true)
					findAll("%[(=*)%[", 3)
					findAll("--", 4, true)
					table.sort(found)

					local newLines = self.NewLines
					local curLine = 0
					local lineEnd = 0
					local lastEnding = 0
					local foundHighlights = {}

					for i = 1, #found do
						local pos = found[i]
						if pos <= lastEnding then continue end

						local ending = pos
						local typ = foundMap[pos]

						if typ == 1 then
							ending = string.find(text, '"', pos + 1, true)
							while ending and string.sub(text, ending - 1, ending - 1) == "\\" do ending = string.find(text, '"', ending + 1, true) end
							ending = ending or textLen
						elseif typ == 2 then
							ending = string.find(text, "'", pos + 1, true)
							while ending and string.sub(text, ending - 1, ending - 1) == "\\" do ending = string.find(text, "'", ending + 1, true) end
							ending = ending or textLen
						elseif typ == 3 then
							_, ending = string.find(text, "]" .. extras[pos] .. "]", pos + 1, true)
							ending = ending or textLen
						elseif typ == 4 then
							if foundMap[pos + 2] == 3 then
								_, ending = string.find(text, "]" .. extras[pos + 2] .. "]", pos + 1, true)
								ending = ending or textLen
							else
								ending = string.find(text, "\n", pos + 1, true) or textLen
							end
						end

						while pos > lineEnd do
							curLine += 1
							lineEnd = newLines[curLine] or textLen + 1
						end
						while true do
							if not foundHighlights[curLine] then foundHighlights[curLine] = {} end
							foundHighlights[curLine][pos] = {typ, ending}

							if ending > lineEnd then
								curLine += 1
								lineEnd = newLines[curLine] or textLen + 1
							else
								break
							end
						end
						lastEnding = ending
					end
					self.PreHighlights = foundHighlights
				end

				funcs.HighlightLine = function(self, line)
					if self.ColoredLines[line] then return self.ColoredLines[line] end

					local highlights = {}
					local preHighlights = self.PreHighlights[line] or {}
					local lineText = self.Lines[line] or ""
					local lastEnding, currentType, funcStatus = 0, 0, 0
					local lastWord, wordBeginsDotted = nil, false
					local lineStart = self.NewLines[line - 1] or 0

					local preHighlightMap = {}
					for pos, data in pairs(preHighlights) do
						local relativePos = pos - lineStart
						if relativePos < 1 then
							currentType = data[1]
							lastEnding = data[2] - lineStart
						else
							preHighlightMap[relativePos] = {data[1], data[2] - lineStart}
						end
					end

					for col = 1, #lineText do
						if col <= lastEnding then highlights[col] = currentType; continue end

						local pre = preHighlightMap[col]
						if pre then
							currentType, lastEnding = pre[1], pre[2]
							highlights[col] = currentType
							wordBeginsDotted, lastWord, funcStatus = false, nil, 0
						else
							local char = string.sub(lineText, col, col)
							if string.find(char, "[%a_]") then
								local word = string.match(lineText, "[%a%d_]+", col)
								local wordType = (keywords[word] and 7) or (builtIns[word] and 8)
								lastEnding = col + #word - 1

								if wordType ~= 7 then
									if wordBeginsDotted then
										local prevBuiltIn = lastWord and builtIns[lastWord]
										wordType = (prevBuiltIn and type(prevBuiltIn) == "table" and prevBuiltIn[word] and 8) or 10
									end
									if wordType ~= 8 then
										local x, y, br = string.find(lineText, "^%s*([%({\"'])", lastEnding + 1)
										if x then wordType = (funcStatus > 0 and br == "(" and 16) or 9; funcStatus = 0 end
									end
								else
									wordType = specialKeywordsTypes[word] or wordType
									funcStatus = (word == "function" and 1 or 0)
								end

								lastWord = word
								wordBeginsDotted = false
								if funcStatus > 0 then funcStatus = 1 end
								currentType = wordType
								highlights[col] = currentType
							elseif string.find(char, "%p") then
								local isDot = (char == ".")
								local isNum = isDot and string.find(string.sub(lineText, col + 1, col + 1), "%d")
								highlights[col] = isNum and 6 or 5

								if not isNum then
									local dotStr = isDot and string.match(lineText, "%.%.?%.?", col)
									if dotStr and #dotStr > 1 then
										currentType = 5
										lastEnding = col + #dotStr - 1
										wordBeginsDotted, lastWord, funcStatus = false, nil, 0
									else
										wordBeginsDotted = isDot and not wordBeginsDotted or false
										lastWord = isDot and lastWord or nil
										funcStatus = ((isDot or char == ":") and funcStatus == 1 and 2) or 0
									end
								end
							elseif string.find(char, "%d") then
								local _, endPos = string.find(lineText, "%x+", col)
								local endPart = string.sub(lineText, endPos, endPos + 1)
								if (endPart == "e+" or endPart == "e-") and string.find(string.sub(lineText, endPos + 2, endPos + 2), "%d") then endPos += 1 end
								currentType = 6
								lastEnding = endPos
								highlights[col] = 6
								wordBeginsDotted, lastWord, funcStatus = false, nil, 0
							else
								highlights[col] = currentType
								local _, endPos = string.find(lineText, "%s+", col)
								if endPos then lastEnding = endPos end
							end
						end
					end

					self.ColoredLines[line] = highlights
					return highlights
				end

				funcs.Refresh = function(self)
					local linesFrame = self.GuiElems.LinesFrame
					local hSize = math.max(0, linesFrame.AbsoluteSize.X)
					local vSize = math.max(0, linesFrame.AbsoluteSize.Y)
					local maxLines = math.ceil(vSize / self.FontSize)
					local maxCols = math.ceil(hSize / math.ceil(self.FontSize / 2))
					local viewX, viewY = self.ViewX, self.ViewY
					local lineNumberStr = ""

					for row = 1, maxLines do
						local lineFrame = self.LineFrames[row]
						if not lineFrame then
							lineFrame = create("Frame", {
								Position = UDim2.new(0, 0, 0, (row - 1) * self.FontSize),
								Size = UDim2.new(1, 0, 0, self.FontSize),
								BorderSizePixel = 0, BackgroundTransparency = 1, Parent = linesFrame
							})
							create("Frame", {
								Name = "SelectionHighlight",
								BorderSizePixel = 0, BackgroundColor3 = Settings.Theme.Syntax.SelectionBack, Parent = lineFrame
							})
							create("TextLabel", {
								BackgroundTransparency = 1, Font = Enum.Font.Code, TextSize = self.FontSize,
								Size = UDim2.new(1, 0, 0, self.FontSize), RichText = true, TextXAlignment = Enum.TextXAlignment.Left,
								TextColor3 = self.Colors.Text, ZIndex = 2, Parent = lineFrame
							})
							self.LineFrames[row] = lineFrame
						end

						local relaY = viewY + row
						local lineText = self.Lines[relaY] or ""
						local resText = ""
						local highlights = self:HighlightLine(relaY)
						local colStart = viewX + 1

						local richTemplates = self.RichTemplates
						local textTemplate = richTemplates.Text
						local selectionTemplate = richTemplates.Selection
						local curType = highlights[colStart]
						local curTemplate = richTemplates[typeMap[curType]] or textTemplate

						-- Selection Logic
						local selectionRange = self.SelectionRange
						local selPos1, selPos2 = selectionRange[1], selectionRange[2]
						local selRow, selColumn = selPos1[2], selPos1[1]
						local sel2Row, sel2Column = selPos2[2], selPos2[1]
						local selectionBox = lineFrame.SelectionHighlight

						if relaY - 1 >= selPos1[2] and relaY - 1 <= selPos2[2] then
							local fontSizeX = math.ceil(self.FontSize / 2)
							local posX = (relaY - 1 == selPos1[2] and selPos1[1] or 0) - viewX
							local sizeX = (relaY - 1 == selPos2[2] and selPos2[1] - posX - viewX or maxCols + viewX)
							selectionBox.Position = UDim2.new(0, posX * fontSizeX, 0, 0)
							selectionBox.Size = UDim2.new(0, sizeX * fontSizeX, 1, 0)
							selectionBox.Visible = true
						else
							selectionBox.Visible = false
						end

						for col = 2, maxCols do
							local relaX = viewX + col
							local selRelaX, selRelaY = relaX - 1, relaY - 1
							local posType = highlights[relaX]

							local inSelection = selRelaY >= selRow and selRelaY <= sel2Row and 
								(selRelaY == selRow and selRelaX >= selColumn or selRelaY ~= selRow) and 
								(selRelaY == sel2Row and selRelaX < sel2Column or selRelaY ~= sel2Row)

							if inSelection then posType = -999 end

							if posType ~= curType then
								local template = inSelection and selectionTemplate or richTemplates[typeMap[posType]] or textTemplate
								if template ~= curTemplate then
									local nextText = string.gsub(string.sub(lineText, colStart, relaX - 1), "['\"<>&]", richReplace)
									resText = resText .. (curTemplate ~= textTemplate and (curTemplate .. nextText .. "</font>") or nextText)
									colStart = relaX
									curTemplate = template
								end
								curType = posType
							end
						end

						local lastText = string.gsub(string.sub(lineText, colStart, viewX + maxCols), "['\"<>&]", richReplace)
						if #lastText > 0 then
							resText = resText .. (curTemplate ~= textTemplate and (curTemplate .. lastText .. "</font>") or lastText)
						end

						if self.Lines[relaY] then
							lineNumberStr = lineNumberStr .. (relaY == self.CursorY + 1 and ("<b>" .. relaY .. "</b>\n") or relaY .. "\n")
						end
						lineFrame.TextLabel.Text = resText
					end

					for i = maxLines + 1, #self.LineFrames do
						self.LineFrames[i]:Destroy()
						self.LineFrames[i] = nil
					end

					self.GuiElems.LineNumbersLabel.Text = lineNumberStr
					self:UpdateCursor()
				end

				funcs.UpdateView = function(self)
					local fontWidth = math.ceil(self.FontSize / 2)
					local linesOffset = #tostring(#self.Lines) * fontWidth + 4 * fontWidth
					local linesFrame = self.GuiElems.LinesFrame
					local maxLines = math.ceil(linesFrame.AbsoluteSize.Y / self.FontSize)

					self.ScrollV.VisibleSpace = maxLines
					self.ScrollV.TotalSpace = #self.Lines + 1
					self.ScrollH.VisibleSpace = math.ceil(linesFrame.AbsoluteSize.X / fontWidth)
					self.ScrollH.TotalSpace = self.MaxTextCols + 1

					self.ScrollV.Gui.Visible = #self.Lines + 1 > maxLines
					self.ScrollH.Gui.Visible = (self.MaxTextCols * fontWidth) > linesFrame.AbsoluteSize.X

					local oldOffsets = self.FrameOffsets
					self.FrameOffsets = Vector2.new(self.ScrollV.Gui.Visible and -16 or 0, self.ScrollH.Gui.Visible and -16 or 0)

					if oldOffsets ~= self.FrameOffsets then
						self:UpdateView()
					else
						self.ScrollV:ScrollTo(self.ViewY, true)
						self.ScrollH:ScrollTo(self.ViewX, true)

						if self.ScrollV.Gui.Visible and self.ScrollH.Gui.Visible then
							self.ScrollV.Gui.Size = UDim2.new(0, 16, 1, -16)
							self.ScrollH.Gui.Size = UDim2.new(1, -16, 0, 16)
							self.GuiElems.ScrollCorner.Visible = true
						else
							self.ScrollV.Gui.Size = UDim2.new(0, 16, 1, 0)
							self.ScrollH.Gui.Size = UDim2.new(1, 0, 0, 16)
							self.GuiElems.ScrollCorner.Visible = false
						end

						self.ViewY = self.ScrollV.Index
						self.ViewX = self.ScrollH.Index
						self.GuiElems.LinesFrame.Position = UDim2.new(0, linesOffset, 0, 0)
						self.GuiElems.LinesFrame.Size = UDim2.new(1, -linesOffset + oldOffsets.X, 1, oldOffsets.Y)
						self.GuiElems.LineNumbersLabel.Position = UDim2.new(0, fontWidth, 0, 0)
						self.GuiElems.LineNumbersLabel.Size = UDim2.new(0, #tostring(#self.Lines) * fontWidth, 1, oldOffsets.Y)
					end
				end

				funcs.ProcessTextChange = function(self)
					local maxCols = 0
					for _, line in ipairs(self.Lines) do
						if #line > maxCols then maxCols = #line end
					end
					self.MaxTextCols = maxCols
					self:UpdateView()	
					self.Text = table.concat(self.Lines, "\n")
					self:MapNewLines()
					self:PreHighlight()
					self:Refresh()
				end

				funcs.ConvertText = function(self, text, toEditor) return text end
				funcs.GetText = function(self) return self:ConvertText(table.concat(self.Lines, "\n"), false) end

				funcs.SetText = function(self, txt)
					txt = self:ConvertText(txt, true)
					table.clear(self.Lines)
					local count = 1
					for line in string.gmatch(txt, "([^\n\r]*)[\n\r]?") do
						self.Lines[count] = line
						count += 1
					end
					self:ProcessTextChange()
				end

				funcs.MakeRichTemplates = function(self)
					local templates = {}
					for name, color in pairs(self.Colors) do
						templates[name] = ('<font color="rgb(%s,%s,%s)">'):format(math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
					end
					self.RichTemplates = templates
				end

				funcs.ApplyTheme = function(self)
					self.Colors = Settings.Theme.Syntax
					self.GuiElems.LineNumbersLabel.TextColor3 = self.Colors.Text
					self.Frame.BackgroundColor3 = self.Colors.Background
				end

				local mt = {__index = funcs}

				local function new()
					if not builtInInited then initBuiltIn() end

					local scrollV, scrollH = ScrollBar.new(), ScrollBar.new(true)
					scrollH.Gui.Position = UDim2.new(0, 0, 1, -16)

					local obj = setmetatable({
						FontSize = 15, ViewX = 0, ViewY = 0, Colors = Settings.Theme.Syntax, ColoredLines = {},
						Lines = {""}, LineFrames = {}, Editable = true, Editing = false, CursorX = 0, CursorY = 0,
						FloatCursorX = 0, Text = "", PreHighlights = {}, SelectionRange = {{-1, -1}, {-1, -1}},
						NewLines = {}, FrameOffsets = Vector2.new(0, 0), MaxTextCols = 0, ScrollV = scrollV, ScrollH = scrollH
					}, mt)

					scrollV.WheelIncrement = 3
					scrollH.Increment = 2
					scrollH.WheelIncrement = 7

					scrollV.Scrolled:Connect(function() obj.ViewY = scrollV.Index; obj:Refresh() end)
					scrollH.Scrolled:Connect(function() obj.ViewX = scrollH.Index; obj:Refresh() end)

					makeFrame(obj)
					obj:MakeRichTemplates()
					obj:ApplyTheme()
					scrollV:SetScrollFrame(obj.GuiElems.LinesFrame)
					scrollV.Gui.Parent = obj.Frame
					scrollH.Gui.Parent = obj.Frame

					obj:UpdateView()
					obj.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						obj:UpdateView()
						obj:Refresh()
					end)

					return obj
				end

				return {new = new}
			end)()

			local codeFrame = CodeFrame.new()
			codeFrame.Frame.Parent = backgroundFrame

			return codeFrame
		end

		return tab
	end

	-- Canvas specific helpers (Widgets, Commands, Notifications)

	function canvas:CreateNotification(config)
		return create("Frame", {
			BackgroundTransparency = 1, 
			Position = UDim2.fromScale(0, 0.9), 
			Size = UDim2.new(0.5, 0, 0, 90), 
			ZIndex = 1,
			Parent = notificationFrame
		}, {
			create("UICorner", { CornerRadius = UDim.new(0, 10) }),
			create("UIListLayout"),
			create("Frame", {
				BackgroundColor3 = backgroundColor3,
				BackgroundTransparency = 0.1,
				BorderSizePixel = 0, 
				Size = UDim2.new(0, 250, 1, 0), 
				ZIndex = 2
			}, {
				create("UICorner", { CornerRadius = UDim.new(0, 10) }),
				create("ImageLabel", {
					AnchorPoint = Vector2.one * 0.5,
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, 18, 1, 18),
					Image = "rbxassetid://13960012399",
					ImageColor3 = Color3.fromRGB(0, 0, 0),
					ImageTransparency = 0.5,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
					SliceScale = 0.1,
					ZIndex = 1,
				}),
				create("TextLabel", {
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0, 0.304),
					Size = UDim2.fromOffset(250, 69),
					FontFace = fontRegular,
					TextSize = 17,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextWrapped = true,
					Text = config.Message,
					ZIndex = 2,
				}),
				create("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.fromOffset(250, 30),
					FontFace = fontMedium,
					TextSize = 19,
					RichText = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Text = "Notification",
					ZIndex = 3,
				}, {
					create("Frame", {
						BackgroundColor3 = Color3.new(), 
						BackgroundTransparency = 0.9, 
						BorderSizePixel = 0, 
						Size = UDim2.fromScale(1, 1), 
						ZIndex = 1
					}, {
						create("UICorner", { CornerRadius = UDim.new(0, 10) })
					})
				})
			})
		})
	end

	function canvas:SetSubTitle(config)
		subTitleLabel.Text = config.Text
	end
	
	local quickButtons = {}

	function canvas:AddQuickButton(config)
		local quickButtonFrame = create("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.5,
			Position = UDim2.new(0, 2 + (35 * #quickButtons), 1, -30),
			Size = UDim2.fromOffset(30, 30),
			ZIndex = 2,
			Parent = sideFrame
		}, {
			create("UICorner", { CornerRadius = UDim.new(0, 10) })
		})
		applyGradient(quickButtonFrame, gradients)

		local imageButton = create("ImageButton", {
			AutoButtonColor = false,
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, -10, 1, -10),
			Image = config.Image or "",
			ZIndex = 3,
			Parent = quickButtonFrame
		}, {
			create("UIAspectRatioConstraint")
		})

		local uiShadow = create("ImageLabel", {
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 18, 1, 18),
			Image = "rbxassetid://13960012399",
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
			SliceScale = 0.1,
			Parent = quickButtonFrame
		})
		applyGradient(uiShadow, gradients)

		if config.Callback then
			imageButton.MouseButton1Click:Connect(config.Callback)
		end

		table.insert(quickButtons, quickButtonFrame)

		return imageButton
	end

	canvas.Widgets = {}

	function canvas:AddWidget(config)
		local widget = {
			Enabled = true,
			Name = config.Name
		}

		-- Centralized sizing variables so it's perfectly consistent
		local WIDGET_HEIGHT = 30
		local WIDTH_PADDING = 18

		local widgetFrame = create("Frame", {
			BackgroundColor3 = backgroundColor3,
			BackgroundTransparency = 0.1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(120, WIDGET_HEIGHT),
			ZIndex = 0,
			Parent = guiMain
		}, {
			create("UISizeConstraint", { MaxSize = Vector2.new(math.huge, WIDGET_HEIGHT) }),
			create("UICorner", { CornerRadius = UDim.new(0, 10) })
		})
		widget.Frame = widgetFrame

		local uiShadow = create("ImageLabel", {
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 18, 1, 18),
			Image = "rbxassetid://13960012399",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
			SliceScale = 0.1,
			ZIndex = 1,
			Parent = widgetFrame
		})
		applyGradient(uiShadow, gradients)

		local widgetLabel = create("TextLabel", {
			RichText = true,
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			FontFace = fontRegular,
			Text = "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 18,
			TextTransparency = 0.5,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = widgetFrame
		}, {
			create("UIPadding", { PaddingLeft = UDim.new(0, 9) })
		})
		widget.Label = widgetLabel

		-- Sync the TweenSize to use the exact same padding and height
		widgetLabel:GetPropertyChangedSignal("ContentText"):Connect(function() 
			widgetFrame:TweenSize(UDim2.fromOffset(getTextBounds(widgetLabel).X + WIDTH_PADDING, WIDGET_HEIGHT), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 1/30, true)
		end)

		-- Sync the initial setup size to match
		widgetFrame.Size = UDim2.fromOffset(getTextBounds(widgetLabel).X + WIDTH_PADDING, WIDGET_HEIGHT)

		table.insert(canvas.Widgets, widget)

		local topbarInset = GuiService.TopbarInset.Height + 10
		for index, activeWidget in ipairs(canvas.Widgets) do
			activeWidget.Frame.Position = UDim2.fromOffset(5, topbarInset + (index - 1) * 35)
		end

		return widget
	end

	function canvas:AddCommandBar(config)
		local commandBar = {
			Enabled = true,
			Prefix = Enum.KeyCode.Semicolon
		}

		local commandFrame = create("Frame", {
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundColor3 = backgroundColor3,
			BackgroundTransparency = 0.1,
			Position = UDim2.new(0, 5, 1, -35),
			Size = UDim2.fromOffset(600, 30),
			ZIndex = 2147483645,
			Parent = guiMain
		}, {
			create("UISizeConstraint", { MaxSize = Vector2.new(math.huge, 30) }),
			create("UICorner", { CornerRadius = UDim.new(0, 10) })
		})
		commandBar.Frame = commandFrame

		local uiShadow = create("ImageLabel", {
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 18, 1, 18),
			Image = "rbxassetid://13960012399",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
			SliceScale = 0.1,
			ZIndex = commandFrame.ZIndex - 1,
			Parent = commandFrame
		})

		local commandBox = create("TextBox", {
			RichText = false,
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			FontFace = fontRegular,
			Text = "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 18,
			TextTransparency = 0,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = commandFrame.ZIndex + 2,
			Parent = commandFrame
		}, {
			create("UIPadding", { PaddingLeft = UDim.new(0, 9) })
		})
		commandBar.Box = commandBox

		local commandLabel = create("TextLabel", {
			RichText = true,
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(1, 1),
			FontFace = fontRegular,
			Text = "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 18,
			TextTransparency = 0.5,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = commandFrame.ZIndex + 1,
			Parent = commandFrame
		}, {
			create("UIPadding", { PaddingLeft = UDim.new(0, 9) })
		})
		commandBar.Label = commandLabel

		local function updateSize()
			local bounds = Vector2.max(getTextBounds(commandBox), getTextBounds(commandLabel))
			commandFrame:TweenSize(UDim2.fromOffset(bounds.X + 18, 30), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 1/30, true)
		end

		commandFrame.Size = UDim2.fromOffset((Vector2.max(getTextBounds(commandBox), getTextBounds(commandLabel))).X + 18, 30)

		commandBox:GetPropertyChangedSignal("ContentText"):Connect(updateSize)
		commandLabel:GetPropertyChangedSignal("ContentText"):Connect(updateSize)

		return commandBar
	end

	function canvas:CreateCornerButton(config)
		local imageButton = create("ImageButton", {
			AnchorPoint = Vector2.new(0, 1),
			AutoButtonColor = false,
			BackgroundColor3 = backgroundColor3,
			BackgroundTransparency = 0.1,
			Position = UDim2.new(0, 10, 1, -10),
			Size = UDim2.fromOffset(50, 50),
			ZIndex = 2147483647,
			Parent = guiMain,
		}, {
			create("UICorner", { CornerRadius = UDim.new(0, 10) })
		})

		local textLabel = create("TextLabel", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0, 
			Size = UDim2.fromScale(1, 1), 
			ZIndex = 2147483646,
			Text = config.Text,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 18,
			FontFace = fontRegular,
			Parent = imageButton
		})
		applyGradient(textLabel, gradients)

		local shadow = create("ImageLabel", {
			AnchorPoint = Vector2.one * 0.5,
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 18, 1, 18),
			Image = "rbxassetid://13960012399",
			ImageColor3 = Color3.fromRGB(0, 0, 0),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(Vector2.one * 200, Vector2.one * 500),
			SliceScale = 0.1,
			ZIndex = 1,
			Parent = imageButton
		})

		imageButton.MouseEnter:Connect(function()
			TweenService:Create(imageButton, TweenInfo.new(), { Rotation = 360 }):Play()
		end)

		imageButton.MouseLeave:Connect(function()
			TweenService:Create(imageButton, TweenInfo.new(), { Rotation = 0 }):Play()
		end)

		return imageButton
	end

	canvas.TweenInfo = tweenInfo
	canvas.Gradients = gradients

	return canvas
end

return module
