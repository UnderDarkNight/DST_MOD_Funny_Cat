----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    玩家身上的一些距离API

    主要是给 playerprox 组件检查玩家靠近使用的跳出
            inst.components.playerprox:SetOnPlayerNear

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Y_PARAM = 100

AddPlayerPostInit(function(inst)
    -------------------------------------------------------------------------------------
    ---
        local old_GetDistanceSqToPoint = inst.GetDistanceSqToPoint
        inst.GetDistanceSqToPoint = function(self,...)
            local x,y,z = self.Transform:GetWorldPosition()
            if y > Y_PARAM then
                return math.huge
            end
            return old_GetDistanceSqToPoint(self,...)
        end
    -------------------------------------------------------------------------------------
    ---
        local old_GetDistanceSqToInst = inst.GetDistanceSqToInst
        inst.GetDistanceSqToInst = function(self,...)
            local old_ret = old_GetDistanceSqToInst(self,...)
            local x,y,z = self.Transform:GetWorldPosition()
            if y > Y_PARAM then
                return math.huge
            end
            return old_ret
        end
    -------------------------------------------------------------------------------------
end)