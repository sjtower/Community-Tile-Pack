meta.name = 'Community-Tile-Pack'
meta.version = '0'
meta.description = 'A collection of custom Lua tiles from the Spelunky 2 Community'
meta.author = 'GetimOliver, Dregu, JayTheBusinessGoose, JawnGC'

local level_sequence = require("LevelSequence/level_sequence")

local dwelling1 = require("dwelling1")

level_sequence.set_levels({dwelling1})

--------------------------------------
---- /SOUNDS
--------------------------------------

--------------------------------------
---- CAMP
--------------------------------------

local function camp_bounds_callback()
	return set_callback(function()
		set_camp_camera_bounds_enabled(true)
		set_global_timeout(function()
			if state.theme ~= THEME.BASE_CAMP then return end
			set_camp_camera_bounds_enabled(false)
			state.camera.bounds_left = 0
			state.camera.bounds_right = 72.5
			state.camera.bounds_top = 130.4 - 8 * 6 + 16
			state.camera.bounds_bottom = 130.6 - 8 * 6
		end, 140)
	end, ON.CAMP)

end

local function undo_camp_bounds_callback()
	return set_callback(function()
		set_camp_camera_bounds_enabled(true)
	end, ON.LEVEL)
end

--------------------------------------
---- DO NOT SPAWN GHOST 
--------------------------------------

-- set_ghost_spawn_times(-1, -1)

--------------------------------------
---- /DO NOT SPAWN GHOST 
--------------------------------------

local active = false
local callbacks = {}
local vanilla_sound_callbacks = {}

local function activate()
	if active then return end
	active = true
	level_sequence.activate()

	local function add_callback(callback_id)
		callbacks[#callbacks+1] = callback_id
	end
	local function add_vanilla_sound_callback(callback_id)
		vanilla_sound_callbacks[#vanilla_sound_callbacks+1] = callback_id
	end

	add_callback(camp_bounds_callback())
	add_callback(undo_camp_bounds_callback())
end

set_callback(function()
	activate()
end, ON.LOAD)

set_callback(function()
	activate()
end, ON.SCRIPT_ENABLE)

set_callback(function()
	if not active then return end
	active = false
	level_sequence.deactivate()

	for _, callback in pairs(callbacks) do
		clear_callback(callback)
	end
	for _, vanilla_sound_callback in pairs(vanilla_sound_callbacks) do
		clear_vanilla_sound_callback(vanilla_sound_callback)
	end
	callbacks = {}
	vanilla_sound_callbacks = {}
end, ON.SCRIPT_DISABLE)
