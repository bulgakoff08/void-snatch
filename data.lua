require("prototypes.items")
require("prototypes.entities")
require("prototypes.recipes")

local GRAPHICS_PATH = "__void-snatch__/graphics/"

data:extend({
    {
        type = "item-group",
        name = "void-snatch",
        icon_size = 128,
        icon = GRAPHICS_PATH .. "void-snatch.png",
        inventory_order = "v",
        order = "v-a"
    },
    {
        type = "item-subgroup",
        name = "resource-duplication",
        group = "void-snatch",
        order = "a-a"
    },
    {
        type = "item-subgroup",
        name = "catalyst-duplication",
        group = "void-snatch",
        order = "b-a"
    },
    {
        type = "item-subgroup",
        name = "void-machines",
        group = "void-snatch",
        order = "c-a"
    },
    {
        type = "item-subgroup",
        name = "void-other",
        group = "void-snatch",
        order = "d-a"
    },
    {
        type = "item-subgroup",
        name = "void-chests",
        group = "void-snatch",
        order = "e-a"
    },
    {
        type = "recipe-category",
        name = "void-smelting"
    },
    {
        type = "fuel-category",
        name = "void-fuel"
    },
    {
        type = "technology",
        name = "vs-void-stone",
        icon = GRAPHICS_PATH .. "void-snatch.png",
        icon_size = 128,
        effects = {{type = "give-item", item = "vs-void-stone", count = 1}},
        prerequisites = {},
        order = "f-b-b",
        unit = {count = 100, ingredients = {{"automation-science-pack", 1}}, time = 10}
    }
})