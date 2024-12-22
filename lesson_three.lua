-- Change Speed
-- Add this to a collecable objection.
script.Parent.Touched:Connect(function(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = humanoid.WalkSpeed + 30 -- Increase speed by 10

		-- Add glow effect
		local glow = Instance.new("PointLight")
		glow.Parent = script.Parent
		glow.Brightness = 2

		script.Parent:Destroy() -- Remove collectible after use
	end
end)

-- Change Health
-- Add this to a collecable objection.

script.Parent.Touched:Connect(function(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.MaxHealth = humanoid.MaxHealth + 20 -- Increase max health by 20
		humanoid.Health = humanoid.MaxHealth -- Restore health to full

		-- Add glow effect
		local glow = Instance.new("PointLight")
		glow.Parent = script.Parent
		glow.Brightness = 2

		script.Parent:Destroy() -- Remove collectible after use
	end
end)


-- Teleport Character
-- Add this to a collecable objection.

script.Parent.Touched:Connect(function(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		local character = hit.Parent

		-- Generate random nearby location
		local randomX = math.random(-200, 200)
		local randomZ = math.random(-10, 10)
		local newPosition = character.PrimaryPart.Position + Vector3.new(randomX, 0, randomZ)

		-- Teleport player
		character:SetPrimaryPartCFrame(CFrame.new(newPosition))

		-- Add glow effect
		local glow = Instance.new("PointLight")
		glow.Parent = script.Parent
		glow.Brightness = 2

		 
	end
end)
