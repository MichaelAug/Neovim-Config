return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require("dapui").setup()

			vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
			vim.api.nvim_set_hl(0, "red", { fg = "#ed0b0f" })
			vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
			vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })

			-- Set breakpoint icons
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "red", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

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

			-- stylua: ignore start
			dap.listeners.before.attach.dapui_config = function() dapui.open() end
			dap.listeners.before.launch.dapui_config = function() dapui.open() end
			dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
			dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

			-- set up keybinds
			vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Continue" })
			vim.keymap.set("n", "<leader>dr", function() dap.restart() end, { desc = "Restart session" })
			vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate session" })
			vim.keymap.set("n", "<leader>dL", function() dap.list_breakpoints() end,
				{ desc = "List breakpoints in quickfix window" })
			vim.keymap.set("n", "<leader>dC", function() dap.clear_breakpoints() end, { desc = "Clear breakpoints" })
			vim.keymap.set("n", "<leader>du", function() dap.reverse_continue() end, { desc = "Reverse continue" })
			vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step over" })
			vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step into" })
			vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step out" })
			vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dB", function() dap.set_breakpoint() end, { desc = "Set breakpoint" })
			vim.keymap.set("n", "<Leader>dm", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
				{ desc = "Set Log Point Message" })
			vim.keymap.set("n", "<Leader>dR", function() dap.repl.open() end, { desc = "Open REPL/Debug console" })
			vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end,
				{ desc = "Re-run last debug adapter/configuration" })
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function() require("dap.ui.widgets").hover() end,
				{ desc = "View expression in floating window" })
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function() require("dap.ui.widgets").preview() end,
				{ desc = "View expression in preview window" })
			vim.keymap.set("n", "<Leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end, { desc = "View current frames" })
			vim.keymap.set("n", "<Leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end, { desc = "View current scopes" })
			-- stylua: ignore end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			-- This needs to point to the python executable in your virtual environment that has debugpy installed
			-- it can be separate to your dev environment
			require("dap-python").setup("~\\Documents\\.virtualenvs\\debugpy\\Scripts\\python.exe")
		end,
	},
}
