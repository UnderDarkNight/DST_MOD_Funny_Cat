------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    地图彩蛋

    function Map:IsLandTileAtPoint(x, y, z)
    local tile = self:GetTileAtPoint(x, y, z)
    return TileGroupManager:IsLandTile(tile)
    end

    function Map:IsOceanTileAtPoint(x, y, z)
        local tile = self:GetTileAtPoint(x, y, z)
        return TileGroupManager:IsOceanTile(tile)
    end

            ["ROCKY"] = true,          --- 矿区
            ["DIRT"] = true,           --- 沙漠
            ["SAVANNA"] = true,        --- 绿草原
            ["GRASS"] = true,          --- 黄草地
            ["FOREST"] = true,         --- 森林
            ["MARSH"] = true,          --- 沼泽
            ["MUD"] = true,           --- 泥泞
            ["DECIDUOUS"] = true,     --- 落叶林
            ["METEOR"] = true,        --- 月岛地形
            -- ["OCEAN"] = true,        --- 海洋

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TUNING.FUNNY_CAT_MAP_EGGS_FN = {}
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 基础API
    local function GetRandomWithNonRepeatable(_table)
        if #_table == 0 then
            return nil -- 或者返回一个默认值，如：return {x=0, y=0}
        end    
        local ret_num = math.random(#_table)
        local ret = _table[ret_num]
        table.remove(_table, ret_num)
        return ret
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 骷髅
    TUNING.FUNNY_CAT_MAP_EGGS_FN["skeleton"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  skeleton")
        
        local function GetSurroundPoints(x,y,z)
            local ret_points = {}
            local temp_points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                target = Vector3(x,y,z),
                range = 3,
                num = 10,
            })
            for i, v in ipairs(temp_points) do
                table.insert(ret_points,v)
            end
            temp_points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                target = Vector3(x,y,z),
                range = 4,
                num = 20,
            })
            for i, v in ipairs(temp_points) do
                table.insert(ret_points,v)
            end
            temp_points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                target = Vector3(x,y,z),
                range = 5,
                num = 10,
            })
            for i, v in ipairs(temp_points) do
                table.insert(ret_points,v)
            end
            return ret_points
        end
        --- 提取其中一个坐标，做不可重复处理
        local function GetRandom(points_table)
            if #points_table == 0 then
                return nil -- 或者返回一个默认值，如：return {x=0, y=0}
            end    
            local ret_num = math.random(#points_table)
            local ret_point = points_table[ret_num]
            table.remove(points_table, ret_num)
            return ret_point
        end


        local commands = {
            ------------------------------------------------------------------------------------------------------------------------
            --- 烹饪锅、冰箱
                [1] = function(Indicator)
                    -------------------------------------------------------
                    --
                        local ret_inst = {}
                    -------------------------------------------------------
                    ---
                        local mid_pt = Indicator:GetRandomPointInThisRoom()
                        -- SpawnPrefab("fc_skeleton").Transform:SetPosition(mid_pt.x,mid_pt.y,mid_pt.z)
                        SpawnPrefab("fc_skeleton"):PushEvent("SetPositionByCallback",{pt = mid_pt,callback = ret_inst})
                        local surround_pts = GetSurroundPoints(mid_pt.x,mid_pt.y,mid_pt.z)
                        local temp_pt = nil
                    -------------------------------------------------------
                    --- 锅
                        temp_pt = GetRandom(surround_pts)
                        if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                            -- SpawnPrefab("fc_cookpot").Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                            SpawnPrefab("fc_cookpot"):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})                        
                        end
                        if math.random() < 0.5 then
                            temp_pt = GetRandom(surround_pts)
                            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                                -- SpawnPrefab("fc_cookpot").Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                                SpawnPrefab("fc_icebox"):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})                        
                            end
                        end
                    -------------------------------------------------------
                    --- 食物
                        local foods = deepcopy(TUNING.FUNNY_CAT_FOOD_RESOURCES)
                        local ret_foods = {}
                        for i = 1, 10, 1 do
                            table.insert(ret_foods,GetRandom(foods))
                        end
                        for k, prefab in pairs(ret_foods) do
                            temp_pt = GetRandom(surround_pts)
                            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                                -- SpawnPrefab("fc_"..prefab).Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                                SpawnPrefab("fc_"..prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                            end
                        end
                    -------------------------------------------------------
                    ---
                        return ret_inst
                    -------------------------------------------------------
                end,
            ------------------------------------------------------------------------------------------------------------------------
            --- 箱子+道具
                [2] = function(Indicator)
                    -------------------------------------------------------
                    --
                        local ret_inst = {}
                    -------------------------------------------------------
                    ---
                        local mid_pt = Indicator:GetRandomPointInThisRoom()
                        -- SpawnPrefab("fc_skeleton").Transform:SetPosition(mid_pt.x,mid_pt.y,mid_pt.z)
                        SpawnPrefab("fc_skeleton"):PushEvent("SetPositionByCallback",{pt = mid_pt,callback = ret_inst})
                        local surround_pts = GetSurroundPoints(mid_pt.x,mid_pt.y,mid_pt.z)
                        local temp_pt = nil
                    -------------------------------------------------------
                    --- 箱子
                        temp_pt = GetRandom(surround_pts)
                        local box_origin_prefab = {"treasurechest","terrariumchest","sunkenchest"}
                        local ret_box = "fc_"..box_origin_prefab[math.random(#box_origin_prefab)]
                        if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                            -- SpawnPrefab("fc_cookpot").Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                            SpawnPrefab(ret_box):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                        end
                    -------------------------------------------------------
                    --- 物品
                        local origin_items = deepcopy(TUNING.FUNNY_CAT_ITEM_RESOURCES)
                        local ret_items = {}
                        local item_max_num = math.random(3,8)
                        for i = 1, item_max_num, 1 do
                            table.insert(ret_items,GetRandom(origin_items))
                        end
                        for k, prefab in pairs(ret_items) do
                            temp_pt = GetRandom(surround_pts)
                            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                                -- SpawnPrefab("fc_"..prefab).Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                                SpawnPrefab("fc_"..prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                            end
                        end
                    -------------------------------------------------------
                    ---
                        return ret_inst
                    -------------------------------------------------------
                end,
            ------------------------------------------------------------------------------------------------------------------------
            --- 火坑+道具
                [3] = function(Indicator)
                    -------------------------------------------------------
                    --
                        local ret_inst = {}
                    -------------------------------------------------------
                    ---
                        local mid_pt = Indicator:GetRandomPointInThisRoom()
                        -- SpawnPrefab("fc_skeleton").Transform:SetPosition(mid_pt.x,mid_pt.y,mid_pt.z)
                        SpawnPrefab("fc_skeleton"):PushEvent("SetPositionByCallback",{pt = mid_pt,callback = ret_inst})
                        local surround_pts = GetSurroundPoints(mid_pt.x,mid_pt.y,mid_pt.z)
                        local temp_pt = nil
                    -------------------------------------------------------
                    --- 火坑
                        temp_pt = GetRandom(surround_pts)
                        local box_origin_prefab = {"campfire","firepit","coldfire","coldfirepit","tent","siestahut"}
                        local ret_box = "fc_"..box_origin_prefab[math.random(#box_origin_prefab)]
                        if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                            -- SpawnPrefab("fc_cookpot").Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                            SpawnPrefab(ret_box):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                        end
                    -------------------------------------------------------
                    --- 物品
                        local origin_items = deepcopy(TUNING.FUNNY_CAT_ITEM_RESOURCES)
                        local ret_items = {}
                        local item_max_num = math.random(3,8)
                        for i = 1, item_max_num, 1 do
                            table.insert(ret_items,GetRandom(origin_items))
                        end
                        for k, prefab in pairs(ret_items) do
                            temp_pt = GetRandom(surround_pts)
                            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                                -- SpawnPrefab("fc_"..prefab).Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                                SpawnPrefab("fc_"..prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                            end
                        end
                    -------------------------------------------------------
                    ---
                        return ret_inst
                    -------------------------------------------------------
                end,
            ------------------------------------------------------------------------------------------------------------------------
            --- 雕像+道具
                [4] = function(Indicator)
                    -------------------------------------------------------
                    --
                        local ret_inst = {}
                    -------------------------------------------------------
                    ---
                        local mid_pt = Indicator:GetRandomPointInThisRoom()
                        -- SpawnPrefab("fc_skeleton").Transform:SetPosition(mid_pt.x,mid_pt.y,mid_pt.z)
                        SpawnPrefab("fc_skeleton"):PushEvent("SetPositionByCallback",{pt = mid_pt,callback = ret_inst})
                        local surround_pts = GetSurroundPoints(mid_pt.x,mid_pt.y,mid_pt.z)
                        local temp_pt = nil
                    -------------------------------------------------------
                    --- 火坑
                        temp_pt = GetRandom(surround_pts)
                        local box_origin_prefab = {"sculptingtable"}
                        local ret_box = "fc_"..box_origin_prefab[math.random(#box_origin_prefab)]
                        if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                            -- SpawnPrefab("fc_cookpot").Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                            SpawnPrefab(ret_box):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                        end
                    -------------------------------------------------------
                    --- 物品
                        local origin_items = deepcopy(TUNING.FUNNY_CAT_CHESSPIECES_RESOURCES)
                        local ret_items = {}
                        local item_max_num = math.random(2,4)
                        for i = 1, item_max_num, 1 do
                            table.insert(ret_items,GetRandom(origin_items))
                        end
                        for k, prefab in pairs(ret_items) do
                            temp_pt = GetRandom(surround_pts)
                            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                                -- SpawnPrefab("fc_"..prefab).Transform:SetPosition(temp_pt.x,temp_pt.y,temp_pt.z)
                                SpawnPrefab("fc_"..prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
                            end
                        end
                    -------------------------------------------------------
                    ---
                        return ret_inst
                    -------------------------------------------------------
                end,
            ------------------------------------------------------------------------------------------------------------------------
        }


        local ret_fn = commands[math.random(#commands)]
        if ret_fn then
            return ret_fn(Indicator)
        else
            print("error : random cmd fn not found")
            return {}
        end

    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 猪屋
    TUNING.FUNNY_CAT_MAP_EGGS_FN["pighouse"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  pighouse")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()        
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = 8,
            num = 6,
        })
        local ret_inst = {}
        local head_stick = SpawnPrefab("fc_mermhead")
        head_stick:PushEvent("SetPositionByCallback",{pt = mid_pt,callback = ret_inst})
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab("fc_pighouse"):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 兔子窝
    TUNING.FUNNY_CAT_MAP_EGGS_FN["rabbithouse"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  rabbithouse")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()

        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = 8,
            num = 6,
        })
        local ret_inst = {}
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab("fc_rabbithouse"):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 鱼人屋
    TUNING.FUNNY_CAT_MAP_EGGS_FN["mermhouse"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  mermhouse")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = 8,
            num = 6,
        })
        local ret_inst = {}
        local head_stick = SpawnPrefab("fc_pighead")
        head_stick:PushEvent("SetPositionByCallback",{pt = mid_pt,callback = ret_inst})
        local house_type = {"mermhouse","mermhouse_crafted","mermwatchtower"}
        local ret_prefab = "fc_"..house_type[math.random(#house_type)]
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 浆果
    TUNING.FUNNY_CAT_MAP_EGGS_FN["berrybush"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  berrybush")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = math.random(3,6),
            num = math.random(6,8),
        })
        local ret_inst = {}
        local ret_prefab = math.random()<0.5 and "fc_berrybush" or "fc_berrybush2"
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 胡萝卜
    TUNING.FUNNY_CAT_MAP_EGGS_FN["carrot_planted"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  carrot_planted")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = math.random(3,6),
            num = math.random(6,8),
        })
        local ret_inst = {}
        local ret_prefab = "fc_carrot_planted"
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 曼德拉
    TUNING.FUNNY_CAT_MAP_EGGS_FN["mandrake_planted"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  mandrake_planted")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = math.random(3,6),
            num = math.random(6,8),
        })
        local ret_inst = {}
        local ret_prefab = "fc_mandrake_planted"
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 蘑菇
    TUNING.FUNNY_CAT_MAP_EGGS_FN["mushroom"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  mushroom")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = math.random(3,6),
            num = math.random(8,10),
        })
        local ret_inst = {}
        local mushroom_type = {"red_mushroom","blue_mushroom","green_mushroom"}
        local ret_prefab = "fc_"..mushroom_type[math.random(1,#mushroom_type)]
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 花
    TUNING.FUNNY_CAT_MAP_EGGS_FN["flower"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  flower")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = math.random(3,6),
            num = math.random(8,10),
        })
        local ret_inst = {}
        local plant_type = {"flower","flower_rose","flower_evil"}
        local ret_prefab = "fc_"..plant_type[math.random(1,#plant_type)]
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 大理石树
    TUNING.FUNNY_CAT_MAP_EGGS_FN["marbletree"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  marbletree")
        
        local mid_pt = Indicator:GetRandomPointInThisRoom()
        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
            pt = mid_pt,
            range = math.random(3,6),
            num = math.random(8,10),
        })
        local ret_inst = {}
        local plant_type = {"marbletree","marbleshrub"}
        local ret_prefab = "fc_"..plant_type[math.random(1,#plant_type)]
        for k, temp_pt in pairs(points) do
            if temp_pt and TheWorld.Map:IsLandTileAtPoint(temp_pt.x,temp_pt.y,temp_pt.z) then
                SpawnPrefab(ret_prefab):PushEvent("SetPositionByCallback",{pt = temp_pt,callback = ret_inst})
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 建筑群
    TUNING.FUNNY_CAT_MAP_EGGS_FN["buildings"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  buildings")
        
        local ret_inst = {}
        local buildings = deepcopy(TUNING.FUNNY_CAT_BUILDING_RESOURCES)
        local buildings_num = math.random(3,8)
        ---- 从buildings中随机选择buildings_num个建筑
        local ret_buildings = {}
        for i = 1,buildings_num do
            table.insert(ret_buildings,GetRandomWithNonRepeatable(buildings))
        end
        for k, temp_prefab in pairs(ret_buildings) do
            local temp_inst = SpawnPrefab("fc_"..temp_prefab)
            if Indicator:PlaceInRandom(temp_inst) then
                table.insert(ret_inst,temp_inst)
            else
                temp_inst:Remove()
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 随机物品
    TUNING.FUNNY_CAT_MAP_EGGS_FN["random_items"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  random_items")
        
        local ret_inst = {}
        local buildings = deepcopy(TUNING.FUNNY_CAT_ITEM_RESOURCES)
        local buildings_num = math.random(3,8)
        ---- 从buildings中随机选择buildings_num个建筑
        local ret_buildings = {}
        for i = 1,buildings_num do
            table.insert(ret_buildings,GetRandomWithNonRepeatable(buildings))
        end
        for k, temp_prefab in pairs(ret_buildings) do
            local temp_inst = SpawnPrefab("fc_"..temp_prefab)
            if Indicator:PlaceInRandom(temp_inst) then
                table.insert(ret_inst,temp_inst)
            else
                temp_inst:Remove()
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 蜘蛛群
    TUNING.FUNNY_CAT_MAP_EGGS_FN["spiderden"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  spiderden")

        if Indicator:GetType() == "OCEAN" or math.random() < 0.5 then
            return {}
        end
        local ret_inst = {}
        local num = math.random(10,20)
        for i = 1, num, 1 do
            local tempInst = SpawnPrefab("fc_spiderden")
            if Indicator:PlaceInRandom(tempInst) then
                table.insert(ret_inst,tempInst)
            else
                tempInst:Remove()
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 池塘
    TUNING.FUNNY_CAT_MAP_EGGS_FN["ponds"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  ponds")

        local perfect_tags = {
            ["SAVANNA"] = true,
            ["FOREST"] = true,
            ["MARSH"] = true,
            ["MUD"] = true,
            ["DECIDUOUS"] = true,
        }
        if not perfect_tags[Indicator:GetType()] then
            return {}
        end
        local ponds = {"pond","pond_mos","pond_cave"}
        local ret_prefab = "fc_"..ponds[math.random(1,#ponds)]
        local ret_inst = {}
        local ponds_num = math.random(10,20)
        for i = 1, ponds_num, 1 do
            local tempInst = SpawnPrefab(ret_prefab)
            if Indicator:PlaceInRandom(tempInst) then
                table.insert(ret_inst,tempInst)                
            else
                tempInst:Remove()
            end
        end
        return ret_inst        
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 墓地
    TUNING.FUNNY_CAT_MAP_EGGS_FN["graveyard"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  graveyard")

        local perfect_tags = {
            ["SAVANNA"] = true,        --- 绿草原
            ["FOREST"] = true,         --- 森林
        }
        if not perfect_tags[Indicator:GetType()] then
            return {}
        end
        local origin_prefabs = {"gravestone","mound"}
        local ret_inst = {}
        local max_num = math.random(10,20)
        for i = 1, max_num, 1 do
            local ret_prefab = "fc_"..origin_prefabs[math.random(1,#origin_prefabs)]
            local tempInst = SpawnPrefab(ret_prefab)
            if Indicator:PlaceInRandom(tempInst) then
                table.insert(ret_inst,tempInst)                
            else
                tempInst:Remove()
            end
        end
        return ret_inst        
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 蜜蜂群
    TUNING.FUNNY_CAT_MAP_EGGS_FN["beehive"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  beehive")

        local perfect_tags = {
            ["SAVANNA"] = true,        --- 绿草原
            ["FOREST"] = true,         --- 森林
        }
        if not perfect_tags[Indicator:GetType()] then
            return {}
        end
        local origin_prefabs = {"beehive","wasphive"}
        local ret_inst = {}
        local max_num = math.random(10,20)
        for i = 1, max_num, 1 do
            local ret_prefab = "fc_"..origin_prefabs[math.random(1,#origin_prefabs)]
            local tempInst = SpawnPrefab(ret_prefab)
            if Indicator:PlaceInRandom(tempInst) then
                table.insert(ret_inst,tempInst)                
            else
                tempInst:Remove()
            end
        end
        return ret_inst        
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 冰川 rock_ice
    TUNING.FUNNY_CAT_MAP_EGGS_FN["rock_ice"] = function(Indicator)
        print("+++ FUNNY_CAT_MAP_EGGS_FN  rock_ice")
        local ret_inst = {}
        local max_num = math.random(10,20)
        for i = 1, max_num, 1 do
            local ret_prefab = "fc_rock_ice"
            local tempInst = SpawnPrefab(ret_prefab)
            if Indicator:PlaceInRandom(tempInst) then
                table.insert(ret_inst,tempInst)                
            else
                tempInst:Remove()
            end
        end
        return ret_inst
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------