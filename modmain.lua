GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 

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
