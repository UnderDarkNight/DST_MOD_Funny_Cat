-- 注意：Lua中没有直接的字典类型，这里使用table代替
-- local alphabet = {
--     A = 0, B = 1, C = 2, D = 3, E = 4, F = 5, G = 6,
--     H = 7, I = 8, J = 9, K = 10, L = 11, M = 12, N = 13,
--     O = 14, P = 15, Q = 16, R = 17, S = 18, T = 19,
--     U = 20, V = 21, W = 22, X = 23, Y = 24, Z = 25,
--     ["1"] = 26, ["2"] = 27, ["3"] = 28, ["4"] = 29, ["5"] = 30, ["6"] = 31,
--     ["7"] = 32, ["8"] = 33, ["9"] = 34, ["0"] = 35
-- }
local alphabet = dofile(resolvefilepath("scripts/cd_key_creater/codebook.lua"))

math.randomseed(os.time())

local function generate_cdkey_and_check_value()
    local characters = {} -- 将使用table来模拟Python的list
    for k in pairs(alphabet) do table.insert(characters, k) end
    local cdkey = ""
    for i=1,16 do cdkey = cdkey .. characters[math.random(#characters)] end
    local account = string.sub(cdkey, 1, 8)
    local password = string.sub(cdkey, 9)
    local check_value = 0
    for i=1,#account do check_value = check_value + alphabet[string.sub(account, i, i)] end
    for i=1,#password do check_value = check_value + alphabet[string.sub(password, i, i)] end
    check_value = check_value % 36
    return cdkey, check_value
end

local function validate_cdkey(cdkey, stored_check_value)
    if #cdkey ~= 16 then return false end
    local account = string.sub(cdkey, 1, 8)
    local password = string.sub(cdkey, 9)
    local calculated_check_value = 0
    for i=1,#account do calculated_check_value = calculated_check_value + alphabet[string.sub(account, i, i)] end
    for i=1,#password do calculated_check_value = calculated_check_value + alphabet[string.sub(password, i, i)] end
    calculated_check_value = calculated_check_value % 36
    return calculated_check_value == stored_check_value
end

local function format_check_value(check_value)
    -- 将校验值格式化为两位数的字符串
    return string.format("%02d", check_value)
end

local function final_create_one_cdkey()
    local cdkey, check_value = generate_cdkey_and_check_value()
    check_value = format_check_value(check_value)
    return cdkey .. tostring(check_value)
end

local function final_check_cdkey(cdkey_with_check_value)
    local cdkey = string.sub(cdkey_with_check_value, 1, 16)
    local check_value = tonumber(string.sub(cdkey_with_check_value, 17))
    return validate_cdkey(cdkey, check_value)
end

local function example_main(input_key)
    if input_key == nil then
        input_key = final_create_one_cdkey()
        print("created one cdkey:", input_key)
        print("checking key", final_check_cdkey(input_key) and "valid" or "invalid")
    else
        print("checking key by input", input_key, final_check_cdkey(input_key) and "valid" or "invalid")
    end
end

-- example_main()
-- example_main("DNKMY2OCBYGP3SER2")
-- example_main("MNOQ6C0DNJWZ92UW10")
-- example_main("KR4FHTBPSY00QB442")
-- example_main("6P0UN79BDJT8ICUA23")
-- example_main("6P0UN79BDJT8ICUA21")

return {
    create_cd_key = final_create_one_cdkey,
    check_cd_key = final_check_cdkey,
}