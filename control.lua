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
                table.insert(grid, 'kr-portable-generator-equipment')
                table.insert(grid, 'personal-roboport-mk2-equipment')
            else
                table.insert(grid, 'night-vision-equipment')
                table.insert(grid, 'belt-immunity-equipment')
                table.insert(grid, 'personal-laser-defense-equipment')
                table.insert(grid, 'exoskeleton-equipment')
                table.insert(grid, 'battery-mk2-equipment')
                table.insert(grid, 'battery-mk2-equipment')
                table.insert(grid, 'energy-shield-mk2-equipment')
                table.insert(grid, 'fusion-reactor-equipment')
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
        armor = 'auto',
        grid = (function() local g = copy_grid(base_equipment_grid); add_prototype_to_grid(g); return g end)(),
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
        armor = 'auto',
        grid = (function() local g = copy_grid(base_equipment_grid); add_prototype_to_grid(g); return g end)(),
        items = {
            {    5, 'mhh-prototype-battery' },
            {    6, 'mhh-prototype-exoskeleton' },
            {    1, 'mhh-prototype-fusion-reactor' },
            {   50, 'mhh-prototype-personal-laser-defense' },
            {    3, 'mhh-prototype-energy-shield' },
            {    2, 'mhh-prototype-personal-roboport' },
            { 2000, 'mhh-prototype-construction-robot' },
            { 1500, 'mhh-prototype-logistic-robot' },
            {  200, 'mhh-prototype-roboport' },
            {10000, 'production-science-pack' },
            {10000, 'utility-science-pack' },
        },
    },
}

local function get_armor_name(preset)
    if preset.armor ~= 'auto' then
        return preset.armor
    end
    if script.active_mods['space-exploration'] then
        return 'se-thruster-suit-4'
    elseif script.active_mods['Krastorio2'] then
        return 'kr-power-armor-mk4'
    end
    return 'mhh-prototype-power-armor'
end

local function arm_player(player)
    if not (player and player.valid and player.name) then return end
    if storage.players[player.name] then return end

    local preset_name = settings.startup['mhh-jumpstart-preset'].value
    local preset = presets[preset_name]
    if not preset then return end

    local armor_name = get_armor_name(preset)
    local armor_inv = player.get_inventory(defines.inventory.character_armor)
    if armor_inv then
        armor_inv.insert({ name = armor_name, count = 1 })
    end

    local grid = player.character and player.character.grid
    local placed = {}
    if grid then
        for _, equip_name in ipairs(preset.grid) do
            if prototypes.equipment[equip_name] then
                local result = grid.put({ name = equip_name })
                if result then
                    placed[equip_name] = true
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
                player.insert({ name = name, count = count })
            else
                player.print('Unable to add ' .. name .. ' to inventory, please check spelling.')
            end
        end
    end

    storage.players[player.name] = true
end

local armor_checks = { 'mhh-prototype-power-armor', 'se-thruster-suit-4', 'se-thruster-suit-3', 'kr-power-armor-mk4', 'kr-power-armor-mk3', 'power-armor-mk2', 'power-armor' }

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
    if data.mod_changes['MHH_Jumpstart'] then
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
    arm_player(player)
end)
