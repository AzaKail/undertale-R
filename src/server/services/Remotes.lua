local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = {}

function Remotes.getFolder()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end
	return remotesFolder
end

function Remotes.getRemote(name)
	local folder = Remotes.getFolder()
	local remote = folder:FindFirstChild(name)
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = folder
	end
	return remote
end

return Remotes