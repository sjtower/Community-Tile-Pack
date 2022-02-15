local checkpoints = require("Checkpoints/checkpoints")
local nocrap = require("Modules.Dregu.no_crap")
local death_blocks = require("Modules.JawnGC.death_blocks")
local moving_totems = require("Modules.JayTheBusinessGoose.moving_totems")
local monster_generator = require("Modules.JayTheBusinessGoose.monster_generator")
local death_elevators = require("Modules.GetimOliver.death_elevators")
local timed_doors = require("Modules.GetimOliver.timed_door")
local inverse_timed_doors = require("Modules.GetimOliver.inverse_timed_door")

local dwelling1 = {
    identifier = "dwelling1",
    title = "Dwelling 1",
    theme = THEME.DWELLING,
    width = 6,
    height = 5,
    file_name = "dwell-1.lvl",
}

local level_state = {
    loaded = false,
    callbacks = {},
}

local saved_checkpoint

local function save_checkpoint(checkpoint)
    saved_checkpoint = checkpoint
end

dwelling1.load_level = function()
    if level_state.loaded then return end
    level_state.loaded = true

    death_blocks.activate(level_state)
    death_elevators.activate(level_state)
    moving_totems.activate(level_state)
    timed_doors.activate(level_state, 100)
    inverse_timed_doors.activate(level_state, 100)
    monster_generator.activate(level_state, ENT_TYPE.MONS_UFO)

    checkpoints.activate()
    checkpoints.checkpoint_activate_callback(function(x, y, layer, time)
        save_checkpoint({
            position = {
                x = x,
                y = y,
                layer = layer,
            },
            time = time,
        })
    end)

    if saved_checkpoint then
        checkpoints.activate_checkpoint_at(
            saved_checkpoint.position.x,
            saved_checkpoint.position.y,
            saved_checkpoint.position.layer,
            saved_checkpoint.time
        )
    end
    
end

dwelling1.unload_level = function()
    if not level_state.loaded then return end

    checkpoints.deactivate()
    timed_doors.deactivate()
    inverse_timed_doors.deactivate()

    local callbacks_to_clear = level_state.callbacks
    level_state.loaded = false
    level_state.callbacks = {}
    for _,callback in ipairs(callbacks_to_clear) do
        clear_callback(callback)
    end
end

return dwelling1
