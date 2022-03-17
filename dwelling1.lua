local checkpoints = require("Checkpoints/checkpoints")
local nocrap = require("Modules.Dregu.no_crap")
local faster_bullets = require("Modules.Dregu.faster_bullets")
local fast_push_blocks = require("Modules.Dregu.fast_push_block")
local death_blocks = require("Modules.JawnGC.death_blocks")
local moving_totems = require("Modules.JayTheBusinessGoose.moving_totems")
local monster_generator = require("Modules.JayTheBusinessGoose.monster_generator")
local signs = require("Modules.JayTheBusinessGoose.signs")
local death_elevators = require("Modules.GetimOliver.death_elevators")
local timed_doors = require("Modules.GetimOliver.timed_door")
local inverse_timed_doors = require("Modules.GetimOliver.inverse_timed_door")
local key_blocks          = require("Modules.GetimOliver.key_blocks")
local on_off_blocks       = require("Modules.GetimOliver.on_off_blocks")

local dwelling1 = {
    identifier = "dwelling1",
    title = "Welcome to the Spelunky 2 Community Tile Pack!",
    theme = THEME.DWELLING,
    width = 6,
    height = 5,
    file_name = "dwell-1.lvl",
}

local level_state = {
    loaded = false,
    callbacks = {},
}

dwelling1.load_level = function()
    if level_state.loaded then return end
    level_state.loaded = true

    faster_bullets.activate(level_state)
    fast_push_blocks.activate(level_state)
    death_blocks.activate(level_state)
    death_elevators.activate(level_state)
    moving_totems.activate(level_state)
    key_blocks.activate(level_state)
    timed_doors.activate(level_state, 100)
    inverse_timed_doors.activate(level_state, 100)
    on_off_blocks.activate(level_state, 30)
    monster_generator.activate(level_state, ENT_TYPE.MONS_BAT)
    checkpoints.activate()
    signs.activate(level_state, {"Sign 1", "2", "Three"})
    
end

dwelling1.unload_level = function()
    if not level_state.loaded then return end

    checkpoints.deactivate()
    timed_doors.deactivate()
    inverse_timed_doors.deactivate()
    on_off_blocks.deactivate()
    key_blocks.deactivate()
    moving_totems.deactivate()
    signs.deactivate()

    local callbacks_to_clear = level_state.callbacks
    level_state.loaded = false
    level_state.callbacks = {}
    for _,callback in ipairs(callbacks_to_clear) do
        clear_callback(callback)
    end
end

return dwelling1
