----------------------------------------------------------------------------------------------------------------------------------
--[[

     挂载在玩家身上，关于 地块进出标记、事件

     
]]--
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_player_tile_event = Class(function(self, inst)
    self.inst = inst

    self.crrent_tile_data = {
        tile_x = 0,
        tile_y = 0,
        tags = {}
    }

end,
nil,
{

})

-----------------------------------------------------------------------------------------------------
--- 
    function funny_cat_player_tile_event:SetCrrentTileData(data)
        self.crrent_tile_data = data
    end
    function funny_cat_player_tile_event:GetCurrentTileData()
        return self.crrent_tile_data or {}
    end
-----------------------------------------------------------------------------------------------------
---
    function funny_cat_player_tile_event:GetTileTags()
        local crash_flag,origin_ret = pcall(function()
            return self.crrent_tile_data.tags or {}
        end)
        if crash_flag then
            return origin_ret            
        else
            return {}
        end
    end
    function funny_cat_player_tile_event:HasTag(tag)
        local tags = self:GetTileTags()
        if table.contains(tags,tag) then
            return true
        end
        return false
    end    
    function funny_cat_player_tile_event:HasOneOfTags(temp_tags,...)  --- 自动兼容 table 和连续输入
        local finding_tags = {}
        if type(temp_tags) == "table" then
            finding_tags = temp_tags
        else
            finding_tags = {temp_tags,...}
        end        
        for _,tag in ipairs(finding_tags) do
            if self:HasTag(tag) then
                return true
            end
        end
        return false
    end
-----------------------------------------------------------------------------------------------------
return funny_cat_player_tile_event