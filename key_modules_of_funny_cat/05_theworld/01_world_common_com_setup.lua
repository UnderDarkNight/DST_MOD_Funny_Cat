------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddPrefabPostInit("world",function(inst)
    if not TheWorld.ismastersim then
        return
    end

    if inst.components.funny_cat_world_map_tile_sys == nil then
        inst:AddComponent("funny_cat_world_map_tile_sys")        
    end
    inst.components.funny_cat_world_map_tile_sys:AddPostInitFn(function()
        print("fake error : funny_cat_world_map_tile_sys  OnPostInit")
    end)

end)