local assets =
{
    Asset("ANIM", "anim/cane.zip"),
    Asset("ANIM", "anim/swap_cane.zip"),
}

local function Player_SetSkeletonDescription(inst, char, playername, cause, pkname, userid)
    inst.char = char
    inst.playername = playername
    inst.userid = userid
    inst.pkname = pkname
    inst.cause = pkname == nil and cause:lower() or nil


    print("info save_data",inst)
end

local function Player_SetSkeletonAvatarData(inst, client_obj)
    -- inst.components.playeravatardata:SetData(client_obj)

    local origin_player = nil
    for k, temp_player in pairs(AllPlayers) do
        if temp_player.userid == inst.userid then
            origin_player = temp_player
            break
        end
    end

    -----------------------------------------------------------------------------------------------------------------------------
    --- 原始的骷髅生成、并赋予数据
        local x,y,z = inst.Transform:GetWorldPosition()
        local ret_inst = SpawnPrefab("skeleton_player")
        ret_inst.Transform:SetPosition(x,y,z)
        ret_inst:SetSkeletonDescription(inst.char, inst.playername, inst.cause, inst.pkname, inst.userid)
        ret_inst:SetSkeletonAvatarData(client_obj)
    -----------------------------------------------------------------------------------------------------------------------------
    print("info spawn_skeleton",origin_player,inst)
    inst:Remove()

end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.AnimState:SetBank("cane")
    inst.AnimState:SetBuild("swap_cane")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")


    inst.SetSkeletonDescription = Player_SetSkeletonDescription
    inst.SetSkeletonAvatarData  = Player_SetSkeletonAvatarData

    return inst
end

return Prefab("funny_cat_other_skeleton", fn, assets)
