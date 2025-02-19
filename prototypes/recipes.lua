local GRAPHICS_PATH = "__void-snatch__/graphics/"
local SETTING_DUPLICATION_RECIPE_IN = "vs-duplication-recipe-in"
local SETTING_DUPLICATION_RECIPE_OUT = "vs-duplication-recipe-out"

local function type(itemId)
    if (itemId == "water") then
        return "fluid"
    elseif (itemId == "crude-oil") then
        return "fluid"
    elseif (itemId == "sulfuric-acid") then
        return "fluid"
    else
        return "item"
    end
end

local function ingredient(itemId, count)
    if (count < 1) then
        return {
            type = type(itemId),
            name = itemId,
            probability = count
        }
    else
        return {
            type = type(itemId),
            name = itemId,
            amount = count
        }
    end
end

local function items(item1, amount1, item2, amount2, item3, amount3, item4, amount4)
    local result = {}
    if (item1 ~= nil) then table.insert(result, ingredient(item1, amount1)) end
    if (item2 ~= nil) then table.insert(result, ingredient(item2, amount2)) end
    if (item3 ~= nil) then table.insert(result, ingredient(item3, amount3)) end
    if (item4 ~= nil) then table.insert(result, ingredient(item4, amount4)) end
    return result
end

local function recipe(category, subgroup, duration, recipeId, inputs, outputs)
    return {
        type = "recipe",
        name = recipeId,
        category = category,
        subgroup = subgroup,
        energy_required = duration,
        ingredients = inputs,
        hide_from_player_crafting = category == "smelting" or category == "void-smelting",
        results = outputs,
        allow_as_intermediate = false,
        main_product = outputs[1]["name"]
    }
end

local function recipeWithIcon(category, subgroup, duration, icon, inputs, outputs)
    local result = recipe(category, subgroup, duration, "vs-" .. icon, inputs, outputs)
    result["icon"] = GRAPHICS_PATH .. "icons/recipes/" .. icon .. ".png"
    result["icon_size"] = 64
    return result
end

local function noRecycle (prototype)
    prototype["auto_recycle"] = false
    return prototype
end

local dupeOreIn = settings.startup[SETTING_DUPLICATION_RECIPE_IN].value
local dupeOreOut = settings.startup[SETTING_DUPLICATION_RECIPE_OUT].value

data:extend({

    noRecycle(recipe("crafting", "catalyst-duplication", 60, "vs-void-stone", items("vs-used-void-nugget", 100), items("vs-void-stone", 1))),
    noRecycle(recipe("crafting", "catalyst-duplication", 2, "vs-void-shard", items("vs-void-stone", 1), items("vs-void-shard", 10))),
    noRecycle(recipe("crafting", "catalyst-duplication", 1, "vs-void-nugget", items("vs-void-shard", 1), items("vs-void-nugget", 10))),
    noRecycle(recipe("crafting", "catalyst-duplication", 0.25, "vs-void-catalyst", items("vs-void-nugget", 1), items("vs-void-catalyst", 1, "vs-used-void-nugget", 1))),

    noRecycle(recipeWithIcon("crafting", "resource-duplication", 3, "coal-duplicate", items("coal", dupeOreIn, "vs-void-catalyst", 1), items("coal", dupeOreOut))),
    noRecycle(recipeWithIcon("crafting", "resource-duplication", 3, "copper-ore-duplicate", items("copper-ore", dupeOreIn, "vs-void-catalyst", 1), items("copper-ore", dupeOreOut))),
    noRecycle(recipeWithIcon("crafting", "resource-duplication", 3, "iron-ore-duplicate", items("iron-ore", dupeOreIn, "vs-void-catalyst", 1), items("iron-ore", dupeOreOut))),
    recipeWithIcon("crafting-with-fluid", "resource-duplication", 3, "oil-duplicate", items("crude-oil", dupeOreIn * 5, "vs-void-catalyst", 1), items("crude-oil", dupeOreOut * 5)),
    noRecycle(recipeWithIcon("crafting", "resource-duplication", 3, "stone-duplicate", items("stone", dupeOreIn, "vs-void-catalyst", 1), items("stone", dupeOreOut))),
    noRecycle(recipeWithIcon("crafting", "resource-duplication", 3, "uranium-ore-duplicate", items("uranium-ore", dupeOreIn, "vs-void-catalyst", 1), items("uranium-ore", dupeOreOut))),
    noRecycle(recipeWithIcon("crafting", "resource-duplication", 3, "wood-duplicate", items("wood", dupeOreIn, "vs-void-catalyst", 1), items("wood", dupeOreOut))),

    recipe("smelting", "void-other", 2, "vs-book-burn-1", items("vs-helping-book-1", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-2", items("vs-helping-book-2", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-3", items("vs-helping-book-3", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-4", items("vs-helping-book-4", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-5", items("vs-helping-book-5", 1), items("vs-void-catalyst", 200)),

    recipe("smelting", "void-chests", 1, "vs-hungry-chest-a-smelt", items("vs-hungry-chest-a", 1), items("vs-hungry-chest-b", 1)),
    recipe("smelting", "void-chests", 1, "vs-hungry-chest-b-smelt", items("vs-hungry-chest-b", 1), items("vs-hungry-chest-c", 1)),
    recipe("smelting", "void-chests", 1, "vs-hungry-chest-c-smelt", items("vs-hungry-chest-c", 1), items("vs-hungry-chest-d", 1)),
    recipe("smelting", "void-chests", 1, "vs-hungry-chest-d-smelt", items("vs-hungry-chest-d", 1), items("vs-hungry-chest-e", 1)),
    recipe("smelting", "void-chests", 1, "vs-hungry-chest-e-smelt", items("vs-hungry-chest-e", 1), items("vs-hungry-chest-f", 1)),
    recipe("smelting", "void-chests", 1, "vs-hungry-chest-f-smelt", items("vs-hungry-chest-f", 1), items("vs-hungry-chest-a", 1)),

    noRecycle(recipe("void-smelting", "void-other", 3, "vs-coal-duplicate-smelting", items("coal", dupeOreIn), items("coal", dupeOreOut))),
    noRecycle(recipe("void-smelting", "void-other", 3, "vs-copper-ore-duplicate-smelting", items("copper-ore", dupeOreIn), items("copper-ore", dupeOreOut))),
    noRecycle(recipe("void-smelting", "void-other", 3, "vs-iron-ore-duplicate-smelting", items("iron-ore", dupeOreIn), items("iron-ore", dupeOreOut))),
    noRecycle(recipe("void-smelting", "void-other", 3, "vs-stone-duplicate-smelting", items("stone", dupeOreIn), items("stone", dupeOreOut))),
    noRecycle(recipe("void-smelting", "void-other", 3, "vs-uranium-ore-duplicate-smelting", items("uranium-ore", dupeOreIn), items("uranium-ore", dupeOreOut))),
    noRecycle(recipe("void-smelting", "void-other", 3, "vs-wood-duplicate-smelting", items("wood", dupeOreIn), items("wood", dupeOreOut))),

    recipe("crafting", "void-machines", 1, "vs-void-generator", items("iron-chest", 1, "iron-gear-wheel", 3, "copper-cable", 10, "vs-void-catalyst", 50), items("vs-void-generator", 1)),
    recipe("crafting", "void-machines", 1, "vs-snatch-chest", items("iron-chest", 1, "vs-void-catalyst", 50), items("vs-snatch-chest", 1)),
    recipe("crafting", "void-machines", 1, "vs-void-furnace", items("stone-furnace", 1, "vs-void-catalyst", 200), items("vs-void-furnace", 1)),
    recipe("crafting", "void-machines", 1, "vs-void-assembling-machine", items("assembling-machine-2", 1, "vs-void-catalyst", 500, "vs-used-void-nugget", 2), items("vs-void-assembling-machine", 1)),

    recipe("crafting", "void-chests", 1, "vs-hungry-chest-a", items("iron-chest", 1, "vs-void-catalyst", 100), items("vs-hungry-chest-a", 1)),
    recipe("crafting", "void-chests", 1, "vs-hungry-chest-b", items("iron-chest", 1, "vs-void-catalyst", 100), items("vs-hungry-chest-b", 1)),
    recipe("crafting", "void-chests", 1, "vs-hungry-chest-c", items("iron-chest", 1, "vs-void-catalyst", 100), items("vs-hungry-chest-c", 1)),
    recipe("crafting", "void-chests", 1, "vs-hungry-chest-d", items("iron-chest", 1, "vs-void-catalyst", 100), items("vs-hungry-chest-d", 1)),
    recipe("crafting", "void-chests", 1, "vs-hungry-chest-e", items("iron-chest", 1, "vs-void-catalyst", 100), items("vs-hungry-chest-e", 1)),
    recipe("crafting", "void-chests", 1, "vs-hungry-chest-f", items("iron-chest", 1, "vs-void-catalyst", 100), items("vs-hungry-chest-f", 1)),

    {
        type = "recipe",
        name = "vs-meditate",
        category = "crafting",
        subgroup = "void-other",
        energy_required = 300,
        icon = GRAPHICS_PATH .. "icons/recipes/meditate.png",
        icon_size = 64,
        allow_as_intermediate = false,
        ingredients = {},
        results = {
            {type = "item", name = "vs-void-catalyst", amount = 100},
        }
    },
    {
        type = "recipe",
        name = "vs-void-snatch",
        category = "crafting",
        subgroup = "void-machines",
        energy_required = 5,
        icon = GRAPHICS_PATH .. "icons/recipes/void-snatch.png",
        icon_size = 64,
        ingredients = {},
        results = {
            {type = "item", name = "vs-used-void-nugget", amount = 1, probability = 0.005},
            {type = "item", name = "coal", amount = 1, probability = 0.3},
            {type = "item", name = "copper-ore", amount = 1, probability = 0.2},
            {type = "item", name = "iron-ore", amount = 1, probability = 0.5},
            {type = "item", name = "stone", amount = 1, probability = 0.4},
            {type = "item", name = "uranium-ore", amount = 1, probability = 0.05},
            {type = "item", name = "wood", amount = 1, probability = 0.4}
        }
    },
    {
        type = "recipe",
        name = "vs-void-snatch-with-oil",
        category = "crafting-with-fluid",
        subgroup = "void-machines",
        energy_required = 5,
        icon = GRAPHICS_PATH .. "icons/recipes/void-snatch-oil.png",
        icon_size = 64,
        ingredients = {},
        results = {
            {type = "item", name = "vs-used-void-nugget", amount = 1, probability = 0.005},
            {type = "item", name = "coal", amount = 1, probability = 0.3},
            {type = "item", name = "copper-ore", amount = 1, probability = 0.2},
            {type = "item", name = "iron-ore", amount = 1, probability = 0.5},
            {type = "item", name = "stone", amount = 1, probability = 0.4},
            {type = "item", name = "uranium-ore", amount = 1, probability = 0.05},
            {type = "item", name = "wood", amount = 1, probability = 0.4},
            {type = "fluid", name = "crude-oil", amount = 100, probability = 0.2}
        }
    }
})
