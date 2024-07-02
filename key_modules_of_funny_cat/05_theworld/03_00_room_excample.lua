------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    指示器（ indicator ） 的回调 并生成上面的 物品

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


            完全正常的树( livingtree )
            树枝( sapling )
            池塘( pond )
            多支树（ twiggytree ）
            多汁浆果 berrybush_juicy
            常青树（ evergreen ）
            常青树（ evergreen_sparse）

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


AddPrefabPostInit("world",function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:ListenForEvent("map_room_indicator_inited",function(_,Indicator)
        if Indicator:GetType() ~= "FOREST" then
            return
        end
        ------------------------------------------------------------------------------------------------------------------------------------
        ---
            local cmd_table = {
                ["evergreen"] = math.random(20,30),
                ["evergreen_sparse"] = math.random(5,10),
                ["twiggytree"] = math.random(5,10),
                ["sapling"] = math.random(5,10),
                ["pond"] = math.random(0,1),
                ["berrybush_juicy"] = math.random(0,3),
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