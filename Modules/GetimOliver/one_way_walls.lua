local right_blocks = {}
local left_blocks = {}

local texture_definition = TextureDefinition.new()
texture_definition.width = 128
texture_definition.height = 128
texture_definition.tile_width = 128
texture_definition.tile_height = 128

local function one_way_right_texture() 
    texture_definition.texture_path = f'Modules/GetimOliver/Textures/one_way_right.png'
    local active_texture = define_texture(texture_definition)
    return active_texture
end

local function one_way_left_texture() 
    texture_definition.texture_path = f'Modules/GetimOliver/Textures/one_way_left.png'
    local active_texture = define_texture(texture_definition)
    return active_texture
end

local function activate(level_state)

    define_tile_code("one_way_right")
    level_state.callbacks[#level_state.callbacks+1] = set_pre_tile_code_callback(function(x, y, layer)
        local block_uid = spawn_entity(ENT_TYPE.ITEM_WEB, x, y, layer, 0, 0)
        local block = get_entity(block_uid)
        
        block.flags = set_flag(block.flags, ENT_FLAG.PASSES_THROUGH_PLAYER)
        block.flags = clr_flag(block.flags, ENT_FLAG.SOLID)
        
        block.hitboxy = 0.45
        block.hitboxx = 0.5

        block:set_texture(one_way_right_texture())

        right_blocks[#right_blocks + 1] = get_entity(block_uid)
        set_pre_collision2(block_uid, function(self, collidee)
            if collidee.velocityx < 0.1 then collidee.velocityx = 0.1 end
            return true
        end)
        return true
    end, "one_way_right")

    define_tile_code("one_way_left")
    level_state.callbacks[#level_state.callbacks+1] = set_pre_tile_code_callback(function(x, y, layer)
        local block_uid = spawn_entity(ENT_TYPE.ITEM_WEB, x, y, layer, 0, 0)
        local block = get_entity(block_uid)
        
        block.flags = set_flag(block.flags, ENT_FLAG.PASSES_THROUGH_PLAYER)
        block.flags = clr_flag(block.flags, ENT_FLAG.SOLID)

        block.hitboxy = 0.45
        block.hitboxx = 0.5
        
        block:set_texture(one_way_left_texture())

        left_blocks[#left_blocks + 1] = get_entity(block_uid)
        set_pre_collision2(block_uid, function(self, collidee)
            if collidee.velocityx > -0.1 then collidee.velocityx = -0.1 end
            return true
        end)
        return true
    end, "one_way_left")
end

local function deactivate()
    left_blocks = {}
    right_blocks = {}
end

return {
    activate = activate,
    deactivate = deactivate
}
