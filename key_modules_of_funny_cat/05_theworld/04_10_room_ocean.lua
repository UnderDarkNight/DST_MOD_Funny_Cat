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
            if Indicator:GetType() ~= "OCEAN" then
                return
            end
            print("info room type",Indicator:GetType())
            ------------------------------------------------------------------------------------------------------------------------------------
            --- 地图彩蛋
                local ret_inst = TUNING.FUNNY_CAT_MAP_EGGS_FN["rock_ice"](Indicator) or {}
            ------------------------------------------------------------------------------------------------------------------------------------
            ---
                local cmd_table = {
                    ["seastack"] = math.random(20,30),
                    ["saltstack"] = math.random(5,10),
                    ["waterplant"] = math.random(5,10),
                    ["messagebottle"] = math.random(5,10),
                    ["bullkelp_plant"] = math.random(5,10),
                    ["wobster_den"] = math.random(5,10),
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
            --- 海鱼
                local all_fish_prefab = {}
                local all_fish_data = require("prefabs/oceanfishdef").fish
                for origin_fish_name, fish_def in pairs(all_fish_data) do
                    table.insert(all_fish_prefab, "fc_"..origin_fish_name.."_inv")
                end
                local fish_num = math.random(10,20)
                for i = 1, fish_num, 1 do
                    local fish_prefab = all_fish_prefab[math.random(1,#all_fish_prefab)]
                    local fish_inst = SpawnPrefab(fish_prefab)
                    if not Indicator:PlaceInRandom(fish_inst) then
                        fish_inst:Remove()
                    end
                end
            ------------------------------------------------------------------------------------------------------------------------------------
        end)
    end)

end)