------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    -- if TUNING.FUNNY_CAT_DEBUGGING_MODE then
    --     return
    -- end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

            local target_tiles = {
                -- 7, -- 坟地
                -- 6, -- 池塘区
                -- 1, --- 不能使用
                -- 2, -- 卵石地皮   GetWorldTileMap().ROAD
                3, -- 矿区 GetWorldTileMap().ROCKY GetTile:3
                4, -- 沙漠 GetWorldTileMap().DIRT  GetTile:4
                5, -- 草原 GetWorldTileMap().SAVANNA  GetTile:5
                6, -- 草地 GetWorldTileMap().GRASS GetTile:6
                7, -- 森林 GetWorldTileMap().FOREST GetTile:7
                8, -- 沼泽 GetWorldTileMap().MARSH GetTile:8
                -- 9,   -- 木地板 GetTile:10
                -- 10,  -- 地毯  GetTile:11
                -- 11,  --- 棋盘 GetTile:12
                -- 12,  --鸟粪地皮 GetTile:13
                -- 13,  --真菌地皮 GetTile:14
                -- 14,  --未知偏蓝草地（挖不起来）
                -- 15,  --未知偏蓝草地（挖不起来）
                -- 16,  --未知图形地毯（挖不起来）
                17,     -- 泥泞 GetWorldTileMap().MUD  GetTile:17
                -- 18,  -- 不能使用
                -- 19,  -- 不能使用
                -- 20,  -- 不能使用
                -- 21,  -- 洞穴岩石地皮  GetWorldTileMap().TILES_GLOW   GetTile:16
                -- 22,  -- 泥泞地皮 GetTile:17
                -- 23,  -- 未知沼泽地皮 GetTile:35
                -- 24,  -- 不能使用
                -- 25， -- 远古地面 GetTile:18  GetWorldTileMap().FUNGUSGREEN 
                -- 26,  -- 不能使用
                -- 27,  -- 远古瓷砖 GetTile:20
                -- 28,  -- 不能使用
                -- 29,  -- 远古砖雕 GetTile:22
                -- 30,  -- 不能使用
                -- 31,  -- 未知岩石地皮（挖不起来） GetTile:37
                32,  -- 未知粉色地皮（挖不起来） GetTile:36   暴食模式地皮

                34, --  meteor 月岛地皮在创建的时候使用的id。并不是GetTile得到的43

            }

]]--
        local TILE_TYPE_INDEX = {
            ["ROCKY"] = 3,          --- 矿区
            ["DIRT"] = 4,           --- 沙漠
            ["SAVANNA"] = 5,        --- 绿草原
            ["GRASS"] = 6,          --- 黄草地
            ["FOREST"] = 7,         --- 森林
            ["MARSH"] = 8,          --- 沼泽
            ["MUD"] = 17,           --- 泥泞
            ["DECIDUOUS"] = 36,     --- 落叶林
            ["METEOR"] = 43,        --- 落叶林
            -- ["OCEAN"] = nil,        --- 海洋
        }
        local TILE_TYPE = {}
        for k, v in pairs(TILE_TYPE_INDEX) do
            TILE_TYPE[v] = k
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
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 只运行一次。
            if inst.components.funny_cat_world_map_tile_sys:Get("MapInited") then
                print("+++++++++ main land task already done +++++++++++++++++")
                return
            end
            inst.components.funny_cat_world_map_tile_sys:Set("MapInited",true)
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- debug 测试
            local start_time = os.clock()
            print("+++++++++ main land task start +++++++++++++++++")

        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 一些参数
            local ROOM_TILE_SIZE = 20
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 先处理修正绚丽之门
            local door = TheSim:FindFirstEntityWithTag("multiplayer_portal")
            local x,y,z = door.Transform:GetWorldPosition()
            x = x - 2
            z = z - 2
            x,y,z = TheWorld.Map:GetTileCenterPoint(x,y,z)
            x = x + 2
            z = z + 2
            door.Transform:SetPosition(x,y,z)
            local main_land_x,main_land_y,main_land_z = x,y,z
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- 根据地图尺寸布局 指示器 大尺寸 300X300 tile .   小尺寸 140X140 tile .
            local MAP_SIZE = 300
            if TUNING.FUNNY_CAT_CONFIG.MAP_SIZE_BIG then
                MAP_SIZE = 300
            else
                MAP_SIZE = 140
            end

            local ROOM_SIDE_NUM = MAP_SIZE/20

            local SIDE_LEGNTH = (ROOM_SIDE_NUM-1)*ROOM_TILE_SIZE*TILE_SCALE

            local start_room_x = main_land_x - math.floor(ROOM_SIDE_NUM/2)*ROOM_TILE_SIZE * TILE_SCALE
            local start_room_y = 0
            local start_room_z = main_land_z - math.floor(ROOM_SIDE_NUM/2)*ROOM_TILE_SIZE * TILE_SCALE
            local delta_by_room = ROOM_TILE_SIZE * TILE_SCALE


            local tag_num = 1
            for temp_x = start_room_x , start_room_x + SIDE_LEGNTH ,delta_by_room do
                for temp_z = start_room_z , start_room_z + SIDE_LEGNTH ,delta_by_room do
                    local current_tile = TheWorld.Map:GetTileAtPoint(temp_x,0,temp_z)
                    local tile_tag = IsOceanTile(current_tile) and "OCEAN" or TILE_TYPE[current_tile] or "tag_"..tostring(tag_num)
                    -- local tile_tag = "tag_"..tostring(tag_num)
                    tag_num = tag_num + 1
                    SpawnPrefab("map_room_indicator"):PushEvent("Set",{
                        pt = Vector3(temp_x,0,temp_z),
                        tag = tile_tag,
                    })
                end
            end
                
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        --- debug 测试
            
            print("+++++++++ main land task end  +++++++++++++++++")
            local end_time = os.clock()
            print(string.format(" +++ main land create task cost time  : %.4f", end_time - start_time) )
        --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    end)

end)