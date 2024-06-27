----------------------------------------------------
--- 本文件单纯返还路径
----------------------------------------------------

-- local function sum(a, b)
--     return a + b
-- end

-- local info = debug.getinfo(sum)

-- for k,v in pairs(info) do
--         print(k,':', info[k])
-- end

--------------------------------------------------------------------------
local addr_test = debug.getinfo(1).source           ---- 找到绝对路径

local temp_str_index = string.find(addr_test, "scripts/prefabs/")
local temp_addr = string.sub(addr_test,temp_str_index,-1)
-- print("fake error 6666666666666:",temp_addr)    ---- 找到本文件所处的相对路径

local temp_str_index2 = string.find(temp_addr,"/__prefabs_list.lua")

local Prefabs_addr_base = string.sub(temp_addr,1,temp_str_index2) .. "/"    --- 得到最终文件夹路径

---------------------------------------------------------------------------
-- local Prefabs_addr_base = "scripts/prefabs/01_fwd_in_pdt_items/"               --- 文件夹路径
local prefabs_name_list = {
    "01_01_wagstaff_none",      --- 瓦格斯塔夫 皮肤
    "01_02_wagstaff",                      --- 瓦格斯塔夫 基础本体

    "02_01_woodlegs_none",                      --- 木腿船长 基础本体
    "02_02_woodlegs",                      --- 木腿船长 基础本体

    "03_01_wilba_none",                      --- 薇尔芭 基础本体
    "03_02_wilba",                      --- 薇尔芭 基础本体


}


---------------------------------------------------------------------------
---- 正在测试的物品
if TUNING.FUNNY_CAT_DEBUGGING_MODE == true then
    local debugging_name_list = {



    }
    for k, temp in pairs(debugging_name_list) do
        table.insert(prefabs_name_list,temp)
    end
end
---------------------------------------------------------------------------












local ret_addrs = {}
for i, v in ipairs(prefabs_name_list) do
    table.insert(ret_addrs,Prefabs_addr_base..v..".lua")
end
return ret_addrs