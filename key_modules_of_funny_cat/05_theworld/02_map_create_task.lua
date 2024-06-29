------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    if TUNING.FUNNY_CAT_DEBUGGING_MODE then
        return
    end
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
        --- 初始化数据
            local map_width,map_height = TheWorld.Map:GetSize()
            local all_map_tile_data = {}
            for tile_x = 1, map_width, 1 do
                for tile_y = 1, map_height, 1 do
                    all_map_tile_data[tile_x] = all_map_tile_data[tile_x] or {}
                    all_map_tile_data[tile_x][tile_y] = nil
                end
            end

            local map_room_inst_mid_point_delta = 20*4 --- map_room_inst 的偏移参数。
            local main_land_size = 200 -- 或者可以是200，根据需要修改
            local map_room_inst_num_per_side = main_land_size/20  -- map_room_inst 的数量
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 获取地图中间区域的 相关数据
            -- 目标区域尺寸
            local targetSize = main_land_size 
            -- 计算起始坐标，确保提取的区域位于地图中央
            local tile_start_X = math.floor((map_width - targetSize) / 2)
            local tile_start_Y = math.floor((map_height - targetSize) / 2)
            -- 输出起始坐标
            print("起始坐标（X, Y）:(", tile_start_X, ", ", tile_start_Y, ")")
            
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- map_room_inst 的起始坐标
            local function GetWorldPointCenterByTileXY(x,y,map_width,map_height)
                if map_width == nil or map_height == nil then
                    map_width,map_height = TheWorld.Map:GetSize()
                end
                local ret_x = x - map_width/2
                local ret_z = y - map_height/2
                -- return Vector3(ret_x*TILE_SCALE,0,ret_z*TILE_SCALE)
                return ret_x*TILE_SCALE,0,ret_z*TILE_SCALE
            end
            local temp_x,temp_y,temp_z = GetWorldPointCenterByTileXY(tile_start_X,tile_start_Y)
            
            local map_room_start_x = temp_x + 36
            local map_room_start_y = temp_y
            local map_room_start_z = temp_z + 36
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 创建 map_room_inst
            for i = 1, map_room_inst_num_per_side, 1 do
                for j = 1, map_room_inst_num_per_side, 1 do
                    local current_mid_x = map_room_start_x + (i-1)*map_room_inst_mid_point_delta
                    local current_mid_y = 0
                    local current_mid_z = map_room_start_z + (j-1)*map_room_inst_mid_point_delta
                    SpawnPrefab("map_room_desert"):PushEvent("Set",{
                        pt = Vector3(current_mid_x,current_mid_y,current_mid_z),
                        all_map_tiles = all_map_tile_data,
                    })
                end
            end
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        -- 清除外围空间
            for temp_tile_x = 1, map_width, 1 do
                for temp_tile_y = 1, map_height, 1 do
                    if all_map_tile_data[temp_tile_x][temp_tile_y] == nil then
                        --- 删除该地块
                        TheWorld.Map:SetTile(temp_tile_x,temp_tile_y,1)
                        -- TheWorld.Map:SetTile(temp_tile_x,temp_tile_y,201)
                    else
                        local data = all_map_tile_data[temp_tile_x][temp_tile_y]
                        local tile_type = data.tile_type
                        TheWorld.Map:SetTile(temp_tile_x,temp_tile_y,tile_type)
                    end
                end
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