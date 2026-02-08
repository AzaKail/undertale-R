local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LOBBY_DURATION = 30
local MIN_PLAYERS = 2

local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
if not remotesFolder then
	remotesFolder = Instance.new("Folder")
	remotesFolder.Name = "Remotes"
	remotesFolder.Parent = ReplicatedStorage
end

local function getRemote(name)
	local remote = remotesFolder:FindFirstChild(name)
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = remotesFolder
	end
	return remote
end

local lobbyTimerEvent = getRemote("LobbyTimer")
local selectSoulEvent = getRemote("SelectSoul")
local soulSelectedEvent = getRemote("SoulSelected")
local matchStatusEvent = getRemote("MatchStatus")

Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("SelectedSoul", "")
	soulSelectedEvent:FireClient(player, "")
end)

selectSoulEvent.OnServerEvent:Connect(function(player, soulName)
	if soulName ~= "Justice" and soulName ~= "Asgore" then
		return
	end

	player:SetAttribute("SelectedSoul", soulName)
	soulSelectedEvent:FireClient(player, soulName)
end)

task.spawn(function()
	while true do
		if #Players:GetPlayers() < MIN_PLAYERS then
			matchStatusEvent:FireAllClients("need_more")
			lobbyTimerEvent:FireAllClients(-1)
			task.wait(1)
			continue
		end

		for timeRemaining = LOBBY_DURATION, 0, -1 do
			lobbyTimerEvent:FireAllClients(timeRemaining)
			task.wait(1)
		end

		matchStatusEvent:FireAllClients("starting")
		task.wait(3)
	end
end)