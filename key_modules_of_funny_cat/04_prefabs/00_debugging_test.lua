
if not TUNING.FUNNY_CAT_DEBUGGING_MODE then
    return
end

AddPrefabPostInit("staff_lunarplant", function(inst)
    if not TheWorld.ismastersim then
        return
    end


    local old_floater_SwitchToFloatAnim = inst.components.floater.SwitchToFloatAnim
    inst.components.floater.SwitchToFloatAnim = function(self,...)
        print("info SwitchToFloatAnim")
        if self.do_bank_swap then
            print("+++++ 111 ++++ ",self.float_index)
            if self.float_index < 0 then
                self.inst.AnimState:SetBankAndPlayAnimation("floating_item", "left")
            print("+++++ 222 ++++")

            else
                self.inst.AnimState:SetBankAndPlayAnimation("floating_item", "right")
            print("+++++ 333 ++++")

            end
            self.inst.AnimState:SetFrame(math.abs(self.float_index))
            self.inst.AnimState:Pause()
    
            if self.swap_data ~= nil then
            print("+++++ 444 ++++")

                local symbol = self.swap_data.sym_name or self.swap_data.sym_build
                local skin_build = self.inst:GetSkinBuild()
            print("+++++ 555 ++++",symbol,skin_build)
            print("+++++ 666 ++++",self.swap_data.sym_name,self.swap_data.sym_build)

                if skin_build ~= nil then
                    self.inst.AnimState:OverrideItemSkinSymbol("swap_spear", skin_build, symbol, self.inst.GUID, self.swap_data.sym_build)
                else
                    self.inst.AnimState:OverrideSymbol("swap_spear", self.swap_data.sym_build, symbol)
                end
            end
        end
        -- return old_floater_SwitchToFloatAnim(self,...)
    end


end)