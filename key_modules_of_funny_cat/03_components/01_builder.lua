------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

]]--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddClassPostConstruct("components/builder_replica", function(self)
    
    self.KnowsRecipe = function(...)
        return false        
    end
    self.HasIngredients = function(...)
        return false
    end
    self.CanBuild = function(...)
        return false
    end


end)

AddComponentPostInit("builder", function(self)
    
    self.KnowsRecipe = function(...)
        return false        
    end
    self.HasIngredients = function(...)
        return false
    end
    self.CanBuild = function(...)
        return false
    end


end)