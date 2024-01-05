local GRAPHICS_PATH = "__void-snatch__/graphics/"

local SETTING_VOID_CATALYST_FUEL_VALUE = "vs-void-catalyst-fuel-value"

local ENERGY_VALUE_DICT = {
    ["6MJ"] = {value = 6, unit = "MJ"},
    ["12MJ"] = {value = 12, unit = "MJ"},
    ["24MJ"] = {value = 24, unit = "MJ"},
    ["48MJ"] = {value = 48, unit = "MJ"},
    ["100MJ"] = {value = 100, unit = "MJ"},
    ["1GJ"] = {value = 1, unit = "GJ"},
}

local function item (itemId, stackSize, subgroup)
    return {
        type = "item",
        name = itemId,
        icon = GRAPHICS_PATH .. "icons/" .. itemId .. ".png",
        icon_size = 64,
        subgroup = subgroup,
        stack_size = stackSize
    }
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

local energyValue = ENERGY_VALUE_DICT[settings.startup[SETTING_VOID_CATALYST_FUEL_VALUE].value]

data:extend({
    fuel("vs-void-catalyst", 1000, "catalyst-duplication", energyValue.value .. energyValue.unit),
    fuel("vs-condensed-void-stone", 1, "catalyst-duplication", (energyValue.value * 10000) .. energyValue.unit),

    machine("vs-snatch-chest", 50, "void-machines"),
    machine("vs-void-generator", 50, "void-machines"),
    machine("vs-void-furnace", 50, "void-machines"),

    machine("vs-hungry-chest-a", 50, "void-chests"),
    machine("vs-hungry-chest-b", 50, "void-chests"),
    machine("vs-hungry-chest-c", 50, "void-chests"),
    machine("vs-hungry-chest-d", 50, "void-chests"),
    machine("vs-hungry-chest-e", 50, "void-chests"),
    machine("vs-hungry-chest-f", 50, "void-chests"),

    {
        type = "item",
        name = "vs-helping-book-1",
        icon = GRAPHICS_PATH .. "icons/vs-helping-book.png",
        icon_size = 64,
        subgroup = "void-machines",
        stack_size = 1
    },
    {
        type = "item",
        name = "vs-helping-book-2",
        icon = GRAPHICS_PATH .. "icons/vs-helping-book.png",
        icon_size = 64,
        subgroup = "void-machines",
        stack_size = 1
    },
    {
        type = "item",
        name = "vs-helping-book-3",
        icon = GRAPHICS_PATH .. "icons/vs-helping-book.png",
        icon_size = 64,
        subgroup = "void-machines",
        stack_size = 1
    },
    {
        type = "item",
        name = "vs-helping-book-4",
        icon = GRAPHICS_PATH .. "icons/vs-helping-book.png",
        icon_size = 64,
        subgroup = "void-machines",
        stack_size = 1
    }
})