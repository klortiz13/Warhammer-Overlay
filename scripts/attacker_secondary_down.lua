-- Change path to where you have the round_count.txt file stored --
Obslua = Obslua or require("obslua")
local file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/attacker_secondary.txt"
local hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local secondaries = {
    "SABOTAGE",
    "STORM HOSTILE OBJECTIVE",
    "ESTABLISH LOCUS",
    "CLEANSE",
    "A TEMPTING TARGET",
    "RECOVER ASSETS",
    "ENGAGE ON ALL FRONTS",
    "ASSASSINATION",
    "BRING IT DOWN",
    "CULL THE HORDE",
    "NO PRISONERS",
    "SECURE NO MAN\'S LAND",
    "MARKED FOR DEATH",
    "DEFEND STRONGHOLD",
    "AREA DENIAL",
    "OVERWHELMING FORCE",
    "BEHIND ENEMY LINES",
    "DISPLAY OF MIGHT",
    "EXTEND BATTLE LINES"
}
local size = #secondaries
local index = (size + 1)

-- Reads the text file round_count.txt and increments its value by 1 --
local function increment_round()
    local file = io.open(file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    index = (index > 1) and (index - 1) or size
    file:write(secondaries[index])
    file:close()
end

local function on_hotkey(pressed)
    if not pressed then return end
    increment_round()
end

-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_attacker_secondary_down_hotkey",
        "[From Lua Script] Attacker Secondary Down",
        on_hotkey
    )

    local hotkey_array = Obslua.obs_data_get_array(settings, "change_attacker_secondary_down_hotkey")
    Obslua.obs_hotkey_load(hotkey_id, hotkey_array)
    Obslua.obs_data_array_release(hotkey_array)
end

function script_description()
    return "Attacker Secondary Down – Changes the Attacker's Secondary Down in data/attacker_secondary.txt"
end

function script_save(settings)
    local hotkey_array = Obslua.obs_hotkey_save(hotkey_id)
    Obslua.obs_data_set_array(settings, "change_attacker_secondary_down_hotkey", hotkey_array)
    Obslua.obs_data_array_release(hotkey_array)
end