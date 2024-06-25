--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TUNING.FUNNY_CAT_FN = {}

-----------------------------------------------------------------------
-- 文本相关
    function TUNING.FUNNY_CAT_FN:GetStringWithName(index1,index2,player_name)
        local str = TUNING.FUNNY_CAT_GET_STRINGS(index1)[index2] or "unkown info string with {name}"
        -- local replacedText = originalText:gsub("{name}", inst:GetDisplayName())
        local replacedText = str:gsub("{name}",tostring(player_name))
        return replacedText
    end
    function TUNING.FUNNY_CAT_FN:GetStrings(prefab)
        return TUNING.FUNNY_CAT_GET_STRINGS(prefab) or {}
    end
    function TUNING.FUNNY_CAT_FN:GetAllStrings()
        return TUNING.FUNNY_CAT_GET_ALL_STRINGS()
    end
-----------------------------------------------------------------------
-- 
-----------------------------------------------------------------------