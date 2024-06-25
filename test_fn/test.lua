--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面调试
    local Widget = require "widgets/widget"
    local Image = require "widgets/image" -- 引入image控件
    local UIAnim = require "widgets/uianim"


    local Screen = require "widgets/screen"

    local AnimButton = require "widgets/animbutton"
    local ImageButton = require "widgets/imagebutton"
    local TextButton = require "widgets/textbutton"
    local UIAnimButton = require "widgets/uianimbutton"

    local Button = require "widgets/button"

    local Menu = require "widgets/menu"
    local Text = require "widgets/text"
    local TEMPLATES = require "widgets/redux/templates"

    local Badge = require "widgets/badge"
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local flg,error_code = pcall(function()
    print("WARNING:PCALL START +++++++++++++++++++++++++++++++++++++++++++++++++")
    local x,y,z =    ThePlayer.Transform:GetWorldPosition()  
    ----------------------------------------------------------------------------------------------------------------
    ----
        -- ThePlayer.components.funny_cat_com_safe_sys:PushEvent("RPC_PUSH_EVENT_CLIENT",{
        --     abs = 123,
        --     cc = "cc",
        -- })
        -- ThePlayer.replica.funny_cat_com_safe_sys.safe_lock = nil
        -- ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("RPC_PUSH_EVENT_SERVER",{
        --     abs = 123,
        --     cc = "cc",
        -- })

        -- ThePlayer.components.funny_cat_com_safe_sys:RunClientSideTestScript()

        -- local code = [[
        
        --     print("ABC CCCCCCC",ThePlayer)
        
        -- ]]


        -- local code = [[
        --     if ThePlayer.test_key_handler then
        --         ThePlayer.test_key_handler:Remove()
        --         ThePlayer.test_key_handler = nil
        --     end
        --     ThePlayer.test_key_handler = TheInput:AddKeyHandler(function(key,down)
        --         if down then
        --             print(key,CONTROL_OPEN_DEBUG_CONSOLE)
        --         end
        --     end)
        --     print("abcc+++++++++++")
        -- ]]
        -- local inst = ThePlayer

        -- local code1 = [[
        --     ----------------------------------------
        --     ---- 测试代码       单纯的print  
        --         print("66667777")  -- 测试代码      

                
        --     ----------------------------------------
        --     print(9966)  
        --     print("7777 code1")
        -- ]]
        -- local code2 = [[
        --     print("66667777 code2")
        --     print(995566)  --77
        -- ]]
        -- inst.components.funny_cat_com_safe_sys:RunClientSideScript(code1)
        -- inst:DoTaskInTime(1,function(inst)
        --     inst.components.funny_cat_com_safe_sys:RunClientSideScript(code2)
        -- end)

            -- CONSOLE_ENABLED = false     --- 控制台关闭。
       
        -- local code_in_client_side = [[
        --     if ThePlayer == nil then
        --         print("error ThePlayer == nil")
        --         return
        --     end
        --     ThePlayer:DoTaskInTime(0.5,function()
        --         ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("console_closed")                    
        --     end)
        --     print("+++++ info +++++++")
        -- ]]
        -- ThePlayer.components.funny_cat_com_safe_sys:RunClientSideScript(code_in_client_side)

        -- ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("console_closed")

    ----------------------------------------------------------------------------------------------------------------
    ---- MOD屏蔽
        local code = [[
        
            
            local white_list = {
                ["workshop-2896126381"] = true
            }
            local all_mods = KnownModIndex:GetClientModNamesTable() or {}

            local ClientSideMods = {}
            for _, _table in pairs(all_mods) do
                local modname = _table.modname
                if not white_list[modname] then
                    table.insert(ClientSideMods, modname)
                end
            end
            
            for _, mod_id in pairs(ClientSideMods) do
                local mod_info = KnownModIndex:GetModInfo(mod_id) or {}
                local mod_name = mod_info.name
                if ThePlayer then
                    ThePlayer:PushEvent("funny_cat_event.whisper",{
                        message = "检测到MOD: " .. mod_name .. ",你将不会被分配到任何队伍里",
                        m_colour = {255/255,0/255,0/255},
                    })
                end
            end
            ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("client_side_mod_checker_start",{
                safe_lock = {safe_lock},
                mod_num = #ClientSideMods,
            })

        ]]


        -- local white_list = {
        --     ["workshop-2896126381"] = true
        -- }
        -- local all_mods = KnownModIndex:GetClientModNamesTable() or {}

        -- local ClientSideMods = {}
        -- for _, _table in pairs(all_mods) do
        --     local modname = _table.modname
        --     if not white_list[modname] then
        --         table.insert(ClientSideMods, modname)
        --     end
        -- end
        
        -- for _, mod_id in pairs(ClientSideMods) do
        --     local mod_info = KnownModIndex:GetModInfo(mod_id) or {}
        --     local mod_name = mod_info.name
        --     if ThePlayer then
        --         ThePlayer:PushEvent("funny_cat_event.whisper",{
        --             message = "检测到MOD: " .. mod_name .. ",你将不会被分配到任何队伍里",
        --             m_colour = {255/255,0/255,0/255},
        --         })
        --     end
        -- end
    
        -- code = code:gsub("{mod_num}", tostring(safe_lock))

    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))