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

        -- local code = [[
        --     print("6666")
        -- ]]

        -- ThePlayer.components.funny_cat_com_safe_sys:RunClientSideScript(code)

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

        ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("console_closed")

    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))