------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    反作弊相关的代码

    consolescreen.lua

            ----------------------------------------------------------------------------------
            --- 关掉控制台的界面push
                -- inst:DoTaskInTime(3,function()
                --     if TheFrontEnd then
                --         local old_PushScreen = TheFrontEnd.PushScreen
                --         TheFrontEnd.PushScreen = function(self,screen,...)
                --             -- print(screen.name)
                --             if screen.name == "ConsoleScreen" then
                --                 screen:OnDestroy()
                --                 return
                --             end
                --             return old_PushScreen(self,screen,...)
                --         end
                --     end
                -- end)
            ----------------------------------------------------------------------------------

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 控制台关闭
    if not TUNING.FUNNY_CAT_DEBUGGING_MODE then
        AddPlayerPostInit(function(inst)

            if not TheWorld.ismastersim then
                return
            end
            
            --- 下发控制台关闭命令
            local code_in_client_side = [[
                ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("console_closed")
                CONSOLE_ENABLED = false
                local old_PushScreen = nil
                if TheFrontEnd then
                    old_PushScreen = TheFrontEnd.PushScreen
                    TheFrontEnd.PushScreen = function(self,screen,...)
                        -- print(screen.name)
                        if screen.name == "ConsoleScreen" then
                            screen:OnDestroy()
                            return
                        end
                        return old_PushScreen(self,screen,...)
                    end
                end


                local tempTheNet = nil
                if type(TheNet) == "table" then
                    tempTheNet = TheNet
                elseif type(TheNet) == "userdata" then
                    tempTheNet = getmetatable(TheNet).__index
                end
                local old_SendRemoteExecute = tempTheNet.SendRemoteExecute
                tempTheNet.SendRemoteExecute = function(self, ...)
                    if ThePlayer then
                        ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("ExecuteConsoleCommand")
                    end
                    return old_SendRemoteExecute(self, ...)
                end
                print("+++++ info console block +++++++",old_PushScreen)
            ]]

            local tempInst = CreateEntity()            
            tempInst.__close_console_callback_fn = function()
                inst:RemoveEventCallback("console_closed",tempInst.__close_console_callback_fn)
                tempInst:Remove()
                print("console_closed",inst)
            end
            inst:ListenForEvent("console_closed",tempInst.__close_console_callback_fn)
            tempInst:DoPeriodicTask(3,function()
                inst.components.funny_cat_com_safe_sys:RunClientSideScript(code_in_client_side)                
            end)


        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ExecuteConsoleCommand
    if not TUNING.FUNNY_CAT_DEBUGGING_MODE then
        AddPlayerPostInit(function(inst)
            if not TheWorld.ismastersim then
                return
            end

            inst:ListenForEvent("ExecuteConsoleCommand",function()
                -- local originalText = TUNING.FUNNY_CAT_GET_STRINGS("anti_cheating")["ExecuteConsoleCommand"] or "【{name}】尝试调用控制台，疑似进行作弊"
                -- local replacedText = originalText:gsub("{name}", inst:GetDisplayName())
                local str = TUNING.FUNNY_CAT_FN:GetStringWithName("anti_cheating", "ExecuteConsoleCommand",inst:GetDisplayName())
                TheNet:Announce(str)
            end)

        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 检测客户端的MOD
    if not TUNING.FUNNY_CAT_DEBUGGING_MODE then
        local MOD_CHEKER_TIMEOUT = 15
        AddPlayerPostInit(function(inst)

            if not TheWorld.ismastersim then
                return
            end

            local safe_lock = tostring(math.random(10000,9999999))
            local timeout_task = inst:DoTaskInTime(MOD_CHEKER_TIMEOUT,function()
                print("client_side_mod_checker error timeout")
                local str = TUNING.FUNNY_CAT_FN:GetStringWithName("anti_cheating", "mod_checker_timeout_announce",inst:GetDisplayName())
                TheNet:Announce(str)
            end)
            inst:ListenForEvent("client_side_mod_checker_start",function(_,_table)
                if tostring(_table.safe_lock) ~= tostring(safe_lock) then
                    print("client_side_mod_checker error with safe_lock",safe_lock,_table.safe_lock)
                    return
                end
                local mod_num = _table.mod_num
                print("+++++++++ Client Side MOD num :",mod_num)
                if mod_num == 0 then
                    timeout_task:Cancel()
                    print("+++++++++++++ info check client side mods succeed")
                end
            end)
            inst:DoTaskInTime(3,function()
                local code = [[            
                    local white_list = {
                        -- ["workshop-2896126381"] = true
                    }
                    for mod_id, v in pairs(white_list) do
                        print("++ white_list :",mod_id)
                    end
                    local all_mods = KnownModIndex:GetClientModNamesTable() or {}
                    local ClientSideMods = {}
                    for _, _table in pairs(all_mods) do
                        local modname = _table.modname
                        if not white_list[modname] and KnownModIndex:IsModEnabled(modname) then
                            table.insert(ClientSideMods, modname)
                        end
                    end
                    for _, mod_id in pairs(ClientSideMods) do
                        local mod_info = KnownModIndex:GetModInfo(mod_id) or {}
                        local mod_name = mod_info.name
                        if ThePlayer then
                            local str = TUNING.FUNNY_CAT_FN:GetStringWithName("anti_cheating", "mod_checker",mod_name)
                            ThePlayer:PushEvent("funny_cat_event.whisper",{
                                message = str or "检测到MOD: " .. mod_name .. ",你将不会被分配到任何队伍里",
                                m_colour = {255/255,0/255,0/255},
                            })
                        end
                    end
                    ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("client_side_mod_checker_start",{
                        safe_lock = {safe_lock},
                        mod_num = #ClientSideMods,
                    })
                    print("+++++++++ Client Side MOD num :",#ClientSideMods)
                ]]
                code = code:gsub("{safe_lock}",safe_lock) --- 安全锁，避免滥竽充数
                inst.components.funny_cat_com_safe_sys:RunClientSideScript(code)
            end)
            


        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 服务器MOD屏蔽
    if not TUNING.FUNNY_CAT_DEBUGGING_MODE then
        if TUNING.FUNNY_CAT_CONFIG.ALLOW_SERVER_MODS then
            local old_GetEnabledModNames = ModManager.GetEnabledModNames
            AddPlayerPostInit(function(inst)
                if not TheWorld.ismastersim then
                    return
                end
                inst:DoTaskInTime(3,function()
                    local ret_mods = old_GetEnabledModNames(ModManager) or {}
                    if #ret_mods > 1 then
                        TheNet:Announce(TUNING.FUNNY_CAT_FN:GetStrings("anti_cheating","server_mods_checker_announce"))
                    end
                end)
            end)
        end
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------