----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    胡子容器

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 威尔逊 胡子容器 的test 函数
    local all_container_widgets = require("containers")
    local params = all_container_widgets.params
    params.beard_sack_3.itemtestfn = function()
        return true
    end
    params.beard_sack_3.widget.slotbg = {}
    params.beard_sack_3.widget.animbank = "funny_cat_other_beard_container"
    params.beard_sack_3.widget.animbuild = "funny_cat_other_beard_container"
    -- {
    --                                         { image = "inv_slot_morsel.tex" },
    --                                         { image = "inv_slot_morsel.tex" },
    --                                         { image = "inv_slot_morsel.tex" },
    --                                      },
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local death_and_respawn_from_ghost_event_setup = function(inst,beard_inst)
        -------------------------------------------------------------------------------------
        --
            local function setup_event(the_beard_inst)
                -------------------------------------------------------------
                --- 死亡掉落
                    the_beard_inst:ListenForEvent("death",function()
                        the_beard_inst.components.container:DropEverything()
                        the_beard_inst:Remove()
                    end,inst)
                -------------------------------------------------------------
                --- 意外掉落则删除
                    the_beard_inst:ListenForEvent("ondropped",function()
                        the_beard_inst.components.container:DropEverything()
                        the_beard_inst:Remove()
                    end)
                -------------------------------------------------------------
            end
        -------------------------------------------------------------------------------------
        -- 记录
            inst.beard_container_prefab = beard_inst.prefab
        -------------------------------------------------------------------------------------
            setup_event(beard_inst)
        -------------------------------------------------------------------------------------
        -- 周期性检查
            inst:DoPeriodicTask(3,function()
                if inst:HasTag("playerghost") then
                    return
                end
                local temp_inst = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
                if temp_inst == nil then
                    temp_inst = SpawnPrefab(inst.beard_container_prefab)
                    inst.components.inventory:Equip(temp_inst)
                    setup_event(temp_inst)
                end
            end)
        -------------------------------------------------------------------------------------
    end
    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(0,function()
            if inst.prefab == "wilson" then
                local beard_callbacks = inst.components.beard.callbacks
                local ret_beard_fn = nil
                for i = 1, 20, 1 do
                    if beard_callbacks[i] then
                        ret_beard_fn = beard_callbacks[i]
                    end
                end
                if ret_beard_fn then
                    ret_beard_fn(inst,inst.components.beard.skinname)
                end
                inst.components.beard.daysgrowth = 30
                local beard_container = nil
                if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD) == nil then
                    beard_container = SpawnPrefab("beard_sack_3")
                    inst.components.inventory:Equip(beard_container)
                else
                    beard_container = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
                end
                death_and_respawn_from_ghost_event_setup(inst,beard_container)

                inst:ListenForEvent("respawnfromghost",function()
                    inst:DoTaskInTime(2,function()                        
                        if ret_beard_fn then
                            ret_beard_fn(inst,inst.components.beard.skinname)
                        end
                        inst.components.beard.daysgrowth = 30
                    end)
                end)

            else
            
                
                local beard_container = nil
                if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD) == nil then
                    beard_container = SpawnPrefab("funny_cat_other_beard_container")
                    inst.components.inventory:Equip(beard_container)
                else
                    beard_container = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.BEARD)
                end
                death_and_respawn_from_ghost_event_setup(inst,beard_container)

            end
        end)
    end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 添加键盘监听
    local function Add_Key_Listener(inst)
        local key_listener = TheInput:AddKeyHandler(function(key,down)  ------ 30FPS 轮询，不要过于复杂

            if down and not ThePlayer:HasTag("playerghost") then            

                if TUNING.FUNNY_CAT_FN:IsKeyPressed(TUNING.FUNNY_CAT_CONFIG.CARD_HOT_KEY_1,key) then
                    inst.replica.funny_cat_com_safe_sys:PushEvent("card_slot_hot_key_press_client",1)
                elseif TUNING.FUNNY_CAT_FN:IsKeyPressed(TUNING.FUNNY_CAT_CONFIG.CARD_HOT_KEY_2,key) then
                    inst.replica.funny_cat_com_safe_sys:PushEvent("card_slot_hot_key_press_client",2)
                elseif TUNING.FUNNY_CAT_FN:IsKeyPressed(TUNING.FUNNY_CAT_CONFIG.CARD_HOT_KEY_3,key) then
                    inst.replica.funny_cat_com_safe_sys:PushEvent("card_slot_hot_key_press_client",3)                    
                end

            end
        end)
        inst:ListenForEvent("onremove",function()
            key_listener:Remove()
        end)
    end
    AddPlayerPostInit(function(inst)
        inst:DoTaskInTime(1,function()
            if inst == ThePlayer and inst.HUD then
                Add_Key_Listener(inst)

                inst:ListenForEvent("card_slot_hot_key_press_fail_sound",function()
                    TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/click_negative", nil, .4)
                end)

            end
        end)

        if not TheWorld.ismastersim then
            return
        end

        local cd_task = nil
        inst:ListenForEvent("card_slot_hot_key_press_client",function(inst,slot_num)
            if cd_task then
                inst.components.funny_cat_com_safe_sys:PushEvent("card_slot_hot_key_press_fail_sound")
                inst.components.funny_cat_com_safe_sys:PushEvent("funny_cat_event.whisper",{
                    m_colour = {255/255,255/255,255/255},
                    message = "请不要过快连续使用卡槽快捷键",
                    icondata = "profileflair_treasurechest_monster",
                })
                return
            end

            cd_task = inst:DoTaskInTime(3,function()
                cd_task = nil
            end)
            print("+++ card_slot_hot_key_press",slot_num)
            inst:PushEvent("card_slot_hot_key_press",slot_num)
            inst.components.funny_cat_com_safe_sys:PushEvent("funny_cat_event.whisper",{
                m_colour = {0/255,255/255,0/255},
                message = "激活卡槽 "..tostring(slot_num),
                icondata = "profileflair_treasurechest_monster",
            })
        end)


    end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
