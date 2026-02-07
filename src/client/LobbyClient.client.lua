local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local lobbyTimerEvent = remotes:WaitForChild("LobbyTimer")
local selectSoulEvent = remotes:WaitForChild("SelectSoul")
local soulSelectedEvent = remotes:WaitForChild("SoulSelected")
local matchStatusEvent = remotes:WaitForChild("MatchStatus")

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
timerTitle.Text = "Таймер"
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
timerLabel.Text = "Матч начнётся через: --"
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
statusLabel.Text = "Ожидание игроков"
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
inventoryLabel.Text = "Инвентарь / магазин"
inventoryLabel.TextXAlignment = Enum.TextXAlignment.Left
inventoryLabel.TextYAlignment = Enum.TextYAlignment.Top
inventoryLabel.Parent = inventoryPanel

local playersPanel = Instance.new("Frame")
playersPanel.Name = "PlayersPanel"
playersPanel.AnchorPoint = Vector2.new(1, 0)
playersPanel.Position = UDim2.new(1, -20, 0.15, 0)
playersPanel.Size = UDim2.new(0, 220, 0, 280)
playersPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
playersPanel.BackgroundTransparency = 0.15
playersPanel.Parent = lobbyFrame

local playersTitle = Instance.new("TextLabel")
playersTitle.Name = "PlayersTitle"
playersTitle.Size = UDim2.new(1, -20, 0, 24)
playersTitle.Position = UDim2.new(0, 10, 0, 10)
playersTitle.BackgroundTransparency = 1
playersTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
playersTitle.Font = Enum.Font.GothamBold
playersTitle.TextSize = 14
playersTitle.Text = "Список игроков"
playersTitle.TextXAlignment = Enum.TextXAlignment.Left
playersTitle.Parent = playersPanel

local openMenuButton = Instance.new("TextButton")
openMenuButton.Name = "OpenMenuButton"
openMenuButton.AnchorPoint = Vector2.new(0.5, 1)
openMenuButton.Position = UDim2.new(0.5, 0, 1, -20)
openMenuButton.Size = UDim2.new(0, 220, 0, 34)
openMenuButton.BackgroundColor3 = Color3.fromRGB(88, 120, 255)
openMenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openMenuButton.Font = Enum.Font.GothamBold
openMenuButton.TextSize = 14
openMenuButton.Text = "Выбор персонажа"
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

local killersTab = Instance.new("TextLabel")
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

local survivorsTab = Instance.new("TextLabel")
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
iconLabel.Size = UDim2.new(1, 0, 1, 0)
iconLabel.BackgroundTransparency = 1
iconLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
iconLabel.Font = Enum.Font.Gotham
iconLabel.TextSize = 12
iconLabel.Text = "Тут иконка\nперсонажа"
iconLabel.Parent = iconPlaceholder

local descriptionLabel = Instance.new("TextLabel")
descriptionLabel.Name = "Description"
descriptionLabel.Size = UDim2.new(1, -20, 0, 80)
descriptionLabel.Position = UDim2.new(0, 10, 0, 130)
descriptionLabel.BackgroundTransparency = 1
descriptionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
descriptionLabel.Font = Enum.Font.Gotham
descriptionLabel.TextSize = 12
descriptionLabel.Text = "Краткое описание выбранного персонажа и способностей."
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
selectedLabel.Text = "Выбрано: —"
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedLabel.Parent = detailPanel

local selectButton = Instance.new("TextButton")
selectButton.Name = "SelectSoulButton"
selectButton.Size = UDim2.new(0, 120, 0, 26)
selectButton.Position = UDim2.new(0, 10, 1, -36)
selectButton.BackgroundColor3 = Color3.fromRGB(88, 120, 255)
selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
selectButton.Font = Enum.Font.GothamBold
selectButton.TextSize = 12
selectButton.Text = "Выбрать"
selectButton.Parent = detailPanel

local buttonGrid = Instance.new("Frame")
buttonGrid.Name = "ButtonGrid"
buttonGrid.Size = UDim2.new(0, 440, 0, 260)
buttonGrid.Position = UDim2.new(0, 260, 0, 70)
buttonGrid.BackgroundTransparency = 1
buttonGrid.Parent = soulMenu

local selectedCandidate = "Justice"

local soulDescriptions = {
	Asgore = "Killer: базовый удар. Заглушка до уникальных атак.",
	Justice = "Дальняя атака, простой выстрел. Подходит для старта.",
	Bravery = "Закрыто.",
	Patience = "Закрыто.",
	Kindness = "Закрыто.",
	Perseverance = "Закрыто.",
	Integrity = "Закрыто.",
}

local function updateCandidate(name)
	selectedCandidate = name
	descriptionLabel.Text = soulDescriptions[name] or "Описание пока не готово."
end

local function createSoulButton(text, position, enabled)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 200, 0, 50)
	button.Position = position
	button.BackgroundColor3 = enabled and Color3.fromRGB(90, 200, 120) or Color3.fromRGB(60, 60, 60)
	button.TextColor3 = enabled and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(170, 170, 170)
	button.Font = Enum.Font.Gotham
	button.TextSize = 12
	button.Text = text
	button.AutoButtonColor = enabled
	button.Parent = buttonGrid
	return button
end

local asgoreButton = createSoulButton("Asgore", UDim2.new(0, 0, 0, 0), true)
local justiceButton = createSoulButton("Justice", UDim2.new(0, 220, 0, 0), true)
local braveryButton = createSoulButton("Bravery (locked)", UDim2.new(0, 0, 0, 70), false)
local patienceButton = createSoulButton("Patience (locked)", UDim2.new(0, 220, 0, 70), false)
local kindnessButton = createSoulButton("Kindness (locked)", UDim2.new(0, 0, 0, 140), false)
local perseveranceButton = createSoulButton("Perseverance (locked)", UDim2.new(0, 220, 0, 140), false)
local integrityButton = createSoulButton("Integrity (locked)", UDim2.new(0, 0, 0, 210), false)

openMenuButton.MouseButton1Click:Connect(function()
	soulMenu.Visible = not soulMenu.Visible
end)

local function bindPreview(button, name)
	button.MouseButton1Click:Connect(function()
		updateCandidate(name)
	end)
end

bindPreview(justiceButton, "Justice")
bindPreview(asgoreButton, "Asgore")
bindPreview(braveryButton, "Bravery")
bindPreview(patienceButton, "Patience")
bindPreview(kindnessButton, "Kindness")
bindPreview(perseveranceButton, "Perseverance")
bindPreview(integrityButton, "Integrity")

selectButton.MouseButton1Click:Connect(function()
	selectSoulEvent:FireServer(selectedCandidate)
end)

lobbyTimerEvent.OnClientEvent:Connect(function(timeRemaining)
	timerLabel.Text = string.format("Матч начнётся через: %02d", timeRemaining)
end)

soulSelectedEvent.OnClientEvent:Connect(function(soulName)
	if soulName == "" then
		selectedLabel.Text = "Выбрано: —"
	else
		selectedLabel.Text = ("Выбрано: %s"):format(soulName)
	end
end)

matchStatusEvent.OnClientEvent:Connect(function(status)
	if status == "starting" then
		statusLabel.Text = "Матч стартует..."
	else
		statusLabel.Text = "Ожидание игроков"
	end
end)

updateCandidate("Justice")