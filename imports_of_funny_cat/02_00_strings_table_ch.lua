----------------------------------------------------------------------------------------------------------------------------------
--[[

    中文文本
    
]]--
----------------------------------------------------------------------------------------------------------------------------------


local crrent_language = "ch"
if TUNING.FUNNY_CAT_GET_LANGUAGE() ~= crrent_language then
    return
end

local strings = {   
    --------------------------------------------------------------------
    --- 正在debug 测试的
        ["funny_cat_skin_test_item"] = {
            ["name"] = "皮肤测试物品",
            ["inspect_str"] = "inspect单纯的测试皮肤",
            ["recipe_desc"] = "测试描述666",
        },
        ["anti_cheating"] = {
            ["ExecuteConsoleCommand"] = "【{name}】尝试调用控制台，疑似进行作弊",
            ["rpc_safe_lock"] = "检测到玩家【{name}】使用非法安全锁",
            ["mod_checker"] = "检测到MOD:{name},你将不会被分配到任何队伍里",
            ["mod_checker_timeout_announce"] = "【{name}】开了本地MOD或者检测超时，无法正常分配队伍",
            ["debugging_mode_announce"] = "󰀭躲猫猫󰀭        测试模式 ON ,本模式很容易进行外挂作弊。",
            ["server_mods_checker_announce"] = "检测到服务器存在󰀭躲猫猫󰀭以外的MOD，游戏将可能会出现奇怪的机制",
            ["anti_cheating_anomaly"] = "󰀭躲猫猫󰀭反作弊系统在【{name}】的客户端出现异常",
        },
        ["beard_container_hotkey"] = {
            ["succeed"] = "激活卡槽 ",
            ["failed"] = "请不要过快连续使用卡槽快捷键",
        },
    --------------------------------------------------------------------
    --- 01_items
        ["funny_cat_item_cleaning_broom"] = {
            ["name"] = "清洁扫把 测试",
            ["inspect_str"] = "清洁扫把 测试",
            ["recipe_desc"] = "清洁扫把 测试",
        },
    --------------------------------------------------------------------
    --------------------------------------------------------------------
}

TUNING.FUNNY_CAT_GET_STRINGS = function(prefab_name1,prefab_name2)
    local prefab_name = "nil"
    if type(prefab_name1) == "string" then
        prefab_name = prefab_name1
    elseif type(prefab_name2) == "string" then
        prefab_name = prefab_name2
    end            
    return strings[prefab_name] or {}
end

TUNING.FUNNY_CAT_GET_ALL_STRINGS = function()
    return strings
end