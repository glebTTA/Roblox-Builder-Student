--- Ensure LocalPlayer is loaded
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait() -- Wait until player loads

-- Points variable
local points = 0
-- Function to reset points
function resetPoints()
    points = 0
    print("Player died. Points reset to 0.")
end

-- Function to add weapons to the backpack
function addWeapon(weaponName)
    local weapon = game.ServerStorage:FindFirstChild(weaponName)

    -- Ensure Backpack exists
    local backpack = player:WaitForChild("Backpack")

    -- Check if weapon already exists in the backpack
    if backpack:FindFirstChild(weaponName) then
        print(weaponName .. " is already in the backpack!")
        return
    end

    -- Add weapon if found
    if weapon then
        weapon:Clone().Parent = backpack
        print(weaponName .. " added to backpack!")
    else
        print("Weapon not found!")
    end
end

-- Function to handle player setup and main game logic
function setupPlayer()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Attach death event
    humanoid.Died:Connect(resetPoints)

    -- Main game loop for updating points and unlocking weapons
    spawn(function()
        while true do
            wait(1)
            points += 1
            print("Points: " .. points)

            if points >= 10 then
                addWeapon("Katana")
            end
            if points >= 20 then
                addWeapon("Bow")
            end
        end
    end)
end

player.CharacterAdded:Connect(setupPlayer)
setupPlayer()
