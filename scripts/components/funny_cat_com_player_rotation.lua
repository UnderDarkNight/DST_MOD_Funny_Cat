----------------------------------------------------------------------------------------------------------------------------------
--[[

    

]]--
----------------------------------------------------------------------------------------------------------------------------------
local funny_cat_com_player_rotation = Class(function(self, inst)
    self.inst = inst

    inst:DoTaskInTime(0,function()
        
        local function push_event(inst)
            inst:PushEvent("funny_cat_com_player_rotation")
        end

        local old_ForceFacePoint = inst.ForceFacePoint
        inst.ForceFacePoint = function(self,...)
            old_ForceFacePoint(self,...)
            push_event(self)
        end

        local old_FacePoint = inst.FacePoint
        inst.FacePoint = function(self,...)
            old_FacePoint(self,...)
            push_event(self)
        end

        inst:ListenForEvent("locomote",push_event)

    end)


end,
nil,
{

})
------------------------------------------------------------------------------------------------------------------------------
--
    function funny_cat_com_player_rotation:Fx_Face_2_Target(fx,target)
        if target == nil or fx == nil then
            return
        end
        
        local x,y,z = target.Transform:GetWorldPosition()
        local player = self.inst
        local angle = player:GetAngleToPoint(x,y,z)    --- 玩家和目标 的角度
        local player_angle = player.Transform:GetRotation()    --- 玩家自身的旋转角度

        local ret_angle = angle - player_angle

        ------- 溢出处理
            if ret_angle < 0 then
                ret_angle = 360 + ret_angle
            end
            if ret_angle > 360 then
                ret_angle = ret_angle - 360
            end

        fx.Transform:SetRotation(ret_angle)
    end
------------------------------------------------------------------------------------------------------------------------------
return funny_cat_com_player_rotation







