

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
            light = true,            
            map = "lava_pond.png",
            common_postinit = function(inst)
                MakePondPhysics(inst, 1.95)
                inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
                inst.AnimState:SetLayer(LAYER_BACKGROUND)
                inst.AnimState:SetSortOrder(3)

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
            light = true,
            map = "hotspring.png",
            common_postinit = function(inst)
                MakePondPhysics(inst, 1)
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
                                    spider_inst:ListenForEvent("entitysleep",function()
                                        spider_inst.Transform:SetPosition(x,y,z)
                                    end)
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
    -- 杀人蜂巢穴( wasphive )
        ["wasphive"] = {
            bank = "wasphive",
            build = "wasphive",
            anim = "cocoon_small",
            loop = true,
            icon_data = {

            },            
            map = "wasphive.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 0.5)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.bees = {}
                local MAX_BEES = 6
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0,function()
                                local x,y,z = inst.Transform:GetWorldPosition()
                                local new_table = {}
                                for k, v in pairs(inst.bees) do
                                    if v and v:IsValid() then
                                        table.insert(new_table,v)
                                    end
                                end
                                inst.bees = new_table
                                local need_spawn_num = MAX_BEES - #inst.bees
                                if need_spawn_num > 0 then
                                    for i = 1, need_spawn_num, 1 do
                                        local bee = SpawnPrefab("killerbee")
                                        bee.Transform:SetPosition(x,y,z)
                                        table.insert(inst.bees,bee)
                                        bee:ListenForEvent("entitysleep",function()
                                            bee.Transform:SetPosition(x,y,z)
                                        end)
                                    end
                                end
                    end)
                end
                inst.OnEntitySleep = function()
                   local x,y,z = inst.Transform:GetWorldPosition()
                   for k, v in pairs(inst.bees) do
                        if v and v:IsValid() and v:IsAsleep() then
                            v.Transform:SetPosition(x,y,z)
                        end
                   end
                end
            end,
        },
    --------------------------------------------------------------------
    -- 蜂巢穴( beehive )
        ["beehive"] = {
            bank = "beehive",
            build = "beehive",
            anim = "cocoon_small",
            loop = true,
            icon_data = {

            },            
            map = "beehive.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .5)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.bees = {}
                local MAX_BEES = 6
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0,function()
                                local x,y,z = inst.Transform:GetWorldPosition()
                                local new_table = {}
                                for k, v in pairs(inst.bees) do
                                    if v and v:IsValid() then
                                        table.insert(new_table,v)
                                    end
                                end
                                inst.bees = new_table
                                local need_spawn_num = MAX_BEES - #inst.bees
                                if need_spawn_num > 0 then
                                    for i = 1, need_spawn_num, 1 do
                                        local bee = SpawnPrefab(math.random()<0.4 and "killerbee" or "bee")
                                        bee.Transform:SetPosition(x,y,z)
                                        table.insert(inst.bees,bee)
                                        bee:ListenForEvent("entitysleep",function()
                                            bee.Transform:SetPosition(x,y,z)
                                        end)
                                    end
                                end
                    end)
                end
                inst.OnEntitySleep = function()
                   local x,y,z = inst.Transform:GetWorldPosition()
                   for k, v in pairs(inst.bees) do
                        if v and v:IsValid() and v:IsAsleep() then
                            v.Transform:SetPosition(x,y,z)
                        end
                   end
                end
            end,
        },
    --------------------------------------------------------------------
    -- 曼德拉草( mandrake_planted )
        ["mandrake_planted"] = {
            bank = "mandrake",
            build = "mandrake",
            anim = "ground",
            loop = true,
            icon_data = {

            },            
            -- map = "beehive.png",
            common_postinit = function(inst)
                MakeInventoryPhysics(inst)
            end,
            master_postinit = function(inst)
                
            end,
        },
    --------------------------------------------------------------------
    -- 浆果( berrybush )
        ["berrybush"] = {
            bank = "berrybush",
            build = "berrybush",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "berrybush.png",
            common_postinit = function(inst)
                MakeSmallObstaclePhysics(inst, .1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 三叶浆果( berrybush2 )
        ["berrybush2"] = {
            bank = "berrybush2",
            build = "berrybush2",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "berrybush2.png",
            common_postinit = function(inst)
                MakeSmallObstaclePhysics(inst, .1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.components.inspectable.GetDescription = function()
                    return STRINGS.CHARACTERS.GENERIC.DESCRIBE.BERRYBUSH.GENERIC
                end
            end,
        },
    --------------------------------------------------------------------
    -- 多汁浆果( berrybush_juicy )
        ["berrybush_juicy"] = {
            bank = "berrybush_juicy",
            build = "berrybush_juicy",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "berrybush_juicy.png",
            common_postinit = function(inst)
                MakeSmallObstaclePhysics(inst, .1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 红蘑菇( red_mushroom )
        ["red_mushroom"] = {
            bank = "mushrooms",
            build = "mushrooms",
            anim = "red",
            loop = true,
            icon_data = {

            },            
            -- map = "berrybush_juicy.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 蓝蘑菇( blue_mushroom )
        ["blue_mushroom"] = {
            bank = "mushrooms",
            build = "mushrooms",
            anim = "blue",
            loop = true,
            icon_data = {

            },            
            -- map = "berrybush_juicy.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 绿蘑菇( green_mushroom )
        ["green_mushroom"] = {
            bank = "mushrooms",
            build = "mushrooms",
            anim = "green",
            loop = true,
            icon_data = {

            },            
            -- map = "berrybush_juicy.png",
            common_postinit = function(inst)

            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 花( flower )
        ["flower"] = {
            bank = "flowers",
            build = "flowers",
            -- anim = "green",
            loop = true,
            icon_data = {

            },            
            -- map = "berrybush_juicy.png",
            common_postinit = function(inst)
                inst.AnimState:SetRayTestOnBB(true)
                inst:AddTag("flower")
            end,
            master_postinit = function(inst)
                local names = {"f1","f2","f3","f4","f5","f6","f7","f8","f9","f10","rose"}
                local ret_name = names[math.random(#names)]
                inst.AnimState:PlayAnimation(ret_name,true)

                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(6, 8)
                inst.components.playerprox:SetOnPlayerNear(function()
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if inst.butterfly == nil or not inst.butterfly:IsValid() then
                        local new_inst = SpawnPrefab("butterfly")
                        new_inst.Transform:SetPosition(x,y,z)
                        inst.butterfly = new_inst
                        new_inst:ListenForEvent("entitysleep",function()
                            new_inst:Remove()
                        end)
                    end
                end)
                -- inst.components.playerprox:SetOnPlayerFar(onfar)
            end,
        },
    --------------------------------------------------------------------
    -- 花( flower )
        ["flower_rose"] = {
            bank = "flowers",
            build = "flowers",
            anim = "rose",
            loop = true,
            icon_data = {

            },            
            -- map = "berrybush_juicy.png",
            common_postinit = function(inst)
                inst.AnimState:SetRayTestOnBB(true)
                inst:AddTag("flower")
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(6, 8)
                inst.components.playerprox:SetOnPlayerNear(function()
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if inst.butterfly == nil or not inst.butterfly:IsValid() then
                        local new_inst = SpawnPrefab("butterfly")
                        new_inst.Transform:SetPosition(x,y,z)
                        inst.butterfly = new_inst
                        new_inst:ListenForEvent("entitysleep",function()
                            new_inst:Remove()
                        end)
                    end
                end)
                -- inst.components.playerprox:SetOnPlayerFar(onfar)
            end,
        },
    --------------------------------------------------------------------
    -- 芦苇( reeds )
        ["reeds"] = {
            bank = "grass",
            build = "reeds",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "reeds.png",
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 普通池塘草( marsh_plant )
        ["marsh_plant"] = {
            bank = "marsh_plant",
            build = "marsh_plant",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "idle_mos.png",
            common_postinit = function(inst)
            end,
            master_postinit = function(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 珊瑚池塘( marsh_plant )
        ["pond_algae"] = {
            bank = "pond_rock",
            build = "pond_plant_cave",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "idle_mos.png",
            common_postinit = function(inst)
            end,
            master_postinit = function(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 沼泽池塘( pond_mos )
        ["pond_mos"] = {
            bank = "marsh_tile",
            build = "marsh_tile",
            anim = "idle_mos",
            loop = true,
            icon_data = {

            },            
            map = "pond_mos.png",
            common_postinit = function(inst)
                inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
                inst.AnimState:SetLayer(LAYER_BACKGROUND)
                inst.AnimState:SetSortOrder(3)
                MakePondPhysics(inst, 1.95)
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()                    
                        inst.plant_ents = {}
                        local MAX_PANTS_NUM = math.random(3,7)
                        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                            target = inst,
                            range = 1.95,
                            num = 20,
                        })
                        for i = 1, MAX_PANTS_NUM, 1 do
                            local plant = SpawnPrefab("fc_marsh_plant")
                            if plant ~= nil then
                                local pt = points[math.random(#points)]
                                plant.Transform:SetPosition(pt.x, pt.y, pt.z)
                                table.insert(inst.plant_ents, plant)
                            end
                        end
                        inst:ListenForEvent("onremove",function()
                            for k, v in pairs(inst.plant_ents) do
                                v:Remove()
                            end
                        end)
                end)
                --------------------------------------------------------
                --- 动物相关
                    inst._animals = {}
                    local MAX_ANIMAL_NUM = math.random(1,3)
                    inst.OnEntityWake = function()
                        inst:DoTaskInTime(0,function()
                            local x,y,z = inst.Transform:GetWorldPosition()
                            local new_table = {}
                            for k, v in pairs(inst._animals) do
                                if v and v:IsValid() then
                                    table.insert(new_table, v)
                                end
                            end
                            inst._animals = new_table
                            local need_2_spawn_num = MAX_ANIMAL_NUM - #inst._animals
                            if need_2_spawn_num > 0 then
                                for i = 1, need_2_spawn_num, 1 do
                                    local animal = SpawnPrefab("mosquito")
                                    if animal ~= nil then
                                        animal.Transform:SetPosition(x, y, z)
                                        table.insert(inst._animals, animal)
                                        animal:ListenForEvent("entitysleep",function()
                                            animal.Transform:SetPosition(x, y, z)
                                        end)
                                    end
                                end
                            end

                        end)
                    end
                    inst.OnEntitySleep = function()
                        local x,y,z = inst.Transform:GetWorldPosition()
                        for k, v in pairs(inst._animals) do
                            if v and v:IsValid() and v:IsAsleep() then
                                v.Transform:SetPosition(x, y, z)
                            end
                        end
                    end
                    inst:ListenForEvent("onremove",function()
                        for k, v in pairs(inst._animals) do
                            v:Remove()
                        end
                    end)
                --------------------------------------------------------
            end,
        },
    --------------------------------------------------------------------
    -- 普通池塘( pond )
        ["pond"] = {
            bank = "marsh_tile",
            build = "marsh_tile",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "pond.png",
            common_postinit = function(inst)
                inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
                inst.AnimState:SetLayer(LAYER_BACKGROUND)
                inst.AnimState:SetSortOrder(3)
                MakePondPhysics(inst, 1.95)
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()                    
                        inst.plant_ents = {}
                        local MAX_PANTS_NUM = math.random(3,7)
                        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                            target = inst,
                            range = 1.95,
                            num = 20,
                        })
                        for i = 1, MAX_PANTS_NUM, 1 do
                            local plant = SpawnPrefab("fc_marsh_plant")
                            if plant ~= nil then
                                local pt = points[math.random(#points)]
                                plant.Transform:SetPosition(pt.x, pt.y, pt.z)
                                table.insert(inst.plant_ents, plant)
                            end
                        end
                        inst:ListenForEvent("onremove",function()
                            for k, v in pairs(inst.plant_ents) do
                                v:Remove()
                            end
                        end)
                end)
                --------------------------------------------------------
                --- 动物相关
                    inst._animals = {}
                    local MAX_ANIMAL_NUM = math.random(1,3)
                    inst.OnEntityWake = function()
                        inst:DoTaskInTime(0,function()
                            local x,y,z = inst.Transform:GetWorldPosition()
                            local new_table = {}
                            for k, v in pairs(inst._animals) do
                                if v and v:IsValid() then
                                    table.insert(new_table, v)
                                end
                            end
                            inst._animals = new_table
                            local need_2_spawn_num = MAX_ANIMAL_NUM - #inst._animals
                            if need_2_spawn_num > 0 then
                                for i = 1, need_2_spawn_num, 1 do
                                    local animal = SpawnPrefab("frog")
                                    if animal ~= nil then
                                        animal.Transform:SetPosition(x, y, z)
                                        table.insert(inst._animals, animal)
                                        animal:ListenForEvent("entitysleep",function()
                                            animal.Transform:SetPosition(x, y, z)
                                        end)
                                    end
                                end
                            end

                        end)
                    end
                    inst.OnEntitySleep = function()
                        local x,y,z = inst.Transform:GetWorldPosition()
                        for k, v in pairs(inst._animals) do
                            if v and v:IsValid() and v:IsAsleep() then
                                v.Transform:SetPosition(x, y, z)
                            end
                        end
                    end
                    inst:ListenForEvent("onremove",function()
                        for k, v in pairs(inst._animals) do
                            v:Remove()
                        end
                    end)
                --------------------------------------------------------
            end,
        },
    --------------------------------------------------------------------
    -- 珊瑚池塘( pond_cave )
        ["pond_cave"] = {
            bank = "marsh_tile",
            build = "marsh_tile",
            anim = "idle_cave",
            loop = true,
            icon_data = {

            },            
            map = "pond_cave.png",
            common_postinit = function(inst)
                inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
                inst.AnimState:SetLayer(LAYER_BACKGROUND)
                inst.AnimState:SetSortOrder(3)
                MakePondPhysics(inst, 1.95)
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()                    
                        inst.plant_ents = {}
                        local MAX_PANTS_NUM = math.random(3,7)
                        local points = TUNING.FUNNY_CAT_FN:GetSurroundPoints({
                            target = inst,
                            range = 1.95,
                            num = 20,
                        })
                        for i = 1, MAX_PANTS_NUM, 1 do
                            local plant = SpawnPrefab("fc_pond_algae")
                            if plant ~= nil then
                                local pt = points[math.random(#points)]
                                plant.Transform:SetPosition(pt.x, pt.y, pt.z)
                                table.insert(inst.plant_ents, plant)
                            end
                        end
                        inst:ListenForEvent("onremove",function()
                            for k, v in pairs(inst.plant_ents) do
                                v:Remove()
                            end
                        end)
                end)
            end,
        },
    --------------------------------------------------------------------
    -- 蕨类植物( cave_fern )
        ["cave_fern"] = {
            bank = "ferns",
            build = "cave_ferns",
            -- anim = "idle_cave",
            loop = true,
            icon_data = {

            },            
            -- map = "pond_cave.png",
            common_postinit = function(inst)
                inst.AnimState:SetRayTestOnBB(true)
            end,
            master_postinit = function(inst)
                local anim_names = {"f1","f2","f3","f4","f5","f6","f7","f8","f9","f10"}
                local ret_anim = anim_names[math.random(#anim_names)]
                inst.AnimState:PlayAnimation(ret_anim,true)
            end,
        },
    --------------------------------------------------------------------
    -- 猴子窝( monkeybarrel )
        ["monkeybarrel"] = {
            bank = "barrel",
            build = "monkey_barrel",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "monkeybarrel.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
            end,
            master_postinit = function(inst)
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0,function()
                        local x,y,z = inst.Transform:GetWorldPosition()
                        if inst._animal == nil or not inst._animal:IsValid() then
                            local animal = SpawnPrefab("monkey")
                            if animal then
                                inst._animal = animal
                                animal.Transform:SetPosition(x,y,z)
                                animal:ListenForEvent("entitysleep",function()
                                    animal.Transform:SetPosition(x,y,z)
                                end)
                            end
                        end
                    end)
                end
            end,
        },
    --------------------------------------------------------------------
    --石笋( "stalagmite_tall""stalagmite_tall_full""stalagmite_tall_med""stalagmite_tall_low" )
        ["stalagmite_tall"] = {
            bank = "rock_stalagmite_tall",
            build = "rock_stalagmite_tall",
            anim = "idle",
            loop = true,
            icon_data = {

            },            
            map = "stalagmite_tall.png",
            common_postinit = function(inst)
                inst:SetPrefabNameOverride("stalagmite_tall")
                MakeObstaclePhysics(inst, 1)
            end,
            master_postinit = function(inst)
                local anims = {"full","med","low"}
                local ret_anim = anims[math.random(#anims)]
                inst.type = "_"..tostring(math.random(2)) -- left or right handed rock
                inst.AnimState:PlayAnimation(ret_anim..inst.type)
            end,
        },
    --------------------------------------------------------------------
    -- 完全正常的树( livingtree )
        ["livingtree"] = {
            bank = "evergreen_living_wood",
            build = "evergreen_living_wood",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "livingtree.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .75)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 树枝( sapling )
        ["sapling"] = {
            bank = "sapling",
            build = "sapling",
            anim = "sway",
            loop = true,
            icon_data = {
            },            
            map = "sapling.png",
            common_postinit = function(inst)
                inst.AnimState:SetRayTestOnBB(true)
                inst:SetPrefabNameOverride("sapling")
            end,
            master_postinit = function(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 月岛树枝( sapling_moon )
        ["sapling_moon"] = {
            bank = "sapling_moon",
            build = "sapling_moon",
            anim = "sway",
            loop = true,
            icon_data = {
            },            
            map = "sapling.png",
            common_postinit = function(inst)
                inst.AnimState:SetRayTestOnBB(true)
                inst:SetPrefabNameOverride("sapling")
            end,
            master_postinit = function(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 多支树（ twiggytree ）
        ["twiggytree"] = {
            bank = "twiggy",
            build = "twiggy_build",
            -- anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "twiggy.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
                inst.MiniMapEntity:SetPriority(-1)                
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabNameOverride("twiggytree")
            end,
            master_postinit = function(inst)
                local color = .5 + math.random() * .5
                inst.AnimState:SetMultColour(color, color, color, 1)
                MakeSnowCovered(inst)
                local anims = {"idle_short","idle_tall","idle_normal"}
                local ret_anim = anims[math.random(#anims)]
                inst.AnimState:PlayAnimation(ret_anim, true)
            end,
        },
    --------------------------------------------------------------------
    -- 常青树（ evergreen ）
        ["evergreen"] = {
            bank = "evergreen_short",
            build = "evergreen_new",
            -- anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "evergreen.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
                inst.MiniMapEntity:SetPriority(-1)                
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabNameOverride("evergreen")
            end,
            master_postinit = function(inst)
                local color = .5 + math.random() * .5
                inst.AnimState:SetMultColour(color, color, color, 1)
                MakeSnowCovered(inst)
                local anims = {"idle_short","idle_tall","idle_normal"}
                local ret_anim = anims[math.random(#anims)]
                inst.AnimState:PlayAnimation(ret_anim, true)
            end,
        },
    --------------------------------------------------------------------
    -- 常青树（ evergreen_sparse ）
        ["evergreen_sparse"] = {
            bank = "evergreen_short",
            build = "evergreen_new_2",
            -- anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "evergreen_lumpy.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
                inst.MiniMapEntity:SetPriority(-1)                
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabNameOverride("evergreen")
            end,
            master_postinit = function(inst)
                local color = .5 + math.random() * .5
                inst.AnimState:SetMultColour(color, color, color, 1)
                MakeSnowCovered(inst)
                local anims = {"idle_short","idle_tall","idle_normal"}
                local ret_anim = anims[math.random(#anims)]
                inst.AnimState:PlayAnimation(ret_anim, true)
            end,
        },
    --------------------------------------------------------------------
    -- 针刺树 ( marsh_tree ）
        ["marsh_tree"] = {
            bank = "marsh_tree",
            build = "tree_marsh",
            -- anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "marshtree.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
                inst.MiniMapEntity:SetPriority(-1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                local ret_anim = "sway"..math.random(4).."_loop"
                inst.AnimState:SetPercent(ret_anim, math.random())
                inst.AnimState:PlayAnimation(ret_anim, true)
            end,
        },
    --------------------------------------------------------------------
    -- 桦树( deciduoustree )
        ["deciduoustree"] = {
            bank = "tree_leaf",
            build = "tree_leaf_trunk_build",
            -- anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "tree_leaf.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
                inst.MiniMapEntity:SetPriority(-1)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                local leaves_build = {"tree_leaf_green_build","nil","tree_leaf_red_build","tree_leaf_orange_build","tree_leaf_yellow_build","tree_leaf_poison_build"}
                local ret_build = leaves_build[math.random(#leaves_build)]
                if ret_build ~= "nil" then
                    inst.AnimState:OverrideSymbol("swap_leaves",ret_build, "swap_leaves")
                end
                local anims = {"sway1_loop_short","sway1_loop_tall","sway1_loop_normal","sway2_loop_short","sway2_loop_tall","sway2_loop_normal"}
                local ret_anim = anims[math.random(#anims)]
                inst.AnimState:SetPercent(ret_anim, math.random())
                inst.AnimState:PlayAnimation(ret_anim, true)

                local snow_over_init = function(inst)
                    if TheWorld.state.issnowcovered then
                        inst.AnimState:HideSymbol("swap_leaves")
                    else                            
                        inst.AnimState:ShowSymbol("swap_leaves")
                    end   
                end
                inst:WatchWorldState("issnowcovered",snow_over_init)
                snow_over_init(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 猫窝( catcoonden )
        ["catcoonden"] = {
            bank = "catcoon_den",
            build = "catcoon_den",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "catcoonden.png",
            common_postinit = function(inst)
                MakeSmallObstaclePhysics(inst, .5)
                MakeSnowCoveredPristine(inst)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 格罗姆雕像( statueglommer )
        ["statueglommer"] = {
            bank = "glommer_statue",
            build = "glommer_statue",
            anim = "full",
            loop = true,
            icon_data = {
            },            
            map = "statueglommer.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .75)
                inst.MiniMapEntity:SetPriority(5)
            end,
            master_postinit = function(inst)
                if math.random() < 0.5 then
                    inst.AnimState:OverrideSymbol("swap_flower", "glommer_swap_flower", "swap_flower")
                    inst.AnimState:Show("swap_flower")
                end
            end,
        },
    --------------------------------------------------------------------
    -- 绿蘑菇树( mushtree_small )
        ["mushtree_small"] = {
            bank = "mushroom_tree_small",
            build = "mushroom_tree_small",
            anim = "idle_loop",
            loop = true,
            icon_data = {
            },            
            map = "mushroom_tree_small.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 蓝蘑菇树( mushtree_tall )
        ["mushtree_tall"] = {
            bank = "mushroom_tree",
            build = "mushroom_tree_tall",
            anim = "idle_loop",
            loop = true,
            icon_data = {
            },            
            map = "mushroom_tree.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 红蘑菇树( mushtree_medium )
        ["mushtree_medium"] = {
            bank = "mushroom_tree_med",
            build = "mushroom_tree_med",
            anim = "idle_loop",
            loop = true,
            icon_data = {
            },            
            map = "mushroom_tree_med.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 月亮蘑菇树( mushtree_moon )
        ["mushtree_moon"] = {
            bank = "mushroom_tree",
            build = "mutatedmushroom_tree_build",
            anim = "idle_loop",
            loop = true,
            icon_data = {
            },            
            map = "mushtree_moon.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, .25)
                inst:SetPrefabName("mushtree_moon")
            end,
            master_postinit = function(inst)

            end,
        },
    --------------------------------------------------------------------
    -- 墓碑( gravestone )
        ["gravestone"] = {
            bank = "gravestone",
            build = "gravestones",
            -- anim = "idle_loop",
            loop = true,
            icon_data = {
            },            
            map = "gravestones.png",
            common_postinit = function(inst)
                inst.AnimState:PlayAnimation("grave" .. tostring(math.random(4)))
                inst:SetPrefabNameOverride("gravestone")
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()
                    local x,y,z = inst.Transform:GetWorldPosition()
                    local offst_x,offst_y,offst_z = (TheCamera:GetDownVec()*.5):Get()
                    SpawnPrefab("mound").Transform:SetPosition(x+offst_x,y+offst_y,z+offst_z)
                end)
                inst.components.inspectable:SetDescription(STRINGS.EPITAPHS[math.random(#STRINGS.EPITAPHS)])
            end,
        },
    --------------------------------------------------------------------
    -- 坟墓( mound )
        ["mound"] = {
            bank = "gravestone",
            build = "gravestones",
            anim = "gravedirt",
            loop = true,
            icon_data = {
            },            
            -- map = "gravestones.png",
            common_postinit = function(inst)
            end,
            master_postinit = function(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 恶魔花( flower_evil )
        ["flower_evil"] = {
            bank = "flowers_evil",
            build = "flowers_evil",
            -- anim = "gravedirt",
            loop = true,
            icon_data = {
            },            
            -- map = "gravestones.png",
            common_postinit = function(inst)
                inst.AnimState:SetRayTestOnBB(true)
                inst:AddTag("flower")
            end,
            master_postinit = function(inst)
                local names = {"f1","f2","f3","f4","f5","f6","f7","f8"}
                inst.animname = names[math.random(#names)]
                inst.AnimState:PlayAnimation(inst.animname)
            end,
        },
    --------------------------------------------------------------------
    -- 海蚀柱 ( seastack )
        ["seastack"] = {
            bank = "water_rock01",
            build = "water_rock_01",
            anim = "1_full",
            -- loop = true,
            icon_data = {
            },            
            map = "seastack.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.1, {1.1, 0.9, 1.1})
                inst.components.floater.bob_percent = 0
            
                local land_time = (POPULATING and math.random()*5*FRAMES) or 0
                inst:DoTaskInTime(land_time, function(inst)
                    inst.components.floater:OnLandedServer()
                end)
            end,
            master_postinit = function(inst)
                local function updateart(inst)
                    local workleft = math.random(10)
                    inst.AnimState:PlayAnimation(
                        (workleft > 6 and inst.stackid.."_full") or
                        (workleft > 3 and inst.has_medium_state and inst.stackid.."_med") or inst.stackid.."_low"
                    )
                end
                local NUM_STACK_TYPES = 5
                inst.stackid = inst.stackid or math.random(NUM_STACK_TYPES)
                updateart(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 盐( saltstack )
        ["saltstack"] = {
            bank = "salt_pillar",
            build = "salt_pillar",
            anim = "full",
            loop = true,
            icon_data = {
            },            
            map = "saltstack.png",
            common_postinit = function(inst)
                inst:SetPhysicsRadiusOverride(2.35)
                MakeWaterObstaclePhysics(inst, 0.80, 2, 0.75)
                MakeInventoryFloatable(inst, "med", nil, 0.85)
                inst.components.floater.bob_percent = 0
            end,
            master_postinit = function(inst)
                local land_time = (POPULATING and math.random()*5*FRAMES) or 0
                inst:DoTaskInTime(land_time, function(inst)
                    inst.components.floater:OnLandedServer()
                end)
                
                local anims = {"empty","low","med","full"}
                inst.AnimState:PlayAnimation(anims[math.random(#anims)])
            end,
        },
    --------------------------------------------------------------------
    -- 海草( waterplant )
        ["waterplant"] = {
            bank = "barnacle_plant",
            build = "barnacle_plant_colour_swaps",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "barnacle_plant.png",
            common_postinit = function(inst)
                inst:SetPhysicsRadiusOverride(2.35)
                MakeWaterObstaclePhysics(inst, 0.80, 2, 0.75)
                inst.Transform:SetSixFaced()            
                inst.AnimState:SetFinalOffset(1)            
                MakeInventoryFloatable(inst, "med", 0.1, {1.1, 0.9, 1.1})
                inst.components.floater.bob_percent = 0
                inst.components.floater.splash = false
            end,
            master_postinit = function(inst)
                local land_time = (POPULATING and math.random()*5*FRAMES) or 0
                inst:DoTaskInTime(land_time, function(inst)
                    inst.components.floater:OnLandedServer()
                end)

                local FLOWER_COLOURS = {"", "white_", "yellow_"}
                inst._colour = FLOWER_COLOURS[math.random(#FLOWER_COLOURS)]
                inst.AnimState:OverrideSymbol("bc_bud", "barnacle_plant_colour_swaps", inst._colour.."bc_bud")
                inst.AnimState:OverrideSymbol("bc_face", "barnacle_plant_colour_swaps", inst._colour.."bc_face")
                inst.AnimState:OverrideSymbol("bc_flower_petal", "barnacle_plant_colour_swaps", inst._colour.."bc_flower_petal")

                inst:DoTaskInTime(0,function()
                    if math.random() < 0.5 then
                        inst.AnimState:PlayAnimation("growth3", false)
                    end
                    -- 设置角度  -180 ~ 180
                    inst.Transform:SetRotation(math.random(-180, 180))
                end)
                inst:DoPeriodicTask(10,function()
                    -- 设置角度  -180 ~ 180
                    inst.Transform:SetRotation(math.random(-180, 180))

                    if inst.AnimState:IsCurrentAnimation("idle") then
                        inst.AnimState:PlayAnimation("growth3", false)
                    else
                        inst.AnimState:PlayAnimation("growth2", false)
                        inst.AnimState:PushAnimation("idle", true)
                    end
                end,5)
            end,
        },
    --------------------------------------------------------------------

    -- 海带 （ bullkelp_plant ）
        ["bullkelp_plant"] = {
            bank = "bullkelp",
            build = "bullkelp",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            map = "bullkelp_plant.png",
            common_postinit = function(inst)
                -- MakeInventoryPhysics(inst, nil, 0.7)
                inst.AnimState:SetFinalOffset(1)
                AddDefaultRippleSymbols(inst, true, false)
            end,
            master_postinit = function(inst)
                ---------------------
                inst.underwater = SpawnPrefab("bullkelp_plant_leaves")
                inst.underwater.entity:SetParent(inst.entity)
                inst.underwater.Transform:SetPosition(0,0,0)
                ---------------------
                local start_frame = math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1
                inst.AnimState:SetFrame(start_frame)
                inst.underwater.AnimState:SetFrame(start_frame)

                inst:ListenForEvent("onremove",function()
                    inst.underwater:Remove()
                end)

            end,
        },
    --------------------------------------------------------------------
    -- 大理石树、大理石灌木  （ marbletree marbleshrub ）
        ["marbletree"] = {
            bank = "marble_trees",
            build = "marble_trees",
            anim = "full_1",
            loop = true,
            icon_data = {
            },            
            map = "marbletree.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 0.1)
                inst.MiniMapEntity:SetPriority(-1)
                MakeSnowCoveredPristine(inst)
                inst:SetPrefabName("marbletree")
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                function inst:SetType(the_type)
                    if type(the_type) == "number" then
                        local idle_anims = {"full_1","full_2","full_3","full_4"}
                        the_type = math.clamp(the_type, 1, #idle_anims)

                        local anim = idle_anims[the_type]
                        inst.AnimState:PlayAnimation(anim, true)
                    end
                end
                inst:ListenForEvent("Set",function(inst,_table)
                    -- _table = _table or {
                    --     pt = Vector3(0,0,0),
                    --     type = 3,
                    -- }
                    inst.Transform:SetPosition(_table.pt.x,_table.pt.y,_table.pt.z)
                    inst:SetType(_table.type)
                    inst.Ready = true
                end)

            end,
        },
        ["marbleshrub"] = {
            bank = "marbleshrub",
            build = "marbleshrub",
            anim = "idle_short",
            loop = true,
            icon_data = {
            },            
            map = "marbleshrub1.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 0.1)
                inst.MiniMapEntity:SetPriority(-1)
                MakeSnowCoveredPristine(inst)
                local function SetupShrubShape(inst, buildnum)
                    inst.shapenumber = buildnum
                    if inst.shapenumber ~= 1 then
                        inst.AnimState:OverrideSymbol("marbleshrub_top1", "marbleshrub_build", "marbleshrub_top"..tostring(inst.shapenumber))
                        inst.MiniMapEntity:SetIcon("marbleshrub"..tostring(inst.shapenumber)..".png")
                    end
                end
                inst.SetupShrubShape = SetupShrubShape
                inst:SetPrefabName("marbleshrub")

            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                function inst:SetType(the_type)
                    local NUM_BUILDS = 3
                    inst:SetupShrubShape(math.random(NUM_BUILDS))
                    local idle_anims = {"idle_short","idle_normal","idle_tall"}
                    inst.AnimState:PlayAnimation(idle_anims[math.random(#idle_anims)], true)
                end

                inst:ListenForEvent("Set",function(inst,_table)
                    _table = _table or {
                        pt = Vector3(0,0,0),
                        type = 3,
                    }
                    inst.Transform:SetPosition(_table.pt.x,_table.pt.y,_table.pt.z)
                    inst:SetType(_table.type)
                    inst.Ready = true
                end)
                inst:DoTaskInTime(0,function()
                    if inst.Ready ~= true then
                        inst:SetType()
                    end
                end)

            end,
        },

    --------------------------------------------------------------------

}

TUNING.FUNNY_CAT_NATURAL_RESOURCES = {}

for k, v in pairs(temp_table) do
    table.insert(TUNING.FUNNY_CAT_NATURAL_RESOURCES,k)
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end