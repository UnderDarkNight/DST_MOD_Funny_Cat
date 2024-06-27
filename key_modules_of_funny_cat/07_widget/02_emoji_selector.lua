------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[


    表情包系统

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

    local GestureWheel = require "widgets/gesturewheel"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local SHOWIMAGE = true
    local SHOWTEXT = true
    local RIGHTSTICK = false
    local function add_emoji_widget(inst)

        local emoji_widget = nil
        inst:ListenForEvent("funny_cat_event.emoji_widget_switch",function()
            if emoji_widget then
                emoji_widget:Kill()
                emoji_widget = nil
                return
            end
            -- emoji_widget = ThePlayer.HUD.controls:AddChild(GestureWheel(emote_sets, SHOWIMAGE, SHOWTEXT, RIGHTSTICK))
        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local function Add_Key_Listener(inst)
        local key_listener = TheInput:AddKeyHandler(function(key,down)  ------ 30FPS 轮询，不要过于复杂
            if down == true and TUNING.FUNNY_CAT_FN:IsKeyPressed(TUNING.FUNNY_CAT_CONFIG.EMOJI_HOT_KEY,key) then
                print("6666666666666666666666666666666",math.random(1000))
                inst:PushEvent("funny_cat_event.emoji_widget_switch")
            end
        end)
        inst:ListenForEvent("onremove",function()
            key_listener:Remove()
        end)
    end
    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(1,function()
            if not (ThePlayer and ThePlayer.HUD and ThePlayer == inst ) then
                return
            end
            Add_Key_Listener(inst)
            add_emoji_widget(inst)
        end)
    end)