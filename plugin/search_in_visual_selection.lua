vim.keymap.set('x', '<Plug>(search-in-visual-selection)', function() return require('search_in_visual_selection').search_in_visual_selection() end, { expr = true })
