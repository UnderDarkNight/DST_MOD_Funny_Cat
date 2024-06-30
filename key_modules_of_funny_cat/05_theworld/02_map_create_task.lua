------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    -- if TUNING.FUNNY_CAT_DEBUGGING_MODE then
    --     return
    -- end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddPrefabPostInit("world",function(inst)
    if not TheWorld.ismastersim then
        return
    end

    if inst.components.funny_cat_world_map_tile_sys == nil then
        inst:AddComponent("funny_cat_world_map_tile_sys")        
    end
    inst.components.funny_cat_world_map_tile_sys:AddPostInitFn(function()
        -- inst:DoTaskInTime(0,function()
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- debug 测试
            local start_time = os.clock()
            print("+++++++++ main land task start +++++++++++++++++")
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 先处理绚丽之门
            -- local door = TheSim:FindFirstEntityWithTag("multiplayer_portal")
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 删除多余inst TUNING.FUNNY_CAT_RESOURCES
            local function check_is_special_inst(tempInst)
                if tempInst  == TheWorld then
                    return true
                end
                local text = tostring(tempInst)
                local start_index = string.find(text, " - ") + 3 -- 找到" - "后的起始位置并偏移3位（跳过空格和连字符）
                local index = string.sub(text, start_index) -- 从该位置到字符串结束
                -- print("check index:["..index.."]")
                if rawget(_G,index) then
                    return true
                end
                return false
            end
            local new_spawn_data = {}
            for k, tempInst in pairs(Ents) do
                if tempInst.prefab and tempInst.Transform and not check_is_special_inst(tempInst) then
                    if TUNING.FUNNY_CAT_RESOURCES[tempInst.prefab] == nil then
                        -- tempInst:Remove()
                    else
                        table.insert(new_spawn_data, {prefab = tempInst.prefab,pt = Vector3(tempInst.Transform:GetWorldPosition())})
                        tempInst:Remove()
                    end
                    if tempInst.brainfn then
                        tempInst:Remove()
                    end
                end
            end
            for k, temp_data in pairs(new_spawn_data) do
                SpawnPrefab("fc_"..temp_data.prefab).Transform:SetPosition(temp_data.pt.x,0,temp_data.pt.z)
            end

        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- debug 测试
            print("+++++++++ main land task end  +++++++++++++++++")
            local end_time = os.clock()
            print(string.format(" +++ main land create task cost time  : %.4f", end_time - start_time) )
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        -- end)
    end)

end)