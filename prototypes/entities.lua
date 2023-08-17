local GRAPHICS_PATH = "__void-snatch__/graphics/"
data:extend({
    {
        type = "burner-generator",
        name = "vs-void-generator",
        icon = GRAPHICS_PATH .. "icons/vs-void-generator.png",
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        minable = {
            mining_time = 0.5,
            results = {
                {type = "item", name = "vs-void-generator", amount = 1}
            }
        },
        max_health = 250,
        corpse = "iron-chest-remnants",
        dying_explosion = "iron-chest-explosion",
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        resistances = {
            {type = "fire", percent = 90},
            {type = "explosion", percent = 30},
            {type = "impact", percent = 30}
        },
        energy_source = {
            type = "electric",
            usage_priority = "primary-output",
            emissions_per_second = 0.5,
        },
        burner = {
            type = "burner",
            fuel_categories = {"void-fuel"},
            effectivity = 1,
            fuel_inventory_size = 1,
            render_no_power_icon = true,
        },
        max_power_output = "150KW",
        energy_usage = "0kW",
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        animation = {
            layers = {
                {
                    priority = "extra-high",
                    width = 66,
                    height = 76,
                    shift = util.by_pixel(-0.5, -0.5),
                    scale = 0.5,
                    animation_speed = 0.75,
                    frame_count = 8,
                    stripes = {
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-a.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-b.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-c.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-d.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-e.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-f.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-g.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/void-generator-h.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        }
                    }
                },
                {
                    priority = "extra-high",
                    width = 110,
                    height = 50,
                    shift = util.by_pixel(10.5, 6),
                    draw_as_shadow = true,
                    frame_count = 8,
                    scale = 0.5,
                    stripes = {
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        },
                        {
                            filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                            width_in_frames = 1,
                            height_in_frames = 1
                        }
                    }
                }
            }
        },
        min_perceived_performance = 0.25,
        performance_to_sound_speedup = 0.5,
        working_sound = {
            sound = {filename = "__base__/sound/steam-turbine.ogg", volume = 0.25},
            match_speed_to_activity = false,
        },
        open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
        close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75}
    },
    {
        type = "linked-container",
        name = "vs-snatch-chest",
        icon = GRAPHICS_PATH .. "icons/vs-snatch-chest.png",
        icon_size = 64,
        flags = {"placeable-neutral", "player-creation"},
        minable = {
            mining_time = 0.5,
            results = {
                {type = "item", name = "vs-snatch-chest", amount = 1}
            }
        },
        max_health = 250,
        corpse = "iron-chest-remnants",
        dying_explosion = "iron-chest-explosion",
        vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
        resistances = {
            {type = "fire", percent = 90},
            {type = "explosion", percent = 30},
            {type = "impact", percent = 30}
        },
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        picture = {
            layers = {
                {
                    filename = GRAPHICS_PATH .. "entities/snatch-chest.png",
                    priority = "extra-high",
                    width = 66,
                    height = 76,
                    shift = util.by_pixel(-0.5, -0.5),
                    scale = 0.5
                },
                {
                    filename = GRAPHICS_PATH .. "entities/chest-shadow.png",
                    priority = "extra-high",
                    width = 110,
                    height = 50,
                    shift = util.by_pixel(10.5, 6),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        },
        link_id = 4904,
        inventory_size = 200,
        inventory_type = "with_filters_and_bar",
        gui_mode = "none",
        circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
        circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
        circuit_wire_max_distance = default_circuit_wire_max_distance,
        open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
        close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75}
    }
})