------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    指示器（ indicator ） 的回调 并生成上面的 物品

            ["ROCKY"] = 3,          --- 矿区
            ["DIRT"] = 4,           --- 沙漠
            ["SAVANNA"] = 6,        --- 绿草原
            ["GRASS"] = 5,          --- 黄草地
            ["FOREST"] = 7,         --- 森林
            ["MARSH"] = 8,          --- 沼泽
            ["MUD"] = 17,           --- 泥泞
            ["DECIDUOUS"] = 36,     --- 落叶林
            ["METEOR"] = 43,        --- 月岛地形
            -- ["OCEAN"] = nil,        --- 海洋

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


AddPrefabPostInit("world",function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:ListenForEvent("map_room_indicator_inited",function(_,Indicator)
        inst:DoStaticTaskInTime(math.random(1,10),function()
            if Indicator:GetType() ~= "FOREST" then
                return
            end
            print("info room type",Indicator:GetType())

            ------------------------------------------------------------------------------------------------------------------------------------
            --- 地图彩蛋
                -- while true do
                --     local temp_table_for_random = {}
                --     for index, v in pairs(TUNING.FUNNY_CAT_MAP_EGGS_FN) do
                --         table.insert(temp_table_for_random, index)
                --     end
                --     local random_index = temp_table_for_random[math.random(#temp_table_for_random)]
                --     local ret_inst = TUNING.FUNNY_CAT_MAP_EGGS_FN[random_index or "skeleton"](Indicator) or {}
                --     if #ret_inst > 0 then
                --         print("info++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                --         for k, v in pairs(ret_inst) do
                --             print("info",k,v)
                --         end
                --         print("info++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                --         break
                --     end
                -- end

                local ret_inst = TUNING.FUNNY_CAT_MAP_EGGS_FN["buildings"](Indicator) or {}
                -- print("info++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                -- for k, v in pairs(ret_inst) do
                --     print("info",k,v)
                -- end
                -- print("info++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
            ------------------------------------------------------------------------------------------------------------------------------------
            ---
                local cmd_table = {
                    ["evergreen"] = math.random(20,30),
                    ["evergreen_sparse"] = math.random(5,10),
                    ["twiggytree"] = math.random(5,10),
                    ["sapling"] = math.random(5,10),
                    ["pond"] = math.random(0,1),
                    ["berrybush_juicy"] = math.random(0,4),
                    ["pighouse"] = math.random(0,3),
                }
                if math.random(1000)/1000 < 0.3 then
                    cmd_table["livingtree"] = 1
                end
                for prefab, num in pairs(cmd_table) do
                    for i = 1, num, 1 do
                        local tempInst = SpawnPrefab("fc_"..prefab)
                        if not Indicator:PlaceInRandom(tempInst) then
                            tempInst:Remove()
                        end
                    end
                end
            ------------------------------------------------------------------------------------------------------------------------------------
        end)
    end)

end)