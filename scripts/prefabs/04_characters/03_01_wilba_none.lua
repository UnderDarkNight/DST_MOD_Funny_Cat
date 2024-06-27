-- local assets =
-- {
-- 	Asset( "ANIM", "anim/esctemplate.zip" ),
-- 	Asset( "ANIM", "anim/ghost_esctemplate_build.zip" ),
-- }

-- local skins =
-- {
-- 	normal_skin = "esctemplate",
-- 	ghost_skin = "ghost_esctemplate_build",
-- }

-- local base_prefab = "esctemplate"

-- local tags = {"BASE" ,"ESCTEMPLATE", "CHARACTER"}

-- return CreatePrefabSkin("esctemplate_none",
-- {
-- 	base_prefab = base_prefab, 
-- 	skins = skins, 
-- 	assets = assets,
-- 	skin_tags = tags,
	
-- 	build_name_override = "esctemplate",
-- 	rarity = "Character",
-- })

local assets =
{
	Asset( "ANIM", "anim/wilba.zip" ),
	Asset( "ANIM", "anim/ghost_wilba_build.zip" ),
	Asset( "ANIM", "anim/ghost_build.zip" ),
}
local skin_fns = {

	-----------------------------------------------------
		CreatePrefabSkin("wilba_none",{
			base_prefab = "wilba",			---- 角色prefab
			skins = {
					normal_skin = "wilba",					--- 正常外观
					-- ghost_skin = "ghost_build",			--- 幽灵外观
					ghost_skin = "ghost_wilba_build",			--- 幽灵外观
			}, 								
			assets = assets,
			skin_tags = {"BASE" ,"CHARACTER"},		--- 皮肤对应的tag
			
			build_name_override = "wilba",
			rarity = "Character",
		}),
	-----------------------------------------------------

}

return unpack(skin_fns)