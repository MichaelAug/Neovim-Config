return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- Environment variable CODELLDB_PATH set in NixOS home manager config
					command = os.getenv("CODELLDB_PATH"),
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Debug with codelldb",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input({
							prompt = "Path to executable: ",
							default = vim.fn.getcwd() .. "/target/debug/",
							completion = "file",
						})
					end,
					cwd = "${workspaceFolder}",
					showDisassembly = "never",
					stopOnEntry = false,
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- Open/close dap ui on debug start/end
			-- stylua: ignore start
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- set up keybinds
			vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Continue" })
			vim.keymap.set("n", "<F6>", function() dap.step_over() end, { desc = "Step over" })
			vim.keymap.set("n", "<F7>", function() dap.step_into() end, { desc = "Step into" })
			vim.keymap.set("n", "<F8>", function() dap.step_out() end, { desc = "Step out" })
			vim.keymap.set("n", "<leader>dr", function() dap.restart() end, { desc = "Restart session" })
			vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate session" })
			vim.keymap.set("n", "<leader>dC", function() dap.clear_breakpoints() end, { desc = "Clear breakpoints" })
			vim.keymap.set("n", "<leader>du", function() dap.reverse_continue() end, { desc = "Reverse continue" })
			vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dB", function() dap.set_breakpoint() end, { desc = "Set breakpoint" })

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				dapui.eval(nil, { enter = true })
			end)
			-- stylua: ignore end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			-- Install debugpy in a virtualenv to use
			local current_working_directory = vim.fn.getcwd()
			local venv_name = "/env/" -- Change this if your venv directory name is different!

			-- This needs to point to the python executable in your virtual environment
			require("dap-python").setup(current_working_directory .. venv_name .. "/bin/python")
		end,
	},
}
