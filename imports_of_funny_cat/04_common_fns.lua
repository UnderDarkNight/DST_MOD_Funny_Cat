--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

TUNING.FUNNY_CAT_FN = {}

-----------------------------------------------------------------------
-- 文本相关
    function TUNING.FUNNY_CAT_FN:GetStringWithName(index1,index2,name)
        local creash_flag, ret = pcall(function()            
            local str = TUNING.FUNNY_CAT_GET_STRINGS(index1)[index2] or "unkown info string with {name}"
            local replacedText = str:gsub("{name}",tostring(name))
            return replacedText
        end)
        if creash_flag then
            return ret
        else
            return "unkown info string with"..tostring(index1).."   "..tostring(index2).."   "..tostring(name)
        end
    end
    function TUNING.FUNNY_CAT_FN:GetStrings(prefab,index)
        local prefab_table = TUNING.FUNNY_CAT_GET_STRINGS(prefab) or {}
        if index then
            return prefab_table[index]
        else
            return prefab_table
        end
    end
    function TUNING.FUNNY_CAT_FN:GetAllStrings()
        return TUNING.FUNNY_CAT_GET_ALL_STRINGS()
    end
-----------------------------------------------------------------------
-- 
    function TUNING.FUNNY_CAT_FN:GetSurroundPoints(CMD_TABLE) -- 获取一圈坐标
        -- local CMD_TABLE = {
        --     target = inst or Vector3(),
        --     range = 8,
        --     num = 8
        -- }
        if CMD_TABLE == nil then
            return
        end
        local theMid = nil
        if CMD_TABLE.target == nil then
            theMid = Vector3( self.inst.Transform:GetWorldPosition() )
        elseif CMD_TABLE.target.x then
            theMid = CMD_TABLE.target
        elseif CMD_TABLE.target.prefab then
            theMid = Vector3( CMD_TABLE.target.Transform:GetWorldPosition() )
        else
            return
        end
        -- --------------------------------------------------------------------------------------------------------------------
        -- -- 8 points
        -- local retPoints = {}
        -- for i = 1, 8, 1 do
        --     local tempDeg = (PI/4)*(i-1)
        --     local tempPoint = theMidPoint + Vector3( Range*math.cos(tempDeg) ,  0  ,  Range*math.sin(tempDeg)    )
        --     table.insert(retPoints,tempPoint)
        -- end
        -- --------------------------------------------------------------------------------------------------------------------
        local num = CMD_TABLE.num or 8
        local range = CMD_TABLE.range or 8
        local retPoints = {}
        for i = 1, num, 1 do
            local tempDeg = (2*PI/num)*(i-1)
            local tempPoint = theMid + Vector3( range*math.cos(tempDeg) ,  0  ,  range*math.sin(tempDeg)    )
            table.insert(retPoints,tempPoint)
        end

        return retPoints


    end
-----------------------------------------------------------------------