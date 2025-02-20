local GRAPHICS_PATH = "__void-snatch__/graphics/"

local function itemWithIcon (itemId, icon, stackSize, subgroup)
    return {
        type = "item",
        name = itemId,
        icon = GRAPHICS_PATH .. "icons/" .. icon .. ".png",
        icon_size = 64,
        subgroup = subgroup,
        stack_size = stackSize
    }
end

local function item (itemId, stackSize, subgroup)
    return itemWithIcon(itemId, itemId, stackSize, subgroup)
end

local function helpingBook (bookId)
    return itemWithIcon(bookId, "vs-helping-book", 1, "void-machines")
end

local function fuel (itemId, stackSize, subgroup, energyValue)
    local result = item(itemId, stackSize, subgroup)
    result["fuel_value"] = energyValue
    result["fuel_category"] = "void-fuel"
    result["fuel_emissions_multiplier"] = 0 -- magic does not waste
    return result
end

local function machine (itemId, stackSize, subgroup)
    local result = item(itemId, stackSize, subgroup)
    result["place_result"] = itemId
    return result
end

data:extend({
    item("vs-void-stone", 1, "catalyst-duplication"),
    item("vs-void-shard", 10, "catalyst-duplication"),
    item("vs-void-nugget", 100, "catalyst-duplication"),
    item("vs-used-void-nugget", 100, "catalyst-duplication"),

    fuel("vs-void-catalyst", 1000, "catalyst-duplication", settings.startup["vs-void-catalyst-fuel-value"].value),

    machine("vs-snatch-chest", 50, "void-machines"),
    machine("vs-void-generator", 50, "void-machines"),
    machine("vs-void-furnace", 50, "void-machines"),
    machine("vs-void-assembling-machine", 50, "void-machines"),

    machine("vs-hungry-chest-a", 50, "void-chests"),
    machine("vs-hungry-chest-b", 50, "void-chests"),
    machine("vs-hungry-chest-c", 50, "void-chests"),
    machine("vs-hungry-chest-d", 50, "void-chests"),
    machine("vs-hungry-chest-e", 50, "void-chests"),
    machine("vs-hungry-chest-f", 50, "void-chests"),

    helpingBook("vs-helping-book-1"),
    helpingBook("vs-helping-book-2"),
    helpingBook("vs-helping-book-3"),
    helpingBook("vs-helping-book-4"),
    helpingBook("vs-helping-book-5")
})
