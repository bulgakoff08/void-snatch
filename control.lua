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
