
local PIECES =
{
    {name="pawn",			moonevent=false,    gymweight=3},
    {name="rook",			moonevent=true,     gymweight=3},
    {name="knight",			moonevent=true,     gymweight=3},
    {name="bishop",			moonevent=true,     gymweight=3},
    {name="muse",			moonevent=false,    gymweight=3},
    {name="formal",			moonevent=false,    gymweight=3},
    {name="hornucopia",		moonevent=false,    gymweight=3},
    {name="pipe",			moonevent=false,    gymweight=3},

    {name="deerclops",		moonevent=false,    gymweight=4},
    {name="bearger",		moonevent=false,    gymweight=4},
    {name="moosegoose",		moonevent=false,    gymweight=4,  },
    {name="dragonfly",		     moonevent=false,    gymweight=4},
    {name="clayhound",		     moonevent=false,    gymweight=3},
    {name="claywarg",		     moonevent=false,    gymweight=3},
    {name="butterfly",		     moonevent=false,    gymweight=3},
    {name="anchor",			     moonevent=false,    gymweight=3},
    {name="moon",			     moonevent=false,    gymweight=4},
    {name="carrat",			     moonevent=false,    gymweight=3},
    {name="beefalo",		     moonevent=false,    gymweight=3},
    {name="crabking",		     moonevent=false,    gymweight=4},
    {name="malbatross",		     moonevent=false,    gymweight=4},
    {name="toadstool",		     moonevent=false,    gymweight=4},
    {name="stalker",		     moonevent=false,    gymweight=4},
    {name="klaus",			     moonevent=false,    gymweight=4},
    {name="beequeen",		     moonevent=false,    gymweight=4},
    {name="antlion",		     moonevent=false,    gymweight=4},
    {name="minotaur",		     moonevent=false,    gymweight=4},
    {name="guardianphase3",      moonevent=false,    gymweight=4},
    {name="eyeofterror",	     moonevent=false,    gymweight=4},
    {name="twinsofterror",	     moonevent=false,    gymweight=4},
    {name="kitcoon",		     moonevent=false,    gymweight=3},
    {name="catcoon",		     moonevent=false,    gymweight=3},
    {name="manrabbit",           moonevent=false,    gymweight=3},
    {name="daywalker",           moonevent=false,    gymweight=4},
    {name="deerclops_mutated",   moonevent=false,    gymweight=4},
    {name="warg_mutated",        moonevent=false,    gymweight=4},
    {name="bearger_mutated",     moonevent=false,    gymweight=4},
    {name="yotd",                moonevent=false,    gymweight=3},
}

local MOON_EVENT_RADIUS = 12
local MOON_EVENT_MINPIECES = 3

local MOONGLASS_NAME = "moonglass"
local MATERIALS =
{
    {name="marble",         prefab="marble",        inv_suffix=""},
    {name="stone",          prefab="cutstone",      inv_suffix="_stone"},
    {name=MOONGLASS_NAME,   prefab="moonglass",  inv_suffix="_moonglass"},
}

local PHYSICS_RADIUS = .45





TUNING.FUNNY_CAT_RESOURCES = TUNING.FUNNY_CAT_RESOURCES or {}

local temp_table = {}

local function GetBuildName(pieceid, materialid)
    local build = "swap_chesspiece_" .. PIECES[pieceid].name
    if materialid then
        build = build .. "_" .. MATERIALS[materialid].name
    end
    return build
end
local function SetMaterial(inst, materialid)
	inst.materialid = materialid
	local build = GetBuildName(inst.pieceid, materialid)
    inst.AnimState:SetBuild(build)
end
local makepiece_with_fn = function(pieceid, materialid)
    local prefabname = materialid and ("chesspiece_"..PIECES[pieceid].name.."_"..MATERIALS[materialid].name) or ("chesspiece_"..PIECES[pieceid].name)
    local fn = function()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeHeavyObstaclePhysics(inst, PHYSICS_RADIUS)
        inst:SetPhysicsRadiusOverride(PHYSICS_RADIUS)

        inst.AnimState:SetBank("chesspiece")
        inst.AnimState:SetBuild("swap_chesspiece_"..PIECES[pieceid].name.."_marble")
        inst.AnimState:PlayAnimation("idle")
        inst:SetPrefabName("chesspiece_"..PIECES[pieceid].name)
        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end
        inst:AddComponent("inspectable")

        inst.pieceid = pieceid
        if materialid then
            SetMaterial(inst, materialid)
        end

        return inst
    end
    return prefabname, fn
end

TUNING.FUNNY_CAT_CHESSPIECES_RESOURCES = TUNING.FUNNY_CAT_CHESSPIECES_RESOURCES or {}

for p = 1,#PIECES do
    --------------------------------------------------------------------
    --- 没材料基础款
        -- -- table.insert(chesspieces, makepiece(p))
        -- local origin_prefab ,fn = makepiece_with_fn(p)
        -- temp_table[origin_prefab] = {
        --     fn = fn,
        --     icon_data = {

        --     },
        -- }
        -- table.insert(TUNING.FUNNY_CAT_CHESSPIECES_RESOURCES, origin_prefab)
    --------------------------------------------------------------------

    for m = 1,#MATERIALS do
        --------------------------------------------------------------------
        --- 三个材料款式
            -- table.insert(chesspieces, makepiece(p, m))
            local origin_prefab ,fn = makepiece_with_fn(p,m)
            temp_table[origin_prefab] = {
                fn = fn,
                icon_data = {
                    
                },
            }
            table.insert(TUNING.FUNNY_CAT_CHESSPIECES_RESOURCES, origin_prefab)
        --------------------------------------------------------------------
    end
end

for k, v in pairs(temp_table) do
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end