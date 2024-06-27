--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    AddClassPostConstruct("widgets/targetindicator", function(self)

        local old_OnUpdate = self.OnUpdate

        self.OnUpdate = function(self,...)
            print("targetindicator OnUpdate",math.random(9999))
            return old_OnUpdate(self,...)
        end
    end)


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 队友指示器圈圈
    AddClassPostConstruct("widgets/targetindicator", function(self)

        -- local old_OnUpdate = self.OnUpdate

        -- self.OnUpdate = function(self,...)
        --     print("targetindicator OnUpdate",math.random(9999))
        --     return old_OnUpdate(self,...)
        -- end
    end)