
--Set the amount of points we would need to obtain a weaon
local Katana_Points = 10
local Bow_Points = 20

-- Create a variable for each weapon and make it equal to the weapon that we stored in Replicated Storage
local weapon_epic_katana = game.ReplicatedStorage.EpicKatana
local weapon_ice_bow = game.ReplicatedStorage.IceBow

-- Now let's create a function that will only run when the player is added to the game


-- Handle player points and weapon granting
local function handlePoints(player, player_points)
	while player and player.Parent do
		wait(1) -- Wait for 1 second
		player_points.value = player_points.value + 1 -- Increase points over time

		print(player.Name .. " has " ..  player_points.value .. " points.") -- Show points in the output

		-- Check if the player has enough points for the Katana
		if  player_points.value >= Katana_Points and weapon_epic_katana then
			local backpack = player:FindFirstChild("Backpack")
			if backpack and not backpack:FindFirstChild(weapon_epic_katana.Name) then
				weapon_epic_katana:Clone().Parent = backpack
			end
		end

		-- Check if the player has enough points for the Bow
		if  player_points.value >= Bow_Points and weapon_ice_bow then
			local backpack = player:FindFirstChild("Backpack")
			if backpack and not backpack:FindFirstChild(weapon_ice_bow.Name) then
				weapon_ice_bow:Clone().Parent = backpack
			end
		end
	end
end

-- Reset points when the player dies
local function resetPointsOnDeath(player, humanoid, player_points)
	humanoid.Died:Connect(function()
		print(player.Name .. " died. Resetting points.")
		player_points.value = 0 -- Reset points
		local backpack = player:FindFirstChild("Backpack")
		if backpack then
			backpack:ClearAllChildren() -- Clear all items from the backpack
		end
	end)
end

-- When a player joins the game
game.Players.PlayerAdded:Connect(function(player)
	-- Shared points reference to track points across respawns
	local pointsRef = { value = 0 } -- Use a table to allow reset across functions

	-- Run the points logic when the player's character is added
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		resetPointsOnDeath(player, humanoid, pointsRef)
		handlePoints(player, pointsRef) -- Start points system when the character spawns
	end)
end)
