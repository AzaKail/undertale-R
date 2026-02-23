local LobbyUI = {}

function LobbyUI.create(playerGui)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "LobbyUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = playerGui

	local lobbyFrame = Instance.new("Frame")
	lobbyFrame.Name = "LobbyFrame"
	lobbyFrame.Size = UDim2.new(1, 0, 1, 0)
	lobbyFrame.BackgroundTransparency = 1
	lobbyFrame.Parent = screenGui

	local leftPanel = Instance.new("Frame")
	leftPanel.Name = "LeftPanel"
	leftPanel.Position = UDim2.new(0, 20, 0.35, 0)
	leftPanel.Size = UDim2.new(0, 220, 0, 240)
	leftPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	leftPanel.BackgroundTransparency = 0.15
	leftPanel.Parent = lobbyFrame

	local timerTitle = Instance.new("TextLabel")
	timerTitle.Name = "TimerTitle"
	timerTitle.Size = UDim2.new(1, -20, 0, 22)
	timerTitle.Position = UDim2.new(0, 10, 0, 10)
	timerTitle.BackgroundTransparency = 1
	timerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	timerTitle.Font = Enum.Font.GothamBold
	timerTitle.TextSize = 14
	timerTitle.Text = "Timer"
	timerTitle.TextXAlignment = Enum.TextXAlignment.Left
	timerTitle.Parent = leftPanel

	local timerLabel = Instance.new("TextLabel")
	timerLabel.Name = "TimerLabel"
	timerLabel.Size = UDim2.new(1, -20, 0, 22)
	timerLabel.Position = UDim2.new(0, 10, 0, 36)
	timerLabel.BackgroundTransparency = 1
	timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	timerLabel.Font = Enum.Font.Gotham
	timerLabel.TextSize = 14
	timerLabel.Text = "Match starts in: --"
	timerLabel.TextXAlignment = Enum.TextXAlignment.Left
	timerLabel.Parent = leftPanel

	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(1, -20, 0, 20)
	statusLabel.Position = UDim2.new(0, 10, 0, 58)
	statusLabel.BackgroundTransparency = 1
	statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextSize = 12
	statusLabel.Text = "Waiting for players"
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.Parent = leftPanel

	local inventoryPanel = Instance.new("Frame")
	inventoryPanel.Name = "InventoryPanel"
	inventoryPanel.Size = UDim2.new(1, -20, 0, 140)
	inventoryPanel.Position = UDim2.new(0, 10, 0, 90)
	inventoryPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
	inventoryPanel.BackgroundTransparency = 0.1
	inventoryPanel.Parent = leftPanel

	local inventoryImage = Instance.new("ImageLabel")
	inventoryImage.Name = "InventoryImage"
	inventoryImage.Size = UDim2.new(1, -20, 1, -20)
	inventoryImage.Position = UDim2.new(0, 10, 0, 10)
	inventoryImage.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	inventoryImage.Image = ""
	inventoryImage.ScaleType = Enum.ScaleType.Fit
	inventoryImage.Parent = inventoryPanel

	local inventoryLabel = Instance.new("TextLabel")
	inventoryLabel.Name = "InventoryLabel"
	inventoryLabel.Size = UDim2.new(1, -20, 0, 36)
	inventoryLabel.Position = UDim2.new(0, 10, 1, -46)
	inventoryLabel.BackgroundTransparency = 1
	inventoryLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	inventoryLabel.Font = Enum.Font.Gotham
	inventoryLabel.TextSize = 12
	inventoryLabel.Text = "Inventory / Shop"
	inventoryLabel.TextXAlignment = Enum.TextXAlignment.Left
	inventoryLabel.TextYAlignment = Enum.TextYAlignment.Top
	inventoryLabel.Parent = inventoryPanel

	local adminPanel = Instance.new("Frame")
	adminPanel.Name = "AdminPanel"
	adminPanel.AnchorPoint = Vector2.new(1, 0)
	adminPanel.Position = UDim2.new(1, -20, 0.15, 0)
	adminPanel.Size = UDim2.new(0, 220, 0, 280)
	adminPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
	adminPanel.BackgroundTransparency = 0.15
	adminPanel.Parent = lobbyFrame

	local adminTitle = Instance.new("TextLabel")
	adminTitle.Name = "AdminTitle"
	adminTitle.Size = UDim2.new(1, -20, 0, 24)
	adminTitle.Position = UDim2.new(0, 10, 0, 10)
	adminTitle.BackgroundTransparency = 1
	adminTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	adminTitle.Font = Enum.Font.GothamBold
	adminTitle.TextSize = 14
	adminTitle.Text = "Admin panel"
	adminTitle.TextXAlignment = Enum.TextXAlignment.Left
	adminTitle.Parent = adminPanel

	local adminHint = Instance.new("TextLabel")
	adminHint.Name = "AdminHint"
	adminHint.Size = UDim2.new(1, -20, 0, 48)
	adminHint.Position = UDim2.new(0, 10, 0, 40)
	adminHint.BackgroundTransparency = 1
	adminHint.TextColor3 = Color3.fromRGB(210, 210, 210)
	adminHint.Font = Enum.Font.Gotham
	adminHint.TextSize = 12
	adminHint.Text = "Temporary debug controls\nfor local testing."
	adminHint.TextXAlignment = Enum.TextXAlignment.Left
	adminHint.TextYAlignment = Enum.TextYAlignment.Top
	adminHint.Parent = adminPanel

	local forceStartButton = Instance.new("TextButton")
	forceStartButton.Name = "ForceStartButton"
	forceStartButton.Size = UDim2.new(1, -20, 0, 34)
	forceStartButton.Position = UDim2.new(0, 10, 0, 96)
	forceStartButton.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
	forceStartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	forceStartButton.Font = Enum.Font.GothamBold
	forceStartButton.TextSize = 12
	forceStartButton.Text = "Force start round"
	forceStartButton.Parent = adminPanel

	local adminResultLabel = Instance.new("TextLabel")
	adminResultLabel.Name = "AdminResultLabel"
	adminResultLabel.Size = UDim2.new(1, -20, 0, 60)
	adminResultLabel.Position = UDim2.new(0, 10, 0, 138)
	adminResultLabel.BackgroundTransparency = 1
	adminResultLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	adminResultLabel.Font = Enum.Font.Gotham
	adminResultLabel.TextSize = 12
	adminResultLabel.Text = "Idle"
	adminResultLabel.TextXAlignment = Enum.TextXAlignment.Left
	adminResultLabel.TextYAlignment = Enum.TextYAlignment.Top
	adminResultLabel.TextWrapped = true
	adminResultLabel.Parent = adminPanel

	local openMenuButton = Instance.new("TextButton")
	openMenuButton.Name = "OpenMenuButton"
	openMenuButton.AnchorPoint = Vector2.new(0.5, 1)
	openMenuButton.Position = UDim2.new(0.5, 0, 1, -20)
	openMenuButton.Size = UDim2.new(0, 220, 0, 34)
	openMenuButton.BackgroundColor3 = Color3.fromRGB(88, 120, 255)
	openMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	openMenuButton.Font = Enum.Font.GothamBold
	openMenuButton.TextSize = 14
	openMenuButton.Text = "Character selection"
	openMenuButton.Parent = lobbyFrame

	local soulMenu = Instance.new("Frame")
	soulMenu.Name = "SoulMenu"
	soulMenu.Visible = false
	soulMenu.AnchorPoint = Vector2.new(0.5, 0.5)
	soulMenu.Position = UDim2.new(0.5, 0, 0.55, 0)
	soulMenu.Size = UDim2.new(0, 720, 0, 360)
	soulMenu.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
	soulMenu.BackgroundTransparency = 0.05
	soulMenu.Parent = lobbyFrame

	local menuHeader = Instance.new("Frame")
	menuHeader.Name = "Header"
	menuHeader.Size = UDim2.new(1, -20, 0, 40)
	menuHeader.Position = UDim2.new(0, 10, 0, 10)
	menuHeader.BackgroundTransparency = 1
	menuHeader.Parent = soulMenu

	local killersTab = Instance.new("TextButton")
	killersTab.Name = "KillersTab"
	killersTab.Size = UDim2.new(0.5, -5, 1, 0)
	killersTab.Position = UDim2.new(0, 0, 0, 0)
	killersTab.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	killersTab.BackgroundTransparency = 0.1
	killersTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	killersTab.Font = Enum.Font.GothamBold
	killersTab.TextSize = 14
	killersTab.Text = "Killers"
	killersTab.Parent = menuHeader

	local survivorsTab = Instance.new("TextButton")
	survivorsTab.Name = "SurvivorsTab"
	survivorsTab.Size = UDim2.new(0.5, -5, 1, 0)
	survivorsTab.Position = UDim2.new(0.5, 5, 0, 0)
	survivorsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	survivorsTab.BackgroundTransparency = 0.1
	survivorsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
	survivorsTab.Font = Enum.Font.GothamBold
	survivorsTab.TextSize = 14
	survivorsTab.Text = "Survivors"
	survivorsTab.Parent = menuHeader

	local detailPanel = Instance.new("Frame")
	detailPanel.Name = "DetailPanel"
	detailPanel.Size = UDim2.new(0, 240, 0, 260)
	detailPanel.Position = UDim2.new(0, 10, 0, 70)
	detailPanel.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
	detailPanel.BackgroundTransparency = 0.1
	detailPanel.Parent = soulMenu

	local iconPlaceholder = Instance.new("Frame")
	iconPlaceholder.Name = "IconPlaceholder"
	iconPlaceholder.Size = UDim2.new(1, -20, 0, 110)
	iconPlaceholder.Position = UDim2.new(0, 10, 0, 10)
	iconPlaceholder.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	iconPlaceholder.Parent = detailPanel

	local iconLabel = Instance.new("TextLabel")
	iconLabel.Name = "IconLabel"
	iconLabel.Size = UDim2.new(1, 0, 1, 0)
	iconLabel.BackgroundTransparency = 1
	iconLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	iconLabel.Font = Enum.Font.Gotham
	iconLabel.TextSize = 12
	iconLabel.Text = "Character icon"
	iconLabel.Parent = iconPlaceholder

	local descriptionLabel = Instance.new("TextLabel")
	descriptionLabel.Name = "Description"
	descriptionLabel.Size = UDim2.new(1, -20, 0, 80)
	descriptionLabel.Position = UDim2.new(0, 10, 0, 130)
	descriptionLabel.BackgroundTransparency = 1
	descriptionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	descriptionLabel.Font = Enum.Font.Gotham
	descriptionLabel.TextSize = 12
	descriptionLabel.Text = "Selected character description and abilities."
	descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
	descriptionLabel.TextYAlignment = Enum.TextYAlignment.Top
	descriptionLabel.TextWrapped = true
	descriptionLabel.Parent = detailPanel

	local selectedLabel = Instance.new("TextLabel")
	selectedLabel.Name = "SelectedLabel"
	selectedLabel.Size = UDim2.new(1, -20, 0, 20)
	selectedLabel.Position = UDim2.new(0, 10, 0, 215)
	selectedLabel.BackgroundTransparency = 1
	selectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	selectedLabel.Font = Enum.Font.Gotham
	selectedLabel.TextSize = 12
	selectedLabel.Text = "Selected: —"
	selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
	selectedLabel.Parent = detailPanel

	local selectButton = Instance.new("TextButton")
	selectButton.Name = "SelectButton"
	selectButton.Size = UDim2.new(0, 120, 0, 26)
	selectButton.Position = UDim2.new(0, 10, 1, -36)
	selectButton.BackgroundColor3 = Color3.fromRGB(88, 120, 255)
	selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	selectButton.Font = Enum.Font.GothamBold
	selectButton.TextSize = 12
	selectButton.Text = "Select"
	selectButton.Parent = detailPanel

	local killersGrid = Instance.new("Frame")
	killersGrid.Name = "KillersGrid"
	killersGrid.Size = UDim2.new(0, 440, 0, 260)
	killersGrid.Position = UDim2.new(0, 260, 0, 70)
	killersGrid.BackgroundTransparency = 1
	killersGrid.Parent = soulMenu

	local survivorsGrid = Instance.new("Frame")
	survivorsGrid.Name = "SurvivorsGrid"
	survivorsGrid.Size = UDim2.new(0, 440, 0, 260)
	survivorsGrid.Position = UDim2.new(0, 260, 0, 70)
	survivorsGrid.BackgroundTransparency = 1
	survivorsGrid.Visible = false
	survivorsGrid.Parent = soulMenu

	return {
		screenGui = screenGui,
		lobbyFrame = lobbyFrame,
		timerLabel = timerLabel,
		statusLabel = statusLabel,
		openMenuButton = openMenuButton,
		soulMenu = soulMenu,
		killersTab = killersTab,
		survivorsTab = survivorsTab,
		descriptionLabel = descriptionLabel,
		selectedLabel = selectedLabel,
		selectButton = selectButton,
		killersGrid = killersGrid,
		survivorsGrid = survivorsGrid,
		forceStartButton = forceStartButton,
		adminResultLabel = adminResultLabel,
	}
end

return LobbyUI