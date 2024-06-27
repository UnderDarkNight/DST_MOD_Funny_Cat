-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- --[[

--     notes_pre  notes_loop  notes_pst

-- ]]--
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddPrefabPostInit(
    "woodlegs",
    function(inst)
        if not TheWorld.ismastersim then
            return
        end
        -- local SHADER_CUTOFF_HEIGHT = -0.125
        -- inst.AnimState:SetErosionParams(0, SHADER_CUTOFF_HEIGHT, -1.0)

        if type(inst.AnimState) == "userdata" then
            TUNING.FUNNY_CAT_FN:Hook_Player_AnimState(inst)
        end

        if type(inst.AnimState) ~= "table" then
            return
        end

        local replace_anim = {
            ["idle_inaction"] = true,
            ["idle_inaction_lunacy"] = true,
        }
        local old_PlayAnimation = inst.AnimState.PlayAnimation
        inst.AnimState.PlayAnimation = function(self,anim,...)
            -- print("PlayAnimation",anim)
            if replace_anim[anim] then
                self:PlayAnimation("emoteXL_bonesaw")
                self:PushAnimation("idle_loop",true)
                return
            end
            return old_PlayAnimation(self,anim,...)
        end
        local old_PushAnimation = inst.AnimState.PushAnimation
        inst.AnimState.PushAnimation = function(self,anim,...)
            -- print("PushAnimation",anim)
            return old_PushAnimation(self,anim,...)
        end

    end)