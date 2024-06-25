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
                local originalText = "【{name}】尝试调用控制台，疑似进行作弊"
                local replacedText = originalText:gsub("{name}", inst:GetDisplayName())
                TheNet:Announce(replacedText)
            end)

        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------