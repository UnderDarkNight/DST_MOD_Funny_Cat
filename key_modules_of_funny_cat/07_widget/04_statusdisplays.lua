--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    隐藏其他 三维内的框框

]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddClassPostConstruct("widgets/statusdisplays", function(self,owner)
    local module_names  = {
        ["brain"] = true,
        ["stomach"] = true,
        ["wereness"] = true,
        ["pethealthbadge"] = true,
        ["inspirationbadge"] = true,
        ["mightybadge"] = true,
    }
    owner:DoTaskInTime(0,function()
        
        -- if self.brain then
        --     self.brain:Hide()
        -- end
        for index, v in pairs(module_names) do
            if self[index] then
                self[index]:Hide()
            end
        end


    end)
end)