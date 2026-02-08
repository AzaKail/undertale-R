local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LobbyUI = require(script.Parent.ui.LobbyUI)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local lobbyTimerEvent = remotes:WaitForChild("LobbyTimer")
local selectSoulEvent = remotes:WaitForChild("SelectSoul")
local soulSelectedEvent = remotes:WaitForChild("SoulSelected")
local matchStatusEvent = remotes:WaitForChild("MatchStatus")

local ui = LobbyUI.create(playerGui)

local selectedCandidate = "Justice"
local currentCategory = "Killers"

local soulDescriptions = {
	Asgore = "Killer: base melee strike. Placeholder until unique attacks.",
	Justice = "Survivor: simple ranged shot. Great starter pick.",
	Bravery = "Locked.",
	Patience = "Locked.",
	Kindness = "Locked.",
	Perseverance = "Locked.",
	Integrity = "Locked.",
}

local function updateCandidate(name)
	selectedCandidate = name
	ui.descriptionLabel.Text = soulDescriptions[name] or "Description not available yet."
end

local function setCategory(category)
	currentCategory = category
	local isKillers = category == "Killers"
	ui.killersGrid.Visible = isKillers
	ui.survivorsGrid.Visible = not isKillers
	ui.killersTab.BackgroundColor3 = isKillers and Color3.fromRGB(48, 48, 60) or Color3.fromRGB(30, 30, 36)
	ui.survivorsTab.BackgroundColor3 = isKillers and Color3.fromRGB(30, 30, 36) or Color3.fromRGB(48, 48, 60)
end

local function createSoulButton(text, position, enabled, parent)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 200, 0, 50)
	button.Position = position
	button.BackgroundColor3 = enabled and Color3.fromRGB(90, 200, 120) or Color3.fromRGB(60, 60, 60)
	button.TextColor3 = enabled and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(170, 170, 170)
	button.Font = Enum.Font.Gotham
	button.TextSize = 12
	button.Text = text
	button.AutoButtonColor = enabled
	button.Parent = parent
	return button
end

local asgoreButton = createSoulButton("Asgore", UDim2.new(0, 0, 0, 0), true, ui.killersGrid)
local justiceButton = createSoulButton("Justice", UDim2.new(0, 0, 0, 0), true, ui.survivorsGrid)
local braveryButton = createSoulButton("Bravery (locked)", UDim2.new(0, 220, 0, 0), false, ui.survivorsGrid)
local patienceButton = createSoulButton("Patience (locked)", UDim2.new(0, 0, 0, 70), false, ui.survivorsGrid)
local kindnessButton = createSoulButton("Kindness (locked)", UDim2.new(0, 220, 0, 70), false, ui.survivorsGrid)
local perseveranceButton = createSoulButton("Perseverance (locked)", UDim2.new(0, 0, 0, 140), false, ui.survivorsGrid)
local integrityButton = createSoulButton("Integrity (locked)", UDim2.new(0, 220, 0, 140), false, ui.survivorsGrid)

local function bindPreview(button, name)
	button.MouseButton1Click:Connect(function()
		updateCandidate(name)
	end)
end

bindPreview(asgoreButton, "Asgore")
bindPreview(justiceButton, "Justice")
bindPreview(braveryButton, "Bravery")
bindPreview(patienceButton, "Patience")
bindPreview(kindnessButton, "Kindness")
bindPreview(perseveranceButton, "Perseverance")
bindPreview(integrityButton, "Integrity")

ui.openMenuButton.MouseButton1Click:Connect(function()
	ui.soulMenu.Visible = not ui.soulMenu.Visible
end)

ui.killersTab.MouseButton1Click:Connect(function()
	setCategory("Killers")
end)

ui.survivorsTab.MouseButton1Click:Connect(function()
	setCategory("Survivors")
end)

ui.selectButton.MouseButton1Click:Connect(function()
	selectSoulEvent:FireServer(selectedCandidate)
end)

lobbyTimerEvent.OnClientEvent:Connect(function(timeRemaining)
	if timeRemaining < 0 then
		ui.timerLabel.Text = "Match starts in: --"
	else
		ui.timerLabel.Text = string.format("Match starts in: %02d", timeRemaining)
	end
end)

soulSelectedEvent.OnClientEvent:Connect(function(soulName)
	if soulName == "" then
		ui.selectedLabel.Text = "Selected: —"
	else
		ui.selectedLabel.Text = ("Selected: %s"):format(soulName)
	end
end)

matchStatusEvent.OnClientEvent:Connect(function(status)
	if status == "starting" then
		ui.statusLabel.Text = "Match starting..."
	elseif status == "need_more" then
		ui.statusLabel.Text = "Need more souls"
	else
		ui.statusLabel.Text = "Waiting for players"
	end
end)

updateCandidate("Justice")
setCategory(currentCategory)