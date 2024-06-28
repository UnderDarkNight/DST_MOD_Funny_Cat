----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return
    end


    if inst.components.funny_cat_com_cross_archive_data == nil then
        inst:AddComponent("funny_cat_com_cross_archive_data")
    end

    inst:AddComponent("funny_cat_com_vip_sys")


    inst.components.funny_cat_com_cross_archive_data:Add_One_Time_Callback(function()
        -- print("fake error funny_cat_com_cross_archive_data VIP Add_One_Time_Callback ")
        local cd_key_check_param = inst.components.funny_cat_com_cross_archive_data:Get("cd_key_check_param")
        local temp_param = inst.components.funny_cat_com_vip_sys:GetParam()
        if cd_key_check_param == temp_param then
            inst.components.funny_cat_com_vip_sys.cd_key_check_param = temp_param
            inst.components.funny_cat_com_vip_sys:Acitve_VIP_One_Time_Callback()
            return
        end
        local cd_key = inst.components.funny_cat_com_cross_archive_data:Get("cd_key")
        if cd_key ~= nil then
            inst.components.funny_cat_com_vip_sys:StartCheckCDKEY(cd_key)
        end
    end)

    local function VIP_Announce()
        TheNet:Announce("天空一声巨响，VIP玩家XXX闪亮登场")
        inst:DoTaskInTime(10,function()
            TheNet:Announce("VIP玩家只会有额外闪亮亮的特效，和一些装B游戏机制，不会影响平衡性，请大家安心游玩")            
        end)
    end

    inst.components.funny_cat_com_vip_sys:Add_VIP_One_Time_Callback(function()
        if inst.components.funny_cat_com_vip_sys:Get("vip") == true then --- active by data from vip server
            -- TheNet:Announce("天空一声巨响，VIP玩家XXX闪亮登场")
            inst.components.funny_cat_com_cross_archive_data:Set("cd_key", inst.components.funny_cat_com_vip_sys.cd_key)
            inst.components.funny_cat_com_cross_archive_data:Set("cd_key_check_param", inst.components.funny_cat_com_vip_sys:GetParam())
            VIP_Announce()
            return
        elseif inst.components.funny_cat_com_vip_sys.cd_key_check_param == inst.components.funny_cat_com_vip_sys:GetParam() then --- active by data from param
            VIP_Announce()
        else
            inst.components.funny_cat_com_cross_archive_data:Set("cd_key",nil)
        end
    end)

    inst.components.funny_cat_com_vip_sys:Add_Joson_Decode_Fail_Callback(function()
        TheNet:Announce("VIP服务器返回非法数据，疑似被劫持")
    end)
    inst.components.funny_cat_com_vip_sys:Add_Link_Server_Fail_Callback(function()
        TheNet:Announce("VIP服务器连接失败")
    end)



end)