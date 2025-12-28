-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/defender_CP.txt"
local hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file round_count.txt and increments its value by 1 --
local function increment_round()
    local file = io.open(file_path, "r")
    if not file then
        print("Could not open file: " .. file_path)
        return
    end

    local contents = file:read("*all")
    contents = contents:gsub("%s+", "")
    local number = tonumber(contents) or 0

    file:close()

    number = number + 1

    file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    file:write(tostring(number))
    file:close()
end

local function on_hotkey(pressed)
    if not pressed then return end
    increment_round()
end

-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    hotkey_id = Obslua.obs_hotkey_register_frontend(
        "increment_defender_cp_hotkey",
        "[From Lua Script] Defender CP",
        on_hotkey
    )

    local hotkey_array = Obslua.obs_data_get_array(settings, "increment_defender_cp_hotkey")
    Obslua.obs_hotkey_load(hotkey_id, hotkey_array)
    Obslua.obs_data_array_release(hotkey_array)
end

function script_description()
    return "Defender CP – increments the Defender's CP in data/defender_CP.txt"
end

function script_save(settings)
    local hotkey_array = Obslua.obs_hotkey_save(hotkey_id)
    Obslua.obs_data_set_array(settings, "increment_defender_cp_hotkey", hotkey_array)
    Obslua.obs_data_array_release(hotkey_array)
end