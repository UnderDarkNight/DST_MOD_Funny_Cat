

TUNING.FUNNY_CAT_RESOURCES = TUNING.FUNNY_CAT_RESOURCES or {}
local temp_table = {
    --------------------------------------------------------------------
    -- 漂流瓶( messagebottle )
        ["messagebottle"] = {
            bank = "bottle",
            build = "bottle",
            -- anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                -- MakeInventoryPhysics(inst)
                MakeInventoryFloatable(inst, "small", -0.04, 1)
            end,
            master_postinit = function(inst)

                
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        if math.random() < 0.5 then
                            inst.AnimState:PlayAnimation("idle_empty_water")
                        else
                            inst.AnimState:PlayAnimation("idle_water")
                        end
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                

            end,
        },
    --------------------------------------------------------------------
    -- 斧头( axe goldenaxe moonglassaxe )
        ["axe"] = {
            bank = "axe",
            build = "axe",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})
            end,
            master_postinit = function(inst)                
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "swap_axe"})
            end,
        },
        ["goldenaxe"] = {
            bank = "goldenaxe",
            build = "goldenaxe",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})
            end,
            master_postinit = function(inst)                
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "swap_goldenaxe"})
            end,
        },
        ["moonglassaxe"] = {
            bank = "glassaxe",
            build = "glassaxe",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", 0.05, {1.2, 0.75, 1.2})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                local swap_data = {sym_build = "swap_glassaxe", bank = "glassaxe"}
                inst.components.floater:SetBankSwapOnFloat(true, -11, swap_data)
            end,
        },
    --------------------------------------------------------------------
    -- 锄头( pickaxe goldenpickaxe )
        ["pickaxe"] = {
            bank = "pickaxe",
            build = "pickaxe",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "swap_pickaxe"})
            end,
        },
        ["goldenpickaxe"] = {
            bank = "goldenpickaxe",
            build = "goldenpickaxe",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "swap_goldenpickaxe"})
            end,
        },
    --------------------------------------------------------------------
    --  多用斧镐 ( multitool_axe_pickaxe )
        ["multitool_axe_pickaxe"] = {
            bank = "multitool_axe_pickaxe",
            build = "multitool_axe_pickaxe",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_multitool_axe_pickaxe"}
                MakeInventoryFloatable(inst, "med", 0.05, {0.7, 0.4, 0.7}, true, -13, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    --  铲子 ( shovel  goldenshovel shovel_lunarplant )
        ["shovel"] = {
            bank = "shovel",
            build = "shovel",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.8, 0.4, 0.8})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, 7, {sym_build = "swap_shovel"})
            end,
        },
        ["goldenshovel"] = {
            bank = "goldenshovel",
            build = "goldenshovel",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.8, 0.4, 0.8})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, 7, {sym_build = "swap_goldenshovel"})
            end,
        },
        ["shovel_lunarplant"] = {
            bank = "shovel_lunarplant",
            build = "shovel_lunarplant",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                inst:AddComponent("floater")
                inst.components.floater:SetBankSwapOnFloat(true, 7, { sym_build = "shovel_lunarplant", sym_name = "swap_shovel_lunarplant" })
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 草叉 pitchfork goldenpitchfork
        ["pitchfork"] = {
            bank = "pitchfork",
            build = "pitchfork",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.78, 0.4, 0.78}, true, 7, {sym_build = "swap_pitchfork"})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
        ["goldenpitchfork"] = {
            bank = "goldenpitchfork",
            build = "goldenpitchfork",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.78, 0.4, 0.78}, true, 7, {sym_build = "swap_pitchfork"})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                inst.components.floater:SetBankSwapOnFloat(true, 7, {sym_build = "swap_goldenshovel"})
            end,
        },
    --------------------------------------------------------------------
    -- 锤子 hammer
        ["hammer"] = {
            bank = "hammer",
            build = "swap_hammer",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.7, 0.4, 0.7}, true, -13, {sym_build = "swap_hammer"})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 暗影收割者 voidcloth_scythe
        ["voidcloth_scythe"] = {
            bank = "scythe_voidcloth",
            build = "scythe_voidcloth",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                inst:AddComponent("floater")
                local SWAP_DATA = { sym_build = "scythe_voidcloth", sym_name = "swap_scythe", bank = "scythe_voidcloth" }
                inst.components.floater:SetBankSwapOnFloat(true, -20, SWAP_DATA)
                if inst.fx ~= nil then
                    inst.fx:Show()
                end
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end

                local function SetFxOwner(inst, owner)
                    if inst._fxowner ~= nil and inst._fxowner.components.colouradder ~= nil then
                        inst._fxowner.components.colouradder:DetachChild(inst.fx)
                    end
                    inst._fxowner = owner  
                    inst.fx.entity:SetParent(inst.entity)
                    --For floating
                    inst.fx.Follower:FollowSymbol(inst.GUID, "swap_spear", nil, nil, nil, true, nil, 2)
                    inst.fx.components.highlightchild:SetOwner(inst)
                    inst.fx:ToggleEquipped(false)                    
                end
                local frame = math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1
                inst.AnimState:SetFrame(frame)
                inst:DoTaskInTime(0,play_water_anim)
                inst.fx = SpawnPrefab("voidcloth_scythe_fx")
                inst.fx.AnimState:SetFrame(frame)
                SetFxOwner(inst, nil)

            end,
        },
    --------------------------------------------------------------------
    -- 亮茄粉碎者 pickaxe_lunarplant
        ["pickaxe_lunarplant"] = {
            bank = "pickaxe_lunarplant",
            build = "pickaxe_lunarplant",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                inst:AddComponent("floater")
                local SWAP_DATA = { sym_build = "pickaxe_lunarplant", sym_name = "swap_pickaxe_lunarplant" }
                inst.components.floater:SetBankSwapOnFloat(true, -13, SWAP_DATA)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 剃刀 razor
        ["razor"] = {
            bank = "razor",
            build = "swap_razor",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", 0.08, {0.9, 0.7, 0.9}, true, -2, {sym_build = "swap_razor"})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 羽毛笔 featherpencil
        ["featherpencil"] = {
            bank = "feather_pencil",
            build = "feather_pencil",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.15, 0.65)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 捕虫网 bugnet
        ["bugnet"] = {
            bank = "bugnet",
            build = "swap_bugnet",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_bugnet"}
                MakeInventoryFloatable(inst, "med", 0.09, {0.9, 0.4, 0.9}, true, -14.5, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 陷阱 trap
        ["trap"] = {
            bank = "trap",
            build = "trap",
            anim = "idle",
            loop = true,
            sound = true,
            icon_data = {
            },            
            map = "rabbittrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {0.8, 0.5, 0.8})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                        inst.AnimState:PlayAnimation("side",true)
                    else
                        if math.random() < 0.5 then
                            inst.AnimState:PlayAnimation("idle",true)
                        else
                            local sound_addr = "dontstarve/common/trap_rustle"
                            inst.AnimState:PlayAnimation("trap_loop",false)
                            inst.SoundEmitter:PlaySound(sound_addr)
                            inst:ListenForEvent("animover",function()
                                inst.AnimState:PlayAnimation("trap_loop",false)
                                inst.SoundEmitter:PlaySound(sound_addr)
                            end)
                        end
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 鸟笼 birdtrap
        ["birdtrap"] = {
            bank = "birdtrap",
            build = "birdtrap",
            anim = "idle",
            loop = true,
            sound = true,
            icon_data = {
            },            
            map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "large", nil, 0.75)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 草席卷 铺盖 bedroll_straw  bedroll_furry
        ["bedroll_straw"] = {
            bank = "swap_bedroll_straw",
            build = "swap_bedroll_straw",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {bank = "swap_bedroll_straw", anim = "idle"}
                MakeInventoryFloatable(inst, "small", 0.2, 0.95, nil, nil, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
        ["bedroll_furry"] = {
            bank = "swap_bedroll_furry",
            build = "swap_bedroll_furry",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {bank = "swap_bedroll_furry", anim = "idle"}
                MakeInventoryFloatable(inst, "small", 0.2, 0.95, nil, nil, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 灯具
        ["lantern"] = {
            bank = "lantern",
            build = "lantern",
            anim = "idle_off",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.2, 0.65)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle_off",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 红灯笼 redlantern
        ["redlantern"] = {
            bank = "redlantern",
            build = "redlantern",
            anim = "idle_loop",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", nil, {0.775, 0.5, 0.775})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                        inst.AnimState:PlayAnimation("float",true)
                    else
                        inst.AnimState:PlayAnimation("idle_loop",true)
                        inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
                
            end,
        },
    --------------------------------------------------------------------
    -- 暗影香炉 thurible
        ["thurible"] = {
            bank = "thurible",
            build = "thurible",
            anim = "idle_loop",
            loop = true,
            sound = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                inst.AnimState:SetFinalOffset(1)
                MakeInventoryFloatable(inst, "med", nil, {0.775, 0.5, 0.775})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                        -- inst.AnimState:PlayAnimation("float",true)
                    else
                        inst.AnimState:PlayAnimation("idle_loop",true)
                        inst.AnimState:SetFrame(math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1)
                    end
                    inst:SpawnChild("thurible_smoke")
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 留声机 phonograph
        ["phonograph"] = {
            bank = "phonograph",
            build = "phonograph",
            anim = "idle",
            loop = true,
            sound = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.07, 0.72)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                        -- inst.AnimState:PlayAnimation("float",true)
                    else
                        if math.random() < 0.5 then
                            inst.AnimState:PlayAnimation("idle",true)
                        else
                            inst.AnimState:PlayAnimation("play_loop",true)
                        end
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 树果酱 treegrowthsolution
        ["treegrowthsolution"] = {
            bank = "treegrowthsolution",
            build = "treegrowthsolution",
            anim = "item",
            -- loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.1)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                        -- inst.AnimState:PlayAnimation("float",true)
                    else
                        inst.AnimState:PlayAnimation("item")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 各种 浆 oar  oar_driftwood malbatross_beak oar_monkey yotd_oar
        ["oar"] = {
            bank = "oar",
            build = "oar",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", nil, 0.68)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
        ["oar_driftwood"] = {
            bank = "oar_driftwood",
            build = "oar_driftwood",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", nil, 0.68)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
        ["malbatross_beak"] = {
            bank = "malbatross_beak",
            build = "malbatross_beak",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", nil, 0.68)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
        ["oar_monkey"] = {
            bank = "oar_monkey",
            build = "oar_monkey",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", nil, 0.68)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
        ["yotd_oar"] = {
            bank = "yotd_oar",
            build = "yotd_oar",
            anim = "idle",
            -- loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", nil, 0.68)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 亮茄魔杖 staff_lunarplant
        ["staff_lunarplant"] = {
            bank = "staff_lunarplant",
            build = "staff_lunarplant",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                inst.AnimState:SetBank("staff_lunarplant")
                inst.AnimState:SetBuild("staff_lunarplant")
                inst.AnimState:PlayAnimation("idle", true)
                inst.AnimState:SetSymbolBloom("pb_energy_loop")
                inst.AnimState:SetSymbolBloom("stone")
                inst.AnimState:SetSymbolLightOverride("pb_energy_loop01", .5)
                inst.AnimState:SetSymbolLightOverride("pb_ray", .5)
                inst.AnimState:SetSymbolLightOverride("stone", .5)
                inst.AnimState:SetSymbolLightOverride("glow", .25)
                inst.AnimState:SetLightOverride(.1)

                inst:AddComponent("floater")
                local SWAP_DATA = { sym_build = "staff_lunarplant", sym_name = "swap_staff_lunarplant" }
                local FLOAT_SCALE = { 0.9, 0.6, 0.9 }
                inst.components.floater:SetBankSwapOnFloat(true, -13, SWAP_DATA)
                inst.components.floater:SetSize("med")
                inst.components.floater:SetVerticalOffset(0.1)
                inst.components.floater:SetScale(FLOAT_SCALE)

            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        local frame = math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1
                        inst.AnimState:SetFrame(frame)
                        inst.fx = SpawnPrefab("staff_lunarplant_fx")
                        inst.fx.AnimState:SetFrame(frame)
                        local function SetFxOwner(inst, owner)
                            --For floating
                            inst.fx.Follower:FollowSymbol(inst.GUID, "swap_spear", nil, nil, nil, true)
                            inst.fx.components.highlightchild:SetOwner(inst)                            
                        end
                        SetFxOwner(inst)
                        inst:ListenForEvent("onremove",function()
                            inst.fx:Remove()
                        end)
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end

                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 亮茄剑 sword_lunarplant
        ["sword_lunarplant"] = {
            bank = "sword_lunarplant",
            build = "sword_lunarplant",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                inst.AnimState:SetSymbolBloom("pb_energy_loop01")
                inst.AnimState:SetSymbolLightOverride("pb_energy_loop01", .5)
                inst.AnimState:SetLightOverride(.1)

                inst:AddComponent("floater")
                local SWAP_DATA = { sym_build = "sword_lunarplant", sym_name = "swap_sword_lunarplant" }
                local FLOAT_SCALE = { 1, 0.4, 1 }
                inst.components.floater:SetBankSwapOnFloat(true, -17.5, SWAP_DATA)
                inst.components.floater:SetSize("med")
                inst.components.floater:SetVerticalOffset(0.05)
                inst.components.floater:SetScale(FLOAT_SCALE)

            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        local frame = math.random(inst.AnimState:GetCurrentAnimationNumFrames()) - 1
                        inst.AnimState:SetFrame(frame)
                        inst.blade1 = SpawnPrefab("sword_lunarplant_blade_fx")
                        inst.blade2 = SpawnPrefab("sword_lunarplant_blade_fx")
                        inst.blade2.AnimState:PlayAnimation("swap_loop2", true)
                        inst.blade1.AnimState:SetFrame(frame)
                        inst.blade2.AnimState:SetFrame(frame)

                        local function SetFxOwner(inst, owner)
                            if inst._fxowner ~= nil and inst._fxowner.components.colouradder ~= nil then
                                inst._fxowner.components.colouradder:DetachChild(inst.blade1)
                                inst._fxowner.components.colouradder:DetachChild(inst.blade2)
                            end
                            inst._fxowner = owner
                            inst.blade1.entity:SetParent(inst.entity)
                            inst.blade2.entity:SetParent(inst.entity)
                            --For floating
                            inst.blade1.Follower:FollowSymbol(inst.GUID, "swap_spear", nil, nil, nil, true, nil, 0, 3)
                            inst.blade2.Follower:FollowSymbol(inst.GUID, "swap_spear", nil, nil, nil, true, nil, 5, 8)
                            inst.blade1.components.highlightchild:SetOwner(inst)
                            inst.blade2.components.highlightchild:SetOwner(inst)                            
                        end

                        
                        SetFxOwner(inst, nil)
                        inst.components.floater:OnLandedServer()

                        inst:ListenForEvent("onremove", function()
                            if inst.blade1 then
                                inst.blade1:Remove()
                            end
                            if inst.blade2 then
                                inst.blade2:Remove()
                            end
                        end)
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end

                end
                inst:DoTaskInTime(0,play_water_anim)


            end,
        },
    --------------------------------------------------------------------
    -- 亮茄炸弹 bomb_lunarplant
        ["bomb_lunarplant"] = {
            bank = "bomb_lunarplant",
            build = "bomb_lunarplant",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", 0.1, 0.8)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 栅栏击剑 fence_rotator
        ["fence_rotator"] = {
            bank = "fence_rotator",
            build = "fence_rotator",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:SetBankSwapOnFloat(true, -9, { sym_build = "fence_rotator", sym_name = "swap_fence_rotator" })
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 步行手杖 cane
        ["cane"] = {
            bank = "cane",
            build = "swap_cane",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_cane"}
                MakeInventoryFloatable(inst, "med", 0.05, {0.85, 0.45, 0.85}, true, 1, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 长矛 spear
        ["spear"] = {
            bank = "spear",
            build = "swap_spear",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 蝙蝠棒 batbat
        ["batbat"] = {
            bank = "batbat",
            build = "batbat",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_batbat"}
                MakeInventoryFloatable(inst, "large", 0.05, {0.8, 0.35, 0.8}, true, -27, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 三叉戟 trident
        ["trident"] = {
            bank = "trident",
            build = "trident",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local FLOATER_SWAP_DATA = {sym_build = "swap_trident"}
                MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.5, 1.1}, true, -9, FLOATER_SWAP_DATA)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 触手尖刺 tentaclespike
        ["tentaclespike"] = {
            bank = "spike",
            build = "tentacle_spike",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_spike", bank = "tentacle_spike"}
                MakeInventoryFloatable(inst, "med", 0.05, {0.9, 0.5, 0.9}, true, -17, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 火腿棒 hambat
        ["hambat"] = {
            bank = "ham_bat",
            build = "ham_bat",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_ham_bat", bank = "ham_bat"}
                MakeInventoryFloatable(inst, "med", nil, {1.0, 0.5, 1.0}, true, -13, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 铥矿棒 ruins_bat
        ["ruins_bat"] = {
            bank = "ruins_bat",
            build = "swap_ruins_bat",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 暗影剑 nightsword
        ["nightsword"] = {
            bank = "nightmaresword",
            build = "nightmaresword",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_nightmaresword", bank = "nightmaresword"}
                MakeInventoryFloatable(inst, "med", 0.05, {1.0, 0.4, 1.0}, true, -17.5, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 玻璃刀 glasscutter
        ["glasscutter"] = {
            bank = "glasscutter",
            build = "glasscutter",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local floater_swap_data = {sym_build = "swap_glasscutter"}
                MakeInventoryFloatable(inst, "med", 0.05, {1.21, 0.4, 1.21}, true, -22, floater_swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 星辰锤 nightstick
        ["nightstick"] = {
            bank = "nightstick",
            build = "nightstick",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "med", 0.05, {1.1, 0.4, 1.1}, true, -19, {sym_build = "swap_nightstick"})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 天气风向标 staff_tornado
        ["staff_tornado"] = {
            bank = "tornado_stick",
            build = "tornado_stick",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local swap_data = {sym_build = "swap_tornado_stick", bank = "tornado_stick"}
                MakeInventoryFloatable(inst, "med", 0.05, {1.0, 0.4, 1.0}, true, -20, swap_data)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 恐怖盾牌 shieldofterror
        ["shieldofterror"] = {
            bank = "eye_shield",
            build = "eye_shield",
            anim = "idle",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, nil, 0.2, {1.1, 0.6, 1.1})
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 亮茄盔甲 armor_lunarplant
        ["armor_lunarplant"] = {
            bank = "armor_lunarplant",
            build = "armor_lunarplant",
            anim = "anim",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local SWAP_DATA = { bank = "armor_lunarplant", anim = "anim" }
                MakeInventoryFloatable(inst, "small", 0.2, 0.80, nil, nil, SWAP_DATA)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("anim",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------
    -- 荆刺盔甲 armor_lunarplant_husk
        ["armor_lunarplant_husk"] = {
            bank = "armor_lunarplant",
            build = "armor_lunarplant_husk",
            anim = "anim",
            loop = true,
            icon_data = {
            },            
            -- map = "birdtrap.png",
            common_postinit = function(inst)
                local SWAP_DATA = { bank = "armor_lunarplant", anim = "anim" }
                MakeInventoryFloatable(inst, "small", 0.2, 0.80, nil, nil, SWAP_DATA)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("anim",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        },
    --------------------------------------------------------------------


}
----------------------------------------------------------------------------------------------------------------------------------------
--- 哑铃
    local dumbbells = {"dumbbell","dumbbell_golden","dumbbell_marble","dumbbell_gem","dumbbell_heat","dumbbell_redgem","dumbbell_bluegem"}
    for i,prefab in ipairs(dumbbells) do
        temp_table[prefab] = {
            bank = prefab,
            build = prefab,
            anim = "idle",
            loop = true,
            common_postinit = function(inst)
                MakeInventoryFloatable(inst, "small", 0.15, 0.9)
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("idle",true)
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        }
    end
----------------------------------------------------------------------------------------------------------------------------------------
--- 帽子
    local hats = {
        "straw","top","beefalo","feather","bee","miner","spider","football",
        "earmuffs","winter","bush","flower","walrus","slurtle","ruins","mole",
        "wathgrithr","wathgrithr_improved","walter","ice","rain","catcoon","watermelon",
        "eyebrella","red_mushroom","green_mushroom","blue_mushroom","hive","dragonhead",
        "dragonbody","dragontail","desert","goggles","moonstorm_goggles","skeleton",
        "kelp","merm","cookiecutter","batnose","nutrientsgoggles","plantregistry",
        "balloon","alterguardian","eyemask","antlion","mask_doll","mask_dollbroken",
        "mask_dollrepaired","mask_blacksmith","mask_mirror","mask_queen","mask_king","mask_tree",
        "mask_fool","monkey_medium","monkey_small","polly_rogers","nightcap","woodcarved","dreadstone",
        "lunarplant","voidcloth","wagpunk","moon_mushroom","scrap_monocle","scrap",
    }

    for k, name in pairs(hats) do    
        local symname = name.."hat"
        local prefabname = symname
        local swap_data = { bank = symname, anim = "anim" }
        local fname = "hat_"..name
        temp_table[prefabname] = {
            bank = symname,
            build = fname,
            anim = "anim",
            -- loop = true,
            icon_data = {
            },            
            -- map = "barnacle_plant.png",
            common_postinit = function(inst)
                MakeInventoryFloatable(inst)
                inst.components.floater:SetBankSwapOnFloat(false, nil, swap_data) --Hats default animation is not "idle", so even though we don't swap banks, we need to specify the swap_data for re-skinning to reset properly when floating
            end,
            master_postinit = function(inst)
                local function play_water_anim(inst)
                    local x,y,z = inst.Transform:GetWorldPosition()
                    if TheWorld.Map:IsOceanAtPoint(x,y,z) then
                        inst.components.floater:OnLandedServer()
                    else
                        inst.AnimState:PlayAnimation("anim")
                    end
                end
                inst:DoTaskInTime(0,play_water_anim)
            end,
        }
    end
----------------------------------------------------------------------------------------------------------------------------------------

TUNING.FUNNY_CAT_ITEM_RESOURCES = TUNING.FUNNY_CAT_ITEM_RESOURCES or {}
for k, v in pairs(temp_table) do
    table.insert(TUNING.FUNNY_CAT_ITEM_RESOURCES,k)
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end