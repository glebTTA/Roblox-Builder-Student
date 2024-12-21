-- Score script ---

print("The Game is Starting...")

-- Now, we will create a variable to keep track of our score

_G.score = 0

-- This code will help us add 1 point to our score each second

while true do
	wait(1) -- wait 1 sesond before adding a point
	_G.score = _G.score + 1 -- add 1 point to our score
	print(score)
end

-- Reset script ---
-- this script will reset the Global points variable on player death.
game:GetService('Players').PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild("Humanoid").Died:Connect(function()
			print(player.Name .. " has died!")
			_G.score = 0
		end)
	end)
end)
