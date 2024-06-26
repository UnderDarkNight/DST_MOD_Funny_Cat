----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    修改 ThePlayer.AnimState 函数，变为 table

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



local function Hook_Player_AnimState(inst)

    if type(inst.AnimState) == "userdata" then            ----- 只能转变一次，重复的操作 会导致  __index 函数错误
        --------------------------------------------------------------------------------------------------------------------------------
            inst.__AnimState_userdata_funny_cat = inst.AnimState      ----- 转移复制原有 userdata
            inst.AnimState = {inst = inst , name = "AnimState"}   ----- name 是必须的，用于 从 _G  里 得到目标, 玩家 inst 也是从这里进入
            ------ 逻辑上复现棱镜模组的代码：

            setmetatable( inst.AnimState , {
                __index = function(_table,fn_name)
                            if _table and _table.inst and _table.name then

                                    if _G[_table.name][fn_name] then    ---- 从_G全局里得到原函数？？这句并不好理解。   ---- lua 会往_G 里自动挂载所有要运行的 userdata ？？
                                        local _table_name = _table.name
                                        local fn = function(temp_table,...)
                                            return _G[_table_name][fn_name](temp_table.inst.__AnimState_userdata_funny_cat,...)
                                        end
                                        rawset(_table,fn_name,fn)
                                        return fn
                                    end

                            end
                end,
            })
        --------------------------------------------------------------------------------------------------------------------------------
    else
        print("warning : ThePlayer.AnimState is already a table ")    
    end

    ------- 成功把  inst.AnimState 从  userdata 变成 table
    --------------------- 挂载函数
    if inst.AnimState.inst ~= inst then
        inst.AnimState.inst = inst
    end
    ---------------------
    -- theAnimState_fn_Upgrade(inst.AnimState)
    print("funny_cat hook player AnimState finish")
end


AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then    ------ hook 服务端足够了
        return
    end    
    Hook_Player_AnimState(inst)    
end)

TUNING.FUNNY_CAT_FN.Hook_Player_AnimState = function(self,inst)
    Hook_Player_AnimState(inst)
end