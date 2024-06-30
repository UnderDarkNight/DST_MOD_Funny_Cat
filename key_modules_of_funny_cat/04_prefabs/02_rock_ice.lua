local flowers = {"rock_ice","sharkboi_ice_hazard"}

local function hook(inst)
    if not TheWorld.ismastersim then
        return
    end
    inst:DoTaskInTime(0,function()
        local x,y,z = inst.Transform:GetWorldPosition()
        inst:Remove()
        SpawnPrefab("fc_rock_ice").Transform:SetPosition(x,y,z)
    end)
end

for k, prefab in pairs(flowers) do
    AddPrefabPostInit(prefab, hook)
end