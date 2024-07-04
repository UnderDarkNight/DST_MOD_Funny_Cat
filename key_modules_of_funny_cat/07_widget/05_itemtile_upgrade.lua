--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[

        修改物品槽，方便鼠标放上去后显示界面


]]--
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    AddClassPostConstruct("widgets/itemtile", function(self,item)


        self.old_OnGainFocus = self.OnGainFocus
        self.OnGainFocus = function(self, ...)
            if self.item then
                self.item:PushEvent("ItemTileOnGainFocus")
            end
            return self.old_OnGainFocus(self, ...)
        end

        self.old_OnLoseFocus = self.OnLoseFocus
        self.OnLoseFocus = function(self, ...)
            if self.item then
                self.item:PushEvent("ItemTileOnLoseFocus")                
            end
            return self.old_OnLoseFocus(self, ...)
        end

        if self.item then
            self.item:ListenForEvent("onremove",function()
                self.item:PushEvent("ItemTileOnLoseFocus")
            end)
        end

        self.old_Kill = self.Kill
        self.Kill = function(self, ...)
            if self.item then
                self.item:PushEvent("ItemTileOnLoseFocus")
            end            
            return self.old_Kill(self, ...)
        end

    end)