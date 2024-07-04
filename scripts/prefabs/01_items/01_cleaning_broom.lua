--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[



]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 参数表
    local SEARCHING_RADIUS = TUNING.FUNNY_CAT_CONFIG.CLEANING_BROOM_RANGE or 6
    local WALK_SPEED_MULT = TUNING.FUNNY_CAT_CONFIG.CLEANING_BROOM_RUN_SPEED_MULTIPLIER or 1
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----
    local assets =
    {
        -- Asset("ANIM", "anim/cane.zip"),
        -- Asset("ANIM", "anim/swap_cane.zip"),
    }

    local function onequip(inst, owner)
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("equipskinneditem", inst:GetSkinName())
            owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "swap_reskin_tool", inst.GUID, "swap_reskin_tool")
        else
            owner.AnimState:OverrideSymbol("swap_object", "swap_reskin_tool", "swap_reskin_tool")
        end
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")

        owner.components.locomotor:SetExternalSpeedMultiplier(inst,string.upper(inst.prefab),WALK_SPEED_MULT)
        
    end

    local function onunequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
        local skin_build = inst:GetSkinBuild()
        if skin_build ~= nil then
            owner:PushEvent("unequipskinneditem", inst:GetSkinName())
        end
        owner.components.locomotor:RemoveExternalSpeedMultiplier(inst,string.upper(inst.prefab))
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 安装右键交互
    local function righ_click_setup(inst)
        inst:ListenForEvent("OnEntityReplicated.funny_cat_com_workable",function(inst,replica_com)
            if replica_com then
                replica_com:SetTestFn(function(inst,doer,right_click)
                    if inst.replica.equippable:IsEquipped() then
                        return true
                    end
                    if right_click and not inst.replica.inventoryitem:IsGrandOwner(doer) then
                        return true
                    end
                    return false
                end)
                replica_com:SetText("funny_cat_item_cleaning_broom","切换皮肤")
            end
        end)
        if TheWorld.ismastersim then
            inst:AddComponent("funny_cat_com_workable")
            inst.components.funny_cat_com_workable:SetOnWorkFn(function(inst,doer)                
                print("funny_cat_com_workable",inst,doer)

                if TheWorld.RESKIN_TOOL == nil then
                    local temp_inst = SpawnPrefab("reskin_tool")
                    temp_inst.Physics:SetActive(false)
                    temp_inst.Transform:SetPosition(0,1000,0)
                    temp_inst:Hide()
                    TheWorld.RESKIN_TOOL = temp_inst
                end

                local reskin_tool = TheWorld.RESKIN_TOOL
                if reskin_tool.components.spellcaster:CanCast(doer,inst,nil) then
                    reskin_tool.parent = doer
                    reskin_tool.components.spellcaster:CastSpell(inst,nil,doer)                    
                    -- return true
                elseif inst.components.inventoryitem:GetGrandOwner() == doer then
                    doer.components.inventory:DropItem(inst)
                    pcall(function()                        
                        local spellCB = reskin_tool.components.spellcaster.spell
                        reskin_tool.parent = doer
                        spellCB(reskin_tool,inst,nil,doer)
                    end)
                    inst:DoTaskInTime(0.1,function()
                        doer.components.inventory:Equip(inst)
                    end)
                    -- return true
                end
                inst:DoTaskInTime(0.1,function()
                    if inst.components.inventoryitem.imagename == nil then
                        inst.components.inventoryitem:ChangeImageName("reskin_tool")                    
                    end
                end)
                return true
            end)
        end
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 圈圈施法
    local function spell_cast_com_setup(inst)
        inst:ListenForEvent("OnEntityReplicated.funny_cat_com_point_and_target_spell_caster",function(inst,replica_com)
            if replica_com then
                replica_com:SetDistance(SEARCHING_RADIUS*1.2)
                replica_com:SetText("funny_cat_item_cleaning_broom","")
                replica_com:SetTestFn(function(inst,doer,target,pt,right_click)
                    if not right_click then
                        return
                    end
                    if inst.fx == nil then
                        local fx = SpawnPrefab("funny_cat_sfx_dotted_circle_client")
                        inst.fx = fx
                        inst:ListenForEvent("onremove",function()
                            fx:Remove()
                        end)
                        fx:PushEvent("Set",{
                            range = SEARCHING_RADIUS,
                            color = Vector3(255,0,0),
                        })

                        fx:DoPeriodicTask(0.1,function()
                            if not inst.replica.equippable:IsEquipped() then
                                fx:Remove()
                                inst.fx = nil
                            end
                        end)
                    end
                    local ret_pt = Vector3(0,0,0)
                    if target then
                        ret_pt = Vector3(target.Transform:GetWorldPosition())
                    elseif type(pt) == "table" and pt.x then
                        ret_pt = pt
                    end

                    inst.fx.Transform:SetPosition(ret_pt.x,0,ret_pt.z)
                    return true
                end)
                replica_com:SetSGAction("veryquickcastspell")
                replica_com:SetAllowCanCastOnImpassable(true)
            end
        end)
        if TheWorld.ismastersim then
            local function SpawnFxInPoint(inst,pt)
                local fx_prefab = "explode_reskin"
                local skin_fx = SKIN_FX_PREFAB[inst:GetSkinName()]
                if skin_fx ~= nil and skin_fx[1] ~= nil then
                    fx_prefab = skin_fx[1]
                end
                local fx = SpawnPrefab(fx_prefab)
                if fx then
                    fx.Transform:SetPosition(pt.x,0,pt.z)                    
                end
            end
            inst:AddComponent("funny_cat_com_point_and_target_spell_caster")
            inst.components.funny_cat_com_point_and_target_spell_caster:SetSpellFn(function(inst,doer,target,pt)                
                -- print("funny_cat_item_cleaning_broom",target,pt)
                local ret_pt = Vector3(0,0,0)
                if target then
                    ret_pt = Vector3(target.Transform:GetWorldPosition())
                elseif type(pt) == "table" and pt.x then
                    ret_pt = pt
                end
                local ents = TheSim:FindEntities(ret_pt.x,0,ret_pt.z,SEARCHING_RADIUS,{"funny_cat_resource"})
                for k, v in pairs(ents) do
                    v:PushEvent("CleanByPlayer",doer)
                        -- SpawnFxInPoint(inst,Vector3(v.Transform:GetWorldPosition()))
                end
                SpawnFxInPoint(inst,ret_pt)
                return true
            end)
        end
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- mouse over event setup
    local function mouse_over_event_setup(inst)
        if TheNet:IsDedicated() then
            return
        end

        inst:ListenForEvent("ItemTileOnGainFocus",function()
            print("++++ info ItemTileOnGainFocus",inst)
        end)
        inst:ListenForEvent("ItemTileOnLoseFocus",function()
            print("++++ info ItemTileOnLoseFocus",inst)
        end)
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("reskin_tool")
        inst.AnimState:SetBuild("reskin_tool")
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("nopunch")
        inst:AddTag("veryquickcast")
        inst:AddTag("funny_cat_item_cleaning_broom")

        local swap_data = {sym_build = "swap_reskin_tool", bank = "reskin_tool"}
        MakeInventoryFloatable(inst, "med", 0.05, {1.0, 0.4, 1.0}, true, -20, swap_data)

        inst.entity:SetPristine()
        ---------------------------------------------------------------------------
        ----
            righ_click_setup(inst)
            spell_cast_com_setup(inst)
            mouse_over_event_setup(inst)
        ---------------------------------------------------------------------------
        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem:ChangeImageName("reskin_tool")

        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(onequip)
        inst.components.equippable:SetOnUnequip(onunequip)
        -- inst.components.equippable.walkspeedmult = WALK_SPEED_MULT


        MakeHauntableLaunchAndIgnite(inst)
        return inst
    end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
return Prefab("funny_cat_item_cleaning_broom", fn, assets)
