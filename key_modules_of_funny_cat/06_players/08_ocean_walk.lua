----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

    地图区域事件


]]--
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



AddPlayerPostInit(function(inst)
    if not TheWorld.ismastersim then
        return
    end

    inst:DoTaskInTime(0,function()
        if inst.components.drownable and inst.components.drownable.enabled ~= false then
            inst.components.drownable.enabled = false
        end

        MakeFlyingCharacterPhysics(inst, 1, .5)
        
        inst.Physics:ClearCollisionMask()
        inst.Physics:CollidesWith(COLLISION.GROUND)
        inst.Physics:CollidesWith(COLLISION.OBSTACLES)
        inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
        inst.Physics:CollidesWith(COLLISION.CHARACTERS)
        inst.Physics:CollidesWith(COLLISION.GIANTS)
    end)

end)