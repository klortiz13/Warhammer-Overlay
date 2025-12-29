-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local Global = require("global_variables")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/primary_mission.txt"
local change_up_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local change_down_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file round_count.txt and increments its value by 1 --
local function change_primary_mission_up()
    local file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    Global.PrimaryIndex = (Global.PrimaryIndex < Global.PrimarySize) and (Global.PrimaryIndex + 1) or 1
    file:write(Global.Primaries[Global.PrimaryIndex])
    file:close()
end

local function on_change_primary_mission_up_hotkey(pressed)
    if not pressed then return end
    change_primary_mission_up()
end

local function change_primary_mission_down()
    local file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    Global.PrimaryIndex = (Global.PrimaryIndex > 1) and (Global.PrimaryIndex - 1) or Global.PrimarySize
    file:write(Global.Primaries[Global.PrimaryIndex])
    file:close()
end

local function on_change_primary_mission_down_hotkey(pressed)
    if not pressed then return end
    change_primary_mission_down()
end

-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    change_up_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_primary_mission_up_hotkey",
        "[Warhammer] Change Primary Mission Up",
        on_change_primary_mission_up_hotkey
    )

    local change_primary_mission_up_hotkey_array = Obslua.obs_data_get_array(settings, "change_primary_mission_up_hotkey")
    Obslua.obs_hotkey_load(change_up_hotkey_id, change_primary_mission_up_hotkey_array)
    Obslua.obs_data_array_release(change_primary_mission_up_hotkey_array)

    change_down_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_primary_mission_down_hotkey",
        "[Warhammer] Change Primary Mission Down",
        on_change_primary_mission_down_hotkey
    )

    local change_primary_mission_down_hotkey_array = Obslua.obs_data_get_array(settings, "change_primary_mission_down_hotkey")
    Obslua.obs_hotkey_load(change_down_hotkey_id, change_primary_mission_down_hotkey_array)
    Obslua.obs_data_array_release(change_primary_mission_down_hotkey_array)
end

function script_description()
    return "Primary Mission – Changes the Primary Mission Up and Down in data/primary_mission.txt"
end

function script_save(settings)
    local change_primary_mission_up_hotkey_array = Obslua.obs_hotkey_save(change_up_hotkey_id)
    Obslua.obs_data_set_array(settings, "change_primary_mission_up_hotkey", change_primary_mission_up_hotkey_array)
    Obslua.obs_data_array_release(change_primary_mission_up_hotkey_array)

    local change_primary_mission_down_hotkey_array = Obslua.obs_hotkey_save(change_down_hotkey_id)
    Obslua.obs_data_set_array(settings, "change_primary_mission_down_hotkey", change_primary_mission_down_hotkey_array)
    Obslua.obs_data_array_release(change_primary_mission_down_hotkey_array)
end