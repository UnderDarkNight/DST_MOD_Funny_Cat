

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
    --------------------------------------------------------------------
    --- 仙人掌
        ["cactus"] = {
            bank = "cactus",
            build = "cactus",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "cactus.png",
            common_postinit = function(inst)
                inst:SetPrefabNameOverride("cactus")
                MakeObstaclePhysics(inst, .3)
            end,
            master_postinit = function(inst)
                if math.random() < 0.5 then
                    inst.AnimState:PlayAnimation("idle_flower", true)
                end
            end,
        },
        ["oasis_cactus"] = {
            bank = "oasis_cactus",
            build = "oasis_cactus",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "oasis_cactus.png",
            common_postinit = function(inst)
                inst:SetPrefabNameOverride("cactus")
                MakeObstaclePhysics(inst, .3)
            end,
            master_postinit = function(inst)
                if math.random() < 0.5 then
                    inst.AnimState:PlayAnimation("idle_flower", true)
                end
            end,
        },
    --------------------------------------------------------------------
    --- 岩浆池
        ["lava_pond"] = {
            bank = "lava_tile",
            build = "lava_tile",
            anim = "bubble_lava",
            loop = true,
            icon_data = {

            },
            map = "lava_pond.png",
            common_postinit = function(inst)
                MakePondPhysics(inst, 1.95)
                inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
                inst.AnimState:SetLayer(LAYER_BACKGROUND)
                inst.AnimState:SetSortOrder(3)

                inst.entity:AddLight()
                inst.Light:Enable(true)
                inst.Light:SetRadius(1.5)
                inst.Light:SetFalloff(0.66)
                inst.Light:SetIntensity(0.66)
                inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()
                    local NUM_ROCK_TYPES = 7
                    if inst.rocks == nil then
                        inst.rocks = {}
                        for i = 1, math.random(2, 4) do
                            local theta = math.random() * 2 * PI
                            local rocktype = math.random(NUM_ROCK_TYPES)
                            table.insert(inst.rocks,
                            {
                                rocktype = rocktype > 1 and tostring(rocktype) or "",
                                offset =
                                {
                                    math.sin(theta) * 2.1 + math.random() * .3,
                                    0,
                                    math.cos(theta) * 2.1 + math.random() * .3,
                                },
                            })
                        end
                    end
                    for i, v in ipairs(inst.rocks) do
                        if type(v.rocktype) == "string" and type(v.offset) == "table" and #v.offset == 3 then
                            local rock = SpawnPrefab("fc_lava_pond_rock")
                            if rock ~= nil then
                                rock.entity:SetParent(inst.entity)
                                rock.Transform:SetPosition(unpack(v.offset))
                                rock.persists = false
                            end
                        end
                    end
                end)
            end,
            create_postinit = function()

            end,
        },
        ["lava_pond_rock"] = {
            bank = "scorched_rock",
            build = "scorched_rock",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            -- map = "lava_pond.png",
            common_postinit = function(inst)
                inst:SetPrefabNameOverride("lava_pond_rock")
            end,
            master_postinit = function(inst)
                local rock_type = ""
                local NUM_ROCK_TYPES = 7
                local temp_type = math.random(1, NUM_ROCK_TYPES)
                if temp_type == 1 then
                    rock_type = ""
                else
                    rock_type = tostring(temp_type)
                end
                inst.AnimState:PlayAnimation("idle"..rock_type, true)
            end,
            create_postinit = function()
                
            end,
        },
    --------------------------------------------------------------------
    -- 尖刺灌木
        ["marsh_bush"] = {
            bank = "marsh_bush",
            build = "marsh_bush",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "lava_pond.png",
            common_postinit = function(inst)
                inst.MiniMapEntity:SetPriority(-1)
            end,
            master_postinit = function(inst)
                inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
                local color = 0.5 + math.random() * 0.5
                inst.AnimState:SetMultColour(color, color, color, 1)
            end,
        },
    --------------------------------------------------------------------
    -- 猎狗骨堆（ houndmound ）
        ["houndmound"] = {
            bank = "houndbase",
            build = "hound_base",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "hound_mound.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .5)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0,function()
                        local x,y,z = inst.Transform:GetWorldPosition()
                        local ents = TheSim:FindEntities(x,y,z,20,("hound"))
                        if #ents > math.random(4) then
                            return
                        end
                        local dogs = {"hound","firehound","icehound","mutatedhound","hedgehound"}
                        local ret_prefab = dogs[math.random(#dogs)]
                        local dog_inst = SpawnPrefab(ret_prefab)
                        if dog_inst ~= nil then
                            dog_inst.Transform:SetPosition(x,y,z)
                        end
                    end)
                end
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 天体裂隙( moon_fissure )
        ["moon_fissure"] = {
            bank = "moon_fissure",
            build = "moon_fissure",
            anim = "crack_idle",
            loop = true,
            icon_data = {

            },            
            -- map = "hound_mound.png",
            common_postinit = function(inst)
                inst:SetPhysicsRadiusOverride(0.4)
                inst.AnimState:SetFinalOffset(3)
            end,
            master_postinit = function(inst)
                inst.fx = SpawnPrefab("moon_fissure_fx")
                inst.fx.entity:SetParent(inst.entity)
            end,
        },
    --------------------------------------------------------------------
    -- 月树( 	"moon_tree""moon_tree_short""moon_tree_normal""moon_tree_tall" )
        ["moon_tree"] = {
            bank = "moon_tree",
            build = "moon_tree",
            -- anim = "crack_idle",
            -- loop = true,
            icon_data = {

            },            
            map = "moon_tree.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .5)
                inst.MiniMapEntity:SetPriority(-1)
                inst:SetPrefabName("moon_tree")
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                -- Add a random colour multiplier to avoid samey-ness.
                inst.color = 0.75 + math.random() * 0.25
                inst.AnimState:SetMultColour(inst.color, inst.color, inst.color, 1)
                MakeSnowCovered(inst)
                local anims = {"idle_short","idle_normal","idle_tall"}
                local anim = anims[math.random(#anims)]
                inst.AnimState:PlayAnimation(anim,true)
            end,
        },
    --------------------------------------------------------------------
    -- 温泉( hotspring )
        ["hotspring"] = {
            bank = "crater_pool",
            build = "crater_pool",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "hotspring.png",
            common_postinit = function(inst)
                MakePondPhysics(inst, 1)
                inst.entity:AddLight()
                inst.Light:Enable(false)
                inst.Light:SetRadius(TUNING.HOTSPRING_GLOW.RADIUS)
                inst.Light:SetIntensity(TUNING.HOTSPRING_GLOW.INTENSITY)
                inst.Light:SetFalloff(TUNING.HOTSPRING_GLOW.FALLOFF)
                inst.Light:SetColour(0.1, 1.6, 2)

                inst:SetDeployExtraSpacing(2)
            end,
            master_postinit = function(inst)
                
            end,
        },
    --------------------------------------------------------------------
    -- 月光玻璃( moonglass_rock )
        ["moonglass_rock"] = {
            bank = "moonglass_rock",
            build = "moonglass_rock",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "rock_moonglass.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabName("moonglass_rock")
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- rock1
        ["rock1"] = {
            bank = "rock",
            build = "rock",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "rock.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- rock2
        ["rock2"] = {
            bank = "rock2",
            build = "rock2",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "rock_gold.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- rock_flintless
        ["rock_flintless"] = {
            bank = "rock_flintless",
            build = "rock_flintless",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "rock_flintless.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                local anims = {"full","med","low"}
                local ret_anim = anims[math.random(#anims)]
                inst.AnimState:PlayAnimation(ret_anim,true)
            end,
        },
    --------------------------------------------------------------------
    -- rock_moon
        ["rock_moon"] = {
            bank = "rock5",
            build = "rock7",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "rock_moon.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- rock_moon_shell
        ["rock_moon_shell"] = {
            bank = "moonrock_shell",
            build = "moonrock_shell",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "rock_moon.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- rock_petrified_tree
        ["rock_petrified_tree"] = {
            bank = "petrified_tree",
            build = "petrified_tree",
            anim = "full",
            loop = true,
            icon_data = {

            },            
            map = "petrified_tree.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabName("rock_petrified_tree")
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.components.inspectable.nameoverride = "PETRIFIED_TREE"

                local rand = math.random()
                local size = (rand > 0.90 and 4)
                    or (rand > 0.60 and 1)
                    or (rand < 0.30 and 2)
                    or 3
                inst.treeSize = size

                if inst.treeSize == 4 then
                    inst.AnimState:SetBuild("petrified_tree_old")
                    inst.AnimState:SetBank("petrified_tree_old")
                    inst.Physics:SetCapsule(.25, 2)
                elseif inst.treeSize == 3 then
                    inst.AnimState:SetBuild("petrified_tree_tall")
                    inst.AnimState:SetBank("petrified_tree_tall")
                    inst.Physics:SetCapsule(1, 2)
                elseif inst.treeSize == 1 then
                    inst.AnimState:SetBuild("petrified_tree_short")
                    inst.AnimState:SetBank("petrified_tree_short")
                    inst.Physics:SetCapsule(.25, 2)
                else
                    inst.AnimState:SetBuild("petrified_tree")
                    inst.AnimState:SetBank("petrified_tree")
                    inst.Physics:SetCapsule(.65, 2)
                end
                
            end,
        },
    --------------------------------------------------------------------
    -- 草( grass )
        ["grass"] = {
            bank = "grass",
            build = "grass1",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "grass.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)
                inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
                local color = 0.75 + math.random() * 0.25
                inst.AnimState:SetMultColour(color, color, color, 1)                
                if math.random() < 0.3 then
                    inst.AnimState:PlayAnimation("picking")
                end
            end,
        },
    --------------------------------------------------------------------
    -- 兔子洞( rabbithole )
        ["rabbithole"] = {
            bank = "rabbithole",
            build = "rabbit_hole",
            anim = "idle",
            -- loop = true,
            icon_data = {

            },            
            map = "grass.png",
            common_postinit = function(inst)
                inst.AnimState:SetLayer(LAYER_BACKGROUND)
                inst.AnimState:SetSortOrder(3)
            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 试金石( resurrectionstone )
        ["resurrectionstone"] = {
            -- bank = "rabbithole",
            -- build = "rabbit_hole",
            -- anim = "idle",
            -- loop = true,
            icon_data = {

            },            
            -- map = "grass.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()
                    local x,y,z = inst.Transform:GetWorldPosition()
                    inst:Remove()
                    SpawnPrefab("resurrectionstone").Transform:SetPosition(x,y,z)
                    -- pighead

                    local offset_x = 3
                    local offset_z = 3

                    SpawnPrefab("fc_pighead").Transform:SetPosition(x + offset_x,0,z + offset_z)
                    SpawnPrefab("fc_pighead").Transform:SetPosition(x - offset_x,0,z + offset_z)
                    SpawnPrefab("fc_pighead").Transform:SetPosition(x + offset_x,0,z - offset_z)
                    SpawnPrefab("fc_pighead").Transform:SetPosition(x - offset_x,0,z - offset_z)
                end)
            end,
        },
    --------------------------------------------------------------------
    -- 猪头棒
        ["pighead"] = {
            bank = "pig_head",
            build = "pig_head",
            anim = "idle_asleep",
            loop = true,
            icon_data = {

            },            
            -- map = "grass.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)
                local function OnFullMoon(inst, isfullmoon)
                    if isfullmoon then
                        if not inst.awake then
                            inst.awake = true
                            inst.AnimState:PlayAnimation("wake")
                            inst.AnimState:PushAnimation("idle_awake", false)
                        end
                    elseif inst.awake then
                        inst.awake = nil
                        inst.AnimState:PlayAnimation("sleep")
                        inst.AnimState:PushAnimation("idle_asleep", false)
                    end
                end
                inst:WatchWorldState("isfullmoon", OnFullMoon)
                OnFullMoon(inst, TheWorld.state.isfullmoon)
            end,
        },
    --------------------------------------------------------------------
    -- 鱼头棒
        ["mermhead"] = {
            bank = "merm_head",
            build = "merm_head",
            anim = "idle_asleep",
            loop = true,
            icon_data = {

            },            
            -- map = "grass.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)
                local function OnFullMoon(inst, isfullmoon)
                    if isfullmoon then
                        if not inst.awake then
                            inst.awake = true
                            inst.AnimState:PlayAnimation("wake")
                            inst.AnimState:PushAnimation("idle_awake", false)
                        end
                    elseif inst.awake then
                        inst.awake = nil
                        inst.AnimState:PlayAnimation("sleep")
                        inst.AnimState:PushAnimation("idle_asleep", false)
                    end
                end
                inst:WatchWorldState("isfullmoon", OnFullMoon)
                OnFullMoon(inst, TheWorld.state.isfullmoon)
            end,
        },
    --------------------------------------------------------------------
    -- 高脚鸟巢穴( tallbirdnest )
        ["tallbirdnest"] = {
            bank = "egg",
            build = "tallbird_egg",
            anim = "eggnest",
            -- loop = true,
            icon_data = {

            },            
            map = "tallbirdnest.png",
            common_postinit = function(inst)
                inst.AnimState:SetFinalOffset(-1)
            end,
            master_postinit = function(inst)
                if math.random() < 0.5 then
                    inst.AnimState:PlayAnimation("nest")
                    inst.components.inspectable.GetStatus = function()
                        return "PICKED"
                    end
                end
            end,
        },
    --------------------------------------------------------------------
    -- 蜘蛛巢穴( "spiderden""spiderden_2""spiderden_3" )
        ["spiderden"] = {
            bank = "spider_cocoon",
            build = "spider_cocoon",
            -- anim = "cocoon_small",
            loop = true,
            icon_data = {

            },            
            map = "tallbirdnest.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .5)
                inst.AnimState:HideSymbol("bedazzled_flare")
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabName("spiderden")

                inst.entity:AddGroundCreepEntity()
            end,
            master_postinit = function(inst)
                local den_level = math.random(1, 3)
                inst.den_level = den_level
                inst.MiniMapEntity:SetIcon("spiderden_" .. tostring(den_level) .. ".png")
                local idle_anim = {"cocoon_small","cocoon_medium","cocoon_large"}
                inst.AnimState:PlayAnimation(idle_anim[den_level])
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0,function()
                        
                        inst.spiders = inst.spiders or {}
                        local new_spiders = {}
                        for k, v in pairs(inst.spiders) do
                            if v and v:IsValid() then
                                table.insert(new_spiders, v)
                            end
                        end
                        inst.spiders = new_spiders
                        local spider_num = den_level*2
                        local need_2_spawn_num = spider_num - #inst.spiders
                        if need_2_spawn_num > 0 then
                            local x,y,z = inst.Transform:GetWorldPosition()
                            local spider_prefabs = {"spider","spider_warrior","spider_hider","spider_spitter","spider_dropper","spider_moon","spider_healer"}
                            for i = 1, need_2_spawn_num, 1 do
                                local ret_prefab = spider_prefabs[math.random(#spider_prefabs)]
                                local spider_inst = SpawnPrefab(ret_prefab)                                
                                if spider_inst then
                                    spider_inst.Transform:SetPosition(x,y,z)
                                    table.insert(inst.spiders, spider_inst)
                                end
                            end
                        end

                    end)
                end
                inst.GroundCreepEntity:SetRadius(TUNING.SPIDERDEN_CREEP_RADIUS[den_level])
            end,
        },
    --------------------------------------------------------------------
    -- 迷你冰川( rock_ice )
        ["rock_ice"] = {
            bank = "ice_boulder",
            build = "ice_boulder",
            -- anim = "cocoon_small",
            loop = true,
            icon_data = {

            },            
            map = "iceboulder.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                inst.__net_type = net_tinybyte(inst.GUID,"rock_ice","rock_ice")
                if not TheNet:IsDedicated() then
                    inst:ListenForEvent("rock_ice", function(inst)
                        local current_type = inst.__net_type:value()
                        local fx = inst:SpawnChild("ice_puddle")
                        fx.AnimState:PlayAnimation("idle",true)
                    end)
                end
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                local anims = {"low","med","full"}
                local anim_type = math.random(#anims)
                local ret_anim = anims[anim_type]
                inst.AnimState:PlayAnimation(ret_anim, false)
                inst.__net_type:set(anim_type)
            end,
        },
    --------------------------------------------------------------------

}

for k, v in pairs(temp_table) do
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end