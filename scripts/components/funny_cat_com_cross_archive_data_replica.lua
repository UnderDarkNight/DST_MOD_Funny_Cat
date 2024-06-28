----------------------------------------------------------------------------------------------------------------------------------
--[[

    

     
]]--
----------------------------------------------------------------------------------------------------------------------------------
---
    local function IsClientSide()
        if TheNet:IsDedicated() then
            return false
        end
        return true
    end
    --- 基础的文件读写函数
    local fileName = "funny_cat_cross_archive_data.txt" -- 文件名缓存

    -- 文件句柄缓存
    local fileHandle = nil

    local function OpenFile(mode)
        if fileHandle == nil then
            fileHandle = io.open(fileName, mode)
        end
        return fileHandle
    end

    local function CloseFile()
        if fileHandle ~= nil then
            fileHandle:close()
            fileHandle = nil
        end
    end

    local function Read_All_Json_Data()
        local file = OpenFile("r")
        if file then
            local text = file:read('*a') -- 读取全部内容而不是单行
            CloseFile()
            return text and json.decode(text) or {}
        else
            print("Failed to open file for reading.")
            return {}
        end
    end

    local function Write_All_Json_Data(json_data)
        if IsClientSide() then
            local file = OpenFile("w")
            if file then
                local w_data = json.encode(json_data)
                file:write(w_data)
                CloseFile()
            else
                print("Failed to open file for writing.")
            end
        end
    end

    local function Get_Cross_Archived_Data_By_userid(userid)
        local crash_flag , all_data_table = pcall(Read_All_Json_Data)
        if crash_flag then
            local temp_json_data = all_data_table
            return temp_json_data[userid] or {}
        else
            print("error : Read_All_Json_Data fn crash")
            return {}
        end
    end

    local function Set_Cross_Archived_Data_By_userid(userid,_table)
        if not IsClientSide() then  --- 只在客户端这一侧执行数据写入
            return
        end

        local temp_json_data = Read_All_Json_Data() or {}
        -- temp_json_data[userid] = _table
        temp_json_data[userid] = temp_json_data[userid] or {}
        for index, value in pairs(_table) do
            temp_json_data[userid][index] = value
        end
        temp_json_data = deepcopy(temp_json_data)
        -- Write_All_Json_Data(temp_json_data)
        pcall(Write_All_Json_Data,temp_json_data)
    end
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_com_cross_archive_data = Class(function(self, inst)
    self.inst = inst
    ---------------------------------------------------------------------------------------------------------------------------
    ---
        inst:DoTaskInTime(3,function()
            self:Init()
        end)
        if IsClientSide() then
            inst:ListenForEvent("funny_cat_com_cross_archive_data_from_server",function(_,data)
                self:SetAllData(data)
            end)
            inst:ListenForEvent("funny_cat_com_cross_archive_data_Force_Client_Upload_Data",function()
                self:Synchronized_Data_To_Server()
            end)
        end
    ---------------------------------------------------------------------------------------------------------------------------
end,
nil,
{

})
--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_cross_archive_data:IsPlayer()
        if self.inst.userid and self.inst.components.playercontroller then
            return true
        end
        return false
    end
    function funny_cat_com_cross_archive_data:Init()
        self:Synchronized_Data_To_Server()
    end
    function funny_cat_com_cross_archive_data:Synchronized_Data_To_Server()
        if self:IsPlayer() then
            local data = self:GetAllData()
            local RPC_HANDLE = self.inst.replica.funny_cat_com_safe_sys or self.inst.replica._.funny_cat_com_safe_sys
            if RPC_HANDLE then
                RPC_HANDLE:PushEvent("funny_cat_com_cross_archive_data_from_client",data)
            end
        end
    end
--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_cross_archive_data:GetAllData()
        local userid = self.inst.userid
        return Get_Cross_Archived_Data_By_userid(tostring(userid)) or {}
    end
    
    function funny_cat_com_cross_archive_data:SetAllData(data)
        local userid = self.inst.userid
        Set_Cross_Archived_Data_By_userid(tostring(userid),data)
    end    
    function funny_cat_com_cross_archive_data:GetDataByIndex(index)
        local data = self:GetAllData()
        return data[index]
    end    
    function funny_cat_com_cross_archive_data:SetDataByIndex(index,value)
        local data = self:GetAllData()
        data[index] = value
        self:SetAllData(data)
    end
--------------------------------------------------------------------------------------------------------------------
-- 简化API    
    function funny_cat_com_cross_archive_data:Set(index,value)
        self:SetDataByIndex(index,value)
    end
    function funny_cat_com_cross_archive_data:Get(index)
        return self:GetDataByIndex(index)
    end
--------------------------------------------------------------------------------------------------------------------



return funny_cat_com_cross_archive_data






