

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    -- inst.entity:AddMiniMapEntity()
    -- inst.MiniMapEntity:SetIcon("moonrockseed.png")
    -- inst.MiniMapEntity:SetPriority(11)
    -- inst.MiniMapEntity:SetCanUseCache(false)
    -- inst.MiniMapEntity:SetDrawOverFogOfWar(true)

    inst.AnimState:SetBank("cane")
    inst.AnimState:SetBuild("swap_cane")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("map_room")
    inst:AddTag("map_room_indicator")
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
    ------------------------------------------------------------------------------------------------------------------------------------
    --- 获取类型 tag
        function inst:GetType()
            return self.__tile_tag
        end
        function inst:SetType(tag)
            self.__tile_tag = tag
        end
    ------------------------------------------------------------------------------------------------------------------------------------
    --- 获取内部坐标
        function inst:InThisRoom(target_or_vector3,yy,zz)   --- 进行多态兼容
            local tx,ty,tz = 1000,1000,1000
            if type(target_or_vector3) == "table" then
                if target_or_vector3.x ~= nil then
                    tx,ty,tz = target_or_vector3.x,target_or_vector3.y,target_or_vector3.z
                elseif target_or_vector3.Transform then
                    tx,ty,tz = target_or_vector3.Transform:GetWorldPosition()
                end
            elseif type(target_or_vector3) == "number" then
                tx,ty,tz = target_or_vector3,yy,zz
            end
            local x,y,z = self.Transform:GetWorldPosition()
            if math.abs(tx-x) < 40 and math.abs(tz-z) < 40 then
                return true
            end
            return false
        end
        function inst:GetRandomPointInThisRoom()            --- 获取区域内的随机坐标
            local x,y,z = self.Transform:GetWorldPosition()
            local max_distance = 38
            local offset_x = math.random(-max_distance,max_distance)
            local offset_z = math.random(-max_distance,max_distance)
            return Vector3(x+offset_x,y,z+offset_z)
        end
        function inst:GetRandomTileCenterPoint()            --- 获取区域内的随机地块中心点
            local random_pt = self:GetRandomPointInThisRoom()
            return Vector3(TheWorld.Map:GetTileCenterPoint(random_pt.x,0,random_pt.z))
        end

        function inst:PlaceInRandom(target)
            for i = 1, 1000, 1 do
                local target_pt = self:GetRandomPointInThisRoom()
                if TheWorld.Map:CanDeployAtPoint(target_pt,target) or self:GetType() == "OCEAN" then
                    target.Transform:SetPosition(target_pt.x,0,target_pt.z)
                    return true
                end
            end
            return false
        end
    ------------------------------------------------------------------------------------------------------------------------------------
    inst:AddComponent("funny_cat_data")
    if TUNING.FUNNY_CAT_DEBUGGING_MODE then
        inst:AddComponent("inspectable")
        inst:SpawnChild("moonrockseed_icon")
    end

    inst:ListenForEvent("Set",function(inst,_table)
        --- 20x20区域。
        _table = _table or {
            -- pt = pt,
            -- tag = "map_room",
        }
        ------------------------------------------------------------------------------------------------------------------------------------
        --- 基础参数
            local ROOM_SIZE = 20
        ------------------------------------------------------------------------------------------------------------------------------------
        --- 放置尺寸
            local pt = _table.pt
            inst.Transform:SetPosition(pt.x, pt.y, pt.z)
            local star_x = pt.x - 38
            local start_z = pt.z - 38
            local end_x = pt.x + 38
            local end_z = pt.z + 38
            local map_width,map_height = TheWorld.Map:GetSize()
        ------------------------------------------------------------------------------------------------------------------------------------
        --- 绚丽之门 区域检查, 防止在这个区域做事情
            local door = TheSim:FindFirstEntityWithTag("multiplayer_portal")
            if door then
                local door_x,door_y,door_z = door.Transform:GetWorldPosition()
                if math.abs(door_x-pt.x) < 40 and math.abs(door_z-pt.z) < 40 then
                    -- inst:Remove()
                    -- return
                    _table.tag = "DOOR"
                end
            end
        ------------------------------------------------------------------------------------------------------------------------------------
        --- 储存标记位
            inst:AddTag(_table.tag)
            inst:SetType(_table.tag)
            TheWorld.MAP_ROOM_INDICATORS = TheWorld.MAP_ROOM_INDICATORS or {}
            TheWorld.MAP_ROOM_INDICATORS[inst] = _table.tag
            inst.components.funny_cat_data:Set("tag",_table.tag)
        ------------------------------------------------------------------------------------------------------------------------------------
        ---
            local start_tile_x ,start_tile_y = inst:GetTileXYAtPoint(star_x,0,start_z)
            for x = start_tile_x, start_tile_x + ROOM_SIZE, 1 do
                for y = start_tile_y, start_tile_y + ROOM_SIZE, 1 do
                    TheWorld.components.funny_cat_world_map_tile_sys:Add_Tag_To_Tile_XY(x,y,_table.tag)
                    TheWorld.components.funny_cat_world_map_tile_sys:Add_Join_Event_Fn_To_Tile_XY(x,y,function(player,tile_x,tile_y)
                        player:PushEvent("player_enter_map_room",inst)
                    end)
                end
            end
        ------------------------------------------------------------------------------------------------------------------------------------
        --- 回调给TheWorld触发
            if not inst.components.funny_cat_data:Get("inited_flag") then
                TheWorld:PushEvent("map_room_indicator_inited",inst)
                inst.components.funny_cat_data:Set("inited_flag",true)
            end
        ------------------------------------------------------------------------------------------------------------------------------------
    end)


    -------- 重新加载地图的时候初始化
    inst:DoTaskInTime(0,function()
        TheWorld.MAP_ROOM_INDICATORS = TheWorld.MAP_ROOM_INDICATORS or {}
        if TheWorld.MAP_ROOM_INDICATORS[inst] == nil then
            inst:PushEvent("Set",{
                pt = Vector3(inst.Transform:GetWorldPosition()),
                tag = inst.components.funny_cat_data:Get("tag"),
            })
        end
    end)


    return inst
end

return Prefab("map_room_indicator", fn)