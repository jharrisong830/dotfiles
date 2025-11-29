return {
    {
        "catppuccin/nvim",
        opts = function(_, opts)
            local module = require("catppuccin.groups.integrations.bufferline")
            if module then
                module.get = module.get_theme
            end

            opts["flavour"] = "mocha"
            opts["transparent_background"] = true

            return opts
        end
    }
}
