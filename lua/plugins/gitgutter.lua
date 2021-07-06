local g = vim.g
local exec = vim.api.nvim_exec

g.gitgutter_map_keys = 0
g.gitgutter_preview_win_floating = 0

g.gitgutter_sign_added = '▌'
g.gitgutter_sign_modified = '▌'
g.gitgutter_sign_removed = '▁'
g.gitgutter_sign_removed_first_line = '▌'
g.gitgutter_sign_modified_removed = '▌'
g.gitgutter_realtime = 1

exec([[
highlight GitGutterDelete guifg=#F97CA9
highlight GitGutterAdd    guifg=#BEE275
highlight GitGutterChange guifg=#96E1EF
]], false)
