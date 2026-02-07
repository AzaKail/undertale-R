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

local container = Instance.new("Frame")
container.Name = "Container"
container.AnchorPoint = Vector2.new(0.5, 0)
container.Position = UDim2.new(0.5, 0, 0, 20)
container.Size = UDim2.new(0, 360, 0, 140)
container.BackgroundTransparency = 0.2
container.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
container.Parent = screenGui

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 0, 24)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Text = "Лобби"
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = container

local timerLabel = Instance.new("TextLabel")
timerLabel.Name = "TimerLabel"
timerLabel.Size = UDim2.new(1, -20, 0, 22)
timerLabel.Position = UDim2.new(0, 10, 0, 40)
timerLabel.BackgroundTransparency = 1
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.Font = Enum.Font.Gotham
timerLabel.TextSize = 14
timerLabel.Text = "Матч начнётся через: --"
timerLabel.TextXAlignment = Enum.TextXAlignment.Left
timerLabel.Parent = container

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 62)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.Text = "Ожидание игроков"
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = container

local selectedLabel = Instance.new("TextLabel")
selectedLabel.Name = "SelectedLabel"
selectedLabel.Size = UDim2.new(1, -20, 0, 20)
selectedLabel.Position = UDim2.new(0, 10, 0, 84)
selectedLabel.BackgroundTransparency = 1
selectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
selectedLabel.Font = Enum.Font.Gotham
selectedLabel.TextSize = 12
selectedLabel.Text = "Выбрано: —"
selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
selectedLabel.Parent = container

local selectButton = Instance.new("TextButton")
selectButton.Name = "SelectSoulButton"
selectButton.Size = UDim2.new(0, 160, 0, 28)
selectButton.Position = UDim2.new(0, 10, 0, 108)
selectButton.BackgroundColor3 = Color3.fromRGB(88, 120, 255)
selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
selectButton.Font = Enum.Font.GothamBold
selectButton.TextSize = 14
selectButton.Text = "Выбрать душу"
selectButton.Parent = container

local soulMenu = Instance.new("Frame")
soulMenu.Name = "SoulMenu"
soulMenu.Visible = false
soulMenu.Size = UDim2.new(0, 220, 0, 220)
soulMenu.Position = UDim2.new(0, 10, 0, 150)
soulMenu.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
soulMenu.BackgroundTransparency = 0.1
soulMenu.Parent = container

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(1, -20, 0, 24)
menuTitle.Position = UDim2.new(0, 10, 0, 8)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = "Выбор души"
menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextSize = 14
menuTitle.TextXAlignment = Enum.TextXAlignment.Left
menuTitle.Parent = soulMenu

local function createSoulButton(text, y, enabled)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -20, 0, 26)
	button.Position = UDim2.new(0, 10, 0, y)
	button.BackgroundColor3 = enabled and Color3.fromRGB(90, 200, 120) or Color3.fromRGB(60, 60, 60)
	button.TextColor3 = enabled and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(170, 170, 170)
	button.Font = Enum.Font.Gotham
	button.TextSize = 12
	button.Text = text
	button.AutoButtonColor = enabled
	button.Parent = soulMenu
	return button
end

local justiceButton = createSoulButton("Justice", 40, true)

createSoulButton("Bravery (locked)", 70, false)
createSoulButton("Patience (locked)", 100, false)
createSoulButton("Kindness (locked)", 130, false)
createSoulButton("Perseverance (locked)", 160, false)
createSoulButton("Integrity (locked)", 190, false)

selectButton.MouseButton1Click:Connect(function()
	soulMenu.Visible = not soulMenu.Visible
end)

justiceButton.MouseButton1Click:Connect(function()
	selectSoulEvent:FireServer("Justice")
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
	soulMenu.Visible = false
end)

matchStatusEvent.OnClientEvent:Connect(function(status)
	if status == "starting" then
		statusLabel.Text = "Матч стартует..."
	else
		statusLabel.Text = "Ожидание игроков"
	end
end)