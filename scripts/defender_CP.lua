-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local Global = require("global_variables")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/defender_CP.txt"
local hotkey_increment_id = Obslua.OBS_INVALID_HOTKEY_ID
local hotkey_reset_id

-- Reads the text file round_count.txt and increments its value by 1 --
local function increment_defender_cp()
    local file = io.open(file_path, "r")
    if not file then
        print("Could not open file: " .. file_path)
        return
    end

    -- get contents
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
    Global.DefenderCP = number + 1
    file:write(tostring(Global["DefenderCP"]))
    
    file:close()
end

local function on_increment_hotkey(pressed)
    if not pressed then return end
    increment_defender_cp()
end

local function reset_defender_cp()
    local file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.DefenderCP = 0
    file:write(tostring(0))
    file:close()
end

local function on_reset_hotkey(pressed)
    if not pressed then return end
    reset_defender_cp()
end


-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    hotkey_increment_id = Obslua.obs_hotkey_register_frontend(
        "increment_defender_cp_hotkey",
        "[Warhammer] Increment Defender CP",
        on_increment_hotkey
    )

    local increment_defender_cp_hotkey_array = Obslua.obs_data_get_array(settings, "increment_defender_cp_hotkey")
    Obslua.obs_hotkey_load(hotkey_increment_id, increment_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_defender_cp_hotkey_array)

    hotkey_reset_id = Obslua.obs_hotkey_register_frontend(
        "reset_defender_cp_hotkey",
        "[Warhammer] Reset Defender CP",
        on_reset_hotkey
    )

    local reset_defender_cp_hotkey_array = Obslua.obs_data_get_array(settings, "reset_defender_cp_hotkey")
    Obslua.obs_hotkey_load(hotkey_reset_id, reset_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_defender_cp_hotkey_array)
end

function script_description()
    return "Defender CP – increments and resets the Defender's CP in data/defender_CP.txt"
end

function script_save(settings)
    local increment_defender_cp_hotkey_array = Obslua.obs_hotkey_save(hotkey_increment_id)
    Obslua.obs_data_set_array(settings, "increment_defender_cp_hotkey",increment_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_defender_cp_hotkey_array)

    local reset_defender_cp_hotkey_array = Obslua.obs_hotkey_save(hotkey_reset_id)
    Obslua.obs_data_set_array(settings, "reset_defender_cp_hotkey", reset_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_defender_cp_hotkey_array)
end