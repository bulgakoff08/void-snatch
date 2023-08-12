local GRAPHICS_PATH = "__void-snatch__/graphics/"

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

data:extend({
    fuel("vs-void-catalyst", 1000, "catalyst-duplication", "12MJ"),
    machine("vs-snatch-chest", 50, "void-machines"),
    machine("vs-void-generator", 50, "void-machines"),
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