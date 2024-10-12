if game:GetService("CoreGui"):FindFirstChild("ToraScript") then
    game:GetService("CoreGui").ToraScript:Destroy()
end

-- Load the library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ToraScript/Script/main/test", true))()

-- Create the main window
local ExampleWindow = Library:CreateWindow("主要菜单")
local FarmWindow = Library:CreateWindow("自动功能菜单")
local EggWindow = Library:CreateWindow("鸡蛋菜单")
local PlayerWindow = Library:CreateWindow("玩家菜单")

-- Variables
local autoOpenEggActive = false
local autoOpenEventActive = false
local craftActive = false
local autoRebirthActive = false
local autoSpinActive = false
local autoRewardsActive = false
local speedActive = false
local jumpActive = false
local speedValue = 16
local jumpPowerValue = 50
local currentEggConfig = "Egg_Event2"

-- Variables 2
local antiAFKActive = true
local antiAFKTime = 18 * 60
local warningTime = 120

local function antiAFK()
    spawn(function()
        while antiAFKActive do
            wait(antiAFKTime - warningTime)

            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
            print("Anti-AFK activado.")
            
            wait(warningTime)
        end
    end)
end

local function antiAFK()
    spawn(function()
        while antiAFKActive do
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
            wait(60)
        end
    end)
end

local function openEgg(eggConfig)
    local ohNumber1 = 135
    local ohTable3 = {}
    local ohBoolean4 = true
    game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1, eggConfig, ohTable3, ohBoolean4)
end

local function startAutoOpening(eggConfig)
    if openEggLoop then openEggLoop:Disconnect() end
    openEggLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if autoOpenEggActive and eggConfig then
            wait(0.5)
            openEgg(eggConfig)
        end
    end)
end

local function stopAutoOpening()
    if openEggLoop then openEggLoop:Disconnect() end
    openEggLoop = nil
end

local function startAutoCraft()
    if craftLoop then craftLoop:Disconnect() end
    craftLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if craftActive then
            local ohNumber1 = 126
            game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1)
        end
    end)
end

local function stopAutoCraft()
    if craftLoop then craftLoop:Disconnect() end
    craftLoop = nil
end

local function startAutoOpeningEvent()
    spawn(function()
        while autoOpenEventActive do
            local ohNumber1 = 2005
            local ohString2 = Egg_Event2
            game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1, ohString2)
            wait(5)
        end
    end)
end

local function stopAutoOpeningEvent()
    autoOpenEventActive = false
end

local function setAutoPlayerRace(enabled)
    local ohNumber1 = 701
    local ohString2 = "AutoPlayerRace"
    if enabled then
        game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1, ohString2)
        print("AutoPlayerRace Activated")
    else
        local ohDeactivateNumber1 = 306
        local ohBoolean2 = false
        game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohDeactivateNumber1, ohBoolean2)
        print("AutoPlayerRace Deactivated")

        local ohExitNumber1 = 179
        local ohExitBoolean2 = true
        game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohExitNumber1, ohExitBoolean2)
    end
end

local function setAutoBattle(enabled, numExecutions)
    local ohNumber1 = 701
    local ohString2 = "AutoBattle"
    local ohDeactivateNumber1 = 306
    local ohDeactivateBoolean2 = false
    local ohExitNumber1 = 179
    local ohExitBoolean2 = true

    if enabled then
        game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1, ohString2)
        print("AutoBattle Activated")
        
        wait(1)
        for i = 1, numExecutions do
            local ohNumber1 = 286
            game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1)
            wait(0.1)
        end
    else
        game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohDeactivateNumber1, ohDeactivateBoolean2)
        print("AutoBattle Deactivated")

        game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohExitNumber1, ohExitBoolean2)
    end
end

local function startAutoRebirth()
    if autoRebirthLoop then autoRebirthLoop:Disconnect() end
    autoRebirthLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if autoRebirthActive then
            wait(5)
            local ohNumber1 = 132
            local success, errorMsg = pcall(function()
                game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1)
            end)
            if not success then
                print("Error: " .. errorMsg)
            end
        end
    end)
end

local function stopAutoRebirth()
    if autoRebirthLoop then autoRebirthLoop:Disconnect() end
    autoRebirthLoop = nil
end

local function startAutoSpin()
    if spinLoop then spinLoop:Disconnect() end
    spinLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if autoSpinActive then
            local ohNumber1 = 149
            game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1)
        end
    end)
end

local function stopAutoSpin()
    if spinLoop then spinLoop:Disconnect() end
    spinLoop = nil
end

local function startAutoRewards()
    if rewardsLoop then rewardsLoop:Disconnect() end
    rewardsLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if autoRewardsActive then
            for ohNumber2 = 1, 12 do
                local success, errorMsg = pcall(function()
                    game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(105, ohNumber2)
                end)
                if not success then
                    print("Error while claiming reward: " .. errorMsg)
                end
                wait(1)
            end
            wait(60)
        end
    end)
end


local function stopAutoRewards()
    if rewardsLoop then rewardsLoop:Disconnect() end
    rewardsLoop = nil
end

local function setPlayerSpeed(speed)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end

local function enableSpeed()
    setPlayerSpeed(speedValue)
end

local function disableSpeed()
    setPlayerSpeed(16)
end

local function forceResetPlayer()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character:BreakJoints()
        print("Player character reset.")
    else
        print("Player or character not found.")
    end
end

local function cancelAction()
    local ohNumber1 = 2002
    game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1)
end

local function rejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end

local function serverHop()
    local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
    for _, server in pairs(servers) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, game.Players.LocalPlayer)
            break
        end
    end
end

ExampleWindow:AddToggle({
    text = "自动播放比赛",
    flag = "AutoPlayerRaceToggle",
    state = false,
    callback = function(value)
        setAutoPlayerRace(value)
    end
})

ExampleWindow:AddToggle({
    text = " 最好的战斗1",
    flag = "BestBattle1Toggle",
    state = false,
    callback = function(value)
        setAutoBattle(value, 10)
    end
})

ExampleWindow:AddToggle({
    text = "最好的战斗 2",
    flag = "BestBattle2Toggle",
    state = false,
    callback = function(value)
        setAutoBattle(value, 15)
    end
})

ExampleWindow:AddToggle({
    text = "自动重生",
    flag = "AutoRebirthToggle",
    state = false,
    callback = function(value)
        if value then
            autoRebirthActive = true
            startAutoRebirth()
        else
            autoRebirthActive = false
            stopAutoRebirth()
        end
    end
})

ExampleWindow:AddToggle({
    text = "自动获胜",
    flag = "AutoRewardsToggle",
    state = false,
    callback = function(value)
        if value then
            autoRewardsActive = true
            startAutoRewards()
        else
            autoRewardsActive = false
            stopAutoRewards()
        end
    end
})

local worldOptions = {
    ["世界 1"] = {"Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5", "Exercise 6", "Exercise 7"},
    ["世界 2"] = {"Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5", "Exercise 6", "Exercise 7"},
    ["世界 3"] = {"Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5", "Exercise 6", "Exercise 7"},
    ["世界 4"] = {"Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5", "Exercise 6", "Exercise 7"},
}

local exerciseMap = {
    ["Exercise 1"] = 1, ["Exercise 2"] = 2, ["Exercise 3"] = 3, ["Exercise 4"] = 4,
    ["Exercise 5"] = 5, ["Exercise 6"] = 6, ["Exercise 7"] = 7
}

for i = 1, 4 do
    FarmWindow:AddList({
        text = "世界 " .. i,
        flag = "World" .. i .. "Dropdown",
        value = "::Select Exercise::",
        values = worldOptions["World " .. i],
        callback = function(selectedExercise)
            if selectedExercise == "::Select Exercise::" then
                cancelAction()
            else
                local exerciseNumber = exerciseMap[selectedExercise]
                local ohNumber1 = 2002
                game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber1)
                wait(0.7)
                local ohNumber2 = 701
                local ohString2 = "PlayerExercise"
                local ohNumber3 = exerciseNumber
                game:GetService("ReplicatedStorage").RemoteEvent.Client:FireServer(ohNumber2, ohString2, ohNumber3)
                wait(0.5)
            end
        end,
    })
end

EggWindow:AddToggle({
    text = "自动打开鸡蛋",
    flag = "EggAutoOpenToggle",
    state = false,
    callback = function(value)
        autoOpenEggActive = value
        if value then
            startAutoOpening(currentEggConfig)
        else
            stopAutoOpening()
        end
    end
})

EggWindow:AddToggle({
    text = "自动打开事件",
    flag = "EggAutoOpenEventToggle",
    state = false,
    callback = function(value)
        autoOpenEventActive = value
        if value then
            startAutoOpeningEvent()
        else
            stopAutoOpeningEvent()
        end
    end
})

EggWindow:AddToggle({
    text = "自动工艺",
    flag = "EggAutoCraftToggle",
    state = false,
    callback = function(value)
        craftActive = value
        if value then
            startAutoCraft()
        else
            stopAutoCraft()
        end
    end
})

EggWindow:AddToggle({
    text = "自动旋转",
    flag = "EggAutoSpinToggle",
    state = false,
    callback = function(value)
        autoSpinActive = value
        if value then
            startAutoSpin()
        else
            stopAutoSpin()
        end
    end
})

local eggWorldOptions = {
    ["世界 1"] = {"Egg 1", "Egg 2", "Egg 3", "Egg 4"},
    ["世界 2"] = {"Egg 1", "Egg 2", "Egg 3", "Egg 4"},
    ["世界 3"] = {"Egg 1", "Egg 2", "Egg 3", "Egg 4"},
    ["世界 4"] = {"Egg 1", "Egg 2", "Egg 3", "Egg 4"},
}

local eggConfigMap = {
    ["Egg 1"] = function(prefix) return "Egg_" .. prefix .. "_A_Cfg" end,
    ["Egg 2"] = function(prefix) return "Egg_" .. prefix .. "_B_Cfg" end,
    ["Egg 3"] = function(prefix) return "Egg_" .. prefix .. "_C_Cfg" end,
    ["Egg 4"] = function(prefix) return "Egg_" .. prefix .. "_D_Cfg" end,
}

for i = 1, 4 do
    EggWindow:AddList({
        text = "世界 " .. i,
        flag = "World" .. i .. "EggsDropdown",
        value = "::Select Egg::",
        values = eggWorldOptions["World " .. i],
        callback = function(selectedEgg)
            if selectedEgg == "::Select Egg::" then
                stopAutoOpening()
                print("AutoOpenEgg stopped.")
            else
                local prefix = "P" .. i
                local eggConfig = eggConfigMap[selectedEgg](prefix)
                currentEggConfig = eggConfig
                if autoOpenEggActive then
                    startAutoOpening(eggConfig)
                else
                    openEgg(eggConfig)
                    print("Option " .. selectedEgg .. " Event Fired")
                end
            end
        end,
    })
end

PlayerWindow:AddToggle({
    text = "启用速度",
    flag = "PlayerSpeedToggle",
    state = false,
    callback = function(value)
        speedActive = value
        if value then
            enableSpeed()
        else
            disableSpeed()
        end
    end
})

PlayerWindow:AddSlider({
    text = "速度",
    flag = "PlayerSpeedSlider",
    value = 16,
    min = 16,
    max = 100,
    callback = function(value)
        speedValue = value
        if speedActive then
            enableSpeed()
        end
    end
})

PlayerWindow:AddToggle({
    text = "服务器跳",
    flag = "ServerHopToggle",
    state = false,
    callback = function(value)
        serverHop()
    end
})

PlayerWindow:AddButton({
    text = "力重置",
    flag = "ForceResetButton",
    state = false,
    callback = function(value)
        forceResetPlayer()
    end
})

PlayerWindow:AddToggle({
    text = "加入服务器",
    flag = "RejoinServerToggle",
    state = false,
    callback = function(value)
        rejoinServer()
    end
})

PlayerWindow:AddToggle({
    text = "反-AFK",
    flag = "AntiAFKToggle",
    state = true,
    callback = function(value)
        antiAFKActive = value
        if value then
            antiAFK()
        end
    end
})

-- Initialize the library
Library:Init()
