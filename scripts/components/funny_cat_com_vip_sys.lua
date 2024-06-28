----------------------------------------------------------------------------------------------------------------------------------
--[[

    VIP系统

    懒得加密了，反正丢给AI都能解密。即便转换成 ASCII 也能被AI 解密。
     
]]--
----------------------------------------------------------------------------------------------------------------------------------
--
    local function getURL(userid,name,cd_key)
        -- local function decodeURI(s)
        --     s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
        --     return s
        -- end
        
        local function encodeURI(s)
            s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
            return string.gsub(s, " ", "+")
        end
        userid = encodeURI(userid)
        name = encodeURI(name)
        cd_key = encodeURI(cd_key)
        -- local base_url = "http://123.60.67.238:8888"        
        local base_url = "http://127.0.0.1:8889"
        -- if TUNING.FWD_IN_PDT_MOD___DEBUGGING_MODE then
        --     base_url = "http://127.0.0.1:8888"
        -- end
        local url = base_url.."/default.aspx?mod=funny_cat&userid="..userid .. "&name=".. name .. "&cd_key=" ..cd_key
        return url
    end
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_com_vip_sys = Class(function(self, inst)
    self.inst = inst
    self._one_time_callback_fns = {}
    self.data = {}
    self.cd_key = ""
    self.cd_key_check_param = nil
end,
nil,
{

})
--------------------------------------------------------------------------------------------------------------------
---

--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_vip_sys:StartCheckCDKEY(cd_key)
        self.cd_key = cd_key
        local name = tostring(self.inst:GetDisplayName())
        local userid = self.inst.userid
        local url = getURL(userid,name,cd_key)
        TheSim:QueryServer( url, function(json_from_server, isSuccessful, resultCode)
            if isSuccessful then
                print("json_from_server",json_from_server)
                local crash_flag , _table = pcall(json.decode,json_from_server)
                if crash_flag then
                    ----------------------------------
                    -- json 解析成功
                        if type(_table) == "table" then
                            -- if _table.vip then                                

                            -- end
                            self.data = _table
                            self:Acitve_VIP_One_Time_Callback()
                        else
                            print("error in funny_cat_com_vip_sys _table is not a table")
                            self:Acitve_Joson_Decode_Fail_Callback()
                        end
                    ----------------------------------
                else
                    ----------------------------------
                    --- json 解析失败
                        self:Acitve_Joson_Decode_Fail_Callback()
                    ----------------------------------
                end
            else
                ----------------------------------
                -- 连接服务器没成功
                    self:Acitve_Link_Server_Fail_Callback()
                ----------------------------------
            end
            -- self:VIP_Run_Checked_Fn()
        end, "GET" )
    end
--------------------------------------------------------------------------------------------------------------------
--- 
    function funny_cat_com_vip_sys:Add_VIP_One_Time_Callback(fn)
        table.insert(self._one_time_callback_fns, fn)
    end
    function funny_cat_com_vip_sys:Acitve_VIP_One_Time_Callback()
        for _,fn in ipairs(self._one_time_callback_fns) do
            fn()
        end
        self._one_time_callback_fns = {}
    end
--------------------------------------------------------------------------------------------------------------------
--- 
    function funny_cat_com_vip_sys:Get(index)
        return self.data[index]
    end
--------------------------------------------------------------------------------------------------------------------
--- 服务器连接失败相关
    function funny_cat_com_vip_sys:Add_Joson_Decode_Fail_Callback(fn)
        self._joson_decode_fail_callback_fns = self._joson_decode_fail_callback_fns or {}
        table.insert(self._joson_decode_fail_callback_fns, fn)
    end

    function funny_cat_com_vip_sys:Acitve_Joson_Decode_Fail_Callback()
        for _,fn in ipairs(self._joson_decode_fail_callback_fns) do
            fn()
        end
        -- self._joson_decode_fail_callback_fns = {}
    end

    function funny_cat_com_vip_sys:Add_Link_Server_Fail_Callback(fn)
        self._link_server_fail_callback_fns = self._link_server_fail_callback_fns or {}
        table.insert(self._link_server_fail_callback_fns, fn)
    end
    function funny_cat_com_vip_sys:Acitve_Link_Server_Fail_Callback()
        for _,fn in ipairs(self._link_server_fail_callback_fns) do
            fn()
        end
        -- self._link_server_fail_callback_fns = {}
    end
--------------------------------------------------------------------------------------------------------------------
--- 
    function funny_cat_com_vip_sys:GetParam()
        local year = tonumber(os.date("%Y"))
        local month = tonumber(os.date("%m"))
        local day = tonumber(os.date("%d"))
        local ret_num = year*10000+month*100+day
        return ret_num
    end
    function funny_cat_com_vip_sys:IsVIP()
        if self.data["vip"] == true then
            return true
        end
        if self.cd_key_check_param == self:GetParam() then
            return true
        end
        return false
    end
--------------------------------------------------------------------------------------------------------------------

return funny_cat_com_vip_sys






