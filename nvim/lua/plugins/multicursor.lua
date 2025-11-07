-- lua/plugins/multicursor.lua
--
-- Configures 'multicurs.nvim', a simple multicursor plugin.
--
-- We will map VSCode's 'Ctrl+D' to add the next occurrence
-- of the current word as a new cursor.
return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
        {
            mode = { 'v', 'n' },
            '<C-d>',
            '<cmd>MCstart<cr>',
            desc = 'Create a selection for selected text or word under the cursor',
        },
    },
}
