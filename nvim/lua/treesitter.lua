require('nvim-treesitter.install').prefer_git = true -- install parsers using git

local treeconfig = require('nvim-treesitter.configs')

treeconfig.setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'bash', 'erlang', 'gleam', 'html', 'java', 'javascript', 'json', 'ocaml', 'powershell', 'python', 'swift', 'typescript' },

    sync_install = false,
    auto_install = false,

    highlight = {
        enable = true, -- enable syntax highlighting
        disable = function(lang, buf) -- disable for large files 
            local max_filesize = 1000 * 1024 -- 1MB file size
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false
    }
}

