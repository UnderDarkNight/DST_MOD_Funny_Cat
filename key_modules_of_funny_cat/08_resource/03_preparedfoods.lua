

TUNING.FUNNY_CAT_RESOURCES = TUNING.FUNNY_CAT_RESOURCES or {}
local temp_table = {
    --------------------------------------------------------------------
    --- 基础示例
        -- ["test"] = {
        --     bank = "funny_cat",
        --     build = "funny_cat",
        --     anim = "funny_cat",
        --     icon_data = {

        --     },
        --     map = "pighouse.png",
        --     common_postinit = function(inst)
                
        --     end,
        --     master_postinit = function(inst)
                
        --     end,
        --     create_postinit = function() --- 在创建时执行，通常进行文本设置
        --         -- STRINGS.NAMES[string.upper("fc_"..origin_prefab_name)] = STRINGS.NAMES[string.upper(origin_prefab_name)]
        --         -- STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper("fc_"..origin_prefab_name)] = STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(origin_prefab_name)]
                
        --     end
        -- },
    -- --------------------------------------------------------------------
    -- --- 骷髅、前辈
    --     ["skeleton"] = {
    --         bank = "skeleton",
    --         build = "skeletons",
    --         -- anim = "idle",
    --         loop = true,
    --         icon_data = {

    --         },
    --         map = "cactus.png",
    --         common_postinit = function(inst)
    --             MakeSmallObstaclePhysics(inst, 0.25)
    --         end,
    --         master_postinit = function(inst)
    --             inst.AnimState:PlayAnimation("idle"..tostring(math.random(6)))
    --         end,
    --     },
    -- --------------------------------------------------------------------

        
    --------------------------------------------------------------------
}


TUNING.FUNNY_CAT_FOOD_PREFAB_RESOURCES = {}
----------------------------------------------------------------------------------------------------------------
---
    local foods = require("preparedfoods")
    for prefab, data in pairs(foods) do
        local ret_table  = {
            -- bank = "cook_pot_food",
            -- build = data.overridebuild or "cook_pot_food",
            -- idle = "idle",
            icon_data = {

            },
            common_postinit = function(inst)
                inst.AnimState:SetBuild(data.overridebuild or "cook_pot_food")
                inst.AnimState:SetBank("cook_pot_food")
                inst.AnimState:PlayAnimation("idle")
                inst.AnimState:OverrideSymbol("swap_food", data.overridebuild or "cook_pot_food", data.basename or data.name)
                if data.floater ~= nil then
                    MakeInventoryFloatable(inst, data.floater[1], data.floater[2], data.floater[3])
                else
                    MakeInventoryFloatable(inst)
                end
                if data.basename ~= nil then
                    inst:SetPrefabNameOverride(data.basename)
                end
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if inst.components.floater ~= nil and TheWorld.Map:IsOceanTileAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    end
                end)
            end,
        }
        temp_table[prefab] = ret_table
        table.insert(TUNING.FUNNY_CAT_FOOD_PREFAB_RESOURCES,"fc_"..prefab)
    end
----------------------------------------------------------------------------------------------------------------




for k, v in pairs(temp_table) do
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end