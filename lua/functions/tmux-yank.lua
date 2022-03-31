local M = {}

M.tmux_yank = function()

	local get_visual_selection = require(
		'functions.third-party.get_visual_selection'
	).get_visual_selection

	local function join(lines)
		local str = lines[1]
		for i = 2, #lines do
			str = str .. '\n' .. lines[i]
		end
		return str
	end

	local function load_into_tmux_buffer(str)
		local tmp_file_path = os.tmpname()
		local f = assert(io.open(tmp_file_path, 'w'))
		f:write(str)
		f:close()
		os.execute('tmux load-buffer ' .. tmp_file_path)
		os.remove(tmp_file_path)
	end

	local selection_lines = get_visual_selection()
	local selection_str = join(selection_lines)
	load_into_tmux_buffer(selection_str)
end

setmetatable(M, {
   __call = function(_)
      return M.tmux_yank()
   end,
})

return M
