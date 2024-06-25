------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    初始化安装
]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return
    end


    inst:AddComponent("funny_cat_com_rpc_event")
    inst:AddComponent("funny_cat_com_safe_sys")

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
            TheNet:Announce("󰀭躲猫猫󰀭        测试模式 ON")
        end)
    
    end)


end