local function search_in_visual_selection()
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)
	local f = vim.fn
	local up = f.line("'<") - 1
	local down = f.line("'>") + 1
	local left = f.min({ f.virtcol("'<"), f.virtcol("'>") }) - 1
	local right = f.max({ f.virtcol("'<"), f.virtcol("'>") }) + 1
	local mode = f.visualmode()
	local very_magic_search = [[/\v]]
	local lines = [[%\>]] .. up .. [[l%\<]] .. down .. "l"
	local left_column = [[%\>]] .. left .. "v"
	local right_column = [[%\<]] .. right .. "v"
	if mode == "v" then
		if f.line("'<") == f.line("'>") then
			return very_magic_search .. lines .. left_column .. right_column
		else
			return very_magic_search .. lines
		end
	elseif mode == "V" then
		return very_magic_search .. lines
	else -- "\<C-v>" hard to express in lua ._.
        -- (Neo)vim doesn't expose if visual block mode is in $ mode, so we'll use this heuristic that works at least sometimes
        -- The NrrwRgn plugin has a more involved hack using 'curswant' and moving the cursor around, but that's annoying.
		if f.virtcol("'<") == f.virtcol("$") or f.virtcol("'>") == f.virtcol("$") then -- user pressed $ so visual block mode extends to the end of the line everywhere
			return very_magic_search .. lines .. left_column
		else
			return very_magic_search .. lines .. left_column .. right_column
		end
	end
end

vim.keymap.set('x', '<Plug>(search-in-visual-selection)', search_in_visual_selection, { expr = true })
