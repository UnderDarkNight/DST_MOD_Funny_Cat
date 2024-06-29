GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 服务器最大玩家数量
	TUNING.MAX_SERVER_SIZE = 60
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 语言检查
	--- en  ch
	TUNING.FUNNY_CAT_LANGUAGE = GetModConfigData("LANGUAGE") --- 语言
	TUNING.FUNNY_CAT_GET_LANGUAGE = TUNING.FUNNY_CAT_GET_LANGUAGE or function()
		if TUNING.FUNNY_CAT_LANGUAGE == "auto" then
			if LOC.GetLanguage() == LANGUAGE.CHINESE_S or LOC.GetLanguage() == LANGUAGE.CHINESE_S_RAIL or LOC.GetLanguage() == LANGUAGE.CHINESE_T then
				TUNING.FUNNY_CAT_LANGUAGE = "ch"
				return TUNING.FUNNY_CAT_LANGUAGE
			else
				TUNING.FUNNY_CAT_LANGUAGE = "en"
				return TUNING.FUNNY_CAT_LANGUAGE
			end
		else
			return TUNING.FUNNY_CAT_LANGUAGE
		end
	end
	
	TUNING.FUNNY_CAT_GET_STRINGS = function()
		return {}
	end
	TUNING.FUNNY_CAT_GET_ALL_STRINGS = function()
		return {}
	end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---
	TUNING.FUNNY_CAT_DEBUGGING_MODE = GetModConfigData("DEBUGGING_MODE") --- 开发者模式
	TUNING.FUNNY_CAT_CONFIG = {}
	TUNING.FUNNY_CAT_CONFIG.modname = modname
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 控制台屏蔽的另外一种形式
	-- if not TUNING.FUNNY_CAT_DEBUGGING_MODE then
		local old_ExecuteConsoleCommand = rawget(_G,"ExecuteConsoleCommand")
		rawset(_G,"ExecuteConsoleCommand",function(...)
			if ThePlayer then
				ThePlayer.replica.funny_cat_com_safe_sys:PushEvent("ExecuteConsoleCommand")
			end
			return old_ExecuteConsoleCommand(...)
		end)
	-- end	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 
	Assets = {}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 加载基础的素材库
	modimport("imports_of_funny_cat/__all_imports_init.lua")	---- 所有 import  文本库（语言库），素材库

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 关键函数库
	modimport("key_modules_of_funny_cat/_all_modules_init.lua")	---- 载入关键功能模块
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 物品prefab
	PrefabFiles = {
		"funny_cat__all_prefabs"
	}	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 地图生成屏蔽
	local settings = {
		["temperaturedamage"] = "nonlethal",
		["year_of_the_pig"] = "default",
		["bearger"] = "never",
		["year_of_the_beefalo"] = "default",
		["mutated_hounds"] = "never",
		["moon_tree_regrowth"] = "never",
		["summer"] = "default",
		["deciduoustree_regrowth"] = "never",
		["walrus"] = "never",
		["pirateraids"] = "never",
		["moon_spiders"] = "never",
		["year_of_the_varg"] = "default",
		["moon_sapling"] = "never",
		["flowers_regrowth"] = "never",
		["ghostsanitydrain"] = "none",
		["tumbleweed"] = "never",
		["hallowed_nights"] = "default",
		["lightcrab_portalrate"] = "never",
		["bats_setting"] = "never",
		["weather"] = "default",
		["meteorshowers"] = "never",
		["palmcone_seed_portalrate"] = "never",
		["spiders"] = "never",
		["bunnymen_setting"] = "never",
		["palmconetree_regrowth"] = "never",
		["crow_carnival"] = "default",
		["year_of_the_gobbler"] = "default",
		["bees"] = "never",
		["pigs"] = "never",
		["spiderqueen"] = "never",
		["rifts_frequency"] = "never",
		["rock"] = "never",
		["sharkboi"] = "never",
		["flowers"] = "never",
		["moon_berrybush"] = "never",
		["deciduousmonster"] = "never",
		["darkness"] = "nonlethal",
		["task_set"] = "default",
		["summerhounds"] = "default",
		["crabking"] = "never",
		["year_of_the_carrat"] = "default",
		["catcoons"] = "never",
		["spawnprotection"] = "default",
		["grassgekkos"] = "never",
		["winters_feast"] = "default",
		["moon_rock"] = "never",
		["season_start"] = "default",
		["moon_carrot"] = "never",
		["wormhole_prefab"] = "wormhole",
		["touchstone"] = "never",
		["moon_bullkelp"] = "never",
		["resettime"] = "none",
		["no_wormholes_to_disconnected_tiles"] = "true",
		["penguins_moon"] = "never",
		["moon_spider"] = "never",
		["roads"] = "never",
		["ocean_otterdens"] = "never",
		["moon_starfish"] = "never",
		["moon_hotspring"] = "never",
		["malbatross"] = "never",
		["rifts_enabled"] = "never",
		["beefaloheat"] = "default",
		["walrus_setting"] = "never",
		["frogs"] = "never"
	}
	local forest_map = require("map/forest_map")
	local old_Generate = forest_map.Generate
	forest_map.Generate = function(prefab, map_width, map_height, tasks, level, level_type,...)
		print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
			print("param",prefab,map_width,map_height,tasks,level,level_type)
			tasks = {}
			for index, v in pairs(level.overrides) do
				if settings[index] then
					level.overrides[index] = settings[index]
				end
			end
		print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
		return old_Generate(prefab, map_width, map_height, tasks, level, level_type,...)		
	end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------