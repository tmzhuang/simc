local _, simc = ...

local function get_macro_name(key)
    return ('K:' .. string.upper(key))
end

local function create_or_update_macro(name, text)
    local existing_name = GetMacroInfo(name)
    if existing_name then
        index = EditMacro(existing_name, nil, nil, text)
    else
        index = CreateMacro(name, "INV_MISC_QUESTIONMARK", text)
    end
    return index
end

local function sync_macros(macros, mode)
    mode = mode or 1
    for key, text in pairs(macros) do
        local name = ''
        if mode == 1 then
            name = get_macro_name(key)
        else
            name = key
        end
        local index = create_or_update_macro(name, text)
    end
end

local function bind_keys(spells, items, macros)
    for key, spell in pairs(spells) do
        SetBindingSpell(string.upper(key), spell)
    end

    for key, item in pairs(items) do
        SetBindingItem(string.upper(key), item)
    end

    for key, text in pairs(macros) do
        local name = get_macro_name(key)
        local ok = SetBindingMacro(string.upper(key), name)
    end
end

function simc.run_command(argstr)
    local args = { strsplit(" ", argstr) }
    if args[1] == '' then
        simc.show_stats_frame()
    else
        print('No args added yet.')
    end
end
