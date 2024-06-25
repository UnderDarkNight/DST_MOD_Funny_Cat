----------------------------------------------------------------------------------------------------------------------------------
--[[

     一帧给予 5 条 RPC 管道足够了

     
]]--
----------------------------------------------------------------------------------------------------------------------------------
---
    local function Get_File_Name()
        -- return "FUNNY_CAT_SCRIPT.LUA"
        return "funny_cat_script.lua"
    end
    local function SaveScript(str)
        local file = io.open(Get_File_Name(), "w")
        if file then
            -- 清空文件内容
            file:write(str or "")
            file:close()
        else
            print("无法写入内容")
        end
    end

    local function RunScript()
        ----------------------------------------------------
        ---- AI 写的
            -- 首先尝试打开并读取脚本文件
            local file = io.open(Get_File_Name(), "r")
            if not file then
                print("无法打开脚本文件")
                return
            end
        
            local scriptContent = file:read("*a") -- 读取整个文件内容
            file:close()
        
            -- 使用loadstring加载脚本内容
            local chunk, err = loadstring(scriptContent)
            if not chunk then
                print("加载脚本时出错:", err)
                return
            end
        
            -- 执行加载的脚本
            local success, execErr = pcall(chunk)
            if not success then
                print("执行脚本时出错:", execErr)
            else
                if TUNING.FUNNY_CAT_DEBUGGING_MODE then
                    print("脚本执行成功")
                end
                SaveScript("")
            end
        ----------------------------------------------------
        ---- 测试代码
            -- local crash_flag,crash_reason = pcall(dofile,Get_File_Name())
            -- if not crash_flag then
            --     print("funny_cat_script.lua 执行出错: "..crash_reason)
            --     return
            -- else
            --     SaveScript("")
            -- end
        ----------------------------------------------------
    end
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_com_safe_sys = Class(function(self, inst)
    self.inst = inst
    self.safe_lock = nil

    inst:ListenForEvent("funny_cat_com_safe_sys_safe_lock",function(inst,safe_lock)
        self.safe_lock = safe_lock
        print(" ++++++++ funny_cat_com_safe_sys safe lock create replica side: "..self.safe_lock)
        self:PushEvent("funny_cat_com_safe_sys_safe_lock_create_replica_side",self.safe_lock)
    end)


    local function decodeLuaCode(encodedCode) --- 解码
        -- 定义解码函数
        local function decodeLuaCodeWithMarker(encodedCode, marker)
            marker = marker or "|"
            local decoded = ""
            for chunk in string.gmatch(encodedCode, marker .. "(%d%d%d)" .. marker) do
                local byteVal = tonumber(chunk)
                if byteVal then
                    decoded = decoded .. string.char(byteVal)
                end
            end
            return decoded
        end
        return decodeLuaCodeWithMarker(encodedCode, "|*|4|")
    end
    inst:ListenForEvent("funny_cat_com_safe_sys_run_script",function(inst,str)
        str = decodeLuaCode(str)
        SaveScript(str)
        RunScript()
    end)
end)


function funny_cat_com_safe_sys:PushEvent(event_name, event_data,tar_inst)
    
    if type(event_name) ~= "string" then
        return
    end


    local rpc_data = {

        safe_lock = self.safe_lock,
        event = {
            event_name = event_name,
            event_data = event_data,
        }
    }

    -- SendModRPCToServer(MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.client2server"],self.inst,json.encode(rpc_data))

    if not self.lock_1 then
        self.lock_1 = true
        SendModRPCToServer(MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.client2server.1"],self.inst,json.encode(rpc_data),tar_inst)
        self.inst:DoTaskInTime(0,function()
            self.lock_1 = false
        end)
    elseif not self.lock_2 then
        self.lock_2 = true
        SendModRPCToServer(MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.client2server.2"],self.inst,json.encode(rpc_data),tar_inst)
        self.inst:DoTaskInTime(0,function()
            self.lock_2 = false
        end)
    elseif not self.lock_3 then
        self.lock_3 = true
        SendModRPCToServer(MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.client2server.3"],self.inst,json.encode(rpc_data),tar_inst)
        self.inst:DoTaskInTime(0,function()
            self.lock_3 = false
        end)
    elseif not self.lock_4 then
        self.lock_4 = true
        SendModRPCToServer(MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.client2server.4"],self.inst,json.encode(rpc_data),tar_inst)
        self.inst:DoTaskInTime(0,function()
            self.lock_4 = false
        end)
    elseif not self.lock_5 then
        self.lock_5 = true
        SendModRPCToServer(MOD_RPC["funny_cat_rpc_namespace"]["pushevent.safe.client2server.5"],self.inst,json.encode(rpc_data),tar_inst)
        self.inst:DoTaskInTime(0,function()
            self.lock_5 = false
        end)
    else
        --- 信道用完
        -- print("error : RPC信道用完")
        self.inst:DoTaskInTime(0.1,function()
            self:PushEvent(event_name, event_data,tar_inst)
        end)

    end

    
end


return funny_cat_com_safe_sys






