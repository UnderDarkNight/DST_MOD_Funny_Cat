----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    屏蔽角色

]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local block_player_list = {
    ["wanda"] = true,
}

local old_GetSelectableCharacterList = rawget(_G, "GetSelectableCharacterList")
rawset(_G,"GetSelectableCharacterList", function(...)
    local old_ret_table = old_GetSelectableCharacterList(...)
    local new_ret_table = {}
    for k, prefab in pairs(old_ret_table) do
        if prefab and not block_player_list[prefab] then
            table.insert(new_ret_table, prefab)
        end
    end
    return new_ret_table
end)