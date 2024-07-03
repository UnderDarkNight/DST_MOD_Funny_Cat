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
            if Indicator:GetType() ~= "DECIDUOUS" then
                return
            end
            print("info room type",Indicator:GetType())

            ------------------------------------------------------------------------------------------------------------------------------------
            --- 地图彩蛋
                while true do
                    local temp_table_for_random = {}
                    for index, v in pairs(TUNING.FUNNY_CAT_MAP_EGGS_FN) do
                        table.insert(temp_table_for_random, index)
                    end
                    local random_index = temp_table_for_random[math.random(#temp_table_for_random)]
                    local ret_inst = TUNING.FUNNY_CAT_MAP_EGGS_FN[random_index or "skeleton"](Indicator) or {}
                    if #ret_inst > 0 then
                        -- print("info++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                        -- for k, v in pairs(ret_inst) do
                        --     print("info",k,v)
                        -- end
                        -- print("info++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                        break
                    end
                end
            ------------------------------------------------------------------------------------------------------------------------------------
            ---
                local cmd_table = {
                    ["deciduoustree"] = math.random(20,50),
                    ["catcoonden"] = math.random(5,10),
                    ["statueglommer"] = math.random(0,3),
                    ["pighouse"] = math.random(6,15),
                    ["red_mushroom"] = math.random(0,5),
                    ["blue_mushroom"] = math.random(0,5),
                    ["green_mushroom"] = math.random(0,5),
                    ["flower"] = math.random(0,5),
                    ["pond"] = math.random(0,1),
                    ["mermhead"] = math.random(0,3),
                    ["berrybush"] = math.random(0,3),
                    ["berrybush2"] = math.random(0,3),
                    ["berrybush_juicy"] = math.random(0,3),
                    ["gravestone"] = math.random(0,3),

                }
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