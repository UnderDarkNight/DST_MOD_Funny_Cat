--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    修正鸟

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local flowers = {"crow","robin","robin_winter","canary","quagmire_pigeon","puffin"}

local function hook(inst)
    if not TheWorld.ismastersim then
        return
    end


    if inst.components.periodicspawner then
        -- inst.components.periodicspawner:SetPrefab(nil)
        inst.components.periodicspawner.TrySpawn = function()
            return true
        end
    end


end

for k, prefab in pairs(flowers) do
    AddPrefabPostInit(prefab, hook)
end