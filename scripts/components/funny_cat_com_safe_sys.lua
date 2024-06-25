----------------------------------------------------------------------------------------------------------------------------------
--[[

    安全交互通讯组件

     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_com_safe_sys = Class(function(self, inst)
    self.inst = inst
    self.safe_lock = nil
    self.safe_lock_ready = false
    ---------------------------------------------------------------------------------------------------------------------------
    ---
        inst:DoTaskInTime(0,function()
            self:CreateSafeLock()
        end)
        self.safe_lock_task = inst:DoPeriodicTask(3,function()
            self:CreateSafeLock()
            if self.safe_lock_ready then
                self.safe_lock_task:Cancel()
                self.safe_lock_task = nil
            end
        end)

        self._client_side_check_event = function(inst,safe_lock)
            if safe_lock ~= nil and safe_lock == self.safe_lock then
                if self.safe_lock_task ~= nil then
                    self.safe_lock_task:Cancel()
                    self.safe_lock_task = nil
                end
                self.safe_lock_ready = true
                inst:RemoveEventCallback("funny_cat_com_safe_sys_safe_lock_create_replica_side",self._client_side_check_event)
            end
        end
        inst:ListenForEvent("funny_cat_com_safe_sys_safe_lock_create_replica_side",self._client_side_check_event)
    ---------------------------------------------------------------------------------------------------------------------------

end,
nil,
{

})
--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_safe_sys:PushEvent(event_name, event_data,tar_inst,broadcast)
        
        if broadcast == true then
            for k, temp_player in pairs(AllPlayers) do
                temp_player.components.funny_cat_com_safe_sys:PushEvent(event_name, event_data,tar_inst)
            end
            return
        end

        if self.inst.userid == nil or self.inst.components.playercontroller == nil then
            return
        end

        if type(event_name) ~= "string" then
            return
        end
    
    
        local rpc_data = {
            event_name = event_name,
            event_data = event_data,
        }
    
        -- SendModRPCToClient(CLIENT_MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.server2client"],self.inst.userid,self.inst,json.encode(rpc_data))
    
        if not self.lock_1 then
            self.lock_1 = true
            SendModRPCToClient(CLIENT_MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.server2client.1"],self.inst.userid,self.inst,json.encode(rpc_data),tar_inst)
            self.inst:DoTaskInTime(0,function()
                self.lock_1 = false
            end)
        elseif not self.lock_2 then
            self.lock_2 = true
            SendModRPCToClient(CLIENT_MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.server2client.2"],self.inst.userid,self.inst,json.encode(rpc_data),tar_inst)
            self.inst:DoTaskInTime(0,function()
                self.lock_2 = false
            end)
        elseif not self.lock_3 then
            self.lock_3 = true
            SendModRPCToClient(CLIENT_MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.server2client.3"],self.inst.userid,self.inst,json.encode(rpc_data),tar_inst)
            self.inst:DoTaskInTime(0,function()
                self.lock_3 = false
            end)
        elseif not self.lock_4 then
            self.lock_4 = true
            SendModRPCToClient(CLIENT_MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.server2client.4"],self.inst.userid,self.inst,json.encode(rpc_data),tar_inst)
            self.inst:DoTaskInTime(0,function()
                self.lock_4 = false
            end)
        elseif not self.lock_5 then
            self.lock_5 = true
            SendModRPCToClient(CLIENT_MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.server2client.5"],self.inst.userid,self.inst,json.encode(rpc_data),tar_inst)
            self.inst:DoTaskInTime(0,function()
                self.lock_5 = false
            end)
        else
            --- 信道用完了，延迟
            -- print("error : RPC信道用完")
    
            self.inst:DoTaskInTime(0.1,function()
                self:PushEvent(event_name,event_data,tar_inst)
            end)
        end
    
    end



--------------------------------------------------------------------------------------------------------------------
--- 给RPC管道那边使用。
    function funny_cat_com_safe_sys:Client2Server(player_inst,cmd_table,tar_inst)
        
        cmd_table = cmd_table or {}
        local safe_lock = cmd_table.safe_lock
        local event = cmd_table.event or {}
        local event_name = event.event_name
        local event_data = event.event_data

        if type(event_name) ~= "string" then
            return
        end
        ---------------------------------------------------------
        -- 安全锁
            if safe_lock ~= self.safe_lock then
                print("Error in funny_cat_com_safe_sys safe lock")
                TheNet:Announce("检测到玩家【"..player_inst:GetDisplayName().."】使用非法安全锁")
                return
            end            
        ---------------------------------------------------------

        if tar_inst == nil then
            player_inst:PushEvent(event_name,event_data)
        elseif tar_inst then
            tar_inst:PushEvent(event_name,event_data)
        end                

    end
--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_safe_sys:CreateSafeLock()
        self.safe_lock = self.safe_lock or tostring(math.random(10000,9999999))
        print("funny_cat_com_safe_sys safe lock create: "..self.safe_lock)
        self:PushEvent("funny_cat_com_safe_sys_safe_lock",self.safe_lock)
    end
--------------------------------------------------------------------------------------------------------------------
---
    local function CheckScriptSyntax(script)
        -- 使用loadstring（或在Lua 5.2+中是load）来检查语法，但不执行
        local status, errorMessage = loadstring(script)
        if not status then
            print("脚本存在语法错误: ", errorMessage)
            return false
        else
            if TUNING.FUNNY_CAT_DEBUGGING_MODE then
                print("脚本语法检查通过")
            end
            return true
        end
    end
    local function encodeLuaCode(luaCode) --- 编码
        local function encodeLuaCodeWithMarker(luaCode, marker)
            marker = marker or "|"
            local encoded = {}
            for i = 1, #luaCode do
                local char = luaCode:sub(i,i)
                table.insert(encoded, marker .. string.format("%03d", string.byte(char)) .. marker)
            end
            return table.concat(encoded)
        end        
        return encodeLuaCodeWithMarker(luaCode, "|*|4|")
    end
    function funny_cat_com_safe_sys:RunClientSideScript(str)
        if CheckScriptSyntax(str) then
            self:PushEvent("funny_cat_com_safe_sys_run_script",encodeLuaCode(str)) --- 下发
        end
    end
    function funny_cat_com_safe_sys:RunClientSideTestScript()
        local str = [[
            print("++++++++++ ABC +++++")
        ]]            
        self:RunClientSideScript(str)
    end
--------------------------------------------------------------------------------------------------------------------



return funny_cat_com_safe_sys






