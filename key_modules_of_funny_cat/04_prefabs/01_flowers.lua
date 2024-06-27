--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local flowers = {"flower","flower_rose","planted_flower"}

local function hook(inst)
    if not TheWorld.ismastersim then
        return
    end
    inst:DoTaskInTime(0,function()
        local x,y,z = inst.Transform:GetWorldPosition()
        inst:Remove()
        SpawnPrefab("fc_flower").Transform:SetPosition(x,y,z)
    end)
end

for k, prefab in pairs(flowers) do
    AddPrefabPostInit(prefab, hook)
end

-- AddPrefabPostInit(
--     "world",
--     function(inst)
--         if not TheWorld.ismastersim then
--             return
--         end

--         end)