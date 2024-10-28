local SETTING_SNATCH_CHEST_SIZE = "vs-snatch-chest-size"
local SETTING_VOID_CATALYST_SPAWN_INTERVAL = "vs-void-catalyst-spawn-interval"
local SETTING_VOID_GENERATOR_OUTPUT = "vs-void-generator-output"
local SETTING_VOID_CATALYST_FUEL_VALUE = "vs-void-catalyst-fuel-value"
local SETTING_VOID_CATALYST_SPAWN_CHANCE = "vs-void-catalyst-spawn-chance"
local SETTING_VOID_CATALYST_EXCESS_SCENARIO = "vs-void-catalyst-excess-scenario"

data:extend({
    {
        type = "int-setting",
        name = SETTING_SNATCH_CHEST_SIZE,
        setting_type = "startup",
        default_value = 150,
        minimum_value = 1,
        maximum_value = 10000
    },
    {
        type = "int-setting",
        name = SETTING_VOID_CATALYST_SPAWN_INTERVAL,
        setting_type = "startup",
        default_value = 10,
        allowed_values = {0, 1, 5, 10, 15, 30, 60}
    },
    {
        type = "string-setting",
        name = SETTING_VOID_CATALYST_EXCESS_SCENARIO,
        setting_type = "startup",
        default_value = "Do nothing",
        allowed_values = {"Do nothing", "Continue generating"}
    },
    {
        type = "string-setting",
        name = SETTING_VOID_GENERATOR_OUTPUT,
        setting_type = "startup",
        default_value = "150kW",
        allowed_values = {"100kW", "150kW", "500kW", "1MW", "5MW"}
    },
    {
        type = "string-setting",
        name = SETTING_VOID_CATALYST_FUEL_VALUE,
        setting_type = "startup",
        default_value = "12MJ",
        allowed_values = {"6MJ", "12MJ", "24MJ", "48MJ", "100MJ", "1GJ"}
    },
    {
        type = "double-setting",
        name = SETTING_VOID_CATALYST_SPAWN_CHANCE,
        setting_type = "startup",
        default_value = 0.2,
        minimum_value = 0.0,
        maximum_value = 1.0
    }
})