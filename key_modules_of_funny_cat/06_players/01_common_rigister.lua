------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    初始化安装
]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



AddPlayerPostInit(function(inst)
    
    if inst.components.funny_cat_com_player_rotation == nil then
        inst:AddComponent("funny_cat_com_player_rotation")
    end

    if not TheWorld.ismastersim then
        return
    end

    if inst.components.funny_cat_com_rpc_event == nil then
        inst:AddComponent("funny_cat_com_rpc_event")
    end
    if inst.components.funny_cat_com_safe_sys == nil then
        inst:AddComponent("funny_cat_com_safe_sys")
    end
    if inst.components.funny_cat_com_cross_archive_data == nil then
        inst:AddComponent("funny_cat_com_cross_archive_data")
    end

    inst:DoTaskInTime(1,function()
        if inst.MiniMapEntity then
            inst.MiniMapEntity:SetEnabled(false)
        end
    end)



end)


if TUNING.FUNNY_CAT_DEBUGGING_MODE then
    

    AddPlayerPostInit(function(inst)

        inst:ListenForEvent("RPC_PUSH_EVENT_CLIENT",function(inst,_cmd)
            if type(_cmd) == "table" then
                print(" +++++++++ client side RPC_PUSH_EVENT_CLIENT")
                for k, v in pairs(_cmd) do
                    print(k,v)
                end
            else
                print(" +++++++++ client side RPC_PUSH_EVENT_CLIENT",_cmd)
            end
        end)

        if not TheWorld.ismastersim then
            return
        end


        inst:ListenForEvent("RPC_PUSH_EVENT_SERVER",function(inst,_cmd)
            if type(_cmd) == "table" then
                print(" +++++++++ server side RPC_PUSH_EVENT_SERVER")
                for k, v in pairs(_cmd) do
                    print(k,v)                    
                end
            else
                print(" +++++++++ server side RPC_PUSH_EVENT_SERVER",_cmd)
            end
            
        end)


        inst:DoTaskInTime(3,function()
            local str = TUNING.FUNNY_CAT_FN:GetStrings("anti_cheating")["debugging_mode_announce"] or "󰀭躲猫猫󰀭        测试模式 ON"
            TheNet:Announce(str)
        end)
    
    end)


end