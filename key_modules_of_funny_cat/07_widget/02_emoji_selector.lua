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


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local EmoteButton = require "widgets/emote_button"
    local base_emote,other_emote = EmoteButton:GetData()
    local UserCommands = require("usercommands")
        -- UserCommands.RunUserCommand("sit", {}, ThePlayer, false)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 参数表
    -- local base_emote = {
    --     ["rude"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_waving4",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["annoyed"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_annoyed",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["sad"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_sad",true)
    --         root:SetPosition(0,-28,0)
    --         local fx = root:AddChild(UIAnim())
    --         fx:GetAnimState():SetBank("tears_fx")
    --         fx:GetAnimState():SetBuild("tears")
    --         fx:GetAnimState():PlayAnimation("tears_fx",true)
    --         fx:SetScale(0.2)
    --         fx:SetPosition(0,80,0)
    --     end,
    --     ["joy"] = function(root,AnimState)
    --         AnimState:PlayAnimation("research",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["facepalm"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_facepalm",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["wave"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_waving1")
    --         AnimState:PushAnimation("emoteXL_waving2")
    --         AnimState:PushAnimation("emoteXL_waving3",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["dance"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_pre_dance0")
    --         AnimState:PushAnimation("emoteXL_loop_dance0",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["pose"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_strikepose",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["kiss"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_kiss",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["bonesaw"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_bonesaw",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["happy"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_happycheer",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["angry"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_angry",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["sit"] = function(root,AnimState)
    --         if math.random() < 0.5 then
    --             AnimState:PlayAnimation("emote_pre_sit2",false)
    --             AnimState:PushAnimation("emote_loop_sit2",true)
    --         else
    --             AnimState:PlayAnimation("emote_pre_sit4",false)
    --             AnimState:PushAnimation("emote_loop_sit4",true)
    --         end
    --         root:SetPosition(0,-25,0)
    --     end,
    --     ["squat"] = function(root,AnimState)
    --         if math.random() < 0.5 then
    --             AnimState:PlayAnimation("emote_pre_sit1",false)
    --             AnimState:PushAnimation("emote_loop_sit1",true)
    --         else
    --             AnimState:PlayAnimation("emote_pre_sit3",false)
    --             AnimState:PushAnimation("emote_loop_sit3",true)
    --         end
    --         root:SetPosition(0,-25,0)
    --     end,
    --     ["toast"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_pre_toast",false)
    --         AnimState:PushAnimation("emote_loop_toast",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    -- }
    -- local other_emote = {
    --     ["sleepy"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_sleepy",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["yawn"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_yawn",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["swoon"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_swoon",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["chicken"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_loop_dance6",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["robot"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_loop_dance8",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["step"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emoteXL_loop_dance7",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["fistshake"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_fistshake",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["flex"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_flex",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["impatient"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_impatient",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["cheer"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_jumpcheer",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["laugh"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_laugh",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["shrug"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_shrug",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["slowclap"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_slowclap",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    --     ["carol"] = function(root,AnimState)
    --         AnimState:PlayAnimation("emote_loop_carol",true)
    --         root:SetPosition(0,-28,0)
    --     end,
    -- }
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local function button_click(inst,emoji_cmd)
        inst.replica.funny_cat_com_safe_sys:PushEvent("funny_cat_event.emoji",emoji_cmd)
    end
    local function add_emoji_widget(inst)

        local emoji_widget = nil
        inst:ListenForEvent("funny_cat_event.emoji_widget_switch",function()
            if emoji_widget then
                emoji_widget:Kill()
                emoji_widget = nil
                return
            end

            local front_root =  ThePlayer.HUD.controls
            ------------------------------------------------------------------------------------------------------------------------------
            --- 创建一个emoji_widget
                local root = front_root:AddChild(Widget())
                local main_scale_num = 0.7
                local text_color = {255/255,255/255,255/255,1}
                local frame_color = {102/255,51/255,0/255,255/255}
            ---------------------------------------------------------------------------------
            --- 测试用的

            ---------------------------------------------------------------------------------
            -------- 设置锚点
                root:SetHAnchor(0) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
                root:SetVAnchor(0) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
                root:SetPosition(0,0)
                root:MoveToBack()
                root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式
            ---------------------------------------------------------------------------------
            ---- 窗口
                local base_frame = root:AddChild(Widget())
                base_frame:SetScale(main_scale_num,main_scale_num,main_scale_num)
            ---------------------------------------------------------------------------------
            ---- 外圈基础的表情
                local base_num = 0
                for k, v in pairs(base_emote) do
                    base_num = base_num + 1
                end
                local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                    target = Vector3(0,0,0),
                    range = 400,
                    num = base_num,
                })
                local current_num = 1
                for command, v in pairs(base_emote) do
                    local pt = points[current_num]
                    local button = base_frame:AddChild(EmoteButton(command,function()
                        -- print("+++++++666666666",command)
                        button_click(ThePlayer,command)
                        root:Kill()
                        emoji_widget = nil
                    end))
                    button:SetPosition(pt.x,pt.z)
                    current_num = current_num + 1
                end
            ---------------------------------------------------------------------------------
            ---- 内圈需要解锁的表情
                local check_unlocked_emote = function(item_type)                        
                    return ThePlayer.userid == TheNet:GetUserID() and TheInventory:CheckOwnership(item_type)                        
                end
                local unlocked_emote_num = 0
                local unlocked_commands = {}
                for item_type, cmd_table in pairs(EMOTE_ITEMS) do
                    if check_unlocked_emote(item_type) then
                        unlocked_emote_num = unlocked_emote_num + 1
                        table.insert(unlocked_commands,cmd_table.cmd_name)
                    end
                end
                if unlocked_emote_num > 0 then
                    local points_unlocked = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                        target = Vector3(0,0,0),
                        range = 280,
                        num = unlocked_emote_num,
                    })
                    local current_num = 1
                    for command, v in pairs(other_emote) do
                        local pt = points_unlocked[current_num]
                        local button = base_frame:AddChild(EmoteButton(command,function()
                            -- print("+++++++666666666",command)
                            button_click(ThePlayer,command)
                            root:Kill()
                            emoji_widget = nil
                        end))
                        button:SetPosition(pt.x,pt.z)
                        local color = {204/255,102/255,0/255,1}
                        button:SetTint(unpack(color))
                        current_num = current_num + 1
                    end
                end
            ---------------------------------------------------------------------------------
            emoji_widget = root

            ------------------------------------------------------------------------------------------------------------------------------
        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 
    local function add_emoji_event_listener(inst)
        inst:ListenForEvent("funny_cat_event.emoji",function(inst,emoji_cmd)
            if base_emote[emoji_cmd] or other_emote[emoji_cmd] then
                UserCommands.RunUserCommand(emoji_cmd or "sit", {}, inst, false)
            end
        end)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local function Add_Key_Listener(inst)
        local key_listener = TheInput:AddKeyHandler(function(key,down)  ------ 30FPS 轮询，不要过于复杂
            if down == true and TUNING.FUNNY_CAT_FN:IsKeyPressed(TUNING.FUNNY_CAT_CONFIG.EMOJI_HOT_KEY,key) then
                -- print("6666666666666666666666666666666",math.random(1000))
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

        if not TheWorld.ismastersim then
            return
        end
        add_emoji_event_listener(inst)
    end)