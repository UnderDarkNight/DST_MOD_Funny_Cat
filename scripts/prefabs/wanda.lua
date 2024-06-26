
local MakePlayerCharacter = require("prefabs/player_common")
local WandaAgeBadge = require("widgets/wandaagebadge")
local easing = require("easing")

local assets =
{
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ATLAS", "images/hud_wanda.xml"),
    Asset("IMAGE", "images/hud_wanda.tex"),

    Asset("ANIM", "anim/status_oldage.zip"),
    Asset("ANIM", "anim/wanda_basics.zip"),
    Asset("ANIM", "anim/wanda_mount_basics.zip"),
    Asset("ANIM", "anim/wanda_attack.zip"),
    Asset("ANIM", "anim/wanda_casting.zip"),
    Asset("ANIM", "anim/wanda_casting2.zip"),
    Asset("ANIM", "anim/wanda_mount_casting2.zip"),
    Asset("ANIM", "anim/player_idles_wanda.zip"),
}

local prefabs =
{
	"oldager_become_younger_front_fx",
	"oldager_become_younger_back_fx",
	"oldager_become_older_fx",
	"oldager_become_younger_front_fx_mount",
	"oldager_become_younger_back_fx_mount",
	"oldager_become_older_fx_mount",
    
	"wanda_attack_pocketwatch_old_fx",
	"wanda_attack_pocketwatch_normal_fx",
	"wanda_attack_shadowweapon_old_fx",
	"wanda_attack_shadowweapon_normal_fx",
}

local start_inv = {}
for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
    start_inv[string.lower(k)] = v.WANDA
end

prefabs = FlattenTree({ prefabs, start_inv }, true)

local function PlayAgingFx(inst, fx_name)
	if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
		fx_name = fx_name .. "_mount"
	end

	local fx = SpawnPrefab(fx_name)
	fx.entity:SetParent(inst.entity)
end

local function UpdateSkinMode(inst, mode, delay)
	if inst.updateskinmodetask ~= nil then
		inst.updateskinmodetask:Cancel()
		inst.updateskinmodetask = nil
	end

	if delay then
		if inst.queued_skinmode ~= nil then
		    inst.components.skinner:SetSkinMode(inst.queued_skinmode, "wilson")
		end
		inst.queued_skinmode = mode
		inst.updateskinmodetask = inst:DoTaskInTime(FRAMES * 15, UpdateSkinMode, mode)
	else
	    inst.components.skinner:SetSkinMode(mode, "wilson")
		inst.queued_skinmode = nil
	end
end

local function becomeold(inst, silent)
    if inst.age_state == "old" then
        return
    end

	inst.overrideskinmode = "old_skin"
	if not inst.sg:HasStateTag("ghostbuild") then
		UpdateSkinMode(inst, "old_skin", not silent)
	end

    if not silent then
        inst.sg:PushEvent("becomeolder_wanda")
        inst.components.talker:Say(GetString(inst, "ANNOUNCE_WANDA_NORMALTOOLD"))
        inst.SoundEmitter:PlaySound("wanda2/characters/wanda/older_transition")
		PlayAgingFx(inst, "oldager_become_older_fx")
    end


    inst.talksoundoverride = "wanda2/characters/wanda/talk_old_LP"
    --inst.hurtsoundoverride = "dontstarve/characters/wolfgang/hurt_small"
    inst.age_state = "old"

    inst:AddTag("slowbuilder")
	inst.components.inventory.noheavylifting = true
    inst.components.workmultiplier:AddMultiplier(ACTIONS.HAMMER, TUNING.WANDA_OLD_HAMMER_EFFECTIVENESS, inst)
end

local function becomenormal(inst, silent)
    if inst.age_state == "normal" then
        return
    end

	inst.overrideskinmode = "normal_skin"
	if not inst.sg:HasStateTag("ghostbuild") then
		UpdateSkinMode(inst, "normal_skin", not silent)
	end

    if not silent then
        if inst.age_state == "young" then
            inst.components.talker:Say(GetString(inst, "ANNOUNCE_WANDA_YOUNGTONORMAL"))
            inst.sg:PushEvent("becomeolder_wanda")
            inst.SoundEmitter:PlaySound("wanda2/characters/wanda/older_transition")
			PlayAgingFx(inst, "oldager_become_older_fx")
        elseif inst.age_state == "old" then
            inst.components.talker:Say(GetString(inst, "ANNOUNCE_WANDA_OLDTONORMAL"))
            inst.sg:PushEvent("becomeyounger_wanda")
            inst.SoundEmitter:PlaySound("wanda2/characters/wanda/younger_transition")
			PlayAgingFx(inst, "oldager_become_younger_front_fx")
			PlayAgingFx(inst, "oldager_become_younger_back_fx")
        end
    end


    inst.talksoundoverride = nil
    inst.hurtsoundoverride = nil
    inst.age_state = "normal"

    inst:RemoveTag("slowbuilder")
	inst.components.inventory.noheavylifting = false
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, inst)
end

local function becomeyoung(inst, silent)
    if inst.age_state == "young" then
        return
    end

	inst.overrideskinmode = "young_skin"
	if not inst.sg:HasStateTag("ghostbuild") then
		UpdateSkinMode(inst, "young_skin", not silent)
	end

    if not silent then
        inst.components.talker:Say(GetString(inst, "ANNOUNCE_WANDA_NORMALTOYOUNG"))
        inst.sg:PushEvent("becomeyounger_wanda")
        inst.SoundEmitter:PlaySound("wanda2/characters/wanda/younger_transition")
		PlayAgingFx(inst, "oldager_become_younger_front_fx")
		PlayAgingFx(inst, "oldager_become_younger_back_fx")
    end


    inst.talksoundoverride = "wanda2/characters/wanda/talk_young_LP"
    --inst.hurtsoundoverride = "dontstarve/characters/wolfgang/hurt_large"
    inst.age_state = "young"
    
    inst:RemoveTag("slowbuilder")
	inst.components.inventory.noheavylifting = false
    inst.components.workmultiplier:RemoveMultiplier(ACTIONS.HAMMER, inst)
end


local function onhealthchange(inst, data, forcesilent)
    if inst.sg:HasStateTag("nomorph") or
        inst:HasTag("playerghost") or
        inst.components.health:IsDead() then
        return
    end

    local silent = inst.sg:HasStateTag("silentmorph") or not inst.entity:IsVisible() or forcesilent
	local health = inst.components.health ~= nil and inst.components.health:GetPercent() or 0

    if inst.age_state == "old" then
        if health > TUNING.WANDA_AGE_THRESHOLD_OLD then
            if silent and health >= TUNING.WANDA_AGE_THRESHOLD_YOUNG then
                becomeyoung(inst, true)
            else
                becomenormal(inst, silent)
            end
        end
    elseif inst.age_state == "young" then
        if health < TUNING.WANDA_AGE_THRESHOLD_YOUNG then
            if silent and health <= TUNING.WANDA_AGE_THRESHOLD_OLD then
                becomeold(inst, true)
            else
                becomenormal(inst, silent)
            end
        end
    elseif health <= TUNING.WANDA_AGE_THRESHOLD_OLD then
        becomeold(inst, silent)
    elseif health >= TUNING.WANDA_AGE_THRESHOLD_YOUNG then
        becomeyoung(inst, silent)
    else
        becomenormal(inst, silent)
    end
end



--------------------------------------------------------------------------

local function onnewstate(inst)
    if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
        inst._wasnomorph = not inst._wasnomorph
        if not inst._wasnomorph then
            onhealthchange(inst)
        end
    end
end

local function onbecamehuman(inst, data, isloading)
	inst.age_state = nil
	onhealthchange(inst, nil, true)

    inst:ListenForEvent("healthdelta", onhealthchange)
    inst:ListenForEvent("newstate", onnewstate)
end

local function onbecameghost(inst, data)
	inst._wasnomorph = nil
    inst.talksoundoverride = nil
    inst.hurtsoundoverride = nil

	inst.age_state = "old"

    inst:RemoveEventCallback("healthdelta", onhealthchange)
    inst:RemoveEventCallback("newstate", onnewstate)

end

--------------------------------------------------------------------------



--------------------------------------------------------------------------


--------------------------------------------------------------------------

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    elseif inst:HasTag("corpse") then
        onbecameghost(inst, { corpse = true })
    else
        onbecamehuman(inst, nil, true)
    end
end

local function OnNewSpawn(inst)
	onload(inst)
end

--------------------------------------------------------------------------

local function common_postinit(inst)
	inst:AddTag("clockmaker")
	inst:AddTag("pocketwatchcaster")
	inst:AddTag("health_as_oldage")

    inst.AnimState:AddOverrideBuild("player_idles_wanda")
    inst.AnimState:AddOverrideBuild("wanda_basics")
    inst.AnimState:AddOverrideBuild("wanda_attack")

end

local function master_postinit(inst)
    inst.starting_inventory = nil

	inst.customidleanim = "idle_wanda"
    inst.talker_path_override = "wanda2/characters/"

	inst._no_healing = true
	inst.deathanimoverride = "death_wanda"

    inst.components.foodaffinity:AddPrefabAffinity("taffy", TUNING.AFFINITY_15_CALORIES_MED)

	inst.components.health:SetMaxHealth(100)	
	
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(100)


	-- inst.skeleton_prefab = nil


    inst.OnLoad = onload
    inst.OnNewSpawn = OnNewSpawn
    inst:ListenForEvent("ms_playerseamlessswaped", OnNewSpawn)
	
    --------------------------------------------------------------------------------------------------------
    -- 特效
        inst:DoTaskInTime(0,function()
            local fx = inst:SpawnChild("pocketwatch_fx_marker")
            -- local fx = inst:SpawnChild("funny_cat_sfx_arrow")
            fx:PushEvent("Set",{})
            fx:ListenForEvent("funny_cat_com_player_rotation",function()
                local current_rotation = inst:GetRotation()
                fx.Transform:SetRotation(-current_rotation)
                -- inst.components.funny_cat_com_player_rotation:Fx_Face_2_Target(fx,TheSim:FindFirstEntityWithTag("multiplayer_portal"))

            end,inst)
        end)
    --------------------------------------------------------------------------------------------------------
end

return MakePlayerCharacter("wanda", prefabs, assets, common_postinit, master_postinit)
