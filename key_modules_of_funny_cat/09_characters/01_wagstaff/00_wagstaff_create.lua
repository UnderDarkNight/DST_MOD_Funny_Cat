
local function Language_check()
    return TUNING.FUNNY_CAT_GET_LANGUAGE()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 素材
    Assets = Assets or {}
    local tempAssets = {
        Asset( "IMAGE", "images/saveslot_portraits/wagstaff.tex" ), --存档图片
        Asset( "ATLAS", "images/saveslot_portraits/wagstaff.xml" ),

        Asset( "IMAGE", "bigportraits/wagstaff.tex" ), --人物大图（方形的那个）
        Asset( "ATLAS", "bigportraits/wagstaff.xml" ),

        Asset( "IMAGE", "bigportraits/wagstaff_none.tex" ),  --人物大图（椭圆的那个）
        Asset( "ATLAS", "bigportraits/wagstaff_none.xml" ),
        
        Asset( "IMAGE", "images/map_icons/wagstaff.tex" ), --小地图
        Asset( "ATLAS", "images/map_icons/wagstaff.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_wagstaff.tex" ), --tab键人物列表显示的头像  --- 直接用小地图那张就行了
        Asset( "ATLAS", "images/avatars/avatar_wagstaff.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_ghost_wagstaff.tex" ),--tab键人物列表显示的头像（死亡）
        Asset( "ATLAS", "images/avatars/avatar_ghost_wagstaff.xml" ),
        
        Asset( "IMAGE", "images/avatars/self_inspect_wagstaff.tex" ), --人物检查按钮的图片
        Asset( "ATLAS", "images/avatars/self_inspect_wagstaff.xml" ),
        
        Asset( "IMAGE", "images/names_wagstaff.tex" ),  --人物名字
        Asset( "ATLAS", "images/names_wagstaff.xml" ),
        
        Asset("ANIM", "anim/wagstaff.zip"),              --- 人物动画文件
        Asset("ANIM", "anim/ghost_wagstaff_build.zip"),  --- 灵魂状态动画文件
    }

    
    for i,v in pairs(tempAssets) do
        table.insert(Assets, v)
    end

    local map_icon = {
        "wagstaff","empty_icon"
    }
    for k, name in pairs(map_icon) do
        AddMinimapAtlas("images/map_icons/".. name ..".xml")        
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色立绘大图
GLOBAL.PREFAB_SKINS["wagstaff"] = {
    "wagstaff_none",
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色选择时候都文本
if Language_check() == "ch" then
    -- The character select screen lines  --人物选人界面的描述
    STRINGS.CHARACTER_TITLES["wagstaff"] = "瓦格斯塔夫"
    STRINGS.CHARACTER_NAMES["wagstaff"] = "瓦格斯塔夫"
    STRINGS.CHARACTER_DESCRIPTIONS["wagstaff"] = "来凑数的"
    STRINGS.CHARACTER_QUOTES["wagstaff"] = "我是来凑数的"

    -- Custom speech strings  ----人物语言文件  可以进去自定义
    -- STRINGS.CHARACTERS[string.upper("wagstaff")] = require "speech_wagstaff"

    -- The character's name as appears in-game  --人物在游戏里面的名字
    STRINGS.NAMES[string.upper("wagstaff")] = "瓦格斯塔夫"
    STRINGS.SKIN_NAMES["wagstaff_none"] = "瓦格斯塔夫"  --检查界面显示的名字

    --生存几率
    STRINGS.CHARACTER_SURVIVABILITY["wagstaff"] = "特别容易"
else
    -- The character select screen lines  --人物选人界面的描述
    STRINGS.CHARACTER_TITLES["wagstaff"] = "Wagstaff"
    STRINGS.CHARACTER_NAMES["wagstaff"] = "Wagstaff"
    STRINGS.CHARACTER_DESCRIPTIONS["wagstaff"] = "make up the numbers"
    STRINGS.CHARACTER_QUOTES["wagstaff"] = "I'm here to make up the numbers."

    -- Custom speech strings  ----人物语言文件  可以进去自定义
    -- STRINGS.CHARACTERS[string.upper("wagstaff")] = require "speech_wagstaff"

    -- The character's name as appears in-game  --人物在游戏里面的名字
    STRINGS.NAMES[string.upper("wagstaff")] = "Wagstaff"
    STRINGS.SKIN_NAMES["wagstaff_none"] = "Wagstaff"  --检查界面显示的名字

    --生存几率
    STRINGS.CHARACTER_SURVIVABILITY["wagstaff"] = "easy"

end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------增加人物到mod人物列表的里面 性别为女性（MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
AddModCharacter("wagstaff", "MALE")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面人物三维显示
TUNING[string.upper("wagstaff").."_HEALTH"] = 100
TUNING[string.upper("wagstaff").."_HUNGER"] = 100
TUNING[string.upper("wagstaff").."_SANITY"] = 100