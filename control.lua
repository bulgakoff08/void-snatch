local SETTING_VOID_CATALYST_SPAWN_INTERVAL = "vs-void-catalyst-spawn-interval"
local SETTING_VOID_CATALYST_SPAWN_CHANCE = "vs-void-catalyst-spawn-chance"

function calculateTicksForSpawnInterval ()
    return settings.startup[SETTING_VOID_CATALYST_SPAWN_INTERVAL].value * 60
end

local spawnChance = settings.startup[SETTING_VOID_CATALYST_SPAWN_CHANCE].value * 100

if spawnChance > 0 then
    script.on_event(defines.events.on_player_crafted_item, function(event)
        local player = game.players[event.player_index]
        local inventory = player.get_main_inventory()
        if inventory then
            if spawnChance >= math.random(1, 100) then
                inventory.insert({name = "vs-void-catalyst", amount = 1})
            end
        end
    end)
end

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    if (player.character == nil) then
        return
    end
    if global == nil then
        global = {}
    end
    if (global.donePlayers == nil) then
        global.donePlayers = {}
    end
    if (global.donePlayers[player] ~= nil) then
        return
    end
    global.donePlayers[player] = true
    local inventory = player.get_main_inventory()
    inventory.insert({name = "vs-helping-book-1", amount = 1})
    inventory.insert({name = "vs-helping-book-2", amount = 1})
    inventory.insert({name = "vs-helping-book-3", amount = 1})
    inventory.insert({name = "vs-helping-book-4", amount = 1})
end)

if calculateTicksForSpawnInterval() > 0 then
    script.on_nth_tick(calculateTicksForSpawnInterval(), function(event)
        local player = game.get_player(1)
        local inventory = player.force.get_linked_inventory("vs-snatch-chest", 0)
        if inventory == nil then
            return
        end
        if inventory.get_item_count("vs-void-catalyst") < 1000 then
            inventory.insert({ name = "vs-void-catalyst", amount = 1})
        end
    end)
end

function randomItem (dictionary)
    local keys = {}
    for key, _ in pairs(dictionary) do
        table.insert(keys, key)
    end
    local index = math.random(1, #keys)
    return keys[index]
end

function createHungryChestHandler (chestId)
    return function(event)
        local player = game.get_player(1)
        local inventory = player.force.get_linked_inventory(chestId, 0)
        if inventory == nil then
            return
        end
        if inventory.get_item_count("vs-void-catalyst") > 0 then
            local inserted = 0
            if math.random(1, 100) < 50 then
                inserted = inserted + inventory.insert({ name = "iron-ore", amount = 1})
            end
            if math.random(1, 100) < 40 then
                inserted = inserted + inventory.insert({ name = "stone", amount = 1})
            end
            if math.random(1, 100) < 40 then
                inserted = inserted + inventory.insert({ name = "wood", amount = 1})
            end
            if math.random(1, 100) < 30 then
                inserted = inserted + inventory.insert({ name = "coal", amount = 1})
            end
            if math.random(1, 100) < 20 then
                inserted = inserted + inventory.insert({ name = "copper-ore", amount = 1})
            end
            if math.random(1, 100) < 5 then
                inserted = inserted + inventory.insert({ name = "uranium-ore", amount = 1})
            end
            if inserted > 0 then
                inventory.remove({ name = "vs-void-catalyst", amount = 1})
            end
        end
    end
end

script.on_nth_tick(280, createHungryChestHandler("vs-hungry-chest-a"))
script.on_nth_tick(290, createHungryChestHandler("vs-hungry-chest-b"))
script.on_nth_tick(300, createHungryChestHandler("vs-hungry-chest-c"))
script.on_nth_tick(310, createHungryChestHandler("vs-hungry-chest-d"))
script.on_nth_tick(320, createHungryChestHandler("vs-hungry-chest-e"))