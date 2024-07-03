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
            if Indicator:GetType() ~= "ROCKY" then
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
                    ["rock1"] = math.random(5,20),
                    ["rock2"] = math.random(5,20),
                    ["rock_flintless"] = math.random(5,20),
                    ["tallbirdnest"] = math.random(0,8),
                    ["spiderden"] = math.random(0,3),
                }
                if math.random() > 0.2 then
                    cmd_table["rock_ice"] = math.random(10,20)
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