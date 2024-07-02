

TUNING.FUNNY_CAT_RESOURCES = TUNING.FUNNY_CAT_RESOURCES or {}



-- AddPrefabPostInit("world",function(inst)
--     if not TheWorld.ismastersim then
--         return
--     end

-- end)

local function common_prefab_post_init_fn(inst)
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
end

for origin_prefab, v in pairs(TUNING.FUNNY_CAT_RESOURCES) do
    AddPrefabPostInit("fc_"..origin_prefab,common_prefab_post_init_fn)    
end