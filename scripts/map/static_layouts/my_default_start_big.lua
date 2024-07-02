local map_width = 300
local map_height = 300

local function CreateMapTileData()
        ---------------------------------------------------------
        ---
            -- print("+++++++++++++++++++++++++++++++++++++++++++++++++++")
            -- -- local temp = GetWorldTileMap()
            -- -- for k, v in pairs(temp) do
            -- --    print(k,v)
            -- -- end
            -- print("+++++++++++++++++++++++++++++++++++++++++++++++++++")
        ---------------------------------------------------------
        --- 基础初始化
            local tile_data = {}
            for y = 1,map_width, 1 do
                for x = 1, map_height, 1 do
                    tile_data[y] = tile_data[y] or {}
                    tile_data[y][x] = 0
                end
            end
            
            ------------------------------ 20x20分一个区块
            local block_size = 20
            local block_num = math.ceil(map_width/block_size)
            local block_index = 1
            for block_y = 1, block_num, 1 do
                for block_x = 1, block_num, 1 do
                    local start_x = (block_x - 1) * block_size + 1
                    local start_y = (block_y - 1) * block_size + 1
                    for temp_y = start_y, math.min(start_y + block_size - 1, map_height), 1 do
                        for temp_x = start_x, math.min(start_x + block_size - 1, map_width), 1 do
                            tile_data[temp_y][temp_x] = "block_"..string.format("%03d",block_index)
                        end
                    end
                    block_index = block_index + 1
                end
            end
        ---------------------------------------------------------
        --- 切换成地皮。需要前往 scripts\map\static_layouts\ 寻找参考案例
            local target_tiles = {
                -- 7, -- 坟地
                -- 6, -- 池塘区
                -- 1, --- 不能使用
                -- 2, -- 卵石地皮   GetWorldTileMap().ROAD
                3, -- 矿区 GetWorldTileMap().ROCKY GetTile:3
                4, -- 沙漠 GetWorldTileMap().DIRT  GetTile:4
                5, -- 草原 GetWorldTileMap().SAVANNA  GetTile:5
                6, -- 草地 GetWorldTileMap().GRASS GetTile:6
                7, -- 森林 GetWorldTileMap().FOREST GetTile:7
                8, -- 沼泽 GetWorldTileMap().MARSH GetTile:8
                -- 9,   -- 木地板 GetTile:10
                -- 10,  -- 地毯  GetTile:11
                -- 11,  --- 棋盘 GetTile:12
                -- 12,  --鸟粪地皮 GetTile:13
                -- 13,  --真菌地皮 GetTile:14
                -- 14,  --未知偏蓝草地（挖不起来）
                -- 15,  --未知偏蓝草地（挖不起来）
                -- 16,  --未知图形地毯（挖不起来）
                17,     -- 泥泞 GetWorldTileMap().MUD  GetTile:17
                -- 18,  -- 不能使用
                -- 19,  -- 不能使用
                -- 20,  -- 不能使用
                -- 21,  -- 洞穴岩石地皮  GetWorldTileMap().TILES_GLOW   GetTile:16
                -- 22,  -- 泥泞地皮 GetTile:17
                -- 23,  -- 未知沼泽地皮 GetTile:35
                -- 24,  -- 不能使用
                -- 25， -- 远古地面 GetTile:18  GetWorldTileMap().FUNGUSGREEN 
                -- 26,  -- 不能使用
                -- 27,  -- 远古瓷砖 GetTile:20
                -- 28,  -- 不能使用
                -- 29,  -- 远古砖雕 GetTile:22
                -- 30,  -- 不能使用
                -- 31,  -- 未知岩石地皮（挖不起来） GetTile:37
                32,  -- 未知粉色地皮（挖不起来） GetTile:36   暴食模式地皮

                34, -- 月岛地皮在创建的时候使用的id。并不是GetTile得到的43

            }
            local block_switch_table = {}
            for i = 1, block_index, 1 do
                block_switch_table["block_"..string.format("%03d",i)] = target_tiles[math.random(#target_tiles)]
            end
            
            for y = 1,map_height, 1 do
                for x = 1, map_width , 1 do
                    tile_data[y][x] = block_switch_table[tile_data[y][x]]
                end
            end
        ----------------------------------------------------------------------------
        -- ---- 中间区块
            local mid_block_data = {
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,31,31,31,31, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,31, 2, 2,31, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,31, 2, 2,31, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,31,31,31,31, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0,31,31,31,31, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0,31, 2, 2,31, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0,31, 2, 2,31, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0,31,31,31,31, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0,31,31,31,31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0,31, 2, 2,31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0,31, 2, 2,31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0,31,31,31,31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
            }
            ----------------------------------------------------------------------------
            --- 批量临时切换
                for k, v in pairs(mid_block_data) do ---- 临时测试。
                    if v == 2 then
                        mid_block_data[k] = 7
                    elseif v == 31 then
                        mid_block_data[k] = 3                    
                    end
                end
            ----------------------------------------------------------------------------
            local mid_block = {}
            local temp_num = 1
            for y = 1, block_size, 1 do
                mid_block[y] = {}
                for x = 1,block_size ,1 do
                    mid_block[y][x] = mid_block_data[temp_num]
                    temp_num = temp_num + 1
                end
            end
        ----------------------------------------------------------------------------
        --- 把mid_block 插入到 tile_data 最中间的位置
            local start_x = math.floor((map_width - block_size)/2) + 1
            local start_y = math.floor((map_height - block_size)/2) + 1
            for temp_y = start_y, start_y + block_size - 1, 1 do
                for temp_x = start_x, start_x + block_size - 1, 1 do
                    tile_data[temp_y][temp_x] = mid_block[temp_y - start_y + 1][temp_x - start_x + 1]                            
                end                        
            end
        ----------------------------------------------------------------------------
        -- -- 使用io.open写入到output_map.lua文件
        --     local output_width = map_width
        --     local output_height = map_height
        --     -- local output_width = block_size
        --     -- local output_height = block_size
        --     local output_file = io.open("output_map.lua", "w")
        --     if output_file then
        --         output_file:write("return {\n")
        --         for y = 1, output_height, 1 do
        --             for x = 1, output_width, 1 do -- 修正了循环变量上限应该是map_width
        --                 output_file:write(string.format("%s ", tile_data[y][x])..",")
        --             end
        --             output_file:write("\n") -- 换行
        --         end
        --         output_file:write("}\n")
        --         output_file:close()
        --         print("Map data has been written to output_map.lua.")
        --     else
        --         print("Failed to open file for writing.")
        --     end
        ----------------------------------------------------------------------------
        --- 转换成一维数组
            local tile_data_1d = {}
            local temp_num = 1
            for y = 1, map_height, 1 do
                for x = 1, map_width, 1 do
                    tile_data_1d[temp_num] = tile_data[y][x]
                    temp_num = temp_num + 1
                end
            end
        ----------------------------------------------------------------------------
        return tile_data_1d
end



return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = map_width, --最大边界值
  height = map_height, --最大边界值，一定要设置成正方形！
  tilewidth = 64,  --像素点，推荐64
  tileheight = 64, --像素点，推荐64
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 64,   --像素点，推荐64
      tileheight = 64,  --像素点，推荐64
      spacing = 0,
      margin = 0,
      image = "../../../../tools/tiled/dont_starve/tiles.png",
      imagewidth = 512,   --不要动
      imageheight = 384,  --不要动
      properties = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "BG_TILES",
      x = 0,
      y = 0,
      width = map_width,  --最大边界值
      height = map_height, --最大边界值
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = CreateMapTileData()
    },
    {
      type = "objectgroup",
      name = "FG_OBJECTS",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "绚丽之门",
          type = "multiplayer_portal",
          shape = "rectangle",
          x = 9600, --- 像素尺寸。64x7.5x20
          y = 9600,
          width = .1,
          height = .1,
          visible = true,
          properties = {}
        },
        {
          name = "刷新点",
          type = "spawnpoint_master",
          shape = "rectangle",
          x = 9600,
          y = 9600,
          width = .1,
          height = .1,
          visible = true,
          properties = {}
        },
		    -- {
        --   name = "玫瑰",
        --   type = "flower_rose",  --致查理
        --   shape = "rectangle",
        --   x = 256,    --横坐标，64的倍数
        --   y = 256,    --纵坐标，64的倍数
        --   width = 0,
        --   height = 0,
        --   visible = true,
        --   properties = {}
        -- }
      }
    }
  }
}
