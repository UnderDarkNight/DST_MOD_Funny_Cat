
local function Language_check()
    return TUNING.FUNNY_CAT_GET_LANGUAGE()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 素材
    Assets = Assets or {}
    local tempAssets = {
        -- Asset( "IMAGE", "images/saveslot_portraits/woodlegs.tex" ), --存档图片
        -- Asset( "ATLAS", "images/saveslot_portraits/woodlegs.xml" ),

        Asset( "IMAGE", "bigportraits/woodlegs.tex" ), --人物大图（方形的那个）
        Asset( "ATLAS", "bigportraits/woodlegs.xml" ),

        Asset( "IMAGE", "bigportraits/woodlegs_none.tex" ),  --人物大图（椭圆的那个）
        Asset( "ATLAS", "bigportraits/woodlegs_none.xml" ),
        
        -- Asset( "IMAGE", "images/map_icons/woodlegs.tex" ), --小地图
        -- Asset( "ATLAS", "images/map_icons/woodlegs.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_woodlegs.tex" ), --tab键人物列表显示的头像  --- 直接用小地图那张就行了
        Asset( "ATLAS", "images/avatars/avatar_woodlegs.xml" ),
        
        Asset( "IMAGE", "images/avatars/avatar_ghost_woodlegs.tex" ),--tab键人物列表显示的头像（死亡）
        Asset( "ATLAS", "images/avatars/avatar_ghost_woodlegs.xml" ),
        
        Asset( "IMAGE", "images/avatars/self_inspect_woodlegs.tex" ), --人物检查按钮的图片
        Asset( "ATLAS", "images/avatars/self_inspect_woodlegs.xml" ),
        
        Asset( "IMAGE", "images/names_woodlegs.tex" ),  --人物名字
        Asset( "ATLAS", "images/names_woodlegs.xml" ),
        
        Asset("ANIM", "anim/woodlegs.zip"),              --- 人物动画文件
        Asset("ANIM", "anim/ghost_woodlegs_build.zip"),  --- 灵魂状态动画文件
    }

    
    for i,v in pairs(tempAssets) do
        table.insert(Assets, v)
    end

    local map_icon = {
        -- "woodlegs","empty_icon"
    }
    for k, name in pairs(map_icon) do
        AddMinimapAtlas("images/map_icons/".. name ..".xml")        
    end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色立绘大图
GLOBAL.PREFAB_SKINS["woodlegs"] = {
    "woodlegs_none",
}
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 角色选择时候都文本
if Language_check() == "ch" then
    -- The character select screen lines  --人物选人界面的描述
    STRINGS.CHARACTER_TITLES["woodlegs"] = "木腿船长"
    STRINGS.CHARACTER_NAMES["woodlegs"] = "木腿船长"
    STRINGS.CHARACTER_DESCRIPTIONS["woodlegs"] = "来凑数的"
    STRINGS.CHARACTER_QUOTES["woodlegs"] = "我是来凑数的"

    -- Custom speech strings  ----人物语言文件  可以进去自定义
    -- STRINGS.CHARACTERS[string.upper("woodlegs")] = require "speech_woodlegs"

    -- The character's name as appears in-game  --人物在游戏里面的名字
    STRINGS.NAMES[string.upper("woodlegs")] = "木腿船长"
    STRINGS.SKIN_NAMES["woodlegs_none"] = "木腿船长"  --检查界面显示的名字

    --生存几率
    STRINGS.CHARACTER_SURVIVABILITY["woodlegs"] = "特别容易"
else
    -- The character select screen lines  --人物选人界面的描述
    STRINGS.CHARACTER_TITLES["woodlegs"] = "Woodlegs"
    STRINGS.CHARACTER_NAMES["woodlegs"] = "Woodlegs"
    STRINGS.CHARACTER_DESCRIPTIONS["woodlegs"] = "make up the numbers"
    STRINGS.CHARACTER_QUOTES["woodlegs"] = "I'm here to make up the numbers."

    -- Custom speech strings  ----人物语言文件  可以进去自定义
    -- STRINGS.CHARACTERS[string.upper("woodlegs")] = require "speech_woodlegs"

    -- The character's name as appears in-game  --人物在游戏里面的名字
    STRINGS.NAMES[string.upper("woodlegs")] = "Woodlegs"
    STRINGS.SKIN_NAMES["woodlegs_none"] = "Woodlegs"  --检查界面显示的名字

    --生存几率
    STRINGS.CHARACTER_SURVIVABILITY["Woodlegs"] = "easy"

end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
------增加人物到mod人物列表的里面 性别为女性（MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
AddModCharacter("woodlegs", "MALE")

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----选人界面人物三维显示
TUNING[string.upper("woodlegs").."_HEALTH"] = 100
TUNING[string.upper("woodlegs").."_HUNGER"] = 100
TUNING[string.upper("woodlegs").."_SANITY"] = 100