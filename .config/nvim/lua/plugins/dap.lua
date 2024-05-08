return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>db", "<cmd>DapToggleBreakpoint<cr>" },
            { "<leader>dr", "<cmd>DapContinue<cr>" },
        },
        config = function()
            local dap = require("dap")

            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" }
                }
            }

            for _, language in ipairs { "typescript", "javascript" } do
                dap.configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch Current file (pwa-node)",
                        cwd = "${workspaceFolder}",
                        args = { "${file}" },
                        sourceMaps = true,
                        protocol = "inspector"
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        protocol = "inspector"
                    }
                }
            end
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }
}
