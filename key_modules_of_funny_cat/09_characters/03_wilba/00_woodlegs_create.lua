
local function Language_check()
    return TUNING.FUNNY_CAT_GET_LANGUAGE()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 素材
    Assets = Assets or {}
    local tempAssets = {
        -- Asset( "IMAGE", "images/saveslot_portraits/wilba.tex" ), --存档图片
        -- Asset( "ATLAS", "images/saveslot_portraits/wilba.xml" ),

        Asset( "IMAGE", "bigportraits/wilba.tex" ), --人物大图（方形的那个）
        Asset( "ATLAS", "bigportraits/wilba.xml" ),

        Asset( "IMAGE", "bigportraits/wilba_none.tex" ),  --人物大图（椭圆的那个）
        Asset( "ATLAS", "bigportraits/wilba_none.xml" ),
        
        -- Asset( "IMAGE", "images/map_icons/wilba.tex" ), --小地图
        -- Asset( "ATLAS", "images/map_icons/wilba.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_wilba.tex" ), --tab键人物列表显示的头像  --- 直接用小地图那张就行了
        Asset( "ATLAS", "images/avatars/avatar_wilba.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_ghost_wilba.tex" ),--tab键人物列表显示的头像（死亡）
        Asset( "ATLAS", "images/avatars/avatar_ghost_wilba.xml" ),
        
        Asset( "IMAGE", "images/avatars/self_inspect_wilba.tex" ), --人物检查按钮的图片
        Asset( "ATLAS", "images/avatars/self_inspect_wilba.xml" ),
        
        Asset( "IMAGE", "images/names_wilba.tex" ),  --人物名字
        Asset( "ATLAS", "images/names_wilba.xml" ),
        
        Asset("ANIM", "anim/wilba.zip"),              --- 人物动画文件
        Asset("ANIM", "anim/ghost_wilba_build.zip"),  --- 灵魂状态动画文件
    }

    
    for i,v in pairs(tempAssets) do
        table.insert(Assets, v)
    end

    local map_icon = {
        -- "wilba","empty_icon"
    }
    for k, name in pairs(map_icon) do
        AddMinimapAtlas("images/map_icons/".. name ..".xml")        
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色立绘大图
GLOBAL.PREFAB_SKINS["wilba"] = {
    "wilba_none",
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色选择时候都文本
if Language_check() == "ch" then
    -- The character select screen lines  --人物选人界面的描述
    STRINGS.CHARACTER_TITLES["wilba"] = "薇尔芭"
    STRINGS.CHARACTER_NAMES["wilba"] = "薇尔芭"
    STRINGS.CHARACTER_DESCRIPTIONS["wilba"] = "来凑数的"
    STRINGS.CHARACTER_QUOTES["wilba"] = "我是来凑数的"

    -- Custom speech strings  ----人物语言文件  可以进去自定义
    -- STRINGS.CHARACTERS[string.upper("wilba")] = require "speech_wilba"

    -- The character's name as appears in-game  --人物在游戏里面的名字
    STRINGS.NAMES[string.upper("wilba")] = "薇尔芭"
    STRINGS.SKIN_NAMES["wilba_none"] = "薇尔芭"  --检查界面显示的名字

    --生存几率
    STRINGS.CHARACTER_SURVIVABILITY["wilba"] = "特别容易"
else
    -- The character select screen lines  --人物选人界面的描述
    STRINGS.CHARACTER_TITLES["wilba"] = "Wilba"
    STRINGS.CHARACTER_NAMES["wilba"] = "Wilba"
    STRINGS.CHARACTER_DESCRIPTIONS["wilba"] = "make up the numbers"
    STRINGS.CHARACTER_QUOTES["wilba"] = "I'm here to make up the numbers."

    -- Custom speech strings  ----人物语言文件  可以进去自定义
    -- STRINGS.CHARACTERS[string.upper("wilba")] = require "speech_wilba"

    -- The character's name as appears in-game  --人物在游戏里面的名字
    STRINGS.NAMES[string.upper("wilba")] = "Wilba"
    STRINGS.SKIN_NAMES["wilba_none"] = "Wilba"  --检查界面显示的名字

    --生存几率
    STRINGS.CHARACTER_SURVIVABILITY["wilba"] = "easy"

end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------增加人物到mod人物列表的里面 性别为女性（MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
AddModCharacter("wilba", "FEMALE")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面人物三维显示
TUNING[string.upper("wilba").."_HEALTH"] = 100
TUNING[string.upper("wilba").."_HUNGER"] = 100
TUNING[string.upper("wilba").."_SANITY"] = 100