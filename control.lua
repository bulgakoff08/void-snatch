local SETTING_VOID_CATALYST_SPAWN_INTERVAL = "vs-void-catalyst-spawn-interval"
local SETTING_VOID_CATALYST_SPAWN_CHANCE = "vs-void-catalyst-spawn-chance"
local SETTING_VOID_CATALYST_EXCESS_SCENARIO = "vs-void-catalyst-excess-scenario"

local SCENARIO_CONTINUE = "Continue generating"

local function calculateTicksForSpawnInterval ()
    return settings.startup[SETTING_VOID_CATALYST_SPAWN_INTERVAL].value * 60
end

local spawnChance = settings.startup[SETTING_VOID_CATALYST_SPAWN_CHANCE].value * 100

if spawnChance > 0 then
    script.on_event(defines.events.on_player_crafted_item, function(event)
        local player = game.players[event.player_index]
        local inventory = player.get_main_inventory()
        if inventory then
            if spawnChance >= math.random(1, 100) then
                inventory.insert({name = "vs-void-catalyst", count = 1})
            end
        end
    end)
end

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    if (player.character == nil) then
        return
    end
    if storage == nil then
        storage = {}
    end
    if (storage.donePlayers == nil) then
        storage.donePlayers = {}
    end
    if (storage.donePlayers[player] ~= nil) then
        return
    end
    storage.donePlayers[player] = true
    local inventory = player.get_main_inventory()
    inventory.insert({name = "vs-void-stone", count = 1})
    inventory.insert({name = "vs-helping-book-1", count = 1})
    inventory.insert({name = "vs-helping-book-2", count = 1})
    inventory.insert({name = "vs-helping-book-3", count = 1})
    inventory.insert({name = "vs-helping-book-4", count = 1})
    inventory.insert({name = "vs-helping-book-5", count = 1})
end)

if calculateTicksForSpawnInterval() > 0 then
    script.on_nth_tick(calculateTicksForSpawnInterval(), function(event)
        local player = game.get_player(1)
        local inventory = player.force.get_linked_inventory("vs-snatch-chest", 0)
        if inventory == nil then
            return
        end
        if inventory.get_item_count("vs-void-stone") < 1 then
            return
        end
        if inventory.get_item_count("vs-void-catalyst") < 1000 then
            inventory.insert({ name = "vs-void-catalyst", count = 1})
        elseif settings.startup[SETTING_VOID_CATALYST_EXCESS_SCENARIO].value == SCENARIO_CONTINUE then
            inventory.insert({ name = "vs-void-catalyst", count = 1})
        end
    end)
end

local function addOne (table, itemId)
    if table[itemId] == nil then
        table[itemId] = 1
    else
        table[itemId] = table[itemId] + 1
    end
end

local oreChances = {
    ["iron-ore"] = 40,
    ["stone"] = 30,
    ["wood"] = 25,
    ["coal"] = 25,
    ["copper-ore"] = 15,
    ["uranium-ore"] = 5
}

local function calculateOresSpawn (factor)
    local result = {}
    for _ = 1, factor do
        for ore, chance in pairs(oreChances) do
            if math.random(1, 100) < chance then
                addOne(result, ore)
            end
        end
    end
    return result
end

local function fillInventory (inventory, table)
    local inserted = 0
    for key, value in pairs(table) do
        if value > 0 then
            inserted = inserted + inventory.insert({name = key, count = value})
        end
    end
    return inserted
end

local function createHungryChestHandler (chestId)
    return function(event)
        local player = game.get_player(1)
        local inventory = player.force.get_linked_inventory(chestId, 0)
        if inventory == nil then
            return
        end
        if inventory.get_item_count("vs-void-catalyst") > 0 then
            if fillInventory(inventory, calculateOresSpawn(1)) > 0 then
                inventory.remove({ name = "vs-void-catalyst", count = 1})
            end
        end
    end
end

script.on_nth_tick(61, createHungryChestHandler("vs-hungry-chest-a"))
script.on_nth_tick(62, createHungryChestHandler("vs-hungry-chest-b"))
script.on_nth_tick(63, createHungryChestHandler("vs-hungry-chest-c"))
script.on_nth_tick(64, createHungryChestHandler("vs-hungry-chest-d"))
script.on_nth_tick(65, createHungryChestHandler("vs-hungry-chest-e"))
script.on_nth_tick(66, createHungryChestHandler("vs-hungry-chest-f"))
