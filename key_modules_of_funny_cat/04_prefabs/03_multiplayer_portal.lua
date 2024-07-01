--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    绚丽之门 坐标位置修正。

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local flowers = {"multiplayer_portal","multiplayer_portal_moonrock_constr","multiplayer_portal_moonrock"}

local function hook(inst)
    if not TheWorld.ismastersim then
        return
    end
    inst:DoTaskInTime(0,function()
        local x,y,z = inst.Transform:GetWorldPosition()
        x = x - 2
        z = z - 2
        x,y,z = TheWorld.Map:GetTileCenterPoint(x,y,z)
        x = x + 2
        z = z + 2
        inst.Transform:SetPosition(x,y,z)
        -------------------------------------------------------
        --
            local ents = TheSim:FindEntities(x,y,z,15,{"flower"})
            if #ents == 0 then
                local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                    pt = Vector3(x,y,z),
                    range = 4,
                    num = 8,
                })
                for k, pt in pairs(points) do
                    SpawnPrefab("fc_flower").Transform:SetPosition(pt.x,pt.y,pt.z)
                end
            end
        -------------------------------------------------------
    end)

end

for k, prefab in pairs(flowers) do
    AddPrefabPostInit(prefab, hook)
end