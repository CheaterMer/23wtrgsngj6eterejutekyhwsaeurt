_G.targetr = nil

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Farn2000/ShuShiHis/master/clean_ui.lua"))()
local Window = library:CreateWindow("Mer-Cute", Enum.KeyCode.RightControl, "DiscordInv")

local TabE = Window:CreateTab("Extra", "3192485759")
local TabU = Window:CreateTab("Update Log", "3192485759")
local TabC = Window:CreateTab("Lock On", "3192485759")
local TabS = Window:CreateTab("Range", "3192485759")
local TabM = Window:CreateTab("Damage M", "3192485759")
local TabMisc = Window:CreateTab("MISC", "3192485759")
local TabO = Window:CreateTab("OTHERS Script", "3192485759")




local LabelE = TabE:CreateLabel('Extra')
local LabelU = TabU:CreateLabel('Update Log')
local LabelC = TabC:CreateLabel('Custom Characters')
local LabelS = TabS:CreateLabel('Custom Stuff')
local LabelM = TabM:CreateLabel('Damage Modules')
local LabelMisc = TabMisc:CreateLabel('MISC')
local LabelO = TabO:CreateLabel('OTHER SCRIPTS')









---Extra Tab Stuff
local Credits = TabE:CreateLabel('~Credits~')
local Credits = TabE:CreateLabel('~​Mene Brother​ - For the UI *on gitbook.io*~')
local Credits = TabE:CreateLabel('​shifter#4049​ - Fixing scripts!')
local Credits = TabE:CreateLabel('​void#3308​ - Giving Customs/Attack/Misc Ideas')







---Update Log Tab Stuff
local Update = TabU:CreateLabel('Version: 1.0')






local player = game.Players.LocalPlayer
local char = player.Character
local root = char.HumanoidRootPart
local rootpart = char.HumanoidRootPart

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer


local Remotes = {}

for idx, val in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
    if val:IsA("RemoteEvent") then
        Remotes[val.Name] = val
    end
end

local itemlist = {}

for i,v in pairs(workspace:GetDescendants()) do
    if v:IsA("Tool") then
        --pcall(function ()
        if not table.find(itemlist, v.Name) then
        table.insert(itemlist, v.Name)
        end
        --end)
    end
end

local attack_tools = {
    "Axe",
    "Pickaxe",
    "Crowbar",
    "Hammer",
    "Knife",
    "Fist"
}

local function CheckRange(part1, part2, stud)
    local range = (part1.Position - part2.Position).Magnitude
    if range < stud then
        return true
    end
    return false
end



function anime(id)
				local animation1 = Instance.new("Animation")
				--animation1.Name = "AttackMove"
				animation1.AnimationId = "rbxassetid://"..id
				local anim1 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation1)
				anim1.Name = "AttackMove"
				task.wait()
				anim1:Play()
end
--[[
	task.spawn(function()
	while task.wait() do
	task.wait(0.1)
		--if char:FindFirstChild("Animate") then
			for i,v in ipairs(char.Humanoid:GetPlayingAnimationTracks()) do
				--print(v)
				if LP.Character.IsCuffed.Value == false then
				v:Stop()
				end 
			end 
		--end
	end
	end)
]]

local ToolFinder 

function findtool(toolName)
	if LP.Backpack:FindFirstChild(toolName) then
        ToolFinder = LP.Backpack:FindFirstChild(toolName)
        print("backpack")
		return ToolFinder
	elseif workspace:FindFirstChild(toolName) then
        ToolFinder = workspace:FindFirstChild(toolName)
        print("workspace")
		return ToolFinder
    elseif workspace:FindFirstChild(toolName) == nil then
        for i,v in pairs(Players:GetChildren()) do
            if v.Backpack:FindFirstChild(toolName) then
                ToolFinder = v.Backpack:FindFirstChild(toolName)
                return ToolFinder
            end
        end
	end
end

local ToolFinders

function findtools(toolNames)
	if LP.Backpack:FindFirstChild(toolNames) then
        ToolFinders = LP.Backpack:FindFirstChild(toolNames)
        print("backpack")
		return ToolFinders
    elseif LP.Backpack:FindFirstChild(toolNames) == nil then
        for i,v in pairs(Players:GetChildren()) do
            if v.Backpack:FindFirstChild(toolNames) then
				print(v.Name,"   " , toolNames)
                ToolFinders = v.Backpack:FindFirstChild(toolNames)
                return ToolFinders
            end
        end
	end
end

function cuffs()
	pcall(function()
		for idx, plr in pairs(Players:GetPlayers()) do
			if
				plr ~= LP and CheckRange(LP.Character.HumanoidRootPart, plr.Character.HumanoidRootPart, 10)
				and plr.Character.Hostile.Value and LP.Team ~= plr.Team and plr.Character.Humanoid.Health ~= 0 
			then
				if plr.Team ~= LP.Team and _G.LockOnhit == false and plr.Character.IsCuffed.Value == false then
					Remotes["IsCuffed"]:FireServer(findtool("Handcuffs"), plr.Character)
						task.wait()
				elseif plr.Team ~= LP.Team and _G.LockOnhit == true and plr.Character.IsCuffed.Value == false then
					if plr.Name == _G.targetr then
						Remotes["IsCuffed"]:FireServer(findtool("Handcuffs"), plr.Character)
						task.wait()
					end
				elseif plr.Team ~= LP.Team and _G.LockOnhit == false and plr.Character.IsCuffed.Value == true then
						Remotes["UnCuffed"]:FireServer(plr.Character)
						task.wait()
				elseif plr.Team ~= LP.Team and _G.LockOnhit == true and plr.Character.IsCuffed.Value == true then
					if plr.Name == _G.targetr then
						Remotes["UnCuffed"]:FireServer(plr.Character)
						task.wait()
					end
				end
			end
		end
	end) 
end

function hoglast()
	pcall(function()
		for idx, plr in pairs(Players:GetPlayers()) do
			if
				plr ~= LP and CheckRange(LP.Character.HumanoidRootPart, plr.Character.HumanoidRootPart, 10)
				and plr.Character.Hostile.Value and LP.Team ~= plr.Team and plr.Character.Humanoid.Health ~= 0 
			then
				if plr.Team ~= LP.Team and _G.LockOnhit == false and plr.Character.IsHogged.Value == false then
					Remotes["IsHog"]:FireServer(plr.Character,"Hog")
					task.wait()
				elseif plr.Team ~= LP.Team and _G.LockOnhit == true and plr.Character.IsHogged.Value == false then
					if plr.Name == _G.targetr then
						Remotes["IsHog"]:FireServer(plr.Character,"Hog")
						task.wait()
					end
				elseif plr.Team ~= LP.Team and _G.LockOnhit == false and plr.Character.IsHogged.Value == true then
					Remotes["IsHog"]:FireServer(plr.Character,"UnHog")
					task.wait()
				elseif plr.Team ~= LP.Team and _G.LockOnhit == true and plr.Character.IsHogged.Value == true then
					if plr.Name == _G.targetr then
						Remotes["IsHog"]:FireServer(plr.Character,"UnHog")
						task.wait()
					end
				end
			end
		end
	end) 
end

---CUSTOM CHARACTER TAB -DEATH-
local LockOn = TabC:CreateLabel('*menu*')

local taser 



task.spawn(function()
    while task.wait() do
        spawn(function()
            if taser then
                Remotes["Tase"]:FireServer("Hit", findtools("Taser"), game:GetService("Players"):WaitForChild(_G.targetr).Character.Head)
                task.wait()
                Remotes["Tase"]:FireServer("Recharge", findtools("Taser"))
                task.wait()
            end
        end) 
    end
end)

TabC:CreateToggle("Block Taser",false,false,function(asdf)
    blocktasercombat = asdf
end)

TabC:CreateToggle("Loop Taser",false,false,function(asdf)
    taser = asdf
end)

TabC:CreateButton("One Taser",function()
        Remotes["Tase"]:FireServer("Hit", findtools("Taser"), game:GetService("Players"):WaitForChild(_G.targetr).Character.Head)
		task.wait()
		Remotes["Tase"]:FireServer("Recharge", findtools("Taser"))
		task.wait()
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer


local blocktoolNames = "Taser"


task.spawn(function()
	while task.wait() do
		if blocktasercombat then
			spawn(function()
				for i,v in pairs(Players:GetChildren()) do



						if v ~= LP and v.Backpack:FindFirstChild(blocktoolNames) and v.Backpack:FindFirstChild(blocktoolNames).Charged.Value == true and v.Team ~= LP.Team and v.Character.Hostile.Value == true then
							
							print(v.Name," Backpack  " , blocktoolNames)
							ToolFinders = v.Backpack:FindFirstChild(blocktoolNames)
							
							Remotes["Tase"]:FireServer("Hit", ToolFinders, v.Character.Head)

						elseif v ~= LP and v.Backpack:FindFirstChild(blocktoolNames) and v.Backpack:FindFirstChild(blocktoolNames).Charged.Value == true and v.Team == LP.Team and v.Character.Hostile.Value == true then

							print(v.Name," Backpack other " , blocktoolNames)
							ToolFinders = v.Character:FindFirstChild(blocktoolNames)

							for idx, plr in pairs(Players:GetPlayers()) do
								if plr ~= LP and plr.Character.Hostile.Value == true and plr.Team ~= LP.Team then
									Remotes["Tase"]:FireServer("Hit", ToolFinders, plr.Character.Head)
								end
							end

						end

					if v ~= LP and v.Character:FindFirstChild(blocktoolNames) and v.Character:FindFirstChild(blocktoolNames).Charged.Value == true and v.Team ~= LP.Team and v.Character.Hostile.Value == true then
						
						print(v.Name," Character  " , blocktoolNames)
						ToolFinders = v.Character:FindFirstChild(blocktoolNames)

						Remotes["Tase"]:FireServer("Hit", ToolFinders, v.Character.Head)

					elseif v ~= LP and v.Character:FindFirstChild(blocktoolNames) and v.Character:FindFirstChild(blocktoolNames).Charged.Value == true and v.Team == LP.Team and v.Character.Hostile.Value == true then

						print(v.Name," Character other  " , blocktoolNames)
						ToolFinders = v.Character:FindFirstChild(blocktoolNames)

						for idx, plr in pairs(Players:GetPlayers()) do
							if plr ~= LP and plr.Character.Hostile.Value == true and plr.Team ~= LP.Team then
								Remotes["Tase"]:FireServer("Hit", ToolFinders, plr.Character.Head)
							end
						end

					end
				end
			end)
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if cuff then
			pcall(function()
				for idx, plr in pairs(Players:GetPlayers()) do
					if
						plr ~= LP and CheckRange(LP.Character.HumanoidRootPart, plr.Character.HumanoidRootPart, 10)
						and plr.Character.Hostile.Value and LP.Team ~= plr.Team and plr.Character.Humanoid.Health ~= 0 
					then
						if plr.Team ~= LP.Team and _G.LockOnhit == false and plr.Character.IsCuffed.Value == false then
							Remotes["IsCuffed"]:FireServer(findtool("Handcuffs"), plr.Character)
								task.wait()
						elseif plr.Team ~= LP.Team and _G.LockOnhit == true and plr.Character.IsCuffed.Value == false then
							if plr.Name == _G.targetr then
								Remotes["IsCuffed"]:FireServer(findtool("Handcuffs"), plr.Character)
								task.wait()
							end
						end
					end
				end
			end) 
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if hog then
			pcall(function()
				for idx, plr in pairs(Players:GetPlayers()) do
					if
						plr ~= LP and CheckRange(LP.Character.HumanoidRootPart, plr.Character.HumanoidRootPart, 10)
						and plr.Character.Hostile.Value and LP.Team ~= plr.Team and plr.Character.Humanoid.Health ~= 0 
					then
						if plr.Team ~= LP.Team and _G.LockOnhit == false and plr.Character.IsHogged.Value == false then
							Remotes["IsHog"]:FireServer(plr.Character,"Hog")
							task.wait()
						elseif plr.Team ~= LP.Team and _G.LockOnhit == true and plr.Character.IsHogged.Value == false then
							if plr.Name == _G.targetr then
								Remotes["IsHog"]:FireServer(plr.Character,"Hog")
								task.wait()
							end
						end
					end
				end
			end) 
		end
	end
end)


TabS:CreateToggle("cuff",false,false,function(asdf)
    cuff = asdf
end)

TabS:CreateToggle("hog Taser",false,false,function(asdf)
    hog = asdf
end)


TabS:CreateButton("Cuffed",function()
    cuffs()
end)

TabS:CreateButton("Hogged",function()
    hoglast()
end)

TabO:CreateButton("Zeouron's GUI",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/voidy434343/Zeouron-Mainiatic/main/Tlk%20prison%20obf.txt"))()
end)

TabO:CreateButton("Red's GUI",function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/bryntt-hub/Red-Gui/main/Red"))()
end)

TabO:CreateButton("bryntt's GUI",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bryntt-hub/TLKGUI-20/refs/heads/main/brynttTLKGUI"))()
end)