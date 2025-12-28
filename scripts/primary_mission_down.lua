-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/primary_mission.txt"
local hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local primaries = {
    "TAKE AND HOLD",
    "BURDEN OF TRUST",
    "LINCHPIN",
    "SCORCHED EARTH",
    "PURGE THE FOE",
    "TERRAFORM",
    "HIDDEN SUPPLIES",
    "THE RITUAL",
    "UNEXPLODED ORDINANCE",
    "SUPPLY DROP"
}
local size = #primaries
local index = (size + 1)

-- Reads the text file round_count.txt and increments its value by 1 --
local function increment_round()
    local file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    index = (index > 1) and (index - 1) or size
    file:write(primaries[index])
    file:close()
end

local function on_hotkey(pressed)
    if not pressed then return end
    increment_round()
end

-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_primary_mission_down_hotkey",
        "[From Lua Script] Primary Mission Down",
        on_hotkey
    )

    local hotkey_array = Obslua.obs_data_get_array(settings, "change_primary_mission_down_hotkey")
    Obslua.obs_hotkey_load(hotkey_id, hotkey_array)
    Obslua.obs_data_array_release(hotkey_array)
end

function script_description()
    return "Primary Mission Down – Changes the Primary Mission Down in data/primary_mission.txt"
end

function script_save(settings)
    local hotkey_array = Obslua.obs_hotkey_save(hotkey_id)
    Obslua.obs_data_set_array(settings, "change_primary_mission_down_hotkey", hotkey_array)
    Obslua.obs_data_array_release(hotkey_array)
end