GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
local Layouts =  require("map/layouts").Layouts
local StaticLayout = require("map/static_layout")
require("constants")
require("map/tasks")
require("map/level") 

--新加static_layout 注意这个里面必须有大门否则地图无法生成
Layouts["MyStaticLayout"] = StaticLayout.Get("map/static_layouts/my_default_start",{
            start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
            layout_position = LAYOUT_POSITION.CENTER,
            disable_transform = true,           
			-- defs={
			-- welcomitem = {"spear"} --三矛开局哈哈哈
			-- },
        })	
	
AddStartLocation("MyNewStart", {
    name = STRINGS.UI.SANDBOXMENU.DEFAULTSTART,
    location = "forest",
    start_setpeice = "MyStaticLayout",
    start_node = "Blank",
})

AddTask("Make a NewPick", {
		locks={},
		keys_given={},
		room_choices={
			--["Forest"] = function() return 1 + math.random(SIZE_VARIATION) end, 
			--["BarePlain"] = 1, 
			--["Plain"] = function() return 1 + math.random(SIZE_VARIATION) end, 
			--["Clearing"] = 1,
			["Blank"] = 1,
		}, 
		room_bg=GROUND.GRASS,
		--background_room="BGGrass",
		background_room = "Blank",
		colour={r=0,g=1,b=0,a=1}
	}) 
	
AddLevelPreInitAny(function(level)
	if level.location ~= "forest" then
		return
	end
	level.ocean_population = nil --海洋生态 礁石 海带之类的
	level.ocean_prefill_setpieces = nil --海洋奇遇 特指奶奶岛之类的
	level.tasks = {"Make a NewPick"}
	level.numoptionaltasks = 0
	level.optionaltasks = {}
	level.valid_start_tasks = nil
	level.set_pieces = {}

	level.random_set_pieces = {}
	level.ordered_story_setpieces = {}
	level.numrandom_set_pieces = 0
	


	level.overrides.start_location = "MyNewStart"
	level.overrides.keep_disconnected_tiles = true
	level.overrides.roads = "never"
	level.overrides.birds = "never" --没鸟
	level.overrides.has_ocean = false	--没海
	level.required_prefabs = {} --温蒂更新后的修复
end)

--[[
		Tiled做好地图文件，替换对应段落。

		地图编辑教程：https://www.bilibili.com/read/cv3712122

		将图片转换为lua地图文件：https://www.bilibili.com/read/cv4336821

		制作空白房：https://www.bilibili.com/read/cv4857248

		提取缺氧游戏动画：https://www.bilibili.com/read/cv4265805
]]
