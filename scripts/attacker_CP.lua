-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local Global = require("global_variables")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/attacker_CP.txt"
local hotkey_increment_id = Obslua.OBS_INVALID_HOTKEY_ID
local hotkey_reset_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file round_count.txt and increments its value by 1 --
local function increment_attacker_cp()
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
    Global.AttackerCP = number + 1
    file:write(tostring(Global["AttackerCP"]))
    
    file:close()
end

local function on_increment_hotkey(pressed)
    if not pressed then return end
    increment_attacker_cp()
end

local function reset_attacker_cp()
    local file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.AttackerCP = 0
    file:write(tostring(0))
    file:close()
end

local function on_reset_hotkey(pressed)
    if not pressed then return end
    reset_attacker_cp()
end

-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    hotkey_increment_id = Obslua.obs_hotkey_register_frontend(
        "increment_attacker_cp_hotkey",
        "[From Lua Script] Attacker CP",
        on_increment_hotkey
    )

    local increment_attacker_cp_hotkey_array = Obslua.obs_data_get_array(settings, "increment_attacker_cp_hotkey")
    Obslua.obs_hotkey_load(hotkey_increment_id, increment_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_attacker_cp_hotkey_array)
    
    hotkey_reset_id = Obslua.obs_hotkey_register_frontend(
        "reset_attacker_cp_hotkey",
        "[From Lua Script] Reset Attacker CP",
        on_reset_hotkey
    )

    local reset_attacker_cp_hotkey_array = Obslua.obs_data_get_array(settings, "reset_attacker_cp_hotkey")
    Obslua.obs_hotkey_load(hotkey_reset_id, reset_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_attacker_cp_hotkey_array)

end

function script_description()
    return "Attacker CP – increments and resets the Attacker's CP located in data/attacker_CP.txt"
end

function script_save(settings)
    local increment_attacker_cp_hotkey_array = Obslua.obs_hotkey_save(hotkey_increment_id)
    Obslua.obs_data_set_array(settings, "increment_attacker_cp_hotkey", increment_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_attacker_cp_hotkey_array)

    local reset_attacker_cp_hotkey_array = Obslua.obs_hotkey_save(hotkey_reset_id)
    Obslua.obs_data_set_array(settings, "reset_attacker_cp_hotkey", reset_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_attacker_cp_hotkey_array)
end