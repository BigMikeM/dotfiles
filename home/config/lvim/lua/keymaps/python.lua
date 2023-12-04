-- binding for switching
lvim.builtin.which_key.mappings["P"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
	m = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" },
	M = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" },
	f = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" },
	F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" },
	S = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" },
}
