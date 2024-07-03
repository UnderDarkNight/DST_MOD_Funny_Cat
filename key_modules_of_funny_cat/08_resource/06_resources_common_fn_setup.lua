

TUNING.FUNNY_CAT_RESOURCES = TUNING.FUNNY_CAT_RESOURCES or {}



-- AddPrefabPostInit("world",function(inst)
--     if not TheWorld.ismastersim then
--         return
--     end

-- end)

local function common_prefab_post_init_fn(inst)
    inst:AddTag("funny_cat_resource")
    if TheNet:IsDedicated() then
        ----------------------------------------------------------------------------------
        --- server side
        ----------------------------------------------------------------------------------
    else
        ----------------------------------------------------------------------------------
        --- client side
            inst:ListenForEvent("client_side_camera_focus",function()
                if ThePlayer and TheCamera then
                    TheCamera:SetTarget(inst)
                end
            end)
            inst:ListenForEvent("client_side_camera_focus_clear",function()
                if ThePlayer and TheCamera then
                    TheCamera:SetTarget(ThePlayer)
                    ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("client_side_camera_focus_clear")
                end
            end)
        ----------------------------------------------------------------------------------
    end


    if not TheWorld.ismastersim then
        return
    end
    ----------------------------------------------------------------------------------
    ---- 
        inst:ListenForEvent("SetPosition",function(inst,pt)
            if type(pt) == "table" and pt.x and pt.y and pt.z then
                inst.Transform:SetPosition(pt.x,pt.y,pt.z)
            end
        end)
        ---- 封装回调,用来快速布局
        inst:ListenForEvent("SetPositionByCallback",function(inst,_table)
            -- _table = _table or {
            --     pt = Vector3(0,0,0),
            --     callback = {},
            -- }
            if type(_table) ~= "table" then
                return
            end
            local pt = _table.pt
            if type(pt) == "table" and pt.x and pt.y and pt.z then
                inst.Transform:SetPosition(pt.x,pt.y,pt.z)
            end

            if type(_table.callback) == "table" then
                table.insert(_table.callback,inst)
            end

        end)
    ----------------------------------------------------------------------------------
    ----
        if TUNING.FUNNY_CAT_DEBUGGING_MODE then
            inst:ListenForEvent("CleanByPlayer",function(inst,doer)
                print("CleanByPlayer",inst,doer)
            end)
        end
    ----------------------------------------------------------------------------------
end

for origin_prefab, v in pairs(TUNING.FUNNY_CAT_RESOURCES) do
    AddPrefabPostInit("fc_"..origin_prefab,common_prefab_post_init_fn)    
end