local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

local MatchService = {}

local SKIN_FOLDERS = { "objects", "Skins" }

local function findSkinFolder()
	for _, folderName in ipairs(SKIN_FOLDERS) do
		local folder = ReplicatedStorage:FindFirstChild(folderName)
		if folder then
			return folder
		end
		folder = ServerStorage:FindFirstChild(folderName)
		if folder then
			return folder
		end
		folder = Workspace:FindFirstChild(folderName)
		if folder then
			return folder
		end
	end
	return nil
end

local function getSpawnCFrame(name, fallback)
	local spawn = Workspace:FindFirstChild(name, true)
	if spawn and spawn:IsA("BasePart") then
		return spawn.CFrame
	end
	return fallback or CFrame.new(0, 5, 0)
end

local function applyCharacterModel(player, model, spawnCFrame)
	local character = model:Clone()
	character.Name = player.Name
	character.Parent = Workspace
	player.Character = character
	if spawnCFrame then
		character:PivotTo(spawnCFrame)
	end
end

local function getSkinModel(skinName)
	local folder = findSkinFolder()
	if not folder then
		return nil
	end
	return folder:FindFirstChild(skinName)
end

local function getSurvivorSkinName(selectedSoul)
	if selectedSoul == "" or selectedSoul == nil then
		return "S_Justice"
	end
	return "S_" .. selectedSoul
end

local function assignRoles(players)
	local highest = -math.huge
	local killer = nil
	for _, player in ipairs(players) do
		local roll = math.random(1, 100000)
		player:SetAttribute("RoleRoll", roll)
		if roll > highest then
			highest = roll
			killer = player
		end
	end
	return killer
end

function MatchService.startMatch()
	local players = Players:GetPlayers()
	if #players == 0 then
		return
	end

	local killer = assignRoles(players)
	local killerSpawn = getSpawnCFrame("killer spawn")
	local survivorSpawn = getSpawnCFrame("surv spawn", killerSpawn)

	for _, player in ipairs(players) do
		local role = player == killer and "Killer" or "Survivor"
		player:SetAttribute("Role", role)

		local skinName
		if role == "Killer" then
			skinName = "K_Asgore"
		else
			skinName = getSurvivorSkinName(player:GetAttribute("SelectedSoul"))
		end

		local model = getSkinModel(skinName)
		if model then
			local spawnPoint = role == "Killer" and killerSpawn or survivorSpawn
			applyCharacterModel(player, model, spawnPoint)
		else
			player:LoadCharacter()
			if player.Character then
				player.Character:PivotTo(role == "Killer" and killerSpawn or survivorSpawn)
			end
		end
	end
end

return MatchService