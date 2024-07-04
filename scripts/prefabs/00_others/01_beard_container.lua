----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local assets =
{
    Asset("ANIM", "anim/funny_cat_other_beard_container.zip"),
    -- Asset( "IMAGE", "images/inventoryimages/pvp_item_clockwork_box.tex" ),  -- 背包贴图
    -- Asset( "ATLAS", "images/inventoryimages/pvp_item_clockwork_box.xml" ),
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------
    local function item_test(item)
        return item:HasTag("pocketwatch")
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ 界面安装组件
    local function container_Widget_change(theContainer)
        -----------------------------------------------------------------------------------
        ----- 容器界面名 --- 要独特一点，避免冲突
        local container_widget_name = "funny_cat_other_beard_container"

        -----------------------------------------------------------------------------------
        ----- 检查和注册新的容器界面
        local all_container_widgets = require("containers")
        local params = all_container_widgets.params
        if params[container_widget_name] == nil then
            local offset_x = 2
            local offset_y = 8
            params[container_widget_name] = {
                widget =
                {
                    slotpos =
                    {
                        Vector3(-(64 + 12) + offset_x, 0 + offset_y, 0),
                        Vector3(0 + offset_x, 0 + offset_y, 0),
                        Vector3(64 + 12 + offset_x, 0 + offset_y, 0),
                    },
                    slotbg =
                    {
                        -- { image = "inv_slot_morsel.tex" },
                        -- { image = "inv_slot_morsel.tex" },
                        -- { image = "inv_slot_morsel.tex" },
                    },
                    animbank = "funny_cat_other_beard_container",
                    animbuild = "funny_cat_other_beard_container",
                    pos = Vector3(-82, 89, 0),
                    bottom_align_tip = -100,
                },
                type = "side_inv_behind",
                acceptsstacks = true,
                lowpriorityselection = true,
               -- excludefromcrafting = false,
            }
            ------------------------------------------------------------------------------------------
            ----
            ------------------------------------------------------------------------------------------
            ---- item test
                params[container_widget_name].itemtestfn =  function(container_com, item, slot)
                    -- if item and item.prefab then
                    --     return item_test(item)
                    -- end
                    -- return false
                    return true
                end
            ------------------------------------------------------------------------------------------
        end
        
        theContainer:WidgetSetup(container_widget_name)

        ------------------------------------------------------------------------
    end


    local function add_container_before_not_ismastersim_return(inst)
    -------------------------------------------------------------------------------------------------
    ------ 添加背包container组件    --- 必须在 SetPristine 之后，
    -- -- local container_WidgetSetup = "wobysmall"


        if TheWorld.ismastersim then

            inst:AddComponent("container")
            inst.components.container.openlimit = 1  ---- 限制1个人打开
            container_Widget_change(inst.components.container)    
            -- inst.components.container.canbeopened = false
            inst.components.container:EnableInfiniteStackSize(true)
            -- inst.components.container.stay_open_on_hide = true -- 保证睡觉的时候不隐藏UI
        else

            inst.OnEntityReplicated = function(inst)
                container_Widget_change(inst.replica.container)
            end

        end

    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- client side hud display

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    -- inst.AnimState:SetBank("pvp_item_clockwork_box")
    -- inst.AnimState:SetBuild("pvp_item_clockwork_box")
    -- inst.AnimState:PlayAnimation("idle")

    inst:AddTag("backpack")
    inst:AddTag("funny_cat_other_beard_container")

    local swap_data = {bank = "backpack1", anim = "anim"}
    MakeInventoryFloatable(inst, "small", 0.2, nil, nil, nil, swap_data)

    inst.entity:SetPristine()
    ------------------------------------------------------------------------------------------------------------
    ---
        add_container_before_not_ismastersim_return(inst)
    ------------------------------------------------------------------------------------------------------------

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:ChangeImageName("backpack")
    -- inst.components.inventoryitem.imagename = "pvp_item_clockwork_box"
    -- inst.components.inventoryitem.atlasname = "images/inventoryimages/pvp_item_clockwork_box.xml"
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.canonlygoinpocket = true --- 只能在角色栏，不能进容器。


    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BEARD
    inst.components.equippable:SetPreventUnequipping(true)
    -- inst.components.equippable.restrictedtag = "wanda"
    inst.components.equippable:SetOnEquip(function(inst,owner)
        inst.components.container:Open(owner)
    end)
    -- inst.components.equippable:SetOnUnequip(onunequip)

    MakeHauntableLaunch(inst)
    -- -------------------------------------------------------------------
    -- -- 
    --     inst:ListenForEvent("onputininventory", function()
    --         inst.components.container.canbeopened = true
    --     end)
    --     inst:ListenForEvent("ondropped", function()
    --         inst.components.container.canbeopened = false
    --         inst.components.container:Close()
    --     end)
    -- -------------------------------------------------------------------
    
    return inst
end

return Prefab("funny_cat_other_beard_container", fn, assets),
    Prefab("beard_sack_1", fn, assets),
    Prefab("beard_sack_2", fn, assets),
    Prefab("beard_sack_3", fn, assets)
