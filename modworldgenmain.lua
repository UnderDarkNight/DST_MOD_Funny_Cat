-- GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
-- -- _G = GLOBAL

-- local settings = {
--     ["temperaturedamage"] = "nonlethal",
--     ["year_of_the_pig"] = "default",
--     ["bearger"] = "never",
--     ["year_of_the_beefalo"] = "default",
--     ["mutated_hounds"] = "never",
--     ["moon_tree_regrowth"] = "never",
--     ["summer"] = "default",
--     ["deciduoustree_regrowth"] = "never",
--     ["walrus"] = "never",
--     ["pirateraids"] = "never",
--     ["moon_spiders"] = "never",
--     ["year_of_the_varg"] = "default",
--     ["moon_sapling"] = "never",
--     ["flowers_regrowth"] = "never",
--     ["ghostsanitydrain"] = "none",
--     ["tumbleweed"] = "never",
--     ["hallowed_nights"] = "default",
--     ["lightcrab_portalrate"] = "never",
--     ["bats_setting"] = "never",
--     ["weather"] = "default",
--     ["meteorshowers"] = "never",
--     ["palmcone_seed_portalrate"] = "never",
--     ["spiders"] = "never",
--     ["bunnymen_setting"] = "never",
--     ["palmconetree_regrowth"] = "never",
--     ["crow_carnival"] = "default",
--     ["year_of_the_gobbler"] = "default",
--     ["bees"] = "never",
--     ["pigs"] = "never",
--     ["spiderqueen"] = "never",
--     ["rifts_frequency"] = "never",
--     ["rock"] = "never",
--     ["sharkboi"] = "never",
--     ["flowers"] = "never",
--     ["moon_berrybush"] = "never",
--     ["deciduousmonster"] = "never",
--     ["darkness"] = "nonlethal",
--     ["task_set"] = "default",
--     ["summerhounds"] = "default",
--     ["crabking"] = "never",
--     ["year_of_the_carrat"] = "default",
--     ["catcoons"] = "never",
--     ["spawnprotection"] = "default",
--     ["grassgekkos"] = "never",
--     ["winters_feast"] = "default",
--     ["moon_rock"] = "never",
--     ["season_start"] = "default",
--     ["moon_carrot"] = "never",
--     ["wormhole_prefab"] = "wormhole",
--     ["touchstone"] = "never",
--     ["moon_bullkelp"] = "never",
--     ["resettime"] = "none",
--     ["no_wormholes_to_disconnected_tiles"] = "true",
--     ["penguins_moon"] = "never",
--     ["moon_spider"] = "never",
--     ["roads"] = "never",
--     ["ocean_otterdens"] = "never",
--     ["moon_starfish"] = "never",
--     ["moon_hotspring"] = "never",
--     ["malbatross"] = "never",
--     ["rifts_enabled"] = "never",
--     ["beefaloheat"] = "default",
--     ["walrus_setting"] = "never",
--     ["frogs"] = "never"
-- }
-- -- require("map/level")
-- -- -- print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
-- -- AddGlobalClassPostConstruct("map/level", "Level", function(self,data)
-- --     -- self.desc = "info +++++++6666666666666666666666666666666666666"
-- --     print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
-- --         for index, flag in pairs(data) do
-- --             if index and settings[index] then
-- --                 data[index] = settings[index]
-- --             end
-- --         end
-- --     print("info +++++++6666666666666666666666666666666666666")
-- --     print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

-- -- end)


-- -- local forest_map = require("map/forest_map")
-- -- forest_map.MULTIPLY_PREFABS = {}
-- -- forest_map.TRANSLATE_TO_PREFABS = {}
-- -- forest_map.TRANSLATE_TO_CLUMP = {}
-- -- forest_map.TRANSLATE_AND_OVERRIDE = {}

-- -- print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
-- --     local old_dumptable = rawget(_G, "dumptable")
-- --     rawset(_G, "dumptable", function(tbl,...)

-- --         -----------------------------------------------------
-- --         ---
-- --             local test_num = 0
-- --             local check_is_target_table = false
-- --             for index, v in pairs(tbl) do
-- --                 if settings[index] then
-- --                     test_num = test_num + 1
-- --                 end
-- --                 if test_num > 5 then
-- --                     check_is_target_table = true
-- --                     break
-- --                 end
-- --             end
-- --         -----------------------------------------------------
-- --         -- 
-- --             if check_is_target_table then
-- --                 print("info +++++++6666666666666666666666666666666666666 change setting")
-- --                 for index, v in pairs(tbl) do
-- --                     if settings[index] then
-- --                         tbl[index] =  settings[index]
-- --                     end
-- --                 end
-- --                 return
-- --             end
-- --         -----------------------------------------------------
-- --         return old_dumptable(tbl,...)
-- --     end)
-- -- print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")


-- print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

-- -- require("shardindex")
-- -- local data = ShardIndex:GetGenOptions()
-- -- print(data)
-- -- for k, v in pairs(data) do
-- --     print(k, v)
-- -- end



-- print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")



-- print("fake error in modworldgenmain.lua")