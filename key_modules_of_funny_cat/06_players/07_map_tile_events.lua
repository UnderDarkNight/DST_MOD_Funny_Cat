----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    地图区域事件


]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return
    end

    local last_tile = nil

    inst:AddComponent("funny_cat_player_tile_event")
    inst:ListenForEvent("funny_cat_event.enter_new_tile",function(_,_table)
        local tile_x,tile_y = _table.tx, _table.ty
        local data = {
            tile_x = tile_x,
            tile_y = tile_y,
        }
        local tile_data = TheWorld.components.funny_cat_world_map_tile_sys:Get_Data_By_Tile_XY(tile_x,tile_y) or {}
        local tags = tile_data.tags or {}
        data.tags = tags
        inst.components.funny_cat_player_tile_event:SetCrrentTileData(data)
        if last_tile ~= _table.tile then
            print("player enter new tile:",_table.tile)
            last_tile = _table.tile
        end
        
    end)

    if TUNING.FUNNY_CAT_DEBUGGING_MODE then
        inst:DoTaskInTime(1,function()
            inst.components.inventory:GiveItem(SpawnPrefab("orangestaff"))
            inst.components.inventory:GiveItem(SpawnPrefab("goldenpitchfork"))
        end)
    end

end)