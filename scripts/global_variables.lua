local M = {}
-- Global variables for the primary mission scripts
M.Primaries = {
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
M.PrimarySize = #M.Primaries
M.PrimaryIndex = 1

-- Global variables for the secondary mission scripts
M.Secondaries = {
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
M.SecondarySize = #M.Secondaries
M.SecondaryAttackerIndex = 1
M.SecondaryDefenderIndex = 1

-- Global variables for the counter files
M.AttackerCP = 0
M.DefenderCP = 0
M.BattleRound = 0

return M