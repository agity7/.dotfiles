return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required dependency
		{ "nvim-tree/nvim-web-devicons", optional = true }, -- Optional icons
	},
	opts = function()
		require("spectre").setup({
			default = {
				replace = {
					cmd = "sed", -- Default replace method (use "oxi" if installed)
				},
			},
			is_block_ui_break = true, -- Avoid UI breaks
		})
	end,
	config = function()
		local spectre = require("spectre")

		-- Key mappings
		vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Toggle Spectre",
		})
		vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search selected text",
		})
		vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search in current file",
		})
	end,
}
