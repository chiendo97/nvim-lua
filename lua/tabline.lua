function _G.MyTabline()
    local s = ""
    for tab = 1, vim.fn.tabpagenr("$") do
        local winnr = vim.fn.tabpagewinnr(tab)
        local buflist = vim.fn.tabpagebuflist(tab)
        local bufnr = buflist[winnr]
        local bufname = vim.fn.bufname(bufnr)
        local bufmodified = vim.fn.getbufvar(bufnr, "&mod")

        s = s .. "%" .. tab .. "T"
        s = s .. (tab == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")
        s = s .. " " .. tab .. "."
        s = s .. (bufname ~= "" and "[" .. vim.fn.fnamemodify(bufname, ":t") .. "]" or "[No Name]")
        s = s .. (bufmodified ~= 0 and "[+]" or "")
        s = s .. " %#TabLine#│"
    end

    s = s .. "%#TabLineFill#"
    return s
end

vim.o.tabline = "%!v:lua.MyTabline()"
