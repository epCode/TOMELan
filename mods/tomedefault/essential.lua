local register_node = core.register_node
local register_alias = core.register_alias


register_node('tomedefault:granite', {
    description = 'Granite',
    _tlcomment = "It is very heavy.",
    _color = "yellow",
    tiles = { {name = 'tomedefault_granite_8.png', align_style="world", scale=8} },
    groups = { oddly_breakable_by_hand = 3 },
    is_ground_content = true
})

register_node('tomedefault:water_source', {
    description = 'Water',
    _tlcomment = "You shouldn't be carrying this..",
    _tlcolor = "red",
    tiles = { 'tomedefault_water.png' },
    groups = { oddly_breakable_by_hand = 3 },
    is_ground_content = true
})

register_alias('mapgen_stone', 'tomedefault:granite')
register_alias('mapgen_water_source', 'tomedefault:water_source')
register_alias('mapgen_river_water_source', 'tomedefault:water_source')

local register_item = core.register_item


register_item(':', {
    type = 'none',
    wield_image = 'void_hand_hand.png',
    wield_scale = {x = 0.5, y = 1, z = 4},
    tool_capabilities = {
        full_punch_interval = 0.9,
        max_drop_level = 0,
        groupcaps = {
            crumbly = {
                times = {[2] = 3.00, [3] = 0.70},
                uses = 0,
                maxlevel = 1,
            },
            snappy = {
                times = {[3] = 0.40},
                uses = 0,
                maxlevel = 1,
            },
            oddly_breakable_by_hand = {
                times = {[1] = 3.50, [2] = 2.00, [3] = 0.70},
                uses = 0,
            },
        },
        damage_groups = {fleshy = 1},
    }
})
