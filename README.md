# Community-Tile-Pack

A collection of custom Lua blocks that can be used freely in other mods.

Includes a single level demonstrating each custom Lua tile.

## How to use

1. Copy the "Modules" directory into your own mod, at the root directory
2. include the module in your Lua level file with `requires`. EG:

    ```lua
    local death_blocks = require("Modules.JawnGC.death_blocks")
    ```

3. When loading your level, activate the mod. EG:

    ```lua
        death_blocks.activate(level_state)
    ```

4. When unloading your level, deactivate the mod. Not all mods need to deactivate. EG:

    ```lua
        death_blocks.deactivate()
    ```

5. Look at `dwelling1.lua` for examples on using `requires` and activating the mods.

Checkpoints work a little differently - I encourage you to check out the code in `dwelling1.lua` to see how to implement checkpoints.

Let me know if you need any help working with these mods.

## Included Mods

- checkpoints
- faster bullets
- fast push blocks
- death blocks
- death elevators
- breakable walls
- blocks that break with a key
- timed doors
- reverse timed doors
- monster generator

Contribute your custom Lua tiles - DM me on Discord, or create a pull request in the [Github repo](https://github.com/sjtower/Community-Tile-Pack)
