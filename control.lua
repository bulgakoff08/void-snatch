script.on_event(defines.events.on_player_crafted_item, function(event)
    local player = game.players[event.player_index]
    local inventory = player.get_main_inventory()
    if inventory then
        if math.random(1, 100) > 50 then
            inventory.insert({name = "vs-void-catalyst", amount = 1})
        end
    end
end)

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

script.on_nth_tick(600, function(event)
    local player = game.get_player(1)
    local snatchInventory = player.force.get_linked_inventory("vs-snatch-chest", 0)
    if snatchInventory == nil then
        return
    end
    local catalystCount = snatchInventory.get_item_count("vs-void-catalyst")
    if catalystCount < 1000 then
        snatchInventory.insert({name = "vs-void-catalyst", amount = 1})
    end
end)