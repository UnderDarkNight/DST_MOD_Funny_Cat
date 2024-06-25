------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local tempTheNet = nil
if type(TheNet) == "table" then
    tempTheNet = TheNet
elseif type(TheNet) == "userdata" then
    tempTheNet = getmetatable(TheNet).__index
end

tempTheNet.GetPVPEnabled = function(self,...)
    return false
end


-- local old_SendRemoteExecute = tempTheNet.SendRemoteExecute
-- tempTheNet.SendRemoteExecute = function(self, ...)
--     if ThePlayer then
--         ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("ExecuteConsoleCommand")
--     end
--     return old_SendRemoteExecute(self, ...)
-- end
