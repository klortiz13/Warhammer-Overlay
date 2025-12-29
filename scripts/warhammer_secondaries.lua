Obslua = Obslua or require("obslua")
local Global = require("global_variables")
local change_attacker_secondary_up_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local change_attacker_secondary_down_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local change_defender_secondary_up_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
local change_defender_secondary_down_hotkey_id = Obslua.OBS_INVALID_HOTKEY_ID
-- Change paths accordingly --
local attacker_file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/attacker_secondary.txt"
local defender_file_path = "C:/Users/leona/OneDrive/Documents/Code/Warhammer_OBS_Sources/data/defender_secondary.txt"

-- ========== ATTACKER SECONDARY ========== --
-- Reads the text file attacker_secondary.txt and changes its secondary up --
local function change_attacker_secondary_up()
    local file = io.open(attacker_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    Global.SecondaryAttackerIndex = (Global.SecondaryAttackerIndex < Global.SecondarySize) and (Global.SecondaryAttackerIndex
    + 1) or 1
    file:write(Global.Secondaries[Global.SecondaryAttackerIndex])
    file:close()
end

local function on_change_attacker_secondary_up_hotkey(pressed)
    if not pressed then return end
    change_attacker_secondary_up()
end

-- Reads the text file attacker_secondary.txt and changes its secondary down --
local function change_attacker_secondary_down()
    local file = io.open(attacker_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    Global.SecondaryAttackerIndex = (Global.SecondaryAttackerIndex > 1) and (Global.SecondaryAttackerIndex - 1) or Global.SecondarySize
    file:write(Global.Secondaries[Global.SecondaryAttackerIndex])
    file:close()
end

local function on_change_attacker_secondary_down_hotkey(pressed)
    if not pressed then return end
    change_attacker_secondary_down()
end

-- ========== DEFENDER SECONDARY ========== --
-- Reads the text file defender_secondary.txt and changes its secondary up --
local function change_defender_secondary_up()
    local file = io.open(defender_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    Global.SecondaryDefenderIndex = (Global.SecondaryDefenderIndex < Global.SecondarySize) and (Global.SecondaryDefenderIndex
    + 1) or 1
    file:write(Global.Secondaries[Global.SecondaryDefenderIndex])
    file:close()
end

local function on_change_defender_secondary_up_hotkey(pressed)
    if not pressed then return end
    change_defender_secondary_up()
end

-- Reads the text file defender_secondary.txt and changes its secondary down --
local function change_defender_secondary_down()
    local file = io.open(defender_file_path, "w")
    if not file then
        print("Could not write file")
        return
    end

    Global.SecondaryDefenderIndex = (Global.SecondaryDefenderIndex > 1) and (Global.SecondaryDefenderIndex - 1) or Global.SecondarySize
    file:write(Global.Secondaries[Global.SecondaryDefenderIndex])
    file:close()
end

local function on_change_defender_secondary_down_hotkey(pressed)
    if not pressed then return end
    change_defender_secondary_down()
end

-- ========== CONFIGURATION ========== --
-- This is the name and description that will be displayed in OBS -> Settings -> Hotkeys --
function script_load(settings)
    -- ATTACKER SECONDARY
    change_attacker_secondary_up_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_attacker_secondary_up_hotkey",
        "[Warhammer] Change Attacker Secondary Up",
        on_change_attacker_secondary_up_hotkey
    )

    local change_attacker_secondary_up_hotkey_array = Obslua.obs_data_get_array(settings, "change_attacker_secondary_up_hotkey")
    Obslua.obs_hotkey_load(change_attacker_secondary_up_hotkey_id, change_attacker_secondary_up_hotkey_array)
    Obslua.obs_data_array_release(change_attacker_secondary_up_hotkey_array)

    change_attacker_secondary_down_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_attacker_secondary_down_hotkey",
        "[Warhammer] Change Attacker Secondary Down",
        on_change_attacker_secondary_down_hotkey
    )

    local change_attacker_secondary_down_hotkey_array = Obslua.obs_data_get_array(settings, "change_attacker_secondary_down_hotkey")
    Obslua.obs_hotkey_load(change_attacker_secondary_down_hotkey_id, change_attacker_secondary_down_hotkey_array)
    Obslua.obs_data_array_release(change_attacker_secondary_down_hotkey_array)

    -- DEFENDER SECONDARY
    change_defender_secondary_up_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_defender_secondary_up_hotkey",
        "[Warhammer] Change Defender Secondary Up",
        on_change_defender_secondary_up_hotkey
    )

    local change_defender_secondary_up_hotkey_array = Obslua.obs_data_get_array(settings, "change_defender_secondary_up_hotkey")
    Obslua.obs_hotkey_load(change_defender_secondary_up_hotkey_id, change_defender_secondary_up_hotkey_array)
    Obslua.obs_data_array_release(change_defender_secondary_up_hotkey_array)

    change_defender_secondary_down_hotkey_id = Obslua.obs_hotkey_register_frontend(
        "change_defender_secondary_down_hotkey",
        "[Warhammer] Change Defender Secondary Down",
        on_change_defender_secondary_down_hotkey
    )

    local change_defender_secondary_down_hotkey_array = Obslua.obs_data_get_array(settings, "change_defender_secondary_down_hotkey")
    Obslua.obs_hotkey_load(change_defender_secondary_down_hotkey_id, change_defender_secondary_down_hotkey_array)
    Obslua.obs_data_array_release(change_defender_secondary_down_hotkey_array)

end

function script_description()
    return "Secondary Mission – Changes the Attacker's and Defender's Secondary Mission Up and Down."
end

function script_save(settings)
    -- ATTACKER SECONDARY
    local change_attacker_secondary_up_hotkey_array = Obslua.obs_hotkey_save(change_attacker_secondary_up_hotkey_id)
    Obslua.obs_data_set_array(settings, "change_attacker_secondary_up_hotkey", change_attacker_secondary_up_hotkey_array)
    Obslua.obs_data_array_release(change_attacker_secondary_up_hotkey_array)

    local change_attacker_secondary_down_hotkey_array = Obslua.obs_hotkey_save(change_attacker_secondary_down_hotkey_id)
    Obslua.obs_data_set_array(settings, "change_attacker_secondary_down_hotkey", change_attacker_secondary_down_hotkey_array)
    Obslua.obs_data_array_release(change_attacker_secondary_down_hotkey_array)

    -- DEFENDER SECONDARY
    local change_defender_secondary_up_hotkey_array = Obslua.obs_hotkey_save(change_defender_secondary_up_hotkey_id)
    Obslua.obs_data_set_array(settings, "change_defender_secondary_up_hotkey", change_defender_secondary_up_hotkey_array)
    Obslua.obs_data_array_release(change_defender_secondary_up_hotkey_array)

    local change_defender_secondary_down_hotkey_array = Obslua.obs_hotkey_save(change_defender_secondary_down_hotkey_id)
    Obslua.obs_data_set_array(settings, "change_defender_secondary_down_hotkey", change_defender_secondary_down_hotkey_array)
    Obslua.obs_data_array_release(change_defender_secondary_down_hotkey_array)
end