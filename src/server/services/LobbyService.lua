local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local MatchService = require(script.Parent.MatchService)
local Remotes = require(script.Parent.Remotes)

local LobbyService = {}

local LOBBY_DURATION = 30
local MIN_PLAYERS = 2

local lobbyTimerEvent = Remotes.getRemote("LobbyTimer")
local selectSoulEvent = Remotes.getRemote("SelectSoul")
local soulSelectedEvent = Remotes.getRemote("SoulSelected")
local matchStatusEvent = Remotes.getRemote("MatchStatus")
local forceStartRoundEvent = Remotes.getRemote("ForceStartRound")

local forceStartRequested = false

local function canForceStart(player)
	return game:GetService("RunService"):IsStudio() or player.UserId == game.CreatorId
end

local function getLobbySpawn()
	local spawn = Workspace:FindFirstChild("LobbySpawn", true)
	if spawn and spawn:IsA("BasePart") then
		return spawn
	end
	return nil
end

local function teleportToLobby(player)
	local spawn = getLobbySpawn()
	if not spawn then
		return
	end
	if player.Character then
		player.Character:PivotTo(spawn.CFrame + Vector3.new(0, 3, 0))
	end
end

local function handlePlayerAdded(player)
	player:SetAttribute("SelectedSoul", "")
	player:SetAttribute("Role", "Lobby")
	soulSelectedEvent:FireClient(player, "")
	player.CharacterAdded:Connect(function()
		task.wait(0.1)
		teleportToLobby(player)
	end)
end

local function handleSoulSelection(player, soulName)
	if soulName ~= "Justice" and soulName ~= "Asgore" then
		return
	end

	player:SetAttribute("SelectedSoul", soulName)
	soulSelectedEvent:FireClient(player, soulName)
end

function LobbyService.start()
	Players.PlayerAdded:Connect(handlePlayerAdded)
	selectSoulEvent.OnServerEvent:Connect(handleSoulSelection)
	forceStartRoundEvent.OnServerEvent:Connect(function(player)
		if canForceStart(player) then
			forceStartRequested = true
			matchStatusEvent:FireClient(player, "force_queued")
		else
			matchStatusEvent:FireClient(player, "force_denied")
		end
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		handlePlayerAdded(player)
	end

	task.spawn(function()
		while true do
			if #Players:GetPlayers() < MIN_PLAYERS and not forceStartRequested then
				matchStatusEvent:FireAllClients("need_more")
				lobbyTimerEvent:FireAllClients(-1)
				task.wait(1)
				continue
			end

			if forceStartRequested then
				matchStatusEvent:FireAllClients("starting")
				MatchService.startMatch()
				forceStartRequested = false
				task.wait(3)
				continue
			end

			for timeRemaining = LOBBY_DURATION, 0, -1 do
				lobbyTimerEvent:FireAllClients(timeRemaining)
				task.wait(1)
			end

			matchStatusEvent:FireAllClients("starting")
			MatchService.startMatch()
			task.wait(3)
		end
	end)
end

return LobbyService