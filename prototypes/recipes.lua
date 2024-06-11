local GRAPHICS_PATH = "__void-snatch__/graphics/"

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
        hide_from_player_crafting = category == "smelting",
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

data:extend({


    recipe("crafting", "catalyst-duplication", 1, "vs-void-stone", items("vs-used-void-nugget", 100), items("vs-void-stone", 1)),
    recipe("crafting", "catalyst-duplication", 1, "vs-void-shard", items("vs-void-stone", 1), items("vs-void-shard", 10)),
    recipe("crafting", "catalyst-duplication", 1, "vs-void-nugget", items("vs-void-shard", 1), items("vs-void-nugget", 10)),

    recipe("crafting", "catalyst-duplication", 0.5, "vs-void-catalyst", items("vs-void-nugget", 1), items("vs-void-catalyst", 1, "vs-used-void-nugget", 1)),

    recipeWithIcon("crafting", "resource-duplication", 5, "coal-duplicate", items("coal", 5, "vs-void-catalyst", 1), items("coal", 6)),
    recipeWithIcon("crafting", "resource-duplication", 5, "copper-ore-duplicate", items("copper-ore", 5, "vs-void-catalyst", 1), items("copper-ore", 6)),
    recipeWithIcon("crafting", "resource-duplication", 5, "iron-ore-duplicate", items("iron-ore", 5, "vs-void-catalyst", 1), items("iron-ore", 6)),
    recipeWithIcon("crafting-with-fluid", "resource-duplication", 5, "oil-duplicate", items("crude-oil", 125, "vs-void-catalyst", 1), items("crude-oil", 165)),
    recipeWithIcon("crafting", "resource-duplication", 5, "stone-duplicate", items("stone", 5, "vs-void-catalyst", 1), items("stone", 6)),
    recipeWithIcon("crafting-with-fluid", "resource-duplication", 5, "uranium-ore-duplicate", items("uranium-ore", 5, "sulfuric-acid", 10, "vs-void-catalyst", 1), items("uranium-ore", 6)),
    recipeWithIcon("crafting", "resource-duplication", 5, "wood-duplicate", items("wood", 5, "vs-void-catalyst", 1), items("wood", 6)),

    recipe("smelting", "void-other", 2, "vs-book-burn-1", items("vs-helping-book-1", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-2", items("vs-helping-book-2", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-3", items("vs-helping-book-3", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-4", items("vs-helping-book-4", 1), items("vs-void-catalyst", 200)),
    recipe("smelting", "void-other", 2, "vs-book-burn-5", items("vs-helping-book-5", 1), items("vs-void-catalyst", 200)),

    recipe("void-smelting", "void-other", 1, "vs-coal-voiding", items("coal", 10), items("vs-void-catalyst", 1)),
    recipe("void-smelting", "void-other", 1, "vs-copper-ore-voiding", items("copper-ore", 10), items("vs-void-catalyst", 2)),
    recipe("void-smelting", "void-other", 1, "vs-iron-ore-voiding", items("iron-ore", 10), items("vs-void-catalyst", 2)),
    recipe("void-smelting", "void-other", 1, "vs-stone-voiding", items("stone", 10), items("vs-void-catalyst", 1)),
    recipe("void-smelting", "void-other", 1, "vs-uranium-ore-voiding", items("uranium-ore", 10), items("vs-void-catalyst", 4)),
    recipe("void-smelting", "void-other", 1, "vs-wood-voiding", items("wood", 10), items("vs-void-catalyst", 1)),

    recipe("crafting", "void-machines", 1, "vs-void-generator", items("iron-chest", 1, "iron-gear-wheel", 3, "copper-cable", 10, "vs-void-catalyst", 50), items("vs-void-generator", 1)),
    recipe("crafting", "void-machines", 1, "vs-snatch-chest", items("iron-chest", 1, "vs-void-catalyst", 50), items("vs-snatch-chest", 1)),
    recipe("crafting", "void-machines", 1, "vs-void-furnace", items("stone-furnace", 1, "vs-void-catalyst", 200), items("vs-void-furnace", 1)),

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
        energy_required = 2,
        icon = GRAPHICS_PATH .. "icons/recipes/void-snatch.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "vs-void-shard", amount = 1}
        },
        results = {
            {type = "item", name = "vs-used-void-nugget", amount = 10},
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
        energy_required = 2,
        icon = GRAPHICS_PATH .. "icons/recipes/void-snatch-oil.png",
        icon_size = 64,
        ingredients = {
            {type = "item", name = "vs-void-shard", amount = 1}
        },
        results = {
            {type = "item", name = "vs-used-void-nugget", amount = 10},
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
