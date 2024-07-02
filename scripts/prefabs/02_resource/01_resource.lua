
local RESOURCE_TABLE = TUNING.FUNNY_CAT_RESOURCES

local function CreatePrefab(origin_prefab_name,data_table)
    local assets = {}
    data_table.origin_prefab = origin_prefab_name
    data_table.prefab = "fc_"..origin_prefab_name

    local fn = data_table.fn or function()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()        
        inst.entity:AddNetwork()

        if data_table.map then
            inst.entity:AddMiniMapEntity()
            inst.MiniMapEntity:SetIcon(data_table.map)
        end
        if data_table.build then
            inst.AnimState:SetBuild(data_table.build)
        end
        if data_table.bank then
            inst.AnimState:SetBank(data_table.bank)
        end
        if data_table.anim then
            inst.AnimState:PlayAnimation(data_table.anim,data_table.loop)
        end
        if data_table.light then
            inst.entity:AddLight()
        end
        if data_table.sound then
            inst.entity:AddSoundEmitter()
        end
        
        if data_table.before_Pristine_init then
            data_table.before_Pristine_init(inst)
        end

        inst.entity:SetPristine()

        if data_table.common_postinit then
            data_table.common_postinit(inst)
        end

        inst.data = data_table
        inst.origin_prefab = origin_prefab_name

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        if data_table.master_postinit then
            data_table.master_postinit(inst)
        end
        return inst
    end

    if data_table.create_postinit then
        pcall(data_table.create_postinit)
        -- data_table.create_postinit()
    end

    if data_table.assets then
        for _,temp_asset in pairs(data_table.assets) do
            table.insert(assets, temp_asset)
        end
    end

         
    STRINGS.NAMES[string.upper("fc_"..origin_prefab_name)] = STRINGS.NAMES[string.upper(origin_prefab_name)]
    STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper("fc_"..origin_prefab_name)] = STRINGS.CHARACTERS.GENERIC.DESCRIBE[string.upper(origin_prefab_name)]


        
    return Prefab("fc_"..origin_prefab_name,fn,assets)
end

local ret_prefabs = {}
for origin_prefab_name, data_table in pairs(RESOURCE_TABLE) do
    table.insert(ret_prefabs, CreatePrefab(origin_prefab_name,data_table))
end
return unpack(ret_prefabs)