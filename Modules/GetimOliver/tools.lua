
local function activate(level_state)
    --prints out the location of where it is placed. Useful for spawning entities without manual counting.
    define_tile_code("location_block")
    level_state.callbacks[#level_state.callbacks+1] = set_pre_tile_code_callback(function(x, y, layer)
        local location = tostring(x) .. " | " .. tostring(y)
        print(location)
        return true
    end, "location_block")
end