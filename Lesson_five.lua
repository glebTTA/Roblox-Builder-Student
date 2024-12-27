-- Buy script
-- This goes inside ServerScriptStorage
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local event = ReplicatedStorage:WaitForChild("BuyItem")

event.OnServerEvent:Connect(function(player, itemName, price)
	local points = player:WaitForChild("leaderstats"):FindFirstChild("Points")
	local backpack = player:FindFirstChild("Backpack")

	-- Check if item already exists in Backpack
	if backpack:FindFirstChild(itemName) then
		print(itemName .. " already exists in backpack!")
		return
	end

	-- Check if player has enough points
	if points and points.Value >= price then
		local item = ServerStorage.ShopItems:FindFirstChild(itemName)
		if item then
			points.Value = points.Value - price
			local clonedItem = item:Clone()
			clonedItem.Parent = backpack
			print(itemName .. " purchased!")
		else
			print(itemName .. " not found in ServerStorage!")
		end
	else
		print("Not enough points to buy " .. itemName)
	end
end)


-- Leaderstats script
-- This goes inside ServerScriptStorage
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local points = Instance.new("IntValue")
	points.Name = "Points"
	points.Value = 0
	points.Parent = leaderstats

	-- Continuously update points every second
	while true do
		wait(1) -- Pause for 1 second
		points.Value = points.Value + 1 -- Add 1 point every second
	end
end)

-- local script
-- this goes inside the Frame

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local event = ReplicatedStorage:WaitForChild("BuyItem")

local player = game.Players.LocalPlayer
local points = player:WaitForChild("leaderstats"):WaitForChild("Points")

-- Items configuration
local items = {
	["LaserGunFrame"] = {price = 10, itemName = "LaserGun"},
}

-- Loop through all item frames
for frameName, itemData in pairs(items) do
	local frame = script.Parent:FindFirstChild(frameName) -- Find the frame
	if frame then
		local button = frame:FindFirstChild("BuyButton") -- Find the button inside the frame

		if button then
			-- Connect button click event
			button.MouseButton1Click:Connect(function()
				-- Fire RemoteEvent to server with item info
				event:FireServer(itemData.itemName, itemData.price)
			end)
		else
			print("Buy button not found in " .. frameName)
		end
	else
		print(frameName .. " not found!")
	end
end

