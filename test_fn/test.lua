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

    local SkinsPuppet = require "widgets/skinspuppet"

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
        -- local code = [[
        
            
        --     local white_list = {
        --         ["workshop-2896126381"] = true
        --     }
        --     local all_mods = KnownModIndex:GetClientModNamesTable() or {}

        --     local ClientSideMods = {}
        --     for _, _table in pairs(all_mods) do
        --         local modname = _table.modname
        --         if not white_list[modname] then
        --             table.insert(ClientSideMods, modname)
        --         end
        --     end
            
        --     for _, mod_id in pairs(ClientSideMods) do
        --         local mod_info = KnownModIndex:GetModInfo(mod_id) or {}
        --         local mod_name = mod_info.name
        --         if ThePlayer then
        --             ThePlayer:PushEvent("funny_cat_event.whisper",{
        --                 message = "检测到MOD: " .. mod_name .. ",你将不会被分配到任何队伍里",
        --                 m_colour = {255/255,0/255,0/255},
        --             })
        --         end
        --     end
        --     ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("client_side_mod_checker_start",{
        --         safe_lock = {safe_lock},
        --         mod_num = #ClientSideMods,
        --     })

        -- ]]


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
    ---
        -- local ret_table = ModManager:GetEnabledModNames()
        -- for k, v in pairs(ret_table) do
        --     print(k,v)
        -- end
    ----------------------------------------------------------------------------------------------------------------
            -- local EMOTE = "carol"
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
            -- ThePlayer.___test_fn = function()
            --     local crash_flag,ret = pcall(function()
                    
                
            --         local front_root = ThePlayer.HUD.controls

            --         local root = front_root:AddChild(Widget())
            --         local main_scale_num = 0.7
            --         local text_color = {255/255,255/255,255/255,1}
            --         local frame_color = {102/255,51/255,0/255,255/255}
            --         ---------------------------------------------------------------------------------
            --         --- 测试用的
            --             -- root.inst:DoTaskInTime(5,function()
            --             --     root:Kill()
            --             -- end)
            --         ---------------------------------------------------------------------------------
            --         -------- 设置锚点
            --             root:SetHAnchor(0) -- 设置原点x坐标位置，0、1、2分别对应屏幕中、左、右
            --             root:SetVAnchor(0) -- 设置原点y坐标位置，0、1、2分别对应屏幕中、上、下
            --             root:SetPosition(0,0)
            --             root:MoveToBack()
            --             root:SetScaleMode(SCALEMODE_FIXEDSCREEN_NONDYNAMIC)   --- 缩放模式

            --         ---------------------------------------------------------------------------------
            --         ------
            --         ---------------------------------------------------------------------------------
            --         ------
            --             local button = root:AddChild(Button())
            --             button.bg = button:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
            --             button.puppetframe = button:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
            --             button.puppetframe:SetTint(unpack(frame_color))

            --         ---------------------------------------------------------------------------------
            --         --- 指示器
            --             local emotename = EMOTE or "dance"
            --             button.txtbg = button:AddChild(Image("images/widgets/gesture_bg.xml", "gesture_bg.tex"))
            --             button.txtbg:SetScale(.11*(emotename:len()+1),.5,0)
            --             button.txtbg:SetPosition(-.5,-28,0)
            --             button.txtbg:SetTint(unpack(frame_color))

            --             local text = button:AddChild(Text(NUMBERFONT, 28,nil,text_color))
            --             text:SetHAlign(ANCHOR_MIDDLE)
            --             text:SetPosition(3.5, -50, 0)
            --             text:SetScale(1,.78,1)
            --             text:SetString("/"..emotename)
            --         ---------------------------------------------------------------------------------
            --         --
            --             local prefab = ThePlayer.prefab
            --             local prefabname = nil
            --             if not table.contains(DST_CHARACTERLIST, prefab) and not table.contains(MODCHARACTERLIST, prefab) then
            --                 prefabname = "wilson"
            --             else
            --                 prefabname = prefab
            --             end                        
            --             button.puppet = button:AddChild(SkinsPuppet())
            --             button.puppet.animstate:SetBank("wilson")
            --             button.puppet.animstate:Hide("ARM_carry")
            --             local data = TheNet:GetClientTableForUser(ThePlayer.userid)
            --             button.puppet:SetSkins(
            --                 prefabname,
            --                 data.base_skin,
            --                 {	body = data.body_skin,
            --                     hand = data.hand_skin,
            --                     legs = data.legs_skin,
            --                     feet = data.feet_skin	},
            --                 true)

            --             -- print(button.puppet.animstate)
            --             if base_emote[emotename] then
            --                 base_emote[emotename](button.puppet,button.puppet.animstate)
            --             elseif other_emote[emotename] then
            --                 other_emote[emotename](button.puppet,button.puppet.animstate)
            --             end
            --         ---------------------------------------------------------------------------------

            --         return root
            --     end)
            --     if crash_flag then
            --         return ret
            --     else
            --         print(ret)
            --         return nil
            --     end
            -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local UserCommands = require("usercommands")
        -- UserCommands.RunUserCommand("sit", {}, ThePlayer, false)
    ----------------------------------------------------------------------------------------------------------------
    ----
        ThePlayer.___test_fn = function()
            local crash_flag,ret = pcall(function()
                
            
                local front_root = ThePlayer.HUD.controls

                local root = front_root:AddChild(Widget())
                local main_scale_num = 0.7
                local text_color = {255/255,255/255,255/255,1}
                local frame_color = {102/255,51/255,0/255,255/255}
                ---------------------------------------------------------------------------------
                --- 测试用的
                    -- root.inst:DoTaskInTime(5,function()
                    --     root:Kill()
                    -- end)
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
                ----
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
                            print("+++++++666666666",command)
                        end))
                        button:SetPosition(pt.x,pt.z)
                        current_num = current_num + 1
                    end
                ---------------------------------------------------------------------------------
                ----
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

                    local points_unlocked = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                        target = Vector3(0,0,0),
                        range = 280,
                        num = unlocked_emote_num,
                    })
                    local current_num = 1
                    for command, v in pairs(other_emote) do
                        local pt = points_unlocked[current_num]
                        local button = base_frame:AddChild(EmoteButton(command,function()
                            print("+++++++666666666",command)
                        end))
                        button:SetPosition(pt.x,pt.z)
                        local color = {204/255,102/255,0/255,1}
                        button:SetTint(unpack(color))
                        current_num = current_num + 1
                    end

                ---------------------------------------------------------------------------------

                return root
            end)
            if crash_flag then
                return ret
            else
                print(ret)
                return nil
            end
        end
    ----------------------------------------------------------------------------------------------------------------
    ---
    -- local num = 0
    -- for item_type, v in pairs(EMOTE_ITEMS) do
    --     print("item_type: ",item_type,v)
    --     num = num + 1
    -- end
    -- print("num: ",num)

        -- local num = 0
        -- for k, v in pairs(base_emote) do
        --     print(k)
        --     num = num + 1
        -- end
        -- print("num: ",num)
    ----------------------------------------------------------------------------------------------------------------

        -- local EmoteButton = require "widgets/emote_button"
        -- -- for k, v in pairs(EmoteButton) do
        -- --     print(k,v)
        -- -- end
        -- print(EmoteButton:GetData())
    ----------------------------------------------------------------------------------------------------------------
    ---
            -- for i = 1, 30, 1 do
            --     ThePlayer:DoTaskInTime(i,function(inst)
            --         SpawnPrefab("fc_stalagmite_tall").Transform:SetPosition(inst.Transform:GetWorldPosition())
            --     end)
            -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
                -- ThePlayer:DoTaskInTime(0.1,function()
                --     pcall(function()
                        
                --         -- local ent = TheInput:GetHUDEntityUnderMouse()
                --         -- print("ent: ",ent)

                --         -- for k, v in pairs(ent) do
                --         --     print(k,v)
                --         -- end
                --         -- print("parent",ent.parent)

                --         local ents = TheInput:GetAllEntitiesUnderMouse()
                --         for k, v in pairs(ents) do
                --             print(k,v)
                --         end

                --     end)
                -- end)
    ----------------------------------------------------------------------------------------------------------------
    -- ---
    

    --                 local code = [[

    --                     local function DoAddClassPostConstruct(classdef, postfn)
    --                         local constructor = classdef._ctor
    --                         classdef._ctor = function (self, ...)
    --                             constructor(self, ...)
    --                             postfn(self, ...)
    --                         end
    --                     end
                        
    --                     local function AddClassPostConstruct(package, postfn)
    --                         local classdef = require(package)
    --                         assert(type(classdef) == "table", "Class file path '"..package.."' doesn't seem to return a valid class.")
    --                         DoAddClassPostConstruct(classdef, postfn)
    --                     end
                    
    --                     AddClassPostConstruct("widgets/targetindicator", function(self)
    --                         local old_OnUpdate = self.OnUpdate
    --                         self.OnUpdate = function(self,...)
    --                             self:Kill()
    --                             print("+++ info remove targetindicator")
    --                             return
    --                             -- return old_OnUpdate(self,...)
    --                         end
    --                     end)
    --                     print("+++++ info ++++++++")
    --                 ]]
    --                 ThePlayer.components.funny_cat_com_safe_sys:RunClientSideScript(code)
    ----------------------------------------------------------------------------------------------------------------
    -- 
        -- local cmd_table = require "cd_key_creater/create_and_check_cdkey"
        -- print(cmd_table.create_cd_key())
    ----------------------------------------------------------------------------------------------------------------
    -- 
        -- ThePlayer.components.funny_cat_com_cross_archive_data:Set("cd_key","AAA6666")
        -- ThePlayer.components.funny_cat_com_cross_archive_data:Force_Client_Upload_Data()
        -- print( ThePlayer.components.funny_cat_com_cross_archive_data:Get("test") )
        -- local offset_x = 5
        -- local offset_y = 5
        -- local offset_z = 5
        -- SpawnPrefab("fc_marsh_tree").Transform:SetPosition(x+offset_x,0,z+offset_z)
        -- SpawnPrefab("fc_marsh_tree").Transform:SetPosition(x-offset_x,0,z+offset_z)
        -- SpawnPrefab("fc_marsh_tree").Transform:SetPosition(x+offset_x,0,z-offset_z)
        -- SpawnPrefab("fc_marsh_tree").Transform:SetPosition(x-offset_x,0,z-offset_z)

    ----------------------------------------------------------------------------------------------------------------
    -- 地图调试
        --- 洞穴里的虚空tile 为 1
        ---  201 ~ 247 都是海洋
        --- 浅海 tile  201
        --- 中海 tile  203
        --- 深海 tile  204
        --- 其他  205 
        -- for k, v in pairs(Ents) do
        --     print(k,v)
        -- end

        -- SpawnPrefab("map_room_desert"):PushEvent("Set",{
        --     pt = Vector3(x,y,z)
        -- })
        
        -- local ret = require("worldgen_main")
        -- print(funny_cat_SetTile)

        -- local temp_WorldSim = getmetatable(TheSim).__index
        -- for k, v in pairs(temp_WorldSim) do
        --     print(k,v)
        -- end

        -- local ret = require("wordsim_data")
        -- print(ret.GetWorldSim())
        -- TheSim:SetTile(1,1,1)
        -- print(WorldSimActual)

        -- local map_width,map_height = TheWorld.Map:GetSize()
        -- for x = 1, map_width, 1 do
        --     for y = 1, map_height, 1 do
        --         TheWorld.Map:SetTile(x,y,1)
        --     end
        -- end

        -- print(TheWorld.Map.__test_old)
        -- local UserCommands = require("usercommands")
        -- UserCommands.RunUserCommand("dance", {}, ThePlayer, false)
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- print(TheWorld.Map:GetTileAtPoint(x,y,z))

        -- local tile_x,tile_y = TheWorld.Map:GetTileXYAtPoint(x,y,z)
        -- TheWorld.Map:SetTile(tile_x,tile_y,12)

        -- for k, v in pairs(GetWorldTileMap()) do
        --     print(string.lower(k),v)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
            -- local door = TheSim:FindFirstEntityWithTag("multiplayer_portal")
            -- print(door.Transform:GetWorldPosition())
            -- ThePlayer.Transform:SetPosition(0,0,0)
    ----------------------------------------------------------------------------------------------------------------
    ---
                            


        -- local map_width = 300
        -- local map_height = 300
    
        -- local function CreateMapTileData()
        --         ---------------------------------------------------------
        --         --- 基础初始化
        --             local tile_data = {}
        --             for y = 1,map_width, 1 do
        --                 for x = 1, map_height, 1 do
        --                     tile_data[y] = tile_data[y] or {}
        --                     tile_data[y][x] = 0
        --                 end
        --             end
                    
        --             ------------------------------ 20x20分一个区块
        --             local block_size = 20
        --             local block_num = math.ceil(map_width/block_size)
        --             local block_index = 1
        --             for block_y = 1, block_num, 1 do
        --                 for block_x = 1, block_num, 1 do
        --                     local start_x = (block_x - 1) * block_size + 1
        --                     local start_y = (block_y - 1) * block_size + 1
        --                     for temp_y = start_y, math.min(start_y + block_size - 1, map_height), 1 do
        --                         for temp_x = start_x, math.min(start_x + block_size - 1, map_width), 1 do
        --                             tile_data[temp_y][temp_x] = "block_"..string.format("%03d",block_index)
        --                         end
        --                     end
        --                     block_index = block_index + 1
        --                 end
        --             end
        --         ---------------------------------------------------------
        --         --- 切换成地皮
        --             local target_tiles = { 
        --                 4, -- 沙漠
        --                 43, -- 月岛
        --                 5, -- 草原
        --                 3,  -- 矿区
        --                 6, -- 草地
        --                 8, -- 沼泽
        --                 17, -- 泥泞
        --                 7, -- 森林
        --                 30, -- 桦树林
        --                 25, -- 蘑菇森林
        --                 -- 7, -- 坟地
        --                 -- 6, -- 池塘区
        --             }
        --             local block_switch_table = {}
        --             for i = 1, block_index, 1 do
        --                 block_switch_table["block_"..string.format("%03d",i)] = target_tiles[math.random(#target_tiles)]
        --             end
                    
        --             for y = 1,map_height, 1 do
        --                 for x = 1, map_width , 1 do
        --                     tile_data[y][x] = block_switch_table[tile_data[y][x]]
        --                 end
        --             end
        --         ---------------------------------------------------------
        --         -- ---- 中间区块
        --                 local mid_block_data = {
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        --                     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        --                 }
        --                 local mid_block = {}
        --                 local temp_num = 1
        --                 for y = 1, block_size, 1 do
        --                     mid_block[y] = {}
        --                     for x = 1,block_size ,1 do
        --                         mid_block[y][x] = mid_block_data[temp_num]
        --                         temp_num = temp_num + 1
        --                     end
        --                 end
        --         -------------------------------------------------------
        --         --- 把mid_block 插入到 tile_data 最中间的位置
        --             local start_x = math.floor((map_width - block_size)/2)
        --             local start_y = math.floor((map_height - block_size)/2)
        --             for temp_y = start_y, start_y + block_size - 1, 1 do
        --                 for temp_x = start_x, start_x + block_size - 1, 1 do
        --                     tile_data[temp_y][temp_x] = mid_block[temp_y - start_y + 1][temp_x - start_x + 1]                            
        --                 end                        
        --             end
        --         -------------------------------------------------------
        --         -- -- 使用io.open写入到output_map.lua文件
        --         --     local output_width = map_width
        --         --     local output_height = map_height
        --         --     -- local output_width = block_size
        --         --     -- local output_height = block_size
        --         --     local output_file = io.open("output_map.lua", "w")
        --         --     if output_file then
        --         --         output_file:write("return {\n")
        --         --         for y = 1, output_height, 1 do
        --         --             for x = 1, output_width, 1 do -- 修正了循环变量上限应该是map_width
        --         --                 output_file:write(string.format("%s ", tile_data[y][x])..",")
        --         --             end
        --         --             output_file:write("\n") -- 换行
        --         --         end
        --         --         output_file:write("}\n")
        --         --         output_file:close()
        --         --         print("Map data has been written to output_map.lua.")
        --         --     else
        --         --         print("Failed to open file for writing.")
        --         --     end
        --         -------------------------------------------------------
        --         --- 转换成一维数组
        --             local tile_data_1d = {}
        --             local temp_num = 1
        --             for y = 1, map_height, 1 do
        --                 for x = 1, map_width, 1 do
        --                     tile_data_1d[temp_num] = tile_data[y][x]
        --                     temp_num = temp_num + 1
        --                 end
        --             end
        --         -------------------------------------------------------
        --         return tile_data_1d
        -- end
        
        -- CreateMapTileData()
    ----------------------------------------------------------------------------------------------------------------
    --- 

            -- SpawnPrefab("fc_marbletree"):PushEvent("Set",{
            --     pt = Vector3(x,y,z),
            --     type = math.random(4)
            -- })
            -- SpawnPrefab("fc_marbleshrub"):PushEvent("Set",{
            --     pt = Vector3(x+5,y,z),
            --     -- type = math.random(4)
            -- })
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local hats = {
        --     "straw","top","beefalo","feather","bee","miner","spider","football",
        --     "earmuffs","winter","bush","flower","walrus","slurtle","ruins","mole",
        --     "wathgrithr","wathgrithr_improved","walter","ice","rain","catcoon","watermelon",
        --     "eyebrella","red_mushroom","green_mushroom","blue_mushroom","hive","dragonhead",
        --     "dragonbody","dragontail","desert","goggles","moonstorm_goggles","skeleton",
        --     "kelp","merm","cookiecutter","batnose","nutrientsgoggles","plantregistry",
        --     "balloon","alterguardian","eyemask","antlion","mask_doll","mask_dollbroken",
        --     "mask_dollrepaired","mask_blacksmith","mask_mirror","mask_queen","mask_king","mask_tree",
        --     "mask_fool","monkey_medium","monkey_small","polly_rogers","nightcap","woodcarved","dreadstone",
        --     "lunarplant","voidcloth","wagpunk","moon_mushroom","scrap_monocle","scrap",
        -- }
        -- print("+++ max hats",#hats)
        -- for i = 1, #hats, 1 do
        --     ThePlayer:DoTaskInTime(i,function(inst)
        --         local prefab = "fc_"..hats[i].."hat"
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local dumbbells = {"dumbbell","dumbbell_golden","dumbbell_marble","dumbbell_gem","dumbbell_heat","dumbbell_redgem","dumbbell_bluegem"}
            
        -- -- print("+++ max hats",#hats)
        -- for i = 1, #dumbbells, 1 do
        --     ThePlayer:DoTaskInTime(i,function(inst)
        --         local prefab = "fc_"..dumbbells[i]
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ----
        -- local pillow_materials = {"petals","kelp","beefalowool","steelwool"}
        -- local ret_prefab = {}
        -- for k, temp in pairs(pillow_materials) do
        --     table.insert(ret_prefab, "fc_handpillow_"..temp)
        --     table.insert(ret_prefab, "fc_bodypillow_"..temp)
        -- end
        -- for i = 1, #ret_prefab, 1 do
        --     ThePlayer:DoTaskInTime(i,function(inst)
        --         local prefab = ret_prefab[i]
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local FLOATER_PROPERTIES =
        -- {
        --     ["purple"]  = {0.10, 0.80},
        --     ["blue"]    = {0.10, 0.80},
        --     ["red"]     = {0.10, 0.80},
        --     ["orange"]  = {0.10, 0.82},
        --     ["yellow"]  = {0.10, 0.85},
        --     ["green"]   = {0.05, 0.75},
        --     ["opal"]    = {0.10, 0.87},
        -- }
        -- local ret_prefab = {}
        -- for colour, v in pairs(FLOATER_PROPERTIES) do
        --     table.insert(ret_prefab, "fc_"..colour.."gem")
        -- end
        -- for i = 1, #ret_prefab, 1 do
        --     ThePlayer:DoTaskInTime(i,function(inst)
        --         local prefab = ret_prefab[i]
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())                
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local staffs_with_color = {
        --     ["icestaff"] = "blue",
        --     ["firestaff"] = "red",
        --     ["telestaff"] = "purple",
        --     ["orangestaff"] = "orange",
        --     ["greenstaff"] = "green",
        --     ["yellowstaff"] = "yellow",
        --     ["opalstaff"] = "opal",
        -- }
        -- local ret_prefab = {}
        -- for prefab, v in pairs(staffs_with_color) do
        --     table.insert(ret_prefab, "fc_"..prefab)
        -- end
        -- for i = 1, #ret_prefab, 1 do
        --     ThePlayer:DoTaskInTime(i,function(inst)
        --         local prefab = ret_prefab[i]
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())                
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ---
        -- local amulets_data = {
        --     ["amulet"] = "redamulet",
        --     ["blueamulet"] = "blueamulet",
        --     ["purpleamulet"] = "purpleamulet",
        --     ["orangeamulet"] = "orangeamulet",
        --     ["greenamulet"] = "greenamulet",
        --     ["yellowamulet"] = "yellowamulet",
        -- }
        -- local ret_prefab = {}
        -- for prefab, v in pairs(amulets_data) do
        --     table.insert(ret_prefab, "fc_"..prefab)
        -- end
        -- for i = 1, #ret_prefab, 1 do
        --     ThePlayer:DoTaskInTime(i,function(inst)
        --         local prefab = ret_prefab[i]
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())                
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    --- 雕像调试
        -- local origin_prefabs = TUNING.FUNNY_CAT_CHESSPIECES_RESOURCES

        -- local ret_prefab = {}
        -- for k, temp_prefab in pairs(origin_prefabs) do
        --     -- print(k,v)
        --     table.insert(ret_prefab,"fc_"..temp_prefab)
        -- end
        -- for i = 1, #ret_prefab, 1 do
        --     ThePlayer:DoTaskInTime(i*0.5,function(inst)
        --         local prefab = ret_prefab[i]
        --         print("++++ ",i,prefab)
        --         SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())                
        --     end)
        -- end
    ----------------------------------------------------------------------------------------------------------------
    --- 鱼类调试
        local ret_prefab = {}
        
        local all_fish_data = require("prefabs/oceanfishdef").fish
        for origin_fish_name, fish_def in pairs(all_fish_data) do
            table.insert(ret_prefab,"fc_"..origin_fish_name.."_inv")    
        end

        for i = 1, #ret_prefab, 1 do
            ThePlayer:DoTaskInTime(i*0.5,function(inst)
                local prefab = ret_prefab[i]
                print("++++ ",i,prefab)
                SpawnPrefab(prefab).Transform:SetPosition(inst.Transform:GetWorldPosition())                
            end)
        end
    ----------------------------------------------------------------------------------------------------------------
    --- 
            -- ThePlayer.Transform:SetPosition(x,0,z)


            -- local inst = SpawnPrefab("fc_researchlab")
            -- inst.Transform:SetPosition(x,y,z)
            -- print("check 1",inst.components.playerprox:IsPlayerClose())
            -- ThePlayer.Transform:SetPosition(x,1000,z)
            -- print("check 2",inst.components.playerprox:IsPlayerClose())

            -- if ThePlayer.__test_inst == nil then
            --     ThePlayer.__test_inst = SpawnPrefab("fc_researchlab")
            --     ThePlayer.__test_inst.Transform:SetPosition(x,y,z)                
            -- end
            -- TheCamera:SetTarget(ThePlayer.__test_inst)
            -- ThePlayer.Transform:SetPosition(x,1000,z)
            -- TheCamera:SetTarget(ThePlayer)
            -- ThePlayer.Transform:SetPosition(x,0,z)

    ----------------------------------------------------------------------------------------------------------------
    ---
        -- for tempInst, v in pairs(TheWorld.MAP_ROOM_INDICATORS) do
        --     print("++++ ",tempInst,v)
        --     if tempInst and v == "tag_1" then
        --         ThePlayer.Transform:SetPosition(tempInst.Transform:GetWorldPosition())
        --         break
        --     end
        -- end
    ----------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------
    print("WARNING:PCALL END   +++++++++++++++++++++++++++++++++++++++++++++++++")
end)

if flg == false then
    print("Error : ",error_code)
end

-- dofile(resolvefilepath("test_fn/test.lua"))