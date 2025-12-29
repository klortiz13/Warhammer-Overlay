-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local Global = require("global_variables")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/round_counter.txt"
local increment_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local reset_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file round_count.txt and increments its value by 1 --
local function increment_battle_round()
    local file = io.open(file_path, "r")
    if not file then
        print("Could not open file: " .. file_path)
        return
    end

    local contents = file:read("*all")
    contents = contents:gsub("%s+", "")
    local number = tonumber(contents) or 0
    file:close()

    file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.BattleRound = number + 1
    file:write(tostring(Global["BattleRound"]))

    file:close()
end

local function on_increment_hotkey(pressed)
    if not pressed then return end
    increment_battle_round()
end

local function reset_battle_round()
    local file = io.open(file_path, "w")
    if not file then 
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.BattleRound = 0
    file:write(tostring(0))
    file:close()
end

local function on_reset_hotkey(pressed)
    if not pressed then return end
    reset_battle_round()
end

-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    increment_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "increment_battle_round_hotkey",
        "[Warhammer] Increment Battle Round",
        on_increment_hotkey
    )

    local increment_battle_round_hotkey_array = Obslua.obs_data_get_array(settings, "increment_battle_round_hotkey")
    Obslua.obs_hotkey_load(increment_hotkey_id, increment_battle_round_hotkey_array)
    Obslua.obs_data_array_release(increment_battle_round_hotkey_array)

    reset_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "reset_battle_round_hotkey",
        "[Warhammer] Reset Battle Round",
        on_reset_hotkey
    )

    local reset_battle_round_hotkey_array = Obslua.obs_data_get_array(settings, "reset_battle_round_hotkey")
    Obslua.obs_hotkey_load(reset_hotkey_id, reset_battle_round_hotkey_array)
    Obslua.obs_data_array_release(reset_battle_round_hotkey_array)
end

function script_description()
    return "Round Counter – increments and resets the Battle Round counter in data/round_counter.txt"
end

function script_save(settings)
    local increment_battle_round_hotkey_array = Obslua.obs_hotkey_save(increment_hotkey_id)
    Obslua.obs_data_set_array(settings, "increment_battle_round_hotkey", increment_battle_round_hotkey_array)
    Obslua.obs_data_array_release(increment_battle_round_hotkey_array)

    local reset_battle_round_hotkey_array = Obslua.obs_hotkey_save(reset_hotkey_id)
    Obslua.obs_data_set_array(settings, "reset_battle_round_hotkey", reset_battle_round_hotkey_array)
    Obslua.obs_data_array_release(reset_battle_round_hotkey_array)
end