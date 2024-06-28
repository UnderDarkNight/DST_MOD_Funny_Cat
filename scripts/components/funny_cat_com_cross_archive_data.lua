----------------------------------------------------------------------------------------------------------------------------------
--[[

    

     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_com_cross_archive_data = Class(function(self, inst)
    self.inst = inst
    self.data = {}
    ---------------------------------------------------------------------------------------------------------------------------
    ---
        inst:ListenForEvent("funny_cat_com_cross_archive_data_from_client",function(_,data)
            print("info funny_cat_com_cross_archive_data_from_client")
            self.data = data
            self:Acive_On_Time_Callback()
        end)
        -- inst:DoTaskInTime(0,function()
        --     self:Init()
        -- end)
    ---------------------------------------------------------------------------------------------------------------------------
end,
nil,
{

})
--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_cross_archive_data:Init()
        self.RPC_HANDLE = self.inst.components.funny_cat_com_safe_sys
    end
    function funny_cat_com_cross_archive_data:Synchronized_Data_To_Client()
        local RPC_HANDLE = self.inst.components.funny_cat_com_safe_sys
        if RPC_HANDLE then
            RPC_HANDLE:PushEvent("funny_cat_com_cross_archive_data_from_server",self.data)
        end
    end
--------------------------------------------------------------------------------------------------------------------
---
    function funny_cat_com_cross_archive_data:GetAllData()
        return self.data
    end
    function funny_cat_com_cross_archive_data:SetAllData(data)
        self.data = data
        self:Synchronized_Data_To_Client()
    end
    function funny_cat_com_cross_archive_data:GetDataByIndex(index)
        return self.data[index]
    end
    function funny_cat_com_cross_archive_data:SetDataByIndex(index,value)
        self.data[index] = value
        self:Synchronized_Data_To_Client()
    end
--------------------------------------------------------------------------------------------------------------------
-- 强制下发事件要求客户端上传数据
    function funny_cat_com_cross_archive_data:Force_Client_Upload_Data()
        self.RPC_HANDLE:PushEvent("funny_cat_com_cross_archive_data_Force_Client_Upload_Data")
    end
--------------------------------------------------------------------------------------------------------------------
-- 简化读写API
    function funny_cat_com_cross_archive_data:Set(index,value)
        self:SetDataByIndex(index,value)
    end
    function funny_cat_com_cross_archive_data:Get(index)
        return self:GetDataByIndex(index)
    end
--------------------------------------------------------------------------------------------------------------------
-- 添加一次性执行fn,方便数据更新后回调
    function funny_cat_com_cross_archive_data:Add_One_Time_Callback(fn)
        self.One_Time_Callback = self.One_Time_Callback or {}
        table.insert(self.One_Time_Callback,fn)
    end
    function funny_cat_com_cross_archive_data:Acive_On_Time_Callback()
        self.One_Time_Callback = self.One_Time_Callback or {}
        for _,fn in ipairs(self.One_Time_Callback) do
            fn()
        end
        self.One_Time_Callback = {}
    end
--------------------------------------------------------------------------------------------------------------------



return funny_cat_com_cross_archive_data






