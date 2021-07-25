local M = {}

M.make_cmds = function(cmd_tag, cmd_option, tags, options)
    local cmds = {}
    if #tags == 0 then table.insert(tags, 'json') end

    table.insert(cmds, cmd_tag)
    table.insert(cmds, table.concat(tags, ','))

    if #options > 0 then
        table.insert(cmds, cmd_option)
        table.insert(cmds, table.concat(options, ','))
    end

    return cmds
end

M.add = function(...)
    local cmd_tag = '-add-tags'
    local cmd_option = '-add-options'
    local tags, options = M.getTagsAndOptions(...)
    local cmds = M.make_cmds(cmd_tag, cmd_option, tags, options)
    M.modify(unpack(cmds))
end

M.rm = function(...)
    local cmd_tag = '-remove-tags'
    local cmd_option = '-remove-options'
    local tags, options = M.getTagsAndOptions(...)
    local cmds = M.make_cmds(cmd_tag, cmd_option, tags, options)
    M.modify(unpack(cmds))
end

M.clear = function()
    local cmd = {'-clear-tags'}
    M.modify(unpack(cmd))
end

M.get_current_struct_name = function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local ns = require('go.ts.go').get_struct_node_at_pos(row, col)
    if ns == nil or ns == {} then return '' end
    local struct_name = ns.name

    return struct_name
end

M.get_current_filename = function()
    local fname = vim.fn.expand('%')
    return fname
end

M.split = function(s, delimiter)
    local result = {};
    for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
        table.insert(result, match);
    end
    return unpack(result);
end

M.modify = function(...)
    local fname = M.get_current_filename()
    local struct_name = M.get_current_struct_name()

    local cmds = {
        'gomodifytags',
        '-w',
        '-format',
        'json',
        '-file',
        fname,
        '-struct',
        struct_name
    }

    local arg = {...}
    for _, v in ipairs(arg) do table.insert(cmds, v) end

    -- print(vim.inspect(table.concat(cmds, ' ')))
    vim.fn.jobstart(cmds, {
        on_stdout = function(_, data, _)
            data = M.handle_job_data(data)
            if not data then return end
            local tagged = vim.fn.json_decode(data)
            if tagged.errors ~= nil or tagged.lines == nil or tagged['start'] ==
                nil or tagged['start'] == 0 then
                print('failed to set tags' .. vim.inspect(tagged))
            end
            vim.api.nvim_buf_set_lines(0, tagged['start'] - 1,
                                       tagged['start'] - 1 + #tagged.lines,
                                       false, tagged.lines)
            print('updated')
        end
    })
end

M.getTagsAndOptions = function(...)
    local tags = {}
    local options = {}

    local args = {...}
    for _, arg in ipairs(args) do
        local tag, option = M.split(arg, ',')

        if tag then table.insert(tags, tag) end
        if option then table.insert(options, tag .. '=' .. option) end
    end

    return tags, options
end

M.handle_job_data = function(data)
    if not data then return nil end
    -- Because the nvim.stdout's data will have an extra empty line
    -- at end on some OS (e.g. maxOS), we should remove it.
    if data[#data] == '' then table.remove(data, #data) end
    if #data < 1 then return nil end
    return data
end

return M
