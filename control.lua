local equipment_to_place_in_grid = {
    'mhh-prototype-battery',
    'mhh-prototype-fusion-reactor',
    'mhh-prototype-energy-shield',
    'mhh-prototype-personal-laser-defense',
    'mhh-prototype-exoskeleton',
    'mhh-prototype-personal-roboport',
    'night-vision-equipment',
    'solar-panel-equipment',
    'belt-immunity-equipment',
}

local item_list = {
    {  5, 'mhh-prototype-battery'},
    {  6, 'mhh-prototype-exoskeleton'},
    {  1, 'mhh-prototype-fusion-reactor'},
    { 50, 'mhh-prototype-personal-laser-defense'},
    {  3, 'mhh-prototype-energy-shield'},
    {  2, 'mhh-prototype-personal-roboport'},
    {2000, 'mhh-prototype-construction-robot'},
    {  1, 'night-vision-equipment'},
    {  1, 'solar-panel-equipment'},
    {1500, 'mhh-prototype-logistic-robot'},
    {  200, 'mhh-prototype-roboport'},
    {  10000, 'production-science-pack'},
    {  10000, 'utility-science-pack'},
}

local function get_armor_name()
    local choice = settings.startup['mhh-jumpstart-armor-choice'].value
    if choice == 'none' then
        return nil
    elseif choice == 'auto' then
        if script.active_mods['space-exploration'] then
            return 'se-thruster-suit-4'
        elseif script.active_mods['Krastorio2'] then
            return 'kr-power-armor-mk4'
        end
        return 'mhh-prototype-power-armor'
    end
    return choice
end

local function equip_armor(player)
    local armor_inv = player.get_inventory(defines.inventory.character_armor)
    if not armor_inv then return end

    local armor_name = get_armor_name()
    if not armor_name then return end

    armor_inv.insert({ name = armor_name, count = 1 })

    local grid = player.character.grid
    if not grid then return end

    local placed = {}
    for _, equip_name in ipairs(equipment_to_place_in_grid) do
        if prototypes.equipment[equip_name] then
            local result = grid.put({ name = equip_name })
            if result then
                placed[equip_name] = true
            end
        end
    end

    return placed
end

local function insert_into_inventory(player, grid_placed)
    if not (player and player.valid and player.name) then
        return
    end

    for _, item in ipairs(item_list) do
        local name = item[2]
        local count = item[1]

        if grid_placed and grid_placed[name] then
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

local function has_jumpstart_armor(player)
    local armor_inv = player.get_inventory(defines.inventory.character_armor)

    local function check_inv(inv)
        if not inv then return false end
        return inv.find_item_stack('mhh-prototype-power-armor')
            or inv.find_item_stack('se-thruster-suit-4')
            or inv.find_item_stack('kr-power-armor-mk4')
            or inv.find_item_stack('kr-power-armor-mk3')
    end

    if check_inv(armor_inv) then return true end
    if check_inv(player.get_main_inventory()) then return true end

    return false
end

local function arm_player(player)
    if not (player and player.valid and player.name) then
        return
    end

    if not storage.players[player.name] then
        local grid_placed = equip_armor(player)
        insert_into_inventory(player, grid_placed)
    end
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
