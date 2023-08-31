# Community-Tile-Pack

A collection of custom Lua blocks that can be used freely in other mods.

Includes a single level demonstrating each custom Lua tile.

## How to use

1. Copy the "Modules", "Checkpoints", and "Telescopes" directories into your own mod, at the root directory
2. include one of the module in your Lua level file with `requires`. EG:

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

5. Define the mod's custom tile codes in the level editor in Modlunky
    - In the "Level Editor" tab, find the "Add Tilecode" button in the bottom-right corner
    - type in the name of the custom tile code and press the button
    - Look in the Module's mod folders to see what tilecodes you need
    - Custom tile codes are defined with `define_tile_code`, EG: `define_tile_code("fast_push_block")`
6. Look at `dwelling1.lua` and `Data/dwell-1.lvl` for examples on using `requires`activating the mods, and adding custom tile codes

Checkpoints work a little differently - I encourage you to check out the code in `dwelling1.lua` to see how to implement checkpoints.

Let me know if you need any help working with these mods.

## Included Mods

- checkpoints
- one-way walls (up, down, left, & right)
- one-way platforms
- blocks that break with a key
- locked exits with special key
- custom death blocks
- walls that break with a switch
- floors that break going left or right over them
- no-player blocks
- player-only blocks
- timed doors
- inverse timed doors
- blocks that break at certain money thresholds
- faster bullets
- fast push blocks
- monster generator

Contribute your custom Lua tiles - DM me on Discord, or create a pull request in the [Github repo](https://github.com/sjtower/Community-Tile-Pack)
