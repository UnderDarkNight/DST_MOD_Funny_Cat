

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst:AddTag("map_room")
    inst:AddTag("funny_cat_map_room")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    function inst:GetTileXYAtPoint(x,y,z)
        return TheWorld.Map:GetTileXYAtPoint(x,y,z)
    end
    function inst:GetTileCenterPoint(x,y,z)
        return TheWorld.Map:GetTileCenterPoint(x,y,z)
    end

    function inst:SetTile(tile_x,tile_y,tile_type)
        TheWorld.Map:SetTile(tile_x,tile_y, tile_type)    ---- 生成指定地皮
    end

    function inst:GetWorldPointCenterByTileXY(x,y,map_width,map_height)
        if map_width == nil or map_height == nil then
            map_width,map_height = TheWorld.Map:GetSize()
        end
        local ret_x = x - map_width/2
        local ret_z = y - map_height/2
        -- return Vector3(ret_x*TILE_SCALE,0,ret_z*TILE_SCALE)
        return ret_x*TILE_SCALE,0,ret_z*TILE_SCALE
    end

    -------------------------------------------------------------------------------------------
    --- 储存数据
        inst.TileData = {}
        inst.Mid_World_Points = {}
        function inst:SaveTileData(tile_x,tile_y)
            table.insert(inst.TileData,{x=tile_x,y=tile_y})
            local world_point = Vector3(self:GetWorldPointCenterByTileXY(tile_x,tile_y))
            table.insert(inst.Mid_World_Points,world_point)
        end
    -------------------------------------------------------------------------------------------


    inst:ListenForEvent("Set",function(inst,_table)
        --- 20x20区域。
        -- _table = _table or {
        --     pt = pt,
        --     all_map_tiles = {},  --- 所有地块的指向。需要提前初始化
        --     debug_tag = "",
        -- }
        ------------------------------------------------------------------------------------------------------------------------------------
        --- 放置尺寸
            local pt = _table.pt
            inst.Transform:SetPosition(pt.x, pt.y, pt.z)
            local star_x = pt.x - 38
            local start_z = pt.z - 38
            local end_x = pt.x + 38
            local end_z = pt.z + 38

            local map_width,map_height = TheWorld.Map:GetSize()

            local start_tile_x , start_tile_y = inst:GetTileXYAtPoint(star_x,0,start_z)
            local end_tile_x , end_tile_y = inst:GetTileXYAtPoint(end_x,0,end_z)

            if start_tile_x < 0 or end_tile_x > map_width or start_tile_y < 0 or end_tile_y > map_height then
                return
            end
        ------------------------------------------------------------------------------------------------------------------------------------
        ---
            local all_map_tiles = _table.all_map_tiles

            local tile_type = 30   -- 地皮
            local void_tile_type = 1   -- 洞穴虚空
            local room_tag = "desert"  -- 沙漠tag
            

            for current_tile_x = start_tile_x, end_tile_x, 1 do
                for current_tile_y = start_tile_y, end_tile_y, 1 do
                    -- inst:SetTile(current_tile_x,current_tile_y,tile_type)
                    TheWorld.components.funny_cat_world_map_tile_sys:Add_Tag_To_Tile_XY(current_tile_x,current_tile_y,room_tag)
                    if type(_table.debug_tag) == "string" then
                        TheWorld.components.funny_cat_world_map_tile_sys:Add_Tag_To_Tile_XY(current_tile_x,current_tile_y,_table.debug_tag)
                    end
                    pcall(function()                        
                        all_map_tiles[current_tile_x][current_tile_y] = {
                            belong = inst,
                            tag = room_tag,
                            tile_type = tile_type,
                        }
                    end)
                    inst:SaveTileData(current_tile_x,current_tile_y)
                    -- local ents = TheWorld.Map:GetEntitiesOnTileAtPoint(inst:GetWorldPointCenterByTileXY(current_tile_x,current_tile_y))
                    -- for k, v in pairs(ents) do
                    --     v:Remove()
                    -- end
                end
            end
            -- print("start tile x",start_tile_x)
            -- print("start tile y",start_tile_y)
            -- print("end tile x",end_tile_x)
            -- print("end tile y",end_tile_y)
            -- print("room width",end_tile_x - start_tile_x + 1)
            -- print("room height",end_tile_y - start_tile_y + 1)
        ------------------------------------------------------------------------------------------------------------------------------------
        



    end)


    return inst
end

return Prefab("map_room_desert", fn)