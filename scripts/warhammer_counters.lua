Obslua = Obslua or require("obslua")
local Global = require("global_variables")
-- Change paths accordingly --
local battle_round_file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/battle_round.txt"
local attacker_cp_file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/attacker_cp.txt"
local defender_cp_file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/defender_cp.txt"

-- ========== BATTLE ROUND ========== --
local increment_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local reset_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file round_counter.txt and increments its value by 1 --
local function increment_battle_round()
    local file = io.open(battle_round_file_path, "r")
    if not file then
        print("Could not open file: " .. battle_round_file_path)
        return
    end

    local contents = file:read("*all")
    contents = contents:gsub("%s+", "")
    local number = tonumber(contents) or 0
    file:close()

    file = io.open(battle_round_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.BattleRound = number + 1
    file:write(tostring(Global["BattleRound"]))

    file:close()
end

local function on_increment_battle_round_hotkey(pressed)
    if not pressed then return end
    increment_battle_round()
end

local function reset_battle_round()
    local file = io.open(battle_round_file_path, "w")
    if not file then 
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.BattleRound = 0
    file:write(tostring(0))
    file:close()
end

local function on_reset_battle_round_hotkey(pressed)
    if not pressed then return end
    reset_battle_round()
end

-- ========== ATTACKER CP ========== --
local increment_attacker_cp_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local reset_attacker_cp_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file attacker_CP.txt and increments its value by 1 --
local function increment_attacker_cp()
    local file = io.open(attacker_cp_file_path, "r")
    if not file then
        print("Could not open file: " .. attacker_cp_file_path)
        return
    end
    -- get contents
    local contents = file:read("*all")
    contents = contents:gsub("%s+", "")
    local number = tonumber(contents) or 0
    file:close()

    file = io.open(attacker_cp_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.AttackerCP = number + 1
    file:write(tostring(Global["AttackerCP"]))
    
    file:close()
end

local function on_increment_attacker_cp_hotkey(pressed)
    if not pressed then return end
    increment_attacker_cp()
end

local function reset_attacker_cp()
    local file = io.open(attacker_cp_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.AttackerCP = 0
    file:write(tostring(0))
    file:close()
end

local function on_reset_attacker_cp_hotkey(pressed)
    if not pressed then return end
    reset_attacker_cp()
end

-- ========== DEFENDER CP ========== --
local increment_defender_cp_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local reset_defender_cp_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID

-- Reads the text file defender_CP.txt and increments its value by 1 --
local function increment_defender_cp()
    local file = io.open(defender_cp_file_path, "r")
    if not file then
        print("Could not open file: " .. defender_cp_file_path)
        return
    end

    -- get contents
    local contents = file:read("*all")
    contents = contents:gsub("%s+", "")
    local number = tonumber(contents) or 0
    file:close()

    file = io.open(defender_cp_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.DefenderCP = number + 1
    file:write(tostring(Global["DefenderCP"]))
    
    file:close()
end

local function on_increment_defender_cp_hotkey(pressed)
    if not pressed then return end
    increment_defender_cp()
end

local function reset_defender_cp()
    local file = io.open(defender_cp_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    -- update global and write count
    Global.DefenderCP = 0
    file:write(tostring(0))
    file:close()
end

local function on_reset_defender_cp_hotkey(pressed)
    if not pressed then return end
    reset_defender_cp()
end

-- ========== Configuration ========== --
-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    -- BATTLE ROUND
    increment_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "increment_battle_round_hotkey",
        "[Warhammer] Increment Battle Round",
        on_increment_battle_round_hotkey
    )

    local increment_battle_round_hotkey_array = Obslua.obs_data_get_array(settings, "increment_battle_round_hotkey")
    Obslua.obs_hotkey_load(increment_hotkey_id, increment_battle_round_hotkey_array)
    Obslua.obs_data_array_release(increment_battle_round_hotkey_array)

    reset_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "reset_battle_round_hotkey",
        "[Warhammer] Reset Battle Round",
        on_reset_battle_round_hotkey
    )

    local reset_battle_round_hotkey_array = Obslua.obs_data_get_array(settings, "reset_battle_round_hotkey")
    Obslua.obs_hotkey_load(reset_hotkey_id, reset_battle_round_hotkey_array)
    Obslua.obs_data_array_release(reset_battle_round_hotkey_array)

    -- ATTACKER CP
    increment_attacker_cp_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "increment_attacker_cp_hotkey",
        "[Warhammer] Increment Attacker CP",
        on_increment_attacker_cp_hotkey
    )

    local increment_attacker_cp_hotkey_array = Obslua.obs_data_get_array(settings, "increment_attacker_cp_hotkey")
    Obslua.obs_hotkey_load(increment_attacker_cp_hotkey_id, increment_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_attacker_cp_hotkey_array)
    
    reset_attacker_cp_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "reset_attacker_cp_hotkey",
        "[Warhammer] Reset Attacker CP",
        on_reset_attacker_cp_hotkey
    )

    local reset_attacker_cp_hotkey_array = Obslua.obs_data_get_array(settings, "reset_attacker_cp_hotkey")
    Obslua.obs_hotkey_load(reset_attacker_cp_hotkey_id, reset_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_attacker_cp_hotkey_array)

    -- DEFENDER CP
    increment_defender_cp_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "increment_defender_cp_hotkey",
        "[Warhammer] Increment Defender CP",
        on_increment_defender_cp_hotkey
    )

    local increment_defender_cp_hotkey_array = Obslua.obs_data_get_array(settings, "increment_defender_cp_hotkey")
    Obslua.obs_hotkey_load(increment_defender_cp_hotkey_id, increment_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_defender_cp_hotkey_array)

    reset_defender_cp_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "reset_defender_cp_hotkey",
        "[Warhammer] Reset Defender CP",
        on_reset_defender_cp_hotkey
    )

    local reset_defender_cp_hotkey_array = Obslua.obs_data_get_array(settings, "reset_defender_cp_hotkey")
    Obslua.obs_hotkey_load(reset_defender_cp_hotkey_id, reset_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_defender_cp_hotkey_array)
end

function script_description()
    -- "Battle Round – increments and resets the Battle Round counter in data/round_counter.txt"
    -- "Attacker CP – increments and resets the Attacker's CP located in data/attacker_CP.txt"
    -- "Defender CP – increments and resets the Defender's CP in data/defender_CP.txt"
    return "Warhammer Counters - Increments and resets the Battle Round, Attacker's CP, and Defender's CP."
end

function script_save(settings)
    -- BATTLE ROUND
    local increment_battle_round_hotkey_array = Obslua.obs_hotkey_save(increment_hotkey_id)
    Obslua.obs_data_set_array(settings, "increment_battle_round_hotkey", increment_battle_round_hotkey_array)
    Obslua.obs_data_array_release(increment_battle_round_hotkey_array)

    local reset_battle_round_hotkey_array = Obslua.obs_hotkey_save(reset_hotkey_id)
    Obslua.obs_data_set_array(settings, "reset_battle_round_hotkey", reset_battle_round_hotkey_array)
    Obslua.obs_data_array_release(reset_battle_round_hotkey_array)

    -- ATTACKER CP
    local increment_attacker_cp_hotkey_array = Obslua.obs_hotkey_save(increment_attacker_cp_hotkey_id)
    Obslua.obs_data_set_array(settings, "increment_attacker_cp_hotkey", increment_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_attacker_cp_hotkey_array)

    local reset_attacker_cp_hotkey_array = Obslua.obs_hotkey_save(reset_attacker_cp_hotkey_id)
    Obslua.obs_data_set_array(settings, "reset_attacker_cp_hotkey", reset_attacker_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_attacker_cp_hotkey_array)

    -- DEFENDER CP
    local increment_defender_cp_hotkey_array = Obslua.obs_hotkey_save(increment_defender_cp_hotkey_id)
    Obslua.obs_data_set_array(settings, "increment_defender_cp_hotkey",increment_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(increment_defender_cp_hotkey_array)

    local reset_defender_cp_hotkey_array = Obslua.obs_hotkey_save(reset_defender_cp_hotkey_id)
    Obslua.obs_data_set_array(settings, "reset_defender_cp_hotkey", reset_defender_cp_hotkey_array)
    Obslua.obs_data_array_release(reset_defender_cp_hotkey_array)
end
