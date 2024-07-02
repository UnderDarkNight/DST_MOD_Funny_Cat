

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
        --     before_pristine_init = function(inst)
            
        --     end,
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
    --- 骷髅、前辈
        ["skeleton"] = {
            bank = "skeleton",
            build = "skeletons",
            -- anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "cactus.png",
            common_postinit = function(inst)
                MakeSmallObstaclePhysics(inst, 0.25)
            end,
            master_postinit = function(inst)
                inst.AnimState:PlayAnimation("idle"..tostring(math.random(6)))
            end,
        },
    --------------------------------------------------------------------
    --- 骷髅、前辈（被烧过的）
        ["scorched_skeleton"] = {
            bank = "skeleton",
            build = "scorched_skeletons",
            -- anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "cactus.png",
            common_postinit = function(inst)
                MakeSmallObstaclePhysics(inst, 0.25)
            end,
            master_postinit = function(inst)
                inst.AnimState:PlayAnimation("idle"..tostring(math.random(6)))
            end,
        },
    --------------------------------------------------------------------
    --- 猪屋
        ["pighouse"] = {
            bank = "pig_house",
            build = "pig_house",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            light = true,
            sound = true,
            map = "pighouse.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)                
                inst.Light:SetFalloff(1)
                inst.Light:SetIntensity(.5)
                inst.Light:SetRadius(1)
                inst.Light:Enable(false)
                inst.Light:SetColour(180/255, 195/255, 50/255)
                MakeSnowCoveredPristine(inst)
                --------------------------------------------------------------------------------------------------
                --- window
                    local function MakeWindowSnow()
                        local inst = CreateEntity("Pighouse.MakeWindowSnow")
                    
                        inst.entity:AddTransform()
                        inst.entity:AddAnimState()
                    
                        inst:AddTag("DECOR")
                        inst:AddTag("NOCLICK")
                        --[[Non-networked entity]]
                        inst.persists = false
                    
                        inst.AnimState:SetBank("pig_house")
                        inst.AnimState:SetBuild("pig_house")
                        inst.AnimState:PlayAnimation("windowsnow_idle")
                        inst.AnimState:SetFinalOffset(2)
                    
                        inst:Hide()
                    
                        MakeSnowCovered(inst)
                    
                        return inst
                    end
                    local function MakeWindow()
                        local inst = CreateEntity("Pighouse.MakeWindow")
                    
                        inst.entity:AddTransform()
                        inst.entity:AddAnimState()
                    
                        inst:AddTag("DECOR")
                        inst:AddTag("NOCLICK")
                        --[[Non-networked entity]]
                        inst.persists = false
                    
                        inst.AnimState:SetBank("pig_house")
                        inst.AnimState:SetBuild("pig_house")
                        inst.AnimState:PlayAnimation("windowlight_idle")
                        inst.AnimState:SetLightOverride(.6)
                        inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
                        inst.AnimState:SetFinalOffset(1)
                    
                        inst:Hide()
                    
                        return inst
                    end
                    local function OnUpdateWindow(window, inst, snow)
                        if inst:HasTag("burnt") then
                            inst._windowsnow = nil
                            inst._window = nil
                            snow:Remove()
                            window:Remove()
                        elseif inst.Light:IsEnabled() and inst.AnimState:IsCurrentAnimation("lit") then
                            local build_name = inst.AnimState:GetSkinBuild()
                            if build_name ~= inst._last_skin_build then
                                inst._last_skin_build = build_name
                                if build_name ~= "" then
                                    window.AnimState:SetSkin(build_name)
                                    snow.AnimState:SetSkin(build_name)
                                else
                                    window.AnimState:SetBuild("pig_house")
                                    snow.AnimState:SetBuild("pig_house")
                                end
                            end
                    
                            if not window._shown then
                                window._shown = true
                    
                                window:Show()
                                snow:Show()
                            end
                        elseif window._shown then
                            window._shown = false
                            window:Hide()
                            snow:Hide()
                        end
                    end
                    
                    if not TheNet:IsDedicated() then
                        inst._window = MakeWindow()
                        inst._window.entity:SetParent(inst.entity)
                        inst._windowsnow = MakeWindowSnow()
                        inst._windowsnow.entity:SetParent(inst.entity)
                        if not TheWorld.ismastersim then
                            inst._window:DoPeriodicTask(FRAMES, OnUpdateWindow, nil, inst, inst._windowsnow)
                        end
                    end
                --------------------------------------------------------------------------------------------------
                ---
                    local function LightsOn(inst)
                        if TheWorld.state.iscaveday then
                            return
                        end
                        if not inst:HasTag("burnt") and not inst.lightson then
                            inst.Light:Enable(true)
                            inst.AnimState:PlayAnimation("lit", true)
                            inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lighton")
                            inst.lightson = true
                    
                            local build_name = inst.AnimState:GetSkinBuild()
                            if inst._window ~= nil then
                                if build_name ~= "" then
                                    inst._window.AnimState:SetSkin(build_name)
                                end
                                inst._window.AnimState:PlayAnimation("windowlight_idle", true)
                                inst._window:Show()
                            end
                            if inst._windowsnow ~= nil then
                                if build_name ~= "" then
                                    inst._windowsnow.AnimState:SetSkin(build_name)
                                end
                                inst._windowsnow.AnimState:PlayAnimation("windowsnow_idle", true)
                                inst._windowsnow:Show()
                            end
                        end
                    end
                    inst.LightsOn = LightsOn

                    local function LightsOff(inst)
                        if not inst:HasTag("burnt") and inst.lightson then
                            inst.Light:Enable(false)
                            inst.AnimState:PlayAnimation("idle", true)
                            inst.SoundEmitter:PlaySound("dontstarve/pig/pighut_lightoff")
                            inst.lightson = false
                            if inst._window ~= nil then
                                inst._window:Hide()
                            end
                            if inst._windowsnow ~= nil then
                                inst._windowsnow:Hide()
                            end
                        end
                    end
                    inst.LightsOff = LightsOff
                --------------------------------------------------------------------------------------------------
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)

                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(10, 13)
                inst.components.playerprox:SetOnPlayerNear(function(inst)
                    inst:LightsOff()
                end)
                inst.components.playerprox:SetOnPlayerFar(function(inst)
                    inst:LightsOn()
                end)

                inst:WatchWorldState("iscaveday",function()
                    if TheWorld.state.iscaveday then
                        inst:LightsOff()
                    else
                        if not inst.components.playerprox:IsPlayerClose() then
                            inst:LightsOn()
                        end
                    end
                end)
            end,
        },
    --------------------------------------------------------------------
    --- 漏雨的小屋 mermhouse
        ["mermhouse"] = {
            bank = "merm_house",
            build = "merm_house ",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "mermhouse.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                inst.MiniMapEntity:SetIcon("mermhouse.png")
                inst.AnimState:SetBank("merm_house")
                inst.AnimState:SetBuild("merm_house")
                inst.AnimState:PlayAnimation("idle")
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0, function()
                        if inst.animal == nil or not inst.animal:IsValid() then
                            local animal = SpawnPrefab("merm")
                            inst.animal = animal
                            animal:ListenForEvent("entitysleep",function()
                                animal.Transform:SetPosition(inst.Transform:GetWorldPosition())
                            end)
                            inst:ListenForEvent("onremove",function()
                                animal:Remove()
                            end)
                        end
                        local x,y,z = inst.Transform:GetWorldPosition()
                        inst.animal.Transform:SetPosition(x,y,z)
                    end)
                end
            end,
            assets = {
                Asset("ANIM", "anim/merm_house.zip"),
                Asset("ANIM", "anim/mermhouse_crafted.zip"),
                Asset("MINIMAP_IMAGE", "mermhouse_crafted"),
            },
        },
    --------------------------------------------------------------------
    --- 鱼人工艺屋 mermhouse_crafted
        ["mermhouse_crafted"] = {
            bank = "mermhouse_crafted",
            build = "mermhouse_crafted ",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "mermhouse_crafted.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                inst.MiniMapEntity:SetIcon("mermhouse_crafted.png")
                inst.AnimState:SetBank("mermhouse_crafted")
                inst.AnimState:SetBuild("mermhouse_crafted")
                inst.AnimState:PlayAnimation("idle", true)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0, function()
                        if inst.animal == nil or not inst.animal:IsValid() then
                            local animal = SpawnPrefab("merm")
                            inst.animal = animal
                            animal:ListenForEvent("entitysleep",function()
                                animal.Transform:SetPosition(inst.Transform:GetWorldPosition())
                            end)
                            inst:ListenForEvent("onremove",function()
                                animal:Remove()
                            end)
                        end
                        local x,y,z = inst.Transform:GetWorldPosition()
                        inst.animal.Transform:SetPosition(x,y,z)
                    end)
                end
            end,
            assets = {
                Asset("ANIM", "anim/merm_house.zip"),
                Asset("ANIM", "anim/mermhouse_crafted.zip"),
                Asset("MINIMAP_IMAGE", "mermhouse_crafted"),
            },
        },
    --------------------------------------------------------------------
    --- 鱼人堡垒 mermwatchtower
        ["mermwatchtower"] = {
            bank = "merm_guard_tower",
            build = "merm_guard_tower ",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "merm_guard_tower.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                
                inst.AnimState:SetBank("merm_guard_tower")
                inst.AnimState:SetBuild("merm_guard_tower")
                inst.AnimState:PlayAnimation("idle", true)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst.OnEntityWake = function()
                    inst:DoTaskInTime(0, function()
                        if inst.animal == nil or not inst.animal:IsValid() then
                            local animal = SpawnPrefab("merm")
                            inst.animal = animal
                            animal:ListenForEvent("entitysleep",function()
                                animal.Transform:SetPosition(inst.Transform:GetWorldPosition())
                            end)
                            inst:ListenForEvent("onremove",function()
                                animal:Remove()
                            end)
                        end
                        local x,y,z = inst.Transform:GetWorldPosition()
                        inst.animal.Transform:SetPosition(x,y,z)
                    end)
                end
            end,

        },
    --------------------------------------------------------------------
    --- 兔屋 rabbithouse
        ["rabbithouse"] = {
            bank = "rabbithouse",
            build = "rabbit_house ",
            anim = "idle",
            loop = true,
            icon_data = {

            },
            map = "rabbit_house.png",
            common_postinit = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
                inst.AnimState:SetBank("rabbithouse")
                inst.AnimState:SetBuild("rabbit_house")
                inst.AnimState:PlayAnimation("idle", true)
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst:ListenForEvent("spawn_animal",function()
                    inst:DoTaskInTime(0, function()
                        if inst.animal == nil or not inst.animal:IsValid() then
                            local animal = SpawnPrefab("bunnyman")
                            inst.animal = animal
                            animal:ListenForEvent("entitysleep",function()
                                animal.Transform:SetPosition(inst.Transform:GetWorldPosition())
                            end)
                            animal:ListenForEvent("newstate",function(_,_table)
                                if _table.statename == "sleep" then
                                    _:Remove()
                                end
                            end)
                            inst:ListenForEvent("onremove",function()
                                animal:Remove()
                            end)
                        end
                        local x,y,z = inst.Transform:GetWorldPosition()
                        inst.animal.Transform:SetPosition(x,y,z)
                    end)
                end)
                inst.OnEntityWake = function()
                    if not TheWorld.state.iscaveday then
                        inst:PushEvent("spawn_animal")
                    end
                end
                inst:WatchWorldState("iscaveday",function()
                    if TheWorld.state.iscaveday then
                        if inst.animal and inst.animal:IsAsleep() then
                            inst.animal:Remove()
                            inst.animal = nil
                        end
                    else
                        inst:PushEvent("spawn_animal")
                    end
                end)
            end,

        },
    --------------------------------------------------------------------
    --- 冰箱 icebox
        ["icebox"] = {
            bank = "icebox",
            build = "ice_box ",
            anim = "closed",
            loop = true,
            icon_data = {

            },
            map = "rabbit_house.png",
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)                
            end,
            common_postinit = function(inst)
                inst.AnimState:SetBank("icebox")
                inst.AnimState:SetBuild("ice_box")
                inst.AnimState:PlayAnimation("closed")
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,

        },
    --------------------------------------------------------------------
    --- 盐盒 saltbox
        ["saltbox"] = {
            bank = "saltbox",
            build = "saltbox ",
            anim = "closed",
            loop = true,
            icon_data = {

            },
            map = "rabbit_house.png",
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)                
            end,
            common_postinit = function(inst)
                inst.AnimState:SetBank("saltbox")
                inst.AnimState:SetBuild("saltbox")
                inst.AnimState:PlayAnimation("closed")
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,

        },
    --------------------------------------------------------------------
    --- 烤炉 wintersfeastoven 
        ["wintersfeastoven"] = {
            -- bank = "wintersfeast_oven",
            -- build = "wintersfeast_oven ",
            -- anim = "idle_closed",
            -- loop = true,
            icon_data = {

            },
            fn = function()
                local inst = CreateEntity()

                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddLight()
                inst.entity:AddNetwork()

                MakeObstaclePhysics(inst, 0.8, 1.2)

                inst.MiniMapEntity:SetIcon("wintersfeastoven.png")

                inst.Light:Enable(false)
                inst.Light:SetRadius(2)
                inst.Light:SetFalloff(1.5)
                inst.Light:SetIntensity(.5)
                inst.Light:SetColour(250/255,180/255,50/255)
            -- inst.Light:EnableClientModulation(true)

                inst:AddTag("structure")

                inst.AnimState:SetBank("wintersfeast_oven")
                inst.AnimState:SetBuild("wintersfeast_oven")
                inst.AnimState:PlayAnimation("idle_closed")
                inst.AnimState:SetFinalOffset(1)


                MakeSnowCoveredPristine(inst)

                inst.entity:SetPristine()

                if not TheWorld.ismastersim then
                    return inst
                end

                inst:AddComponent("inspectable")

                MakeSnowCovered(inst)

                return inst
            end

        },
    --------------------------------------------------------------------
    --- 温度计 winterometer   
        ["winterometer"] = {
            icon_data = {

            },
            fn = function()
                local inst = CreateEntity()

                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()

                MakeObstaclePhysics(inst, .4)

                inst.MiniMapEntity:SetIcon("winterometer.png")

                inst.AnimState:SetBank("winter_meter")
                inst.AnimState:SetBuild("winter_meter")
                inst.AnimState:SetPercent("meter", 0)

                inst:AddTag("structure")

                MakeSnowCoveredPristine(inst)


                inst.entity:SetPristine()

                if not TheWorld.ismastersim then
                    return inst
                end
                inst:AddComponent("inspectable")

                MakeSnowCovered(inst)

                local function DoCheckTemp(inst)
                    if not inst:HasTag("burnt") then
                        inst.AnimState:SetPercent("meter", 1 - math.clamp(GetLocalTemperature(inst), 0, TUNING.OVERHEAT_TEMP) / TUNING.OVERHEAT_TEMP)
                    end
                end
                
                local function StartCheckTemp(inst)
                    if inst.task == nil and not inst:HasTag("burnt") then
                        inst.task = inst:DoPeriodicTask(1, DoCheckTemp, 0)
                    end
                end
                inst:ListenForEvent("animover", StartCheckTemp)
                StartCheckTemp(inst)


                return inst
            end

        },
    --------------------------------------------------------------------
    --- 雨量计 rainometer
        ["rainometer"] = {
            icon_data = {
                
            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetIcon("rainometer.png")
                inst.AnimState:SetBank("rain_meter")
                inst.AnimState:SetBuild("rain_meter")
                inst.AnimState:SetPercent("meter", 0)
                MakeSnowCoveredPristine(inst)
                inst.entity:SetPristine()
                if not TheWorld.ismastersim then
                    return inst
                end
                inst:AddComponent("inspectable") 
                MakeSnowCovered(inst)
                local function DoCheckRain(inst)
                    if not inst:HasTag("burnt") then
                        inst.AnimState:SetPercent("meter", TheWorld.state.pop)
                    end
                end                
                local function StartCheckRain(inst)
                    if inst.task == nil and not inst:HasTag("burnt") then
                        inst.task = inst:DoPeriodicTask(1, DoCheckRain, 0)
                    end
                end
                StartCheckRain(inst)
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 避雷针 lightning_rod
        ["lightning_rod"] = {
            icon_data = {
                
            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddLight()
                inst.entity:AddSoundEmitter()
                inst.entity:AddNetwork()            
                inst.MiniMapEntity:SetIcon("lightningrod.png")            
                inst.Light:Enable(false)
                inst.Light:SetRadius(1.5)
                inst.Light:SetFalloff(1)
                inst.Light:SetIntensity(.5)
                inst.Light:SetColour(235/255,121/255,12/255)            
                inst:AddTag("structure")
                inst.AnimState:SetBank("lightning_rod")
                inst.AnimState:SetBuild("lightning_rod")
                inst.AnimState:PlayAnimation("idle")            
                MakeSnowCoveredPristine(inst)
                if not TheWorld.ismastersim then
                    return inst
                end
                inst:AddComponent("inspectable") 
                MakeSnowCovered(inst)
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 木牌 homesign
        ["homesign"] = {
            icon_data = {
                
            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()            
                MakeObstaclePhysics(inst, .2)            
                inst.MiniMapEntity:SetIcon("sign.png")            
                inst.AnimState:SetBank("sign_home")
                inst.AnimState:SetBuild("sign_home")
                inst.AnimState:PlayAnimation("idle")            
                MakeSnowCoveredPristine(inst)
                if not TheWorld.ismastersim then
                    return inst
                end
                inst:AddComponent("inspectable") 
                MakeSnowCovered(inst)
                inst.AnimState:Show("WRITING")
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 指路牌 arrowsign_post
        ["arrowsign_post"] = {
            icon_data = {
                
            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()
                MakeObstaclePhysics(inst, .2)
                inst.MiniMapEntity:SetIcon("sign.png")
                inst.AnimState:SetBank("sign_arrow_post")
                inst.AnimState:SetBuild("sign_arrow_post")
                inst.AnimState:PlayAnimation("idle")
                inst.Transform:SetEightFaced()
                MakeSnowCoveredPristine(inst)
                inst.entity:SetPristine()
                if not TheWorld.ismastersim then
                    return inst
                end
                inst:AddComponent("inspectable")
                MakeSnowCovered(inst)
                inst.AnimState:Show("WRITING")

                inst:DoTaskInTime(0,function()
                    inst.Transform:SetRotation(math.random(-180,180))
                end)

                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 普通箱子 treasurechest
        ["treasurechest"] = {
            bank = "chest",
            build = "treasure_chest",
            anim = "closed",
            map = "chest.png",

            icon_data = {
                
            },
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 华丽箱子 pandoraschest
        ["pandoraschest"] = {
            bank = "pandoras_chest",
            build = "pandoras_chest",
            anim = "closed",
            map = "pandoraschest.png",
            icon_data = {
                
            },
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 大号华丽箱子 minotaurchest
        ["minotaurchest"] = {
            bank = "pandoras_chest_large",
            build = "pandoras_chest_large",
            anim = "closed",
            map = "minotaurchest.png",
            icon_data = {
                
            },
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 泰拉箱子 terrariumchest
        ["terrariumchest"] = {
            bank = "chest",
            build = "treasurechest_terrarium",
            anim = "closed",
            map = "terrariumchest.png",
            icon_data = {
                
            },
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst:SpawnChild("terrariumchest_fx")
            end,
        },
    --------------------------------------------------------------------
    --- 龙鳞箱子 dragonflychest
        ["dragonflychest"] = {
            bank = "dragonfly_chest",
            build = "dragonfly_chest",
            anim = "closed",
            map = "dragonflychest.png",
            icon_data = {
                
            },
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 沉底宝箱 sunkenchest
        ["sunkenchest"] = {
            bank = "sunken_treasurechest",
            build = "sunken_treasurechest",
            anim = "closed",
            map = "sunkenchest.png",
            icon_data = {
                
            },
            before_pristine_init = function(inst)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 龙鳞火龙 dragonflyfurnace
        ["dragonflyfurnace"] = {            
            icon_data = {
                
            },
            fn = function(inst)
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddLight()
                inst.entity:AddNetwork()            
                MakeObstaclePhysics(inst, .5)            
                inst.MiniMapEntity:SetIcon("dragonfly_furnace.png")            
                inst.Light:Enable(true)
                inst.Light:SetRadius(1.0)
                inst.Light:SetFalloff(.9)
                inst.Light:SetIntensity(0.5)
                inst.Light:SetColour(235 / 255, 121 / 255, 12 / 255)            
                inst.AnimState:SetBank("dragonfly_furnace")
                inst.AnimState:SetBuild("dragonfly_furnace")
                inst.AnimState:PlayAnimation("hi", true)
                inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
                inst.AnimState:SetLightOverride(0.4)          
                inst.SoundEmitter:PlaySound("dontstarve/common/together/dragonfly_furnace/fire_LP", "loop")            
                inst.entity:SetPristine()            
                if not TheWorld.ismastersim then
                    return inst
                end                
                inst:AddComponent("inspectable")            
                return inst
            end
            
        },
    --------------------------------------------------------------------
    --- 衣柜 wardrobe
        ["wardrobe"] = {
            bank = "wardrobe",
            build = "wardrobe",
            anim = "closed",
            icon_data = {

            },
            map = "wardrobe.png",
            before_pristine_init = function(inst)
                inst:SetPhysicsRadiusOverride(.8)
                MakeObstaclePhysics(inst, inst.physicsradiusoverride)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 稻草人 scarecrow
        ["scarecrow"] = {
            bank = "scarecrow",
            build = "scarecrow",
            anim = "idle",
            icon_data = {

            },
            map = "scarecrow.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, 0.4)
                inst.AnimState:OverrideSymbol("shadow_hands", "shadow_skinchangefx", "shadow_hands")
                inst.AnimState:OverrideSymbol("shadow_ball", "shadow_skinchangefx", "shadow_ball")
                inst.AnimState:OverrideSymbol("splode", "shadow_skinchangefx", "splode")            
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 肉块雕像 resurrectionstatue
        ["resurrectionstatue"] = {
            bank = "wilsonstatue",
            build = "wilsonstatue",
            anim = "idle",
            icon_data = {

            },
            map = "resurrect.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .3)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 暗影操控器 researchlab3
        ["researchlab3"] = {
            bank = "researchlab3",
            build = "researchlab3",
            anim = "idle",
            icon_data = {

            },
            map = "researchlab3.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(4, 5)
                inst.components.playerprox:SetOnPlayerNear(function()
                    inst.AnimState:PlayAnimation("proximity_pre")
                    inst.AnimState:PushAnimation("proximity_loop", true)
                end)
                inst.components.playerprox:SetOnPlayerFar(function()
                    inst.AnimState:PushAnimation("proximity_pst")
                    inst.AnimState:PushAnimation("idle", false)                    
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 灵子分解器 researchlab4
        ["researchlab4"] = {
            bank = "researchlab4",
            build = "researchlab4",
            anim = "idle",
            icon_data = {

            },
            map = "researchlab4.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(4, 5)
                inst.components.playerprox:SetOnPlayerNear(function()
                    inst.AnimState:PlayAnimation("proximity_loop", true)
                end)
                inst.components.playerprox:SetOnPlayerFar(function()
                    inst.AnimState:PushAnimation("idle", false)                    
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 科学机器 researchlab
        ["researchlab"] = {
            bank = "researchlab",
            build = "researchlab",
            anim = "idle",
            icon_data = {

            },
            map = "researchlab.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(4, 5)
                inst.components.playerprox:SetOnPlayerNear(function()
                    inst.AnimState:PlayAnimation("proximity_loop", true)
                end)
                inst.components.playerprox:SetOnPlayerFar(function()
                    inst.AnimState:PushAnimation("idle", false)                    
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 炼金引擎 researchlab2
        ["researchlab2"] = {
            bank = "researchlab2",
            build = "researchlab2",
            anim = "idle",
            icon_data = {

            },
            map = "researchlab2.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(4, 5)
                inst.components.playerprox:SetOnPlayerNear(function()
                    inst.AnimState:PlayAnimation("proximity_loop", true)
                end)
                inst.components.playerprox:SetOnPlayerFar(function()
                    inst.AnimState:PushAnimation("idle", false)                    
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 姐妹骨灰盒 sisturn
        ["sisturn"] = {
            bank = "sisturn",
            build = "sisturn",
            anim = "idle",
            icon_data = {

            },
            map = "sisturn.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()
                    if math.random() < 0.5 then
                        local FLOWER_LAYERS = {"flower1_roof","flower2_roof","flower1","flower2",}
                        for _, v in ipairs(FLOWER_LAYERS) do
                            inst.AnimState:Hide(v)
                        end
                    end
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 制图桌 cartographydesk
        ["cartographydesk"] = {
            bank = "cartography_desk",
            build = "cartography_desk",
            anim = "idle",
            icon_data = {

            },
            map = "cartographydesk.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 陶轮 sculptingtable
        ["sculptingtable"] = {
            bank = "sculpting_station",
            build = "sculpting_station",
            anim = "idle",
            icon_data = {

            },
            map = "sculpting_station.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 疯狂科学家实验室 madscience_lab
        ["madscience_lab"] = {
            bank = "madscience_lab",
            build = "madscience_lab",
            anim = "idle",
            icon_data = {

            },
            light = true,
            map = "madscience_lab.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .5)
                inst.AnimState:SetFinalOffset(1)
                MakeSnowCoveredPristine(inst)
                inst.Light:Enable(false)
                inst.Light:SetRadius(2)
                inst.Light:SetFalloff(1.5)
                inst.Light:SetIntensity(.5)
                inst.Light:SetColour(250/255,180/255,50/255)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(4, 5)
                inst.components.playerprox:SetOnPlayerNear(function()
                    local create_fx_with_state = function(state)
                        if inst.fx then
                            inst.fx:Remove()
                        end
                        local fx = SpawnPrefab("madscience_lab_fire")
                        fx.entity:SetParent(inst.entity)
                        fx.entity:AddFollower()
                        fx.Follower:FollowSymbol(inst.GUID, "fire_guide", 0, 0, 0)
                        inst.fx = fx
                        if state == 1 or state == 2 then
                            inst.fx.AnimState:PlayAnimation("fire1",true)
                        elseif state == 3 then
                            inst.fx.AnimState:PlayAnimation("fire3_pre")
                            inst.fx.AnimState:PushAnimation("fire3",true) 
                        end
                        inst.Light:Enable(true)
                    end
                    local temp_num = math.random(1000)/1000
                    if temp_num < 0.4 then
                        inst.AnimState:PlayAnimation("cooking_loop1", true)
                        create_fx_with_state(1)
                    elseif temp_num < 0.8 then
                        inst.AnimState:PlayAnimation("cooking_loop2", true)
                        create_fx_with_state(2)
                    else
                        inst.AnimState:PlayAnimation("cooking_loop3_pre")
                        inst.AnimState:PushAnimation("cooking_loop3", true)
                        create_fx_with_state(3)                        
                    end
                end)
                inst.components.playerprox:SetOnPlayerFar(function()
                    inst.AnimState:PushAnimation("idle", false)
                    if inst.fx then
                        inst.fx:Remove()
                        inst.fx = nil
                    end
                    inst.Light:Enable(false)
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 钓具容器 tacklestation
        ["tacklestation"] = {
            bank = "tackle_station",
            build = "tackle_station",
            anim = "idle",
            icon_data = {

            },
            map = "tacklestation.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                inst.MiniMapEntity:SetPriority(5)

                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:AddComponent("playerprox")
                inst.components.playerprox:SetDist(4, 5)
                inst.components.playerprox:SetOnPlayerNear(function()
                    inst.AnimState:PlayAnimation("proximity_loop",true)
                end)
                inst.components.playerprox:SetOnPlayerFar(function()
                    inst.AnimState:PlayAnimation("idle", false)
                end)
                MakeSnowCovered(inst)
            end,
        },
    --------------------------------------------------------------------
    --- 远古伪科学站 ancient_altar    ancient_altar_broken
        ["ancient_altar"] = {

            icon_data = {

            },
            fn = function()
                ------------------------------------------------------------------------------
                    local anim = "idle_full"
                ------------------------------------------------------------------------------
                --  light
                    local MAX_LIGHT_ON_FRAME = 15
                    local MAX_LIGHT_OFF_FRAME = 30

                    local function OnUpdateLight(inst, dframes)
                        local frame = inst._lightframe:value() + dframes
                        if frame >= inst._lightmaxframe then
                            inst._lightframe:set_local(inst._lightmaxframe)
                            inst._lighttask:Cancel()
                            inst._lighttask = nil
                        else
                            inst._lightframe:set_local(frame)
                        end

                        local k = frame / inst._lightmaxframe

                        if inst._islighton:value() then
                            inst.Light:SetRadius(3 * k)
                        else
                            inst.Light:SetRadius(3 * (1 - k))
                        end

                        if TheWorld.ismastersim then
                            inst.Light:Enable(inst._islighton:value() or frame < inst._lightmaxframe)
                            if not inst._islighton:value() then
                                inst.SoundEmitter:KillSound("idlesound")
                            end
                        end
                    end

                    local function OnLightDirty(inst)
                        if inst._lighttask == nil then
                            inst._lighttask = inst:DoPeriodicTask(FRAMES, OnUpdateLight, nil, 1)
                        end
                        inst._lightmaxframe = inst._islighton:value() and MAX_LIGHT_ON_FRAME or MAX_LIGHT_OFF_FRAME
                        OnUpdateLight(inst, 0)
                    end
                ------------------------------------------------------------------------------
                ---
                    local function complete_onturnon(inst)
                        if inst.AnimState:IsCurrentAnimation("proximity_loop") then
                            --NOTE: push again even if already playing, in case an idle was also pushed
                            inst.AnimState:PushAnimation("proximity_loop", true)
                        else
                            inst.AnimState:PlayAnimation("proximity_loop", true)
                        end
                        if not inst.SoundEmitter:PlayingSound("idlesound") then
                            inst.SoundEmitter:PlaySound("dontstarve/common/ancienttable_LP", "idlesound")
                        end
                        if not inst._islighton:value() then
                            inst._islighton:set(true)
                            inst._lightframe:set(math.floor((1 - inst._lightframe:value() / MAX_LIGHT_OFF_FRAME) * MAX_LIGHT_ON_FRAME + .5))
                            OnLightDirty(inst)
                        end
                    end
                    
                    local function complete_onturnoff(inst)
                        inst.AnimState:PushAnimation("idle_full")
                        if inst._islighton:value() then
                            inst._islighton:set(false)
                            inst._lightframe:set(math.floor((1 - inst._lightframe:value() / MAX_LIGHT_ON_FRAME) * MAX_LIGHT_OFF_FRAME + .5))
                            OnLightDirty(inst)
                        end
                    end
                ------------------------------------------------------------------------------
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddSoundEmitter()
                inst.entity:AddLight()
                inst.entity:AddNetwork()
                MakeObstaclePhysics(inst, 0.8, 1.2)
                inst.MiniMapEntity:SetPriority(5)
                inst.MiniMapEntity:SetIcon("tab_crafting_table.png")
                inst.AnimState:SetBank("crafting_table")
                inst.AnimState:SetBuild("crafting_table")
                inst.AnimState:PlayAnimation(anim)
                inst.Light:Enable(false)
                inst.Light:SetRadius(0)
                inst.Light:SetFalloff(1)
                inst.Light:SetIntensity(.5)
                inst.Light:SetColour(1, 1, 1)
                inst.Light:EnableClientModulation(true)

                inst:AddTag("altar")
                inst:AddTag("structure")
                inst:AddTag("stone")

                --prototyper (from prototyper component) added to pristine state for optimization
                inst:AddTag("prototyper")

                inst:SetPrefabNameOverride("ancient_altar")

                inst._lightframe = net_smallbyte(inst.GUID, "ancient_altar._lightframe", "lightdirty")
                inst._islighton = net_bool(inst.GUID, "ancient_altar._islighton", "lightdirty")
                inst._lightmaxframe = MAX_LIGHT_OFF_FRAME
                inst._lightframe:set(inst._lightmaxframe)
                inst._lighttask = nil

                inst.entity:SetPristine()

                if not TheWorld.ismastersim then
                    inst:ListenForEvent("lightdirty", OnLightDirty)

                    return inst
                end

                inst:AddComponent("inspectable")
                ------------------------------------------------------------------------------
                ---
                    inst:AddComponent("playerprox")
                    inst.components.playerprox:SetDist(4, 5)
                    inst.components.playerprox:SetOnPlayerNear(function()
                        -- inst.AnimState:PlayAnimation("proximity_loop",true)
                        complete_onturnon(inst)
                    end)
                    inst.components.playerprox:SetOnPlayerFar(function()
                        -- inst.AnimState:PlayAnimation("idle_broken", false)
                        complete_onturnoff(inst)
                    end)
                ------------------------------------------------------------------------------


                return inst

            end,
            
        },
        ["ancient_altar_broken"] = {

            icon_data = {

            },
            fn = function()
                ------------------------------------------------------------------------------
                    local anim = "idle_broken"
                ------------------------------------------------------------------------------
                --  light
                    local MAX_LIGHT_ON_FRAME = 15
                    local MAX_LIGHT_OFF_FRAME = 30

                    local function OnUpdateLight(inst, dframes)
                        local frame = inst._lightframe:value() + dframes
                        if frame >= inst._lightmaxframe then
                            inst._lightframe:set_local(inst._lightmaxframe)
                            inst._lighttask:Cancel()
                            inst._lighttask = nil
                        else
                            inst._lightframe:set_local(frame)
                        end

                        local k = frame / inst._lightmaxframe

                        if inst._islighton:value() then
                            inst.Light:SetRadius(3 * k)
                        else
                            inst.Light:SetRadius(3 * (1 - k))
                        end

                        if TheWorld.ismastersim then
                            inst.Light:Enable(inst._islighton:value() or frame < inst._lightmaxframe)
                            if not inst._islighton:value() then
                                inst.SoundEmitter:KillSound("idlesound")
                            end
                        end
                    end

                    local function OnLightDirty(inst)
                        if inst._lighttask == nil then
                            inst._lighttask = inst:DoPeriodicTask(FRAMES, OnUpdateLight, nil, 1)
                        end
                        inst._lightmaxframe = inst._islighton:value() and MAX_LIGHT_ON_FRAME or MAX_LIGHT_OFF_FRAME
                        OnUpdateLight(inst, 0)
                    end
                ------------------------------------------------------------------------------
                ---
                    local function broken_onturnon(inst)
                        if not inst.SoundEmitter:PlayingSound("idlesound") then
                            inst.SoundEmitter:PlaySound("dontstarve/common/ancienttable_LP", "idlesound")
                        end
                        if not inst._islighton:value() then
                            inst._islighton:set(true)
                            inst._lightframe:set(math.floor((1 - inst._lightframe:value() / MAX_LIGHT_OFF_FRAME) * MAX_LIGHT_ON_FRAME + .5))
                            OnLightDirty(inst)
                        end
                    end
                    
                    local function broken_onturnoff(inst)
                        if inst._islighton:value() then
                            inst._islighton:set(false)
                            inst._lightframe:set(math.floor((1 - inst._lightframe:value() / MAX_LIGHT_ON_FRAME) * MAX_LIGHT_OFF_FRAME + .5))
                            OnLightDirty(inst)
                        end
                    end
                ------------------------------------------------------------------------------
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddSoundEmitter()
                inst.entity:AddLight()
                inst.entity:AddNetwork()
                MakeObstaclePhysics(inst, 0.8, 1.2)
                inst.MiniMapEntity:SetPriority(5)
                inst.MiniMapEntity:SetIcon("tab_crafting_table.png")
                inst.AnimState:SetBank("crafting_table")
                inst.AnimState:SetBuild("crafting_table")
                inst.AnimState:PlayAnimation(anim)
                inst.Light:Enable(false)
                inst.Light:SetRadius(0)
                inst.Light:SetFalloff(1)
                inst.Light:SetIntensity(.5)
                inst.Light:SetColour(1, 1, 1)
                inst.Light:EnableClientModulation(true)

                inst:AddTag("altar")
                inst:AddTag("structure")
                inst:AddTag("stone")

                --prototyper (from prototyper component) added to pristine state for optimization
                inst:AddTag("prototyper")

                inst:SetPrefabNameOverride("ancient_altar")

                inst._lightframe = net_smallbyte(inst.GUID, "ancient_altar._lightframe", "lightdirty")
                inst._islighton = net_bool(inst.GUID, "ancient_altar._islighton", "lightdirty")
                inst._lightmaxframe = MAX_LIGHT_OFF_FRAME
                inst._lightframe:set(inst._lightmaxframe)
                inst._lighttask = nil

                inst.entity:SetPristine()

                if not TheWorld.ismastersim then
                    inst:ListenForEvent("lightdirty", OnLightDirty)

                    return inst
                end

                inst:AddComponent("inspectable")
                ------------------------------------------------------------------------------
                ---
                    inst:AddComponent("playerprox")
                    inst.components.playerprox:SetDist(4, 5)
                    inst.components.playerprox:SetOnPlayerNear(function()
                        -- inst.AnimState:PlayAnimation("proximity_loop",true)
                        broken_onturnon(inst)
                    end)
                    inst.components.playerprox:SetOnPlayerFar(function()
                        -- inst.AnimState:PlayAnimation("idle_broken", false)
                        broken_onturnoff(inst)
                    end)
                ------------------------------------------------------------------------------


                return inst

            end,
            
        },
    --------------------------------------------------------------------
    --- 舔岩块 saltlick
        ["saltlick"] ={
            bank = "salt_lick",
            build = "salt_lick",
            anim = "idle1",
            map = "saltlick.png",
            icon_data = {

            },
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .4)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)
                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst:DoTaskInTime(0,function()
                    inst.AnimState:PlayAnimation("idle"..tostring(math.random(6)))
                end)
            end,
        },
    --------------------------------------------------------------------
    --- 营火 campfire
        ["campfire"] ={
            icon_data = {

            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddNetwork()
                MakeObstaclePhysics(inst, .2)
                inst.AnimState:SetBank("campfire")
                inst.AnimState:SetBuild("campfire")
                inst.AnimState:PlayAnimation("idle", false)
                inst.entity:SetPristine()
                if not TheWorld.ismastersim then
                    return inst
                end

                inst:AddComponent("inspectable")
                -----------------------------------------------
                --- 
                    inst:ListenForEvent("Set",function(_,level)
                        if inst.fx == nil then
                            local fx = SpawnPrefab("campfirefire")
                            inst.fx = fx
                            inst:ListenForEvent("onremove",function()
                                fx:Remove() 
                            end)
                            inst:AddChild(fx)
                            fx.entity:AddFollower()
                            fx.Follower:FollowSymbol(inst.GUID, "firefx", 0, 0, 0)
                        end
                        inst.fx.components.firefx:SetLevel(level)
                    end)
                -----------------------------------------------
                --
                    inst:DoTaskInTime(0,function()
                        inst:PushEvent("Set",math.random(4))
                    end)
                -----------------------------------------------
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 火坑 campfire
        ["firepit"] ={
            icon_data = {

            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()

                inst.MiniMapEntity:SetIcon("firepit.png")
                inst.MiniMapEntity:SetPriority(1)
                MakeObstaclePhysics(inst, .3)
                inst.AnimState:SetBank("firepit")
                inst.AnimState:SetBuild("firepit")
                inst.AnimState:PlayAnimation("idle", false)
                inst.entity:SetPristine()
                if not TheWorld.ismastersim then
                    return inst
                end

                inst:AddComponent("inspectable")
                -----------------------------------------------
                --- 
                    inst:ListenForEvent("Set",function(_,level)
                        if inst.fx == nil then
                            local fx = SpawnPrefab("campfirefire")
                            inst.fx = fx
                            inst:ListenForEvent("onremove",function()
                                fx:Remove() 
                            end)
                            inst:AddChild(fx)
                            fx.entity:AddFollower()
                            fx.Follower:FollowSymbol(inst.GUID, "firefx", 0, 25, 0, true)
                        end
                        inst.fx.components.firefx:SetLevel(level)
                    end)
                -----------------------------------------------
                --
                    inst:DoTaskInTime(0,function()
                        inst:PushEvent("Set",math.random(4))
                    end)
                -----------------------------------------------
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 吸热营火 coldfire
        ["coldfire"] ={
            icon_data = {

            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()

                inst.MiniMapEntity:SetIcon("coldfire.png")
                inst.MiniMapEntity:SetPriority(1)
            
                inst.AnimState:SetBank("coldfire")
                inst.AnimState:SetBuild("coldfire")
                inst.AnimState:PlayAnimation("idle_loop", false)

                inst.entity:SetPristine()
                if not TheWorld.ismastersim then
                    return inst
                end

                inst:AddComponent("inspectable")
                -----------------------------------------------
                --- 
                    inst:ListenForEvent("Set",function(_,level)
                        if inst.fx == nil then
                            local fx = SpawnPrefab("coldfirefire")
                            inst.fx = fx
                            inst:ListenForEvent("onremove",function()
                                fx:Remove() 
                            end)
                            inst:AddChild(fx)
                            fx.entity:AddFollower()
                            fx.Follower:FollowSymbol(inst.GUID, "firefx", 0, 25, 0, true)
                        end
                        inst.fx.components.firefx:SetLevel(level)
                    end)
                -----------------------------------------------
                --
                    inst:DoTaskInTime(0,function()
                        inst:PushEvent("Set",math.random(6))
                    end)
                -----------------------------------------------
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 吸热火坑 coldfirepit
        ["coldfirepit"] ={
            icon_data = {

            },
            fn = function()
                local inst = CreateEntity()
                inst.entity:AddTransform()
                inst.entity:AddAnimState()
                inst.entity:AddSoundEmitter()
                inst.entity:AddMiniMapEntity()
                inst.entity:AddNetwork()

                inst.MiniMapEntity:SetIcon("coldfirepit.png")
                inst.MiniMapEntity:SetPriority(1)            
                inst.AnimState:SetBank("coldfirepit")
                inst.AnimState:SetBuild("coldfirepit")
                inst.AnimState:PlayAnimation("idle", false)
                MakeObstaclePhysics(inst, .3)

                inst.entity:SetPristine()
                if not TheWorld.ismastersim then
                    return inst
                end

                inst:AddComponent("inspectable")
                -----------------------------------------------
                --- 
                    inst:ListenForEvent("Set",function(_,level)
                        if inst.fx == nil then
                            local fx = SpawnPrefab("coldfirefire")
                            inst.fx = fx
                            inst:ListenForEvent("onremove",function()
                                fx:Remove() 
                            end)
                            inst:AddChild(fx)
                            fx.entity:AddFollower()
                            fx.Follower:FollowSymbol(inst.GUID, "firefx", 0, 75, 0, true)
                        end
                        inst.fx.components.firefx:SetLevel(level)
                    end)
                -----------------------------------------------
                --
                    inst:DoTaskInTime(0,function()
                        inst:PushEvent("Set",math.random(6))
                    end)
                -----------------------------------------------
                return inst
            end,
        },
    --------------------------------------------------------------------
    --- 帐篷 tent siestahut
        ["tent"] = {
            bank = "tent",
            build = "tent",
            anim = "idle",
            loop = true,
            map = "tent.png",
            icon_data = {

            },
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
        ["siestahut"] = {
            bank = "siesta_canopy",
            build = "siesta_canopy",
            anim = "idle",
            loop = true,
            map = "siestahut.png",
            icon_data = {

            },
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, 1)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
            end,
        },
        
    --------------------------------------------------------------------
    -- 蜂箱 ( beebox )
        ["beebox"] = {
            bank = "bee_box",
            build = "bee_box",
            anim = "idle",
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
                                        local bee = SpawnPrefab(math.random()<0.1 and "killerbee" or "bee")
                                        bee.Transform:SetPosition(x,y,z)
                                        table.insert(inst.bees,bee)
                                        bee:ListenForEvent("entitysleep",function()
                                            bee.Transform:SetPosition(x,y,z)
                                        end)
                                        inst:ListenForEvent("onremove",function()
                                            bee:Remove()
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
    -- 烹饪锅 cookpot archive_cookpot
        ["cookpot"] = {
            bank = "cook_pot",
            build = "cook_pot",
            anim = "idle_empty",
            icon_data = {
            },
            map = "cookpot.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst:DoTaskInTime(0,function()
                    if math.random() < 0.3 then
                        inst.AnimState:PlayAnimation("cooking_loop", true)
                    end
                end)
            end,
        },
        ["archive_cookpot"] = {
            bank = "cook_pot",
            build = "cookpot_archive",
            anim = "idle_empty",
            icon_data = {
            },
            map = "cookpot_archive.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .5)
                MakeSnowCoveredPristine(inst)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                MakeSnowCovered(inst)
                inst:DoTaskInTime(0,function()
                    if math.random() < 0.3 then
                        inst.AnimState:PlayAnimation("cooking_loop", true)
                    end
                end)
            end,
        },
    --------------------------------------------------------------------
    -- 格罗姆雕像 statueglommer
        ["statueglommer"] = {
            bank = "glommer_statue",
            build = "glommer_statue",
            anim = "full",
            icon_data = {
            },
            map = "statueglommer.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .75)
                inst.MiniMapEntity:SetPriority(5)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
            end,
        },
    --------------------------------------------------------------------
    -- 老麦雕像 statuemaxwell
        ["statuemaxwell"] = {
            bank = "statue_maxwell",
            build = "statue_maxwell_build",
            anim = "idle_full",
            icon_data = {
            },
            map = "statue.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, .66)
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                inst:DoTaskInTime(0,function()
                    if math.random() < 0.5 then
                        inst.AnimState:AddOverrideBuild("statue_maxwell_vine_build")
                    end
                end)
            end,
        },
    --------------------------------------------------------------------
    -- 大理石雕像 statue_marble
        ["statue_marble"] = {
            bank = "statue_small",
            build = "statue_small",
            anim = "full",
            icon_data = {
            },
            map = "statue_small.png",
            before_pristine_init = function(inst)
                MakeObstaclePhysics(inst, 0.66)
                inst.AnimState:OverrideSymbol("swap_statue", "statue_small_type1_build", "swap_statue")
            end,
            common_postinit = function(inst)                
            end,
            master_postinit = function(inst)
                local function setstatuetype(inst, typeid)
                    typeid = typeid or math.random(4)
                    if typeid ~= inst.typeid then
                        inst.typeid = typeid
                        inst.AnimState:OverrideSymbol("swap_statue", "statue_small_type"..tostring(typeid).."_build", "swap_statue")
                    end
                end
                inst:DoTaskInTime(0,function()
                    setstatuetype(inst)
                end)
            end,
        },
    --------------------------------------------------------------------
}

TUNING.FUNNY_CAT_BUILDING_RESOURCES = TUNING.FUNNY_CAT_BUILDING_RESOURCES or {}

for k, v in pairs(temp_table) do
    table.insert(TUNING.FUNNY_CAT_BUILDING_RESOURCES,k)
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end