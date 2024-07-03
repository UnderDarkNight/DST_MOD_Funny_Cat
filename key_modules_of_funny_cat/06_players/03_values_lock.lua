------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
    屏蔽掉一些 三维数值等
]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return
    end

    ----------------------------------------------------------------------------------------------
    -- health
        -- if inst.components.health then
        --     local old_health_DoDelta = inst.components.health.DoDelta
        --     inst.components.health.DoDelta = function(self, amount,...)
        --         amount = 0
        --         self.currenthealth = self.maxhealth
        --         return old_health_DoDelta(self, amount,...)
        --     end
        -- end
    ----------------------------------------------------------------------------------------------
    -- hunger
        if inst.components.hunger then
            local old_hunger_DoDelta = inst.components.hunger.DoDelta
            inst.components.hunger.DoDelta = function(self, amount,...)
                amount = 0
                self.currenthealth = self.maxhealth
                return old_hunger_DoDelta(self, amount,...)
            end
        end
    ----------------------------------------------------------------------------------------------
    -- Sanity
        if inst.components.sanity then
            local old_sanity_DoDelta = inst.components.sanity.DoDelta
            inst.components.sanity.DoDelta = function(self, amount,...)
                amount = 0
                self.current = self.max
                return old_sanity_DoDelta(self, amount,...)
            end
        end
    ----------------------------------------------------------------------------------------------
    -- 体温
        if inst.components.temperature then
            local old_temperature_DoDelta = inst.components.temperature.DoDelta
            inst.components.temperature.DoDelta = function(self, amount,...)
                amount = 0
                return old_temperature_DoDelta(self, amount,...)
            end
            inst.components.temperature:SetTemperature(30)
        end
    ----------------------------------------------------------------------------------------------
    -- 大力士
        if inst.components.mightiness then
            local old_mightiness_DoDelta = inst.components.mightiness.DoDelta
            inst.components.mightiness.DoDelta = function(self, amount,...)
                amount = 0
                return old_mightiness_DoDelta(self, amount,...)
            end
        end
    ----------------------------------------------------------------------------------------------
    -- 屏蔽查理
        if inst.components.grue then
            inst.components.grue:AddImmunity("funny_cat")
        end
    ----------------------------------------------------------------------------------------------

end)
