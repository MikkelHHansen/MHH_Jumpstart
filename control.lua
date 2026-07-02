local has_quality = true -- quality is part of the base game in Factorio 2.1

local function q(name, count)
    local result = { name = name }
    if count then result.count = count end
    if has_quality then
        local ql = settings.startup['mhh-jumpstart-quality'].value
        if ql and ql ~= 'normal' then result.quality = ql end
    end
    return result
end

local base_equipment_grid = {
    'night-vision-equipment',
    'solar-panel-equipment',
    'belt-immunity-equipment',
}

local prototype_equipment_grid = {
    'mhh-prototype-battery',
    'mhh-prototype-fusion-reactor',
    'mhh-prototype-energy-shield',
    'mhh-prototype-exoskeleton',
    'mhh-prototype-personal-laser-defense',
    'mhh-prototype-personal-roboport',
}

local function copy_grid(base)
    local t = {}
    for _, v in ipairs(base) do t[#t+1] = v end
    return t
end

local function add_prototype_to_grid(grid)
    for _, v in ipairs(prototype_equipment_grid) do grid[#grid+1] = v end
end

local presets = {
    balanced = {
        armor = 'power-armor',
        grid = (function()
            local has_k2 = script.active_mods['Krastorio2']
            local has_se = script.active_mods['space-exploration']
            if has_se then
                return { 'night-vision-equipment', 'belt-immunity-equipment', 'personal-laser-defense-equipment', 'battery-equipment', 'battery-equipment', 'solar-panel-equipment', 'se-rtg-equipment', 'se-lifesupport-equipment-1' }
            elseif has_k2 then
                return { 'kr-superior-night-vision-equipment', 'belt-immunity-equipment', 'kr-personal-laser-defense-mk2-equipment', 'kr-big-battery-equipment', 'kr-big-solar-panel-equipment', 'kr-big-solar-panel-equipment' }
            else
                return { 'night-vision-equipment', 'belt-immunity-equipment', 'personal-laser-defense-equipment', 'battery-equipment', 'battery-equipment', 'solar-panel-equipment', 'solar-panel-equipment', 'solar-panel-equipment', 'solar-panel-equipment', 'solar-panel-equipment' }
            end
        end)(),
        items = {},
    },
    advanced = {
        armor = (function()
            if script.active_mods['space-exploration'] then return 'se-thruster-suit-3'
            elseif script.active_mods['Krastorio2'] then return 'kr-power-armor-mk3'
            else return 'power-armor-mk2' end
        end)(),
        grid = (function()
            local has_k2 = script.active_mods['Krastorio2']
            local has_se = script.active_mods['space-exploration']
            local grid = {}
            if has_se then
                table.insert(grid, 'night-vision-equipment')
                table.insert(grid, 'belt-immunity-equipment')
                table.insert(grid, 'personal-laser-defense-equipment')
                table.insert(grid, 'exoskeleton-equipment')
                table.insert(grid, 'battery-mk2-equipment')
                table.insert(grid, 'battery-mk2-equipment')
                table.insert(grid, 'energy-shield-mk3-equipment')
                table.insert(grid, 'se-rtg-equipment')
                table.insert(grid, 'se-lifesupport-equipment-2')
                table.insert(grid, 'personal-roboport-mk2-equipment')
            elseif has_k2 then
                table.insert(grid, 'kr-superior-night-vision-equipment')
                table.insert(grid, 'belt-immunity-equipment')
                table.insert(grid, 'kr-personal-laser-defense-mk2-equipment')
                table.insert(grid, 'kr-advanced-exoskeleton-equipment')
                table.insert(grid, 'kr-big-battery-mk2-equipment')
                table.insert(grid, 'kr-big-battery-mk2-equipment')
                table.insert(grid, 'kr-energy-shield-mk3-equipment')
                table.insert(grid, 'kr-portable-generator')
                table.insert(grid, 'personal-roboport-mk2-equipment')
            else
                table.insert(grid, 'night-vision-equipment')
                table.insert(grid, 'belt-immunity-equipment')
                table.insert(grid, 'personal-laser-defense-equipment')
                table.insert(grid, 'exoskeleton-equipment')
                table.insert(grid, 'battery-mk2-equipment')
                table.insert(grid, 'battery-mk2-equipment')
                table.insert(grid, 'energy-shield-mk2-equipment')
                table.insert(grid, 'fission-reactor-equipment')
                table.insert(grid, 'solar-panel-equipment')
                table.insert(grid, 'solar-panel-equipment')
                table.insert(grid, 'solar-panel-equipment')
                table.insert(grid, 'personal-roboport-mk2-equipment')
            end
            return grid
        end)(),
        items = {
            { 50, 'construction-robot' },
        },
    },
    overpowered = {
        armor = 'mhh-prototype-power-armor',
        grid = (function() local g = copy_grid(base_equipment_grid); add_prototype_to_grid(g); return g end)(),
        secondary_armor = (function()
            if script.active_mods['space-exploration'] then return 'se-thruster-suit-3' end
            return nil
        end)(),
        secondary_grid = (function()
            if not script.active_mods['space-exploration'] then return {} end
            return { 'se-rtg-equipment', 'se-battery-equipment', 'se-battery-equipment', 'se-lifesupport-equipment-3' }
        end)(),
        items = {
            { 500, 'mhh-prototype-construction-robot' },
            {   2, 'mhh-prototype-battery' },
            {   1, 'mhh-prototype-fusion-reactor' },
            {   2, 'mhh-prototype-energy-shield' },
            {   2, 'mhh-prototype-exoskeleton' },
            {  10, 'mhh-prototype-personal-laser-defense' },
            {   1, 'mhh-prototype-personal-roboport' },
        },
    },
    cheaty = {
        armor = (function()
            if script.active_mods['Krastorio2'] then
                return 'kr-power-armor-mk4'
            end
            return 'mhh-prototype-power-armor'
        end)(),
        secondary_armor = (function()
            if script.active_mods['space-exploration'] then return 'se-thruster-suit-4' end
            return nil
        end)(),
        secondary_grid = (function()
            if not script.active_mods['space-exploration'] then return {} end
            return { 'se-rtg-equipment', 'se-battery-equipment', 'se-battery-equipment', 'se-lifesupport-equipment-4' }
        end)(),
        grid = (function() local g = copy_grid(base_equipment_grid); add_prototype_to_grid(g); return g end)(),
        items = {
            {    3, 'mhh-prototype-battery' },
            {    3, 'mhh-prototype-exoskeleton' },
            {    1, 'mhh-prototype-fusion-reactor' },
            {   16, 'mhh-prototype-personal-laser-defense' },
            {    3, 'mhh-prototype-energy-shield' },
            {    2, 'mhh-prototype-personal-roboport' },
            { 2000, 'mhh-prototype-construction-robot' },
            { 1500, 'mhh-prototype-logistic-robot' },
            {   50, 'mhh-prototype-roboport' },
        },
    },
}

local starter_presets = {
    balanced = {
        {  50, 'transport-belt' },
        {  10, 'underground-belt' },
        {   5, 'splitter' },
        {  20, 'inserter' },
        {   5, 'assembling-machine-1' },
        {   4, 'stone-furnace' },
        {   4, 'electric-mining-drill' },
        {  10, 'small-electric-pole' },
        {   5, 'medium-electric-pole' },
        {  20, 'pipe' },
        {   1, 'boiler' },
        {   2, 'steam-engine' },
        {  10, 'wooden-chest' },
    },
    advanced = {
        { 200, 'transport-belt' },
        {  20, 'underground-belt' },
        {  10, 'splitter' },
        {  50, 'inserter' },
        {  10, 'assembling-machine-1' },
        {   8, 'steel-furnace' },
        {   8, 'electric-mining-drill' },
        {  20, 'small-electric-pole' },
        {  10, 'medium-electric-pole' },
        {  50, 'pipe' },
        {   2, 'boiler' },
        {   4, 'steam-engine' },
        {  20, 'iron-chest' },
    },
    overpowered = (function()
        local has_k2 = script.active_mods['Krastorio2']
        local fast = has_k2 and 'kr-superior-inserter' or 'fast-inserter'
        return {
            { 500, 'fast-transport-belt' },
            {  50, 'fast-underground-belt' },
            {  20, 'fast-splitter' },
            {  50, 'inserter' },
            {  50, fast },
            {  20, 'assembling-machine-2' },
            {  16, 'steel-furnace' },
            {  16, 'electric-mining-drill' },
            {  50, 'small-electric-pole' },
            {  20, 'medium-electric-pole' },
            { 100, 'pipe' },
            {  20, 'solar-panel' },
            {  10, 'accumulator' },
            {  50, 'iron-chest' },
            {  20, 'steel-chest' },
        }
    end)(),
    cheaty = (function()
        local has_k2 = script.active_mods['Krastorio2']
        local fast = has_k2 and 'kr-superior-inserter' or 'fast-inserter'
        local long = has_k2 and 'kr-superior-long-inserter' or 'long-handed-inserter'
        return {
            { 1000, 'express-transport-belt' },
            {  100, 'express-underground-belt' },
            {   50, 'express-splitter' },
            {  100, 'inserter' },
            {  100, fast },
            {  100, long },
            {  100, 'bulk-inserter' },
            {   50, 'assembling-machine-3' },
            {   32, 'electric-furnace' },
            {   32, 'electric-mining-drill' },
            {  100, 'small-electric-pole' },
            {   50, 'medium-electric-pole' },
            {   10, 'substation' },
            {  200, 'pipe' },
            {  100, 'solar-panel' },
            {   50, 'accumulator' },
            {  100, 'iron-chest' },
            {   50, 'steel-chest' },
        }
    end)(),
}

local function get_armor_name(preset)
    return preset.armor
end

local function arm_player(player)
    if not (player and player.valid and player.name) then return end
    if storage.players and storage.players[player.name] then return end

    local preset_name = settings.startup['mhh-jumpstart-preset'].value
    local preset = presets[preset_name]
    if not preset then return end

    local armor_name = get_armor_name(preset)
    local armor_inv = player.get_inventory(defines.inventory.character_armor)
    if armor_inv then
        armor_inv.insert(q(armor_name, 1))
    end

    local grid = player.character and player.character.grid
    local placed = {}
    if grid then
        for _, equip_name in ipairs(preset.grid) do
            if prototypes.equipment[equip_name] then
                local result = grid.put(q(equip_name))
                if result then
                    placed[equip_name] = true
                end
            end
        end
    end

    if preset.secondary_armor then
        if prototypes.item[preset.secondary_armor] then
            player.insert(q(preset.secondary_armor, 1))
        end
        if preset.secondary_grid then
            for _, equip_name in ipairs(preset.secondary_grid) do
                if prototypes.item[equip_name] then
                    player.insert(q(equip_name, 1))
                end
            end
        end
    end

    for _, entry in ipairs(preset.items) do
        local count = entry[1]
        local name = entry[2]
        if placed[name] then
            count = count - 1
        end
        if count > 0 then
            if prototypes.item[name] then
                player.insert(q(name, count))
            else
                player.print('Unable to add ' .. name .. ' to inventory, please check spelling.')
            end
        end
    end

    local starter_preset_name = settings.startup['mhh-jumpstart-starter-items'].value
    if starter_preset_name ~= 'none' then
        local starter_items = starter_presets[starter_preset_name]
        if starter_items then
            for _, entry in ipairs(starter_items) do
                local count = entry[1]
                local name = entry[2]
                if prototypes.item[name] then
                    player.insert(q(name, count))
                else
                    player.print('Unable to add ' .. name .. ' to inventory, please check spelling.')
                end
            end
        end
    end

    storage.players[player.name] = true
end

local armor_checks = { 'mhh-prototype-power-armor', 'se-thruster-suit-4', 'se-thruster-suit-3', 'kr-power-armor-mk4', 'kr-power-armor-mk3', 'power-armor-mk2', 'power-armor', 'mech-armor' }

local function has_jumpstart_armor(player)
    local function check_inv(inv)
        if not inv then return false end
        for _, name in ipairs(armor_checks) do
            if inv.find_item_stack(name) then return true end
        end
        return false
    end
    return check_inv(player.get_inventory(defines.inventory.character_armor))
        or check_inv(player.get_main_inventory())
end

script.on_init(function()
    storage.players = {}
    for _, player in pairs(game.players) do
        arm_player(player)
    end
end)

script.on_configuration_changed(function(data)
    storage.players = storage.players or {}
    if data.mod_changes['MHH_Jumpstart'] or data.mod_changes['MHH_Prototype_Equipment'] then
        for _, player in pairs(game.players) do
            if has_jumpstart_armor(player) then
                storage.players[player.name] = true
            else
                arm_player(player)
            end
        end
    end
end)

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    pcall(function() player.exit_cutscene() end)
    arm_player(player)
end)

script.on_event(defines.events.on_player_joined_game, function(event)
    local player = game.players[event.player_index]
    pcall(function() player.exit_cutscene() end)
    arm_player(player)
end)
