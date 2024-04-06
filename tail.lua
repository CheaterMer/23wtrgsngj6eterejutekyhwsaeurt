local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

function createweight()
    local p = Instance.new("Part",game.Players.LocalPlayer.Character)
    p.Size = Vector3.new(.5,.5,.5)
    p.CanCollide = false
    p.CanTouch = false
    p.Anchored = true
    p.Transparency = 1
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
    local camera = workspace.CurrentCamera
    local humanoid = game.Players.LocalPlayer.Character.Humanoid
    local head = game.Players.LocalPlayer.Character.Head
    local subject = p
    subject.Position = head.Position
    camera.CameraSubject = subject
    local WEIGHT = 10
    local function updateSubject()
        if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local lookXZ = Vector3.new(camera.CFrame.LookVector.X,0,camera.CFrame.LookVector.Z)
            rootPart.CFrame = CFrame.lookAt(rootPart.Position,rootPart.Position + lookXZ)
        end
        if (camera.CFrame.Position - subject.Position).Magnitude < 1 or (camera.CFrame.Position - head.Position).Magnitude < 1 then
            camera.CameraSubject = humanoid
            subject.Position = head.Position
        else
            camera.CameraSubject = subject
            subject.Position = subject.Position:Lerp(head.Position,1/WEIGHT)
        end
    end
    RunService:BindToRenderStep("UpdateSubject", Enum.RenderPriority.Camera.Value, updateSubject)
    end

    local BodyParts = {
        "Head",
        "Torso",
        "Left Arm",
        "Right Arm",
        "Left Leg",
        "Right Leg"
    }
    
    function AfterImage(color3, material, duration, trans)
        for i,v in pairs(Player.Character:GetChildren()) do 
            if table.find(BodyParts, v.Name) then
                local part = Instance.new("Part")
                part.Anchored = true 
                part.CanCollide = false 
                part.Massless = true 
                part.CFrame = v.CFrame
                part.Size = v.Size
                part.Transparency = trans
                part.Color = color3
                part.Material = Enum.Material[material]
                TweenService:Create(part,TweenInfo.new(duration),{Transparency = 1}):Play()
                if v.Name == "Head" then 
                    local mesh = Instance.new("SpecialMesh")
                    mesh.MeshType = Enum.MeshType.Head 
                    mesh.Scale = Vector3.new(1.25,1.25,1.25)
                    mesh.Parent = part
                end
                part.Parent = workspace 
                game.Debris:AddItem(part, duration)
                
            end
        end
    end
--[[    task.spawn(function()
        while task.wait(0.00000001) do
            if breakloops == true then break end
            local function createTrail(duration)
                local part = Instance.new("Part")
                part.Anchored = true 
                part.CanCollide = false
                part.CanTouch = false
                part.CanQuery = false
                part.Massless = true 
                part.Position = Player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))
                part.CFrame = CFrame.lookAt(part.Position, part.Position + Player.Character.HumanoidRootPart.Velocity)
                part.CFrame = part.CFrame * CFrame.new(0,0,math.random(-3,0))
                part.Size = Vector3.new(0.25, 0.25, 5)
                part.Color = Color3.fromRGB(255,255,255)
                part.Material = Enum.Material.Neon
                part.Parent = workspace
                game:GetService("TweenService"):Create(part, TweenInfo.new(duration), {Size = Vector3.new(0.1,0.1,part.Size.Z + 1), Transparency = 1}):Play()
                game.Debris:AddItem(part, duration)
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.Sphere
                mesh.Parent = part
            end
            velocity = Player.Character.HumanoidRootPart.Velocity
            --print(tostring(vector.Magnitude))
            if velocity.Magnitude >= 25 then
                createTrail(0.5)
                AfterImage(Color3.fromRGB(255, 0, 0), "Neon", .5, .3)
            end
        end
    end)
    ]]

Player.CharacterAdded:Connect(function(char)
        task.wait(2)
    createweight()
end)



-- 글자들의 리스트
local characters = {"Don't kill...","dOnT dO It...","who are you??","Null","wHaR aRe yOU DoInG"}

-- 화면에 글자를 무작위로 띄우는 함수
local function spawnRandomCharacter()
    local character = characters[math.random(1, #characters)] -- 무작위 글자 선택
    local gui = Instance.new("ScreenGui") -- 새로운 ScreenGui 생성
    gui.Parent = game.Players.LocalPlayer.PlayerGui -- LocalPlayer의 PlayerGui에 추가
    
    local label = Instance.new("TextLabel") -- 새로운 텍스트 레이블 생성
    label.Text = character -- 텍스트 설정
    label.Position = UDim2.new(math.random(), 0, math.random(), 0) -- 무작위 위치 설정
    label.Size = UDim2.new(0, 100, 0, 100) -- 크기 설정
    label.Parent = gui -- gui에 추가
    label.TextColor3 = Color3.fromRGB(128, 0, 0) -- 색상 설정 (검붉은색)
    label.BackgroundTransparency = 1 -- 배경 투명하게 설정
    label.FontSize = Enum.FontSize.Size36 -- 폰트 크기 설정
    
    -- 1초 후에 글자 제거
    wait(1)
    gui:Destroy()
end

-- 일정 시간마다 글자 생성
while true do
    wait(1) -- 1초마다 실행
    spawnRandomCharacter() -- 함수 호출
end
