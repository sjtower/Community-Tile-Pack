local function activate(level_state, ent_type)

    define_tile_code("custom_death_block")
    local custom_death_blocks = {}
    level_state.callbacks[#level_state.callbacks+1] = set_pre_tile_code_callback(function(x, y, layer)
        local ent_id = spawn(ent_type, x, y, layer, 0, 0)
        custom_death_blocks[#custom_death_blocks + 1] = get_entity(ent_id)
        return true
    end, "custom_death_block")

    local frames = 0
    level_state.callbacks[#level_state.callbacks+1] = set_callback(function ()

        for i = 1,#custom_death_blocks do
            custom_death_blocks[i].color:set_rgba(100 + math.ceil(50 * math.sin(0.05 * frames)), 0, 0, 255) --Pulse effect
            if #players ~= 0 and players[1].standing_on_uid == custom_death_blocks[i].uid then
                kill_entity(players[1].uid, false)
            end
        end

        frames = frames + 1
    end, ON.FRAME)
end

return {
    activate = activate,
}
