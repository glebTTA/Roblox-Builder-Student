-- DashButton LocalScript

local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid") -- Player's humanoid

local button = script.Parent -- Dash Button
local cooldown = false -- Cooldown state
local cooldownTime = 5 -- Cooldown in seconds
local dashDistance = 50 -- Distance to dash forward
local dashSpeed = 100 -- Temporary speed boost
local dashDuration = 0.2 -- Dash lasts 0.2 seconds

-- Function to perform the dash
local function activateDash()
	-- Check cooldown
	if cooldown then
		print("Dash is on cooldown!")
		return
	end

	-- Activate dash
	cooldown = true -- Start cooldown
	button.Text = "Dashing!" -- Update button text
	button.Active = false -- Disable button during dash

	-- Save original speed
	local originalSpeed = humanoid.WalkSpeed

	-- Boost speed temporarily
	humanoid.WalkSpeed = dashSpeed

	-- Dash forward
	local rootPart = player.Character.PrimaryPart -- Get player's root part
	rootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, -dashDistance) -- Move forward

	-- Wait for dash duration
	wait(dashDuration)

	-- Reset speed
	humanoid.WalkSpeed = originalSpeed
	print("Dash complete!")

	-- Reactivate button
	button.Text = "Dash"
	button.Active = true
	cooldown = false
end

-- Connect the button click to the function
button.MouseButton1Click:Connect(activateDash)




-- Leadestats level Up script

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local points = Instance.new("IntValue")
	points.Name = "Points"
	points.Value = 10
	points.Parent = leaderstats
	
	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Value = 0
	level.Parent = leaderstats
	
	local level_up = Instance.new("IntValue")
	level_up.Name = "Level Up"
	level_up.Value = 50
	level_up.Parent = leaderstats

	

	-- Continuously update points every second
	while true do
		wait(1) -- Pause for 1 second
		points.Value = points.Value + 10
		if points.Value >= level_up.Value then
			level.Value = level.Value + 1
			level_up.Value = level_up.Value + 50
		end
	end
end)




-- Coin System Script. Put this inside the Coin part
script.Parent.Touched:Connect(function(hit)
 local player = game.Players:GetPlayerFromCharacter(hit.Parent)
 if player then
  -- Get points stat from leaderstats
  local stats = player:FindFirstChild("leaderstats")
  local points = stats and stats:FindFirstChild("Points")

  if points then
   points.Value += 10 -- Add 10 points
   print("Coin collected! Points: " .. points.Value)
   script.Parent:Destroy() -- Remove the coin
  end
 end
end)





-- Disappearing Door Script. Put this inside The Door object
local door = script.Parent -- The door object
local requiredPoints = 30 -- Points required to unlock the door

-- Check player’s points
 game.Players.PlayerAdded:Connect(function(player)
 local stats = player:WaitForChild("leaderstats") -- Find leaderstats
 local points = stats:WaitForChild("Points") -- Find Points stat

 -- Detect when points change
 points.Changed:Connect(function(newPoints)
  if newPoints >= requiredPoints then -- Check if points meet the requirement
       door.Transparency = 1 -- Make the door transparent
       door.CanCollide = false -- Allow players to walk through
        print("Door unlocked!") -- Debug message
        end
   end)
end)

-- Put This Inside FireZombie enemy

local humanoid = script.Parent:WaitForChild("Humanoid")
humanoid.WalkSpeed = 25

