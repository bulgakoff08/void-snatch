local SETTING_VOID_CATALYST_SPAWN_INTERVAL = "vs-void-catalyst-spawn-interval"
local SETTING_VOID_CATALYST_SPAWN_CHANCE = "vs-void-catalyst-spawn-chance"
local SETTING_VOID_CATALYST_EXCESS_SCENARIO = "vs-void-catalyst-excess-scenario"

local SCENARIO_CONTINUE = "Continue generating"

----------------------------------------
-- On Init - only runs once the first
--   time the game starts
----------------------------------------
script.on_init(function(event)
    storage.player={}    -- table of entities - one for each player, that are used to track 
end)

local function calculateTicksForSpawnInterval ()
    return settings.startup[SETTING_VOID_CATALYST_SPAWN_INTERVAL].value * 60
end

local function safeInsertInventory (inventory, owner_name, item)
    if inventory and inventory.valid then
        return inventory.insert(item)
    else
        log(owner_name .. " showing invalid or no inventory or inventory is full inserting, {" .. item.name.. ", " .. item.count .."}")
        log("    dump: " .. serpent.block(storage.player))
    end
    return 0
end

local spawnChance = settings.startup[SETTING_VOID_CATALYST_SPAWN_CHANCE].value * 100

if spawnChance > 0 then
    script.on_event(defines.events.on_player_crafted_item, function(event)
        local player = game.players[event.player_index]
        if spawnChance >= math.random(1, 100) then
            local inventory = storage.player[event.player_index].inventory
            safeInsertInventory(inventory, player.name, {name="vs-void-catalyst", count=1})
        end
    end)
end

-- Since inventory is not accessible in on_player_created - load it here
script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    local player = game.players[event.player_index]
    local inventory = player.get_main_inventory()
    if not storage.player[player.index] then
        storage.player[player.index] = {initialized = true, inventory = inventory}
    elseif not storage.player[player.index].initialized then 
        storage.player[player.index] = {initialized = true, inventory = inventory}      -- track each players inventory
    end
    inventory = storage.player[player.index].inventory
    if not storage.player[player.index].filled then
        if  safeInsertInventory(inventory, player.name, {name="vs-void-stone",     count=1}) ~= 0 then
            safeInsertInventory(inventory, player.name, {name="vs-helping-book-1", count=1})
            safeInsertInventory(inventory, player.name, {name="vs-helping-book-2", count=1})
            safeInsertInventory(inventory, player.name, {name="vs-helping-book-3", count=1})
            safeInsertInventory(inventory, player.name, {name="vs-helping-book-4", count=1})
            safeInsertInventory(inventory, player.name, {name="vs-helping-book-5", count=1})
            storage.player[player.index].filled = true
        end
    end
end)

    

if calculateTicksForSpawnInterval() > 0 then
    script.on_nth_tick(calculateTicksForSpawnInterval(), function(event)
        for _, player in pairs(game.players) do
            local inventory = player.force.get_linked_inventory("vs-snatch-chest", 0)
            if (inventory == nil) or (not inventory.valid) then
                log("calculateTicksForSpawnInterval: nil or invalid inventory for " .. player.name)
                return
            end
            if inventory.get_item_count("vs-void-stone") < 1 then
                return
            end
            if inventory.get_item_count("vs-void-catalyst") < 1000 then
                safeInsertInventory (inventory, player.name, {name="vs-void-catalyst", count=1})
            elseif settings.startup[SETTING_VOID_CATALYST_EXCESS_SCENARIO].value == SCENARIO_CONTINUE then
                safeInsertInventory (inventory, player.name, {name="vs-void-catalyst", 1})
            end
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
            inserted = inserted + safeInsertInventory(inventory, "Fill Inventory", {name = key, count = value})
        end
    end
    return inserted
end

local chestLetters = {"a", "b", "c", "d", "e", "f"}

script.on_nth_tick(61, function(event)
    for name, force in pairs(game.forces) do
        if name ~= "neutral" and name ~= "enemy" and name ~= "_ABANDONED_" then
            for _, letter in pairs(chestLetters) do
                local inventory = force.get_linked_inventory("vs-hungry-chest-" .. letter, 0)
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
    end
end)

--=================================================================================================
-- updating an existing game would crash with the invent of new variables if not initialized and 
-- filled here
script.on_configuration_changed(function(event)
    if storage.player == nil then
        storage.player = {}
        -- update storage.player for each existing player
        log ("Updating " .. #game.players .. " storage.player to their personal inventory")
        for name,player in pairs(game.players) do
            if not storage.player[player.index] then
                storage.player[player.index] = {initialized = true, inventory = player.get_main_inventory()}
            end
        end
    end
    -- If a server is updated during a game, not from start - reload the mod
    local new = script.active_mods["void-snatch"]
    if new ~= nil then
        local old = storage.scenario_version
        if old ~= new then
            game.reload_script()
            storage.scenario_version = new
        end
    end
end)