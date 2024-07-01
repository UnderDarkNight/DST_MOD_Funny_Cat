

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
    --- 骷髅、前辈
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
    ---
        
    --------------------------------------------------------------------
}
for k, v in pairs(temp_table) do
    TUNING.FUNNY_CAT_RESOURCES[k] = v
end