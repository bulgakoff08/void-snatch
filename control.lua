local SETTING_VOID_CATALYST_SPAWN_INTERVAL = "vs-void-catalyst-spawn-interval"
local SETTING_VOID_CATALYST_SPAWN_CHANCE = "vs-void-catalyst-spawn-chance"
local SETTING_VOID_CATALYST_EXCESS_SCENARIO = "vs-void-catalyst-excess-scenario"

local SCENARIO_CONTINUE = "Continue generating"

script.on_init(function(event)
    storage.player = {}    -- table of entities - one for each player, that are used to track
end)

-- initialize so we have no chance of a crash
local function initPlayerTable (player, inventory)
    if storage.player == nil then
        storage.player = {}
    end
    if not storage.player[player.index] then
        storage.player[player.index] = {initialized = true, inventory = inventory}
    elseif not storage.player[player.index].initialized then 
        storage.player[player.index] = {initialized = true, inventory = inventory}      -- track each players inventory
    end
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


local function initInventory (player, inventory)
    if  safeInsertInventory(inventory, player.name, {name = "vs-void-stone", count = 1}) ~= 0 then
        safeInsertInventory(inventory, player.name, {name = "vs-helping-book-1", count = 1})
        safeInsertInventory(inventory, player.name, {name = "vs-helping-book-2", count = 1})
        safeInsertInventory(inventory, player.name, {name = "vs-helping-book-3", count = 1})
        safeInsertInventory(inventory, player.name, {name = "vs-helping-book-4", count = 1})
        safeInsertInventory(inventory, player.name, {name = "vs-helping-book-5", count = 1})
        storage.player[player.index].filled = true
    end
end


-- Remote interface that other mods could use to change where inventory is stored by this mod
-- Example mod that uses this is Brave New Oarc - but only if you spawn without a character
local voidSnatchInterface = {
    redirectInventory = function(player, entity)
        if not player then
            log("redirectInventory: player field must point to a player - after they join and have a base")
            return
        end
        if not entity then
            log("redirectInventory: entity is invalid")
            return
        end
        initPlayerTable(player, entity)                   -- make sure this is been initialized
        storage.player[player.index].inventory = entity     -- redirect what would normally go into a players inventory into a chest for example
        initInventory(player, storage.player[player.index].inventory)  -- ignore filled, because it was previously initialize and directed to inventory, which was not loaded in BNO
    end
}

remote.add_interface("void-snatch", voidSnatchInterface)
-- example call - you can play with this in game by redirecting your items to another players inventory
-- remote.call("void-snatch", game.players[1], game.players[1].get_main_inventory())  <- testable example

local function calculateTicksForSpawnInterval ()
    return settings.startup[SETTING_VOID_CATALYST_SPAWN_INTERVAL].value * 60
end

local spawnChance = settings.startup[SETTING_VOID_CATALYST_SPAWN_CHANCE].value * 100

local function randomChanceToEarnCatalyst (player_index)
    local player = game.players[player_index]
    if spawnChance >= math.random(1, 100) then
        local inventory = storage.player[player_index].inventory
        safeInsertInventory(inventory, player.name, {name="vs-void-catalyst", count=1})
    end
end

if spawnChance > 0 then
    script.on_event(defines.events.on_player_crafted_item, function(event)
        randomChanceToEarnCatalyst(event.player_index)
    end)
end


script.on_event(defines.events.on_player_changed_surface, function(event)
    local player = game.players[event.player_index]
    log("onPlayerChangedSurface: player " .. player.name .. " changed surfaces to " .. game.surfaces[event.surface_index].name)
end)


script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    local player = game.players[event.player_index]
    local inventory = player.get_main_inventory()
    initPlayerTable(player, inventory)
    inventory = storage.player[player.index].inventory
    if not inventory.valid then
        inventory = player.get_main_inventory()
        storage.player[player.index].inventory = inventory
        log("onPlayerMainInventoryChanged: restore inventory to player's main inventory since it was invalid for " .. player.name)
    end
    if not storage.player[player.index].filled then
        initInventory(player, inventory)
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
                safeInsertInventory(inventory, player.name, {name = "vs-void-catalyst", count = 1})
            elseif settings.startup[SETTING_VOID_CATALYST_EXCESS_SCENARIO].value == SCENARIO_CONTINUE then
                safeInsertInventory(inventory, player.name, {name = "vs-void-catalyst", 1})
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
                        inventory.remove({name = "vs-void-catalyst", count = 1})
                    end
                end
            end
        end
    end
end)


-- updating an existing game would crash with the invent of new variables if not initialized and 
-- filled here
script.on_configuration_changed(function(event)
    if storage.player == nil then
        storage.player = {}
        -- update storage.player for each existing player
        log("Updating " .. #game.players .. " storage.player to their personal inventory")
        for _, player in pairs(game.players) do
            if not storage.player[player.index] then
                storage.player[player.index] = {initialized = true, inventory = player.get_main_inventory()}
            end
        end
    end
    -- If a server is updated during a game, not from start - reload the mod
    local newVersion = script.active_mods["void-snatch"]
    if newVersion ~= nil then
        local oldVersion = storage.scenario_version
        if oldVersion ~= newVersion then
            game.reload_script()
            storage.scenario_version = newVersion
        end
    end
end)